<?php

namespace App\Controladores;

use DI\Container;
use App\Modelos\ModeloUsuarios as Usuarios;
use App\Modelos\ModeloEstados as Estados;
use App\Modelos\ModeloObservaciones as Observaciones;
use App\Modelos\ModeloTickets as Tickets;

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
		$estados = DB::table('state_tickets')->orderBy('description', 'asc')->get();
		return Twig::fromRequest($request)->render($response, 'tickets/tickets.twig', ["estados" => $estados]);
	}

	public function all_tickets(Request $request, Response $response, $args)
	{

		$total = Tickets::count();
		$data = Tickets::select(
			'tickets.area',
			'tickets.name',
			'tickets.id',
			'tickets.problem',
			'tickets.phone',
			'tickets.created_at as fecha',
			DB::raw('(select state_tickets.description from observations inner join state_tickets on (observations.state_tickets_id = state_tickets.id) where tickets_id = tickets.id order by  observations.id desc limit 1) as estado'),
			DB::raw('(select observations.created_at from observations inner join state_tickets on (observations.state_tickets_id = state_tickets.id) where tickets_id = tickets.id and state_tickets_id = 2 order by observations.id desc limit 1) as fecha_solucion'),
			DB::raw('(select observations.comments from observations where tickets_id = tickets.id order by  observations.id desc limit 1) as comentario'),
			DB::raw('(select users.first_name from observations inner join users on (observations.users_id = users.id) where tickets_id = tickets.id order by  observations.id desc limit 1) as responsable')
		)
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
					return $q->where('tickets.phone', 'LIKE', "%" . $_GET['columns'][2]['search']['value'] . "%");
				}
			)
			->when(
				$_GET['columns'][3]['search']['value'] != '',
				function ($q) {
					return $q->where('tickets.problem', 'LIKE', "%" . $_GET['columns'][3]['search']['value'] . "%");
				}
			)
			->when(
				$_GET['columns'][4]['search']['value'] != '',
				function ($q) {
					return $q->whereraw('cast(tickets.created_at as date) LIKE "%' . $_GET['columns'][4]['search']['value'] . '%"');
				}
			)
			->when(
				$_GET['columns'][5]['search']['value'] != '',
				function ($q) {
					return $q->whereraw('(select state_tickets.description from observations inner join state_tickets on (observations.state_tickets_id = state_tickets.id) where tickets_id = tickets.id order by  observations.id desc limit 1) LIKE "%' . $_GET['columns'][5]['search']['value'] . '%"');
				}
			)
			->when(
				$_GET['columns'][6]['search']['value'] != '',
				function ($q) {
					return $q->whereraw('(select users.first_name from observations inner join users on (observations.users_id = users.id) where tickets_id = tickets.id order by  observations.id desc limit 1) LIKE "%' . $_GET['columns'][6]['search']['value'] . '%"');
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
		$ticket = Tickets::select(
			'tickets.area',
			'tickets.name',
			'tickets.id',
			'tickets.problem',
			'tickets.phone',
			'tickets.created_at as fecha',
			DB::raw('(select observations.state_tickets_id from observations inner join state_tickets on (observations.state_tickets_id = state_tickets.id) where tickets_id = tickets.id order by  observations.id desc limit 1) as state_tickets_id')
			
		)
			->where('tickets.id', $args['idticket'])
			->first();

		$comentarios = Observaciones::join('state_tickets', 'state_tickets.id', '=', 'observations.state_tickets_id')
			->where('tickets_id', $args['idticket'])
			->orderBy('observations.created_at', 'DESC')
			->get(['observations.*', 'state_tickets.description']);

		return $response->withStatus(200)->withJson(['ticket' => $ticket, 'comentarios' => $comentarios]);
	}

	public function save_edit(Request $request, Response $response, $args)
	{

		$param = $request->getParsedBody();

		$estadoticket = Observaciones::where('tickets_id', $param['idtickets'])
			->where('state_tickets_id', 2)->first();

		if ($param['idtickets']) {
			if (!empty($param['estado'])) {
				if (empty($estadoticket->state_tickets_id)) {

					/*DB::table('tickets')->where('id', $param['idtickets'])->update([
																	 'state_tickets_id' => $param['estado'],
																	 'users_id' => $_SESSION['idusuario'],
																	 'updated_at' => date('Y-m-d H:i:s')
																 ]);*/

					/* $commet = DB::table('tickets')->join('observations', 'observations.tickets_id', '=', 'tickets.id')
																	 ->where('tickets.id', $param['idtickets'])
																	 ->first(); */

					/* if ($commet) {
																	 DB::table('observations')
																		 ->where('tickets_id', $param['idtickets'])
																		 ->update([
																			 'observations.comments' => $param['textcoment']
																		 ]);
																 } else { */
					Observaciones::create([
						'tickets_id' => $param['idtickets'],
						'comments' => $param['comentario'],
						'users_id' => $_SESSION['idusuario'],
						'state_tickets_id' => $param['estado']
					]);
					//}

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
						'message' => "El ticket ya se encuentra cerrado y no puede ser editado"
					]);
				}
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
				'state_tickets_id' => 1
			]);

			return $response->withStatus(201)->withJson([
				'succes' => true,
				'tipo' => 'success',
				'message' => SAVE
			]);

		}

	}


}