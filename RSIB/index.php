<?php
session_start();

require_once 'config.php';
require_once 'Core/Database.php';
require_once 'Core/Controller.php';

$url = explode('/', $_GET['url'] ?? 'auth/login');
$controllerName = ucfirst($url[0]) . 'Controller';
$method = $url[1] ?? 'login';

require_once "Controllers/$controllerName.php";
$controller = new $controllerName;
call_user_func([$controller, $method]);
?>
