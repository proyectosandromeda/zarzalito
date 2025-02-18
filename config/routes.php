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

$app->group('/bot', function (RouteCollectorProxy $app) { 
    $app->get('', "ControladorBot:load_bot")->setName('BOT');  
    $app->post('/start', "ControladorBot:bot_funcionalidad")->setName('Excepciones');  
    $app->get('/plantilla', "ControladorBot:plantilla")->setName('Excepciones'); 
    
    /**menus dinamicos del bot */
    $app->get("/create_bot", "ControladorMenuBot:index");
    $app->get('/lineas_valle', "ControladorMenuBot:index_menu_valle"); 
    $app->post("/add_menu", "ControladorMenuBot:upload_files_audios_images");
    $app->post("/save_menu", "ControladorMenuBot:guarda_menu")->setName('SaveMenu');
    $app->get("/get_item/{iditem:[0-9]+}", "ControladorMenuBot:get_item")->setName('Excepciones');  
    $app->post("/menu_del", "ControladorMenuBot:delete_menu");
    $app->post("/editar_menu", "ControladorMenuBot:edit_menu");    

    $app->get('/productos_bot/{idcliente:[0-9]+}/{categoria:[0-9]+}', "ControladorMenuBot:lista_producto")->setName('Catalogo');  
    $app->get('/pruebas', "ControladorBot:prueba")->setName('BOT'); 
});
