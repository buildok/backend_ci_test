Vue.component('Order', {
    template: '#order-template',
    props: ['id', 'price', 'likes', 'date'],
});

Vue.component('Transaction', {
    template: '#transaction-template',
    props: ['id', 'amount', 'type', 'date'],
});

Vue.component('User', {
    template: '#user-template',
    data() {
        return {
            balance: 0,
            likes: 0,
            isGuest: false,
        };
    },
    async created() {
        let response = await send('/main_page/session');
        if (response.status == 'error') {
            this.isGuest = true;
        }

        this.balance = response.balance;
        this.likes = response.likes;
    },
    mounted() {
        this.$root.$on('update-balance', balance => this.balance = balance);
        this.$root.$on('update-likes', likes => this.likes = likes);
    },
    methods: {
    }
});

Vue.component('Comment', {
    template: '#comment-template',
    props: ['id', 'assignId', 'parentId', 'text', 'author', 'likes'],
    data() {
        return {
            isOpen: false,
            replyText: '',
            replyError: false,
            likeError: false,
            errorMsg: '',
            replies: [],
            likesCount: this.likes,
            liked: false,
        };
    },
    methods: {
        toggle() {
            this.isOpen = !this.isOpen;
            if (this.isOpen && !this.replies.length) {
                this.replies = app.post.coments.filter(c => c.parentId == this.id);
            }
        },
        async like() {
            let response = await send('/main_page/like_comment', {
                commentId: this.id
            }, 'POST');

            if (response.status == 'error') {
                this.errorMsg = response.error_message;
                this.likeError = true;
                return;
            }

            this.likeError = false;
            this.errorMsg = '';
            this.likesCount++;
            this.liked = true;
            this.$root.$emit('update-likes', response.new_likes_balance);
        },
        async reply() {
            let response = await send('/main_page/comment', {
                postId: this.assignId,
                text: this.replyText,
                parentId: this.id
            }, 'POST');

            if (response.status == 'error') {
                this.errorMsg = response.error_message;
                this.replyError = true;
                return;
            }

            this.replyError = false;
            this.replyText = '';
            this.replies.push(response.comment);
        },
    }
});


var app = new Vue({
    el: '#app',
    data: {
        login: '',
        pass: '',
        post: false,
        invalidLogin: false,
        invalidPass: false,
        loginError: false,
        commentError: false,
        likeError: false,
        buypackError: false,
        txError: false,
        orderError: false,
        errorMsg: '',
        invalidSum: false,
        posts: [],
        addSum: 0,
        amount: 0,
        liked: false,
        commentText: '',
        packs: [],
        transactions: [],
        totalDeposit: 0,
        totalWithdraw: 0,
        balance: 0,
        orders: [],
    },
    computed: {
        test: function () {
            var data = [];
            return data;
        },
    },
    created(){
        var self = this
        axios
            .get('/main_page/get_all_posts')
            .then(function (response) {
                self.posts = response.data.posts;
            });
        axios
            .get('/main_page/get_all_packs')
            .then(function (response) {
                self.packs = response.data.packs;
            });
    },
    methods: {
        openAccount() {
            this.txError = false;
            send('/main_page/transactions').then(response => {
                if (response.status == 'error') {
                    this.errorMsg = response.error_message;
                    this.txError = true;
                } else {
                    this.transactions = response.tx;
                    this.totalDeposit = response.balance.deposit;
                    this.totalWithdraw = response.balance.withdraw;
                    this.balance = response.balance.current
                }
            });
            send('/main_page/orders').then(response => {
                if (response.status == 'error') {
                    this.errorMsg = response.error_message;
                    this.orderError = true;
                } else {
                    this.orders = response.orders;
                }
            });
        },
        logout: function () {
            console.log ('logout');
        },
        logIn: function () {
            var self= this;
            if(self.login === ''){
                self.invalidLogin = true
            }
            else if(self.pass === ''){
                self.invalidPass = true
            }
            else{
                axios.post('/main_page/login', {
                    login: self.login,
                    password: self.pass
                })
                    .then(function (response) {
                        if (response.data.status == 'error') {
                            self.errorMsg = response.data.error_message;
                            self.loginError = true;
                            return;
                        }
                        window.location.href = '/';
                    })
            }
        },
        fiilIn: function () {
            var self= this;
            if(self.addSum <= 0){
                self.errorMsg = 'Please write a sum.';
                self.invalidSum = true
            }
            else{
                self.invalidSum = false
                axios.post('/main_page/add_money', {
                    sum: self.addSum,
                })
                    .then(function (response) {
                        if (response.data.status == 'error') {
                            self.errorMsg = response.data.error_message;
                            self.invalidSum = true;
                            return;
                        }

                        self.$root.$emit('update-balance', response.data.new_balance);
                        setTimeout(function () {
                            $('#addModal').modal('hide');
                        }, 500);
                    })
            }
        },
        openPost: function (id) {
            var self= this;
            axios
                .get('/main_page/get_post/' + id)
                .then(function (response) {
                    self.post = response.data.post;
                    if(self.post){
                        setTimeout(function () {
                            $('#postModal').modal('show');
                        }, 500);
                    }
                })
        },
        async addComment(postId, parentId = 0) {
            this.commentError = false;

            let response = await send('/main_page/comment', {
                postId: postId,
                text: this.commentText,
                parentId: parentId
            }, 'POST');

            if (response.status == 'error') {
                this.errorMsg = response.error_message;
                this.commentError = true;
                return;
            }
            this.commentText = '';

            // coments (one 'm')
            if (this.post.coments !== undefined) {
                this.post.coments.push(response.comment);
            } else {
                this.post.coments = [response.comment];
            }
        },
        async addLike(id) {
            let response = await send('/main_page/like', {
                postId: id
            }, 'POST');

            if (response.status == 'error') {
                this.errorMsg = response.error_message;
                this.likeError = true;
                return;
            }

            this.likeError = false;
            this.errorMsg = '';
            this.liked = true;
            this.post.likes++;
            this.$root.$emit('update-likes', response.new_likes_balance);
        },
        buyPack: function (id) {
            this.buypackError = false;

            var self= this;
            axios.post('/main_page/buy_boosterpack', {
                id: id,
            })
                .then(function (response) {
                    if (response.data.status == 'error') {
                        self.amount = 0;
                        self.errorMsg = response.data.error_message;
                        self.buypackError = true;
                    } else {
                        self.amount = response.data.amount;
                    }

                    self.$root.$emit('update-balance', response.data.user.balance);
                    self.$root.$emit('update-likes', response.data.user.likes);
                    setTimeout(function () {
                        $('#amountModal').modal('show');
                    }, 500);
                })
        }
    }
});

async function send(uri, data = {}, method = 'GET') {
    method = method.toUpperCase();
    let opt = {
        method: method,
        headers: {Accept: 'application/json'},
    }
    if (method == 'GET') {
        if (Object.entries(data).length) {
            uri = uri + '?' + (new URLSearchParams(data)).toSring();
        }
    } else {
        opt.body = JSON.stringify(data);
        opt.headers['Content-Type'] = 'application/json';
    }

    try {
        let response = await fetch(uri, opt);
        if (!response.ok) {
            return {status: 'error', error_message: response.status};
        }

        return await response.json();
    } catch (e) {
        return {status: 'error', error_message: 'Network issue, please try later'};
    }
}
