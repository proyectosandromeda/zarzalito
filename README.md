# Proyecto

## Descripción

Este proyecto es una aplicación web que utiliza varias tecnologías y bibliotecas para proporcionar una experiencia de usuario rica e interactiva. La estructura del proyecto está organizada en diferentes directorios para mantener el código limpio y modular.

## Estructura del Proyecto
Estructura de Directorios  
**config/:** Contiene archivos de configuración para la aplicación.  
**public/:** Contiene los archivos públicos accesibles desde el navegador, incluyendo index.php que es el punto de entrada de la aplicación.  
**src/:** Contiene el código fuente de la aplicación, incluyendo controladores y modelos.  
**templates/:** Contiene las plantillas Twig para la vista.  
vendor/: Contiene las dependencias instaladas por Composer.  

Dependencias
El proyecto utiliza varias bibliotecas y frameworks, incluyendo:  

Composer para la gestión de dependencias de PHP.  
Twig para la renderización de plantillas.  
jQuery y varios plugins de jQuery para funcionalidades de frontend.  
Bootstrap para el diseño y estilos de la interfaz de usuario.  
DataTables para tablas interactivas.  
SweetAlert2 para alertas personalizadas.  

## Instalación

1. Clona el repositorio:
    ```sh
    git clone <URL_DEL_REPOSITORIO>
    ```

2. Instala las dependencias de PHP usando Composer:
    ```sh
    composer install
    ```

3. Configura las variables de entorno copiando el archivo `.env.example` a [.env](http://_vscodecontentref_/7) y ajustando los valores según sea necesario. Aquí están las variables que necesitas configurar:

    ```env
    HOST_BD_MYSQL=tu_host
    BD_MYSQL=tu_base_de_datos
    USER_BD_MYSQL=tu_usuario
    PASS_BD_MYSQL=tu_contraseña
    ```

4. Ejecuta las migraciones de la base de datos:
    ```sh
    php artisan migrate
    ```

## Uso

Para iniciar el servidor de desarrollo, ejecuta:
```sh
php -S localhost:8000 -t public
```

## Licencia
Este proyecto está licenciado bajo la MIT License.
````
