<?php

/**
 * Created by PhpStorm.
 * User: mr.incognito
 * Date: 10.11.2018
 * Time: 21:36
 */
class Main_page extends MY_Controller
{

    public function __construct()
    {
        parent::__construct();

        App::get_ci()->load->model('User_model');
        App::get_ci()->load->model('Login_model');
        App::get_ci()->load->model('Post_model');
        App::get_ci()->load->model('Boosterpack_model');

        if (is_prod())
        {
            die('In production it will be hard to debug! Run as development environment!');
        }
    }

    public function index()
    {
        $user = User_model::get_user();



        App::get_ci()->load->view('main_page', ['user' => User_model::preparation($user, 'default')]);
    }

    public function get_all_posts()
    {
        $posts =  Post_model::preparation(Post_model::get_all(), 'main_page');
        return $this->response_success(['posts' => $posts]);
    }

    public function get_all_packs()
    {
        $packs = Boosterpack_model::preparation(Boosterpack_model::get_all());
        return $this->response_success(['packs' => $packs]);
    }

    public function get_post($post_id){ // or can be $this->input->post('news_id') , but better for GET REQUEST USE THIS

        $post_id = intval($post_id);

        if (empty($post_id)){
            return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
        }

        try
        {
            $post = new Post_model($post_id);
        } catch (EmeraldModelNoDataException $ex){
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NO_DATA);
        }


        $posts =  Post_model::preparation($post, 'full_info');
        return $this->response_success(['post' => $posts]);
    }


    /**
     * Add comment
     * POST /main_page/comment
     * {postId, text, parentId}
     * @return string JSON {comment}
     */
    public function comment()
    {
        if (!User_model::is_logged()) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NEED_AUTH);
        }

        $payload = $this->payload();
        if (!$this->validate($payload, ['postId', 'text', 'parentId'])) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
        }

        $comment = Comment_model::create([
            'assign_id' => $payload->postId,
            'user_id' => User_model::get_session_id(),
            'text' => $payload->text,
            'parent_id' => $payload->parentId,
        ]);

        $this->response_success(['comment' => Comment_model::preparation([$comment], 'full_info')[0]]);
    }


    /* User login
     * POST /main_page/login
     * {login, password}
     * @return string JSON {user}
     */
    public function login()
    {
        $payload = $this->payload();
        if (!$this->validate($payload, ['login', 'password'])) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
        }

        try {
            $model = User_model::findByLogin($payload->login, $payload->password);
        } catch (Throwable $e) {
            return $this->response_error('Wrong login or password');
        }
        Login_model::start_session($model->get_id());

        $this->response_success(['user' => User_model::preparation($model)]);
    }


    public function logout()
    {
        Login_model::logout();
        redirect(site_url('/'));
    }

    /**
     * Add money to the user balance
     * POST /main_page/add_money
     * {sum}
     * @return string JSON {new_balance}
     */
    public function add_money()
    {
        $payload = $this->payload();
        if (!$this->validate($payload, ['sum'])) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
        }
        if ($payload->sum <= 0) {
            return $this->response_error('Sent invalid sum');
        }

        if (!User_model::is_logged()) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NEED_AUTH);
        }

        $user = User_model::get_user();
        if (!$user->deposit($payload->sum)) {
            return $this->response_error('Unsuccessful, please try later');
        }

        $this->response_success(['new_balance' => $user->get_wallet_balance()]);
    }

    /**
     * Buy boosterpack
     * POST /main_page/buy_boosterpack
     * {id}
     * @return string JSON {amount, user:{balance, likes}}
     */
    public function buy_boosterpack()
    {
        $payload = $this->payload();
        if (!$this->validate($payload, ['id'])) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
        }

        if (!User_model::is_logged()) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NEED_AUTH);
        }

        $user = User_model::get_user();
        try {
            $bp = new Boosterpack_model($payload->id);
            if ($user->get_wallet_balance() - $bp->get_price() < 0) {
                return $this->response_error('You do not have enough money');
            }

            if (!$user->buyBoosterpack($bp)) {
                return $this->response_error('Unsuccessful, please try later');
            }
        } catch (EmeraldModelNoDataException $ex) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NO_DATA);
        }

        return $this->response_success([
            'amount' => $bp->get_likes(),
            'user' => ['balance' => $user->get_wallet_balance(), 'likes' => $user->getLikes()]
        ]);
    }


    /**
     * Add like to post
     * POST /main_page/like
     * {postId}
     * @return string JSON {new_likes_balance}
     */
    public function like()
    {
        $payload = $this->payload();
        if (!$this->validate($payload, ['postId'])) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
        }

        try {
            $model = new Post_model($payload->postId);
        } catch (EmeraldModelNoDataException $ex) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NO_DATA);
        }
        return $this->addLike($model);
    }

    /**
     * Add like to comment
     * POST /main_page/like_comment
     * {commentId}
     * @return string JSON {new_likes_balance}
     */
    public function like_comment()
    {
        $payload = $this->payload();
        if (!$this->validate($payload, ['commentId'])) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_WRONG_PARAMS);
        }

        try {
            $model = new Comment_model($payload->commentId);
        } catch (EmeraldModelNoDataException $ex) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NO_DATA);
        }
        return $this->addLike($model);
    }

    /**
     * Returns user transactions
     * GET /main_page/transactions
     * @return string JSON {tx:[transaction], balance:{deposit, withdraw, current}}
     */
    public function transactions()
    {
        if (!User_model::is_logged()) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NEED_AUTH);
        }

        $user = User_model::get_user();
        App::get_ci()->load->model('Transaction_model');
        return $this->response_success([
            'tx' => Transaction_model::get_all_by_user_id($user->get_id()),
            'balance' => [
                'deposit' => $user->get_wallet_total_refilled(),
                'withdraw' => $user->get_wallet_total_withdrawn(),
                'current' => $user->get_wallet_balance(),
            ]
        ]);
    }

    /**
     * Returns user orders
     * GET /main_page/orders
     * @return string JSON {orders:[order]}
     */
    public function orders()
    {
        if (!User_model::is_logged()) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NEED_AUTH);
        }

        $user = User_model::get_user();
        App::get_ci()->load->model('Order_model');
        return $this->response_success(['orders' => Order_model::get_all_by_user_id($user->get_id())]);
    }

    /**
     * Returns user
     * GET /main_page/session
     * @return string JSON {balance, likes}
     */
    public function session()
    {
        if (!User_model::is_logged()) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NEED_AUTH);
        }

        $user = User_model::get_user();
        $this->response_success([
            'balance' => $user->get_wallet_balance(),
            'likes' => $user->getLikes()
        ]);
    }

    private function addLike($model)
    {
        if (!User_model::is_logged()) {
            return $this->response_error(CI_Core::RESPONSE_GENERIC_NEED_AUTH);
        }

        $user = User_model::get_user();
        if (!$user->applyLike()) {
            return $this->response_error('You do not have enough likes');
        }
        $model->like();

        return $this->response_success(['new_likes_balance' => $user->getLikes()]);
    }
}
