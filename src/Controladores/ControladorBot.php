<?php

namespace App\Controladores;

use DI\Container;
use App\Modelos\ModeloUsuarios as Usuarios;
use App\Modelos\ModeloEstados as Estados;
use App\Controladores\OnboardingConversation as BotChat;

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
use BotMan\BotMan\BotManFactory;
use BotMan\BotMan\Drivers\DriverManager;
use Doctrine\Common\Cache\FilesystemCache;
use BotMan\BotMan\Cache\SymfonyCache;
use Symfony\Component\Cache\Adapter\FilesystemAdapter;



/**
 * Clase de controlador para el usuario de la aplicación
 */

class ControladorBot
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
		$config = DB::table('configuration')->select('configuration.id', 'configuration.text_info', 'type_message.description')
			->join('type_message', 'type_message.id', '=', 'configuration.type_message_id')
			->get();


		return Twig::fromRequest($request)->render($response, 'bot/bot.twig', [
			'config' => $config
		]);
	}

	public function load_bot(Request $request, Response $response, $args)
    {
        return Twig::fromRequest($request)->render($response, 'bot/test_bot.twig');
    }

	public function plantilla(Request $request, Response $response, $args)
    {
        return Twig::fromRequest($request)->render($response, 'bot/plantilla_chat.twig');
    }


	public function save_edit(Request $request, Response $response, $args)
	{

		$param = $request->getParsedBody();
		
		if ($param['idconfig']) {

			DB::table('configuration')->where('id',1)->update([
				'text_info' => $param['text_info']
			]);

			return $response->withStatus(200)->withJson([
				'succes' => true,
				'tipo' => 'success',
				'message' => 'Datos actualizados'
			]);

		} else {

			if (empty($exist->email)) {
				DB::table('configuration')->insert([
					'text_info' => $param['text_info'],
					'type_message_id' => 1
				]);

				return $response->withStatus(201)->withJson([
					'succes' => true,
					'tipo' => 'success',
					'message' => SAVE
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

    public function bot_funcionalidad(Request $request, Response $response, $args)
    {
        $param = $request->getParsedBody();
        
        DriverManager::loadDriver(\BotMan\Drivers\Web\WebDriver::class);
        // Configurar caché
        $adapter = new FilesystemAdapter();
        $cache = new SymfonyCache($adapter);

        $config = [
            'user_cache_time' => 40,
            'config' => [
                'conversation_cache_time' => 40,
            ]
        ];
        
        // Crear instancia de BotMan
        $botman = BotManFactory::create($config, $cache);      
        $botman->hears('.*|menu|MENU|Menu', function ($bot) {
            $bot->startConversation(new BotChat);
        });

        $botman->listen();
        return $response->withStatus(200);
    }

}