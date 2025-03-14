<?php

namespace App\Controladores;

use App\Modelos\ModeloObservaciones as Observaciones;

use BotMan\BotMan\Messages\Conversations\Conversation;
use BotMan\BotMan\Messages\Incoming\Answer;
use BotMan\BotMan\Messages\Outgoing\Question;
use BotMan\BotMan\Messages\Outgoing\Actions\Button;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ResponseFactoryInterface;
use Illuminate\Database\Capsule\Manager as DB;

class OnboardingConversation extends Conversation
{
    protected $nombre;
    protected $problema;

    protected $telefono;
    protected $num_ident;
    protected $area;
    protected $hora;
    protected $num_apartamento;
    protected $nom_reserva;

    public function run()
    {
        //$recipient = $this->bot->getMessage()->getSender();
        //$jsonString = file_get_contents('php://input');
        //$data = json_decode($jsonString, true);
        $this->inicio();
    }

    /**
     * Summary of inicio
     * @return void
     */
    public function inicio()
    {

        $mensaje = DB::table('configuration')->select('configuration.id', 'configuration.text_info', 'type_message.description')
            ->join('type_message', 'type_message.id', '=', 'configuration.type_message_id')
            ->where('configuration.id', 1)
            ->first();

        $this->say($mensaje->text_info);
        $this->solicita_nombre();

    }
    /**
     * Summary of menu_principal
     * @return void
     */
    public function solicita_nombre()
    {

        // Manejar la respuesta
        $this->ask('Por favor ingresa tu nombre completo', function (Answer $answer) {
            $this->nombre = $answer->getText();
            $this->solicita_telefono();
        });

    }


    /**
     * Summary of solicita_area
     * @return void
     */
    public function solicita_area()
    {
        $mensaje = "Ahora, indíquenos a qué dependencia u oficina pertenece. Escriba en un solo párrafo. Ejemplo: Contabilidad.";
        $this->ask($mensaje, function (Answer $answer) {
            $this->area = $answer->getText();
            $this->solicitud_problema();
        });
    }

    public function solicita_telefono()
    {
        $mensaje = "Gracias ".$this->nombre." ahora indíquenos su número telefono";
        $this->ask($mensaje, function (Answer $answer) {
            $this->telefono = $answer->getText();
            $this->solicita_area();
        });
    }

    public function solicitud_problema()
    {
        $mensaje = "Perfecto, Para continuar, cuéntame brevemente qué necesita del área de sistemas <br><b>Recuerda enviar el texto en un párrafo sin hacer enter.</b><br> Ejemplo: Requiero mantenimiento de mi computador";
        $this->ask($mensaje, function (Answer $answer) {
            $this->problema = $answer->getText();
            $this->confirmar_datos();
        });
    }

    public function confirmar_datos()
    {
        $mensaje = "Por favor confirma la información para generar el ticket:";
        $mensaje .= "Nombre: " . $this->nombre.PHP_EOL."\n";
        $mensaje .= "Area: " . $this->area.PHP_EOL."\n";
        $mensaje .= "Telefono: " . $this->telefono.PHP_EOL."\n"; 
        $mensaje .= "Problema: " . $this->problema.PHP_EOL."\n"; 

        $buttons[] = Button::create("SI")->value("si");
        $buttons[] = Button::create("NO")->value("no");
        $question = Question::create($mensaje)
            ->addButtons($buttons);

        // Crear botones y enviar al usuario
        $this->ask($question, function ($answer) {
            // $response = $answer->getValue() ?: $answer->getText();
            if ($answer->getValue() == 'si') {
                $this->finalizar();
            } else {
                $this->solicita_nombre();
            }
        });
    }

    public function finalizar()
    {

        $idticket = DB::table('tickets')->insertGetId([
            'name' => $this->nombre,
            'area' => $this->area,
            'phone' => $this->telefono,
            'problem' => $this->problema,            
            'created_at' => date('Y-m-d H:i:s'),
            'updated_at' => date('Y-m-d H:i:s')
        ]);

        Observaciones::create([
            'tickets_id' => $idticket,
            'comments' => $this->problema,
            'state_tickets_id' => 1            
        ]);

        $ntiket = str_pad($idticket, 6, "0", STR_PAD_LEFT);
        $mensaje = "Solicitud de Mantenimiento Recibido. su ticket es el <b>número #".$ntiket."</b> Estaremos trabajando lo más pronto posible en su solución. Gracias por utilizar nuestro servicio de mantenimiento Zarzalito.";
        $this->say($mensaje);
    }



}