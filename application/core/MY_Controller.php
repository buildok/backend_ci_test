<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class MY_Controller extends CI_Controller
{
    const HTTP_OK = 200;
    const HTTP_BAD = 400;
    const HTTP_UNAUTHORIZED = 401;
    const HTTP_FORBIDDEN = 403;
    const HTTP_SERVER_ERROR = 500;

    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Returns request payload
     * @return object stdClass
     */
    protected function payload() : stdClass
    {
        $payload = json_decode(App::get_ci()->input->raw_input_stream) ?? new stdClass;
        return $payload;
    }

    /**
     * Check required fields
     * @param $payload object
     * @param $required array
     * @return bool
     */
    protected function validate(object $payload, array $required) : bool
    {
        foreach ($required as $field) {
            if (!property_exists($payload, $field)) {
                return false;
            }
        }

        return true;
    }

    public function __destruct()
    {

    }
}
