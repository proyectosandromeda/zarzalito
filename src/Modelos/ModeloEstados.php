<?php
namespace App\Modelos;

//importa Eloquent para usarlo en el modelo
use Illuminate\Database\Eloquent\Model as Eloquent;

class ModeloEstados extends Eloquent
{
   // Define la llave primaria de la tabla usuarios
   protected $primaryKey = 'id';

   // Define el nombre de la tabla 
   protected $table = 'state';

   public $timestamps = false;
   
     // Define los campos que pueden llenarse en la tabla
   protected $fillable = [
       'description'
   ];
 
}