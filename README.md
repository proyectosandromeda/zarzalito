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

3. Configura las variables de entorno copiando el archivo `.env.example` a [.env](http://_vscodecontentref_/6) y ajustando los valores según sea necesario. Aquí están las variables que necesitas configurar:

    ```env
    HOST_BD_MYSQL=tu_host
    BD_MYSQL=tu_base_de_datos
    USER_BD_MYSQL=tu_usuario
    PASS_BD_MYSQL=tu_contraseña

    EMAIL_HOST=smtp.tu_proveedor_email.com
    EMAIL_PORT=587
    EMAIL_USERNAME=tu_email@dominio.com
    EMAIL_PASSWORD=tu_contraseña_email
    EMAIL_FROM_ADDRESS=tu_email@dominio.com
    EMAIL_FROM_NAME="Tu Nombre"
    ```

4. Ejecuta las migraciones de la base de datos:
    ```sh
    php artisan migrate
    ```

## Uso
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

3. Configura las variables de entorno copiando el archivo `.env.example` a [.env](http://_vscodecontentref_/6) y ajustando los valores según sea necesario. Aquí están las variables que necesitas configurar:

    ```env
    HOST_BD_MYSQL=tu_host
    BD_MYSQL=tu_base_de_datos
    USER_BD_MYSQL=tu_usuario
    PASS_BD_MYSQL=tu_contraseña

    EMAIL_HOST=smtp.tu_proveedor_email.com
    EMAIL_PORT=587
    EMAIL_USERNAME=tu_email@dominio.com
    EMAIL_PASSWORD=tu_contraseña_email
    EMAIL_FROM_ADDRESS=tu_email@dominio.com
    EMAIL_FROM_NAME="Tu Nombre"
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
La solución consta de dos componentes principales:

- **Widget de Bot (Javascript):** Permite insertar un chatbot en cualquier página web. Funciona de manera autónoma conectándose al servidor backend para gestionar la lógica del bot.
- **Panel Administrativo:** Desarrollado con PHP y Bootstrap para configurar el comportamiento del bot, administrar preguntas y respuestas, y gestionar usuarios. Toda la información se almacena en una base de datos MySQL.

---

## Requisitos Previos

### Para el Widget:
- Navegadores compatibles: Últimas versiones de Chrome, Firefox o Edge.

### Para el Servidor:
- **PHP:** Versión 8.3 o superior.
- **MySQL:** Base de datos para almacenar la lógica del bot.
- **Docker:** Docker Engine y Docker Compose instalados.

---

## Instalación del Widget

1. Copia el siguiente código en la página HTML donde deseas mostrar el bot:

```html
<script>
var botmanWidget = {
  frameEndpoint: 'http://{{url}}/bot/plantilla',
  chatServer: 'http://{{url}}/bot/start',
  title: 'ROBI',
  introMessage: '¡Hola! Este es el nuevo mensaje.',
  placeholderText: 'Pregúntame algo',
  mainColor: '#0943B5',
  bubbleBackground: '#0943B5',
  headerTextColor: '#ffffff',
  bubbleAvatarUrl: 'http://{{url}}/assets/images/bot.png'
};
</script>
<script src="https://cdn.jsdelivr.net/npm/botman-web-widget@0/build/js/widget.js"></script>
```

2. Configura las siguientes variables según sea necesario:
   - `frameEndpoint`: URL de la plantilla o interfaz visual del bot.
   - `chatServer`: URL del servidor que gestiona la lógica conversacional.
   - Personaliza colores, mensajes y el avatar del bot según tu diseño.

3. Guarda los cambios en la página y recarga el sitio web para verificar la integración.

Para iniciar el servidor de desarrollo, ejecuta:
```sh
php -S localhost:8000 -t public
```

## Licencia
Este proyecto está licenciado bajo la MIT License.
````