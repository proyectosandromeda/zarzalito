<?php

namespace App\Controladores;

use DI\Container;
use App\Modelos\ModeloUsuarios as Usuarios;
use App\Modelos\ModeloEstados as Estados;


use Slim\Views\Twig; // Las vistas de la aplicación
use Slim\Router; // Las rutas de la aplicación
use Respect\Validation\Validator as v; // para usar el validador de Respect
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ResponseFactoryInterface;
use Illuminate\Database\Capsule\Manager as DB;
use Guzzle\Http\Exception\ClientErrorResponseException;
use Cartalyst\Sentinel\Native\Facades\Sentinel;
use Slim\Routing\RouteContext;
use Carbon\Carbon;
use Dompdf\Dompdf;
use Dompdf\Options;


/**
 * Clase de controlador para el usuario de la aplicación
 */

class ControladorUsuario
{

	protected $view;
	// objeto de la clase Router
	protected $router;
	protected $messages;
	protected $decoded;
	/**
	 * Constructor de la clase Controller     
	 * @param type Slim\Router $router - Ruta
	 */
	/*public function __construct( Router $router)
				   {
					   
					   $this->router = $router;
				   }*/

	protected $container;
	public function __construct(Container $container)
	{
		$this->container = $container;
	}


	/*-- Funciones del CRUD --*/
	public function index(Request $request, Response $response, $args)
	{
		$estados = Estados::all();
		$roles = Sentinel::getRoleRepository()->all();
		$usuarios = Usuarios::select('email', 'first_name', 'last_name', 'roles.name as role','users.id','role_users.role_id as idrol')
			->join('role_users', 'role_users.user_id', '=', 'users.id')
			->join('roles', 'roles.id', '=', 'role_users.role_id')
			->get();

		return Twig::fromRequest($request)->render($response, 'usuarios/usuarios.twig', [
			'estados' => $estados,
			'roles' => $roles,
			'usuarios' => $usuarios
		]);
	}


	public function save_edit(Request $request, Response $response, $args)
	{

		$param = $request->getParsedBody();
		$routeParser = RouteContext::fromRequest($request)->getRouteParser();

		if ($param['idusuario']) {

			$user = Sentinel::findById($param['idusuario']);

			$infousu['first_name'] = $param['nombre'];
			$infousu['last_name'] = $param['apellido'];
			$infousu['email'] = $param['email'];

			if ($param['passwd']) {
				$infousu['password'] = $param['passwd'];
			}
			Sentinel::update($user, $infousu);

			//actualizacion del rol
			$rol = Sentinel::findById($user->id)->roles()->first();
			if ($param['rol'] != $rol->id) {

				//DB::table('role_users')->where('user_id',$param['idusuario'])->update(['role_id' => $param['rol']]);
				$rol->users()->detach($user);
				$new_rol = Sentinel::findRoleById($param['rol']);
				$new_rol->users()->attach($user);
			}


			//deshabilita o habilita el usuario
			/* 	if ($param['estado'] == 2) {
						  $user = Sentinel::findById($param['idusuario']);
						  Sentinel::getActivationRepository()->remove($user);
					  } else if ($param['estado'] == 1) {
						  DB::table('activations')->insert([
							  'user_id' => $param['idusuario'],
							  'code' => uniqid(),
							  'completed' => 1,
							  'completed_at' => Carbon::now()
						  ]);
					  } */

			return $response->withStatus(200)->withJson([
				'succes' => true,
				'tipo' => 'success',
				
				'message' => 'Datos actualizados'
				
			]);

		} else {

			$exist = Usuarios::select('email')->where('email', $param['email'])->first();
			if (empty($exist->email)) {
				$user = Sentinel::register([
					'email' => $param['email'],
					'password' => $param['passwd'],
					'last_name' => $param['apellido'],
					'first_name' => $param['nombre']
				]);

				if (empty($param['estado'])) {
					$param['estado'] = 2;
				}
				
				//Usuarios::where('email', $param['email'])->update(['estados_idestados' => $param['estado']]);

				$activation = Sentinel::getActivationRepository()->create($user);
				$role = Sentinel::findRoleById($param['rol']);
				$role->users()->attach($user);



				return $response->withStatus(201)->withJson([
					'succes' => true,
					'tipo' => 'success',
					'message' => 'El usuario fue creado',
					'close_modal' => 'modal_edit_usuarios'
				]);

			} else {

				return $response->withJson([
					'succes' => false,
					'tipo' => 'info',
					'message' => 'El correo con el que intentas crear la cuenta ya se encuentra registrado'					
				]);
			}
		}
	}



}