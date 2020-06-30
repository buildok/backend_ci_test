<?php

class Transaction_model
{
    const CLASS_TABLE = 'transaction';

    public static function get_all_by_user_id($user_id)
    {
        return App::get_ci()->s->from(self::CLASS_TABLE)
                               ->where(['user_id' => $user_id])->many();
    }
}
