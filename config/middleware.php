<?php

namespace App\Controladores;

use DI\Container;
use Slim\Factory\AppFactory;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use Slim\Routing\RouteCollectorProxy;
use Slim\Psr7\Response;
use Slim\Exception\HttpNotFoundException;
use Slim\Routing\RouteContext;
use Cartalyst\Sentinel\Native\Facades\Sentinel;
use Slim\Flash\Messages;
use Slim\Psr7\Factory\ResponseFactory;

use App\Controladores\SessionStartMiddleware;
use App\Controladores\AuthMiddleware;
use App\Controladores\HttpNotFoundExceptionf;

//$app->add(HttpNotFoundExceptionf::class);

/* $app->add(function ($request, $handler) {
    $response = $handler->handle($request);
    return $response
        ->withHeader('Access-Control-Allow-Origin', '*')
        ->withHeader('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Accept, Origin, Authorization')
        ->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS')
        ->withHeader('Access-Control-Allow-Credentials', 'true');
}); */



$app->add(function (Request $request, RequestHandler $handler) {

    $response = $handler->handle($request);
    $routeContext = RouteContext::fromRequest($request);
    $routeParser = RouteContext::fromRequest($request)->getRouteParser();
    $route = $routeContext->getRoute();
    $routeName = $route->getName();

    //print_r($user2);
    $publicRoutesArray = array(
        'Login',
        'register',
        'Ingreso',
        'login/new_pass',
        'login/ingreso',
        'Api',
        'Excepciones',
        'Token',
        'Permisos',
        'Newpass',
        'RegisterUserForm',
        'BOT'
    );

    if (in_array($routeName, $publicRoutesArray)) { //rutas publicas permitidas     
        return $response;
    } else {

        if (Sentinel::check()) {

            $path = substr($request->getUri()->getPath(), 1);
            $new_rol = Sentinel::findRoleById($_SESSION['rol']);
            $permisos = array_keys($new_rol->permissions);
            //echo $path;
            //print_r($permisos);
            // exit();
            if (Sentinel::hasAnyAccess($path) || in_array($routeName, $publicRoutesArray) || in_array($routeName, $permisos)) {
                return $response;
            } else {
                //echo $routeName;
                $url = $routeParser->urlFor('Permisos');                
                return $response->withRedirect($url);
            }
        }

        $url = $routeParser->urlFor('Login');
        return $response->withRedirect($url);
    }
});

$app->add(SessionStartMiddleware::class);
// Registrar middleware de autenticación
