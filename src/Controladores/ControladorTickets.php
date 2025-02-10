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

class ControladorTickets
{

	protected $view;
	// objeto de la clase Router
	protected $router;

	protected $container;
	public function __construct(Container $container)
	{
		$this->container = $container;
	}



	/*-- Funciones del CRUD --*/
	public function index(Request $request, Response $response, $args)
	{
		$estados = DB::table('state_tickets')->get();
		return Twig::fromRequest($request)->render($response, 'tickets/tickets.twig', ["estados" => $estados]);
	}

	public function all_tickets(Request $request, Response $response, $args)
	{

		$total = DB::table('tickets')->count();
		$data = DB::table('tickets')->select(
			'tickets.area',
			'tickets.name',
			'tickets.id',
			'tickets.problem',
			'tickets.created_at as fecha',
			'state_tickets.description as estado',
			DB::raw('(concat(users.first_name," ",users.last_name)) as responsable')
		)->join('state_tickets', 'state_tickets.id', '=', 'tickets.state_tickets_id')
			->leftJoin('users', 'users.id', '=', 'tickets.users_id')
			->when(
				$_GET['columns'][0]['search']['value'] != '',
				function ($q) {
					return $q->where('tickets.name', 'LIKE', "%" . $_GET['columns'][0]['search']['value'] . "%");
				}
			)
			->when(
				$_GET['columns'][1]['search']['value'] != '',
				function ($q) {
					return $q->where('tickets.area', 'LIKE', "%" . $_GET['columns'][1]['search']['value'] . "%");
				}
			)
			->when(
				$_GET['columns'][2]['search']['value'] != '',
				function ($q) {
					return $q->where('tickets.problem', 'LIKE', "%" . $_GET['columns'][2]['search']['value'] . "%");
				}
			)
			->when(
				$_GET['columns'][3]['search']['value'] != '',
				function ($q) {
					return $q->whereraw('cast(tickets.created_at as date) LIKE "%' . $_GET['columns'][3]['search']['value'] . '%"');
				}
			)
			->when(
				$_GET['columns'][4]['search']['value'] != '',
				function ($q) {
					return $q->where('state_tickets.description', 'LIKE', "%" . $_GET['columns'][4]['search']['value'] . "%");
				}
			)
			->when(
				$_GET['columns'][5]['search']['value'] != '',
				function ($q) {
					return $q->where('users.first_name', 'LIKE', "%" . $_GET['columns'][5]['search']['value'] . "%");
				}
			)
			->orderby('tickets.created_at', 'DESC')
			->when(
				$_GET['length'] >= 1,
				function ($q) {
					return $q->offset($_GET['start'])->limit($_GET['length']);
				}
			)
			->get();


		return $response->withStatus(200)->withJson([
			"draw" => $_GET['draw'],
			"recordsTotal" => $total,
			"recordsFiltered" => $_GET['draw'],
			'data' => $data
		]);

	}

	public function get_ticket(Request $request, Response $response, $args)
	{
		$ticket = DB::table('tickets')->find($args['idticket']);
		return $response->withStatus(200)->withJson($ticket);
	}

	public function save_edit(Request $request, Response $response, $args)
	{

		$param = $request->getParsedBody();

		if ($param['idtickets']) {
			if (!empty($param['estado'])) {
				DB::table('tickets')->where('id', $param['idtickets'])->update([
					'state_tickets_id' => $param['estado'],
					'users_id' => $_SESSION['idusuario']
				]);

				return $response->withStatus(200)->withJson([
					'succes' => true,
					'tipo' => 'success',
					'message' => EDIT
				]);
			} else {
				return $response->withStatus(200)->withJson([
					'succes' => false,
					'redirect' => 1,
					'tipo' => 'error',
					'message' => "Debes seleccionar un estado"
				]);
			}

		} else {


			DB::table('tickets')->create([
				'area' => $param['area'],
				'problem' => $param['problem'],
				'name' => $param['name'],
				'type_message_id' => 2
			]);

			return $response->withStatus(201)->withJson([
				'succes' => true,
				'tipo' => 'success',
				'message' => SAVE
			]);

		}

	}


}