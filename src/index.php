<?php
use Tqdev\PhpCrudApi\Api;
use Tqdev\PhpCrudApi\Config;
use Tqdev\PhpCrudApi\Request;

// do not reformat the following line
spl_autoload_register(function ($class) {include str_replace('\\', '/', __DIR__ . "/$class.php");});
// as it is excluded in the build

$config = new Config([
    'username' => 'web',
    'password' => 'kenzan2019',
    'database' => 'employee',
]);
$request = new Request();
$api = new Api($config);
$response = $api->handle($request);
$response->output();
