<?php
namespace App\Modelos;

//importa Eloquent para usarlo en el modelo
use Illuminate\Database\Eloquent\Model as Eloquent;

class ModeloObservaciones extends Eloquent
{
   // Define la llave primaria de la tabla usuarios
   protected $primaryKey = 'id';

   // Define el nombre de la tabla 
   protected $table = 'observations';

   public $timestamps = true;
   
     // Define los campos que pueden llenarse en la tabla
   protected $fillable = [
       'comments',
       'tickets_id',
       'users_id',
       'state_tickets_id'
   ];
 
}