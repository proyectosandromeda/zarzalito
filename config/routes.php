<?php
namespace App\Controladores;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Selective\BasePath\BasePathMiddleware;
use Illuminate\Database\Connection;
use Slim\Exception\NotFoundException;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use Slim\App;
use Slim\Routing\RouteContext;
use Slim\Routing\RouteCollectorProxy;
use App\Controladores\HeaderController;


$app->get('/no_permisos', "ControladorLogin:permisos")->setName('Permisos');
$app->get('/regenerate_token', "ControladorToken:regenerate_token")->setName('Excepciones');
$app->get('/get_ip', "ControladorZonasCalor:convertir_direccion")->setName('Token');
$app->get('/formulario/{cliente}/{experiencia}/{form:[0-9]+}', "ControladorExperiencias:show_form")->setName('Excepciones');
$app->get('/json_swagger', "ControladorApi:genera_json_swagger")->setName('Excepciones');
$app->get('/mongodb', "ControladorApiMongoDB:genera_json_swagger")->setName('Excepciones');

$app->get('/', "ControladorIndex:index")->setName('Home');

$app->group('/login', function (RouteCollectorProxy $app) {
    $app->get('/ingreso', "ControladorLogin:index")->setName('Login');
    $app->post('/ingreso', "ControladorLogin:login")->setName('Ingreso');
    $app->get('/logout', "ControladorLogin:salir")->setName('Salida');

    $app->get('/new_pass', "ControladorLogin:index_new_pass")->setName('Newpass');
    $app->post('/generate_pass', "ControladorLogin:new_pass")->setName('Excepciones');
    $app->get('/reset_pass/{code}/{iduser:[0-9]+}', "ControladorLogin:template_entry_new_pass")->setName('Excepciones');
    $app->post('/change_pass', "ControladorLogin:active_pass_reminder")->setName('Excepciones');
})->add('csrf');


$app->group('/usuarios', function (RouteCollectorProxy $app) {
    $app->get('', "ControladorUsuario:index")->setName('Usuarios');
    $app->post('/add_usuario', "ControladorUsuario:save_edit")->setName('AddUsers');
    $app->get('/edit_user/{iduser:[0-9]+}', "ControladorUsuario:edit_user")->setName('EditUser');
    $app->get('/all_usuario', "ControladorUsuario:all_usuarios");
    $app->get('/lista_usuario', "ControladorUsuario:lista_usuarios");
    $app->get('/activate/{code}/{iduser}', "ControladorUsuario:activar_users")->setName('Excepciones');
    $app->get('/fetch_user/{idusuario}', "ControladorUsuario:busca_usuario")->setName('Excepciones');
    $app->post('/change_state', "ControladorUsuario:update_state")->setName('Changestate');
})->add('csrf');


$app->group('/configuracion', function (RouteCollectorProxy $app) {
    $app->get('', "ControladorBot:index")->setName('Configuracion');
    $app->post('/save_edit', "ControladorBot:save_edit")->setName('SaveConfig');
    
})->add('csrf');

$app->group('/tickets', function (RouteCollectorProxy $app) {
    $app->get('', "ControladorTickets:index")->setName('Tickets');
    $app->get('/all', "ControladorTickets:all_tickets")->setName('AllTickets');
    $app->get('/get_ticket/{idticket:[0-9]+}', "ControladorTickets:get_ticket")->setName('AllTickets');
    $app->post('/save_edit', "ControladorTickets:save_edit")->setName('SaveTikect');
    
})->add('csrf');

$app->group('/api', function (RouteCollectorProxy $app) {
    $app->get("/pruebas", "ControladorApi:pruebas")->setName('Api');
    $app->get("/consultar_estrategias/{idcliente:[0-9]+}", "ControladorApi:list_estrategias_byclientes")->setName('Api');
    $app->get("/listar_experiencias_clientes/{idcliente:[0-9]+}", "ControladorApi:listar_experiencias_clientes")->setName('Api');
    $app->get("/listar_mecanicas_by_experiencias/{idexperiencia:[0-9]+}", "ControladorApi:listar_mecanicas_experiencias")->setName('Api');
    $app->get("/listar_mecanicas_byespacios/{idexperiencia:[0-9]+}", "ControladorApi:listar_mecanicas_experienciasbyespacios")->setName('Api');

    $app->get("/listado_clientes", "ControladorApi:listado_clientes")->setName('Api');
    $app->post("/login", "ControladorApi:login")->setName('Api');
    $app->get("/listar_atributos/{idexperiencia:[0-9]+}", "ControladorApi:listar_atributos_mecanicas")->setName('Api');
     
    /**eventos */
    $app->post("/search_events", "ControladorApi:search_events")->setName('Api');
    $app->post("/insert_events", "ControladorApi:insert_events")->setName('Api');

    $app->get("/change_estado_inicio", "ControladorApi:change_estado_inicio")->setName('Api');

    $app->get("/valid_date_experience/{idexperience}", "ControladorApi:validar_fecha_finalizacion_experiencia")->setName('Api');

    

});

