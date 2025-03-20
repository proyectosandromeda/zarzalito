-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 20-03-2025 a las 16:57:39
-- Versión del servidor: 8.0.41-0ubuntu0.22.04.1
-- Versión de PHP: 8.2.28

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `zarzalito`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `activations`
--

CREATE TABLE `activations` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `completed` tinyint DEFAULT '0',
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `activations`
--

INSERT INTO `activations` (`id`, `user_id`, `code`, `completed`, `completed_at`, `created_at`, `updated_at`) VALUES
(1, 1, '698555s5s5s5ss5', 1, '2025-02-05 20:04:23', '2025-02-05 20:04:37', '2025-02-05 20:04:37'),
(4, 4, 'Vk0HXxPbXm4G9srFAcUcBbJZQvcimmxl', 0, NULL, '2025-02-10 19:28:37', '2025-02-10 19:28:37'),
(5, 5, 'OfxT8L3nt98SM1PTJeGINZpAeuvAwVLs', 0, NULL, '2025-02-10 19:29:19', '2025-02-10 19:29:19'),
(6, 6, 'zHjZWh1yOEkaBjHHbOrqI4K5p5pwIb0J', 0, NULL, '2025-02-10 19:29:43', '2025-02-10 19:29:43'),
(7, 7, 'b4GlBVEN2d95kBi7QzQYcmGzLeP23DRQ', 0, NULL, '2025-02-10 19:31:37', '2025-02-10 19:31:37'),
(8, 8, 'VOyUUv0nlXwbPDvT1UlI6p3tWG6tD5hj', 0, NULL, '2025-02-10 19:32:52', '2025-02-10 19:32:52'),
(9, 9, 't1WoyJxum1dQLfZ9Vkr3unyV3NLWmhmb', 0, NULL, '2025-02-10 19:35:08', '2025-02-10 19:35:08'),
(10, 10, 'TgyjZ9lC6tFY6nEGsSUmJ9ySRXk0DreV', 0, NULL, '2025-02-10 19:36:32', '2025-02-10 19:36:32'),
(11, 11, 'Fu1hAmnargOUIesNNRRy9XJTVGBDocSm', 0, NULL, '2025-02-10 19:36:56', '2025-02-10 19:36:56'),
(12, 12, 'bMepzX32lrdPVs2TCu8J8YLgH6FU4hwM', 1, '2025-02-17 05:00:00', '2025-02-10 19:38:19', '2025-02-10 19:38:19'),
(13, 13, 'qR9FqDystPU8eD6bBBjAeSTsGRlUqSIn', 1, '2025-02-17 20:05:27', '2025-02-17 19:24:23', '2025-02-17 19:24:23'),
(14, 14, 'MpKr7NuxUQbYmBo0WUF08DM9bjJQKqeL', 1, '2025-02-17 05:00:00', '2025-02-17 19:24:46', '2025-02-17 19:24:46'),
(15, 15, 'UbIJfLZYJ8kY3izuixAHHaGZmAXnwmPS', 1, '2025-02-17 20:02:39', '2025-02-17 19:25:11', '2025-02-17 19:25:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuration`
--

CREATE TABLE `configuration` (
  `id` int NOT NULL,
  `text_info` text,
  `type_message_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `configuration`
--

INSERT INTO `configuration` (`id`, `text_info`, `type_message_id`) VALUES
(1, '¡Hola!  Bienvenido/a a Zarzalito <b>sistema de gestión de tickets de mantenimiento. </b>Estoy aquí para ayudarte a registrar tu solicitud:', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu_aplicacion`
--

CREATE TABLE `menu_aplicacion` (
  `id` int NOT NULL,
  `title` mediumtext,
  `url` varchar(45) DEFAULT NULL,
  `pid` varchar(45) DEFAULT NULL,
  `parent` int DEFAULT NULL,
  `icon_class` varchar(45) DEFAULT NULL,
  `view` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `menu_aplicacion`
--

INSERT INTO `menu_aplicacion` (`id`, `title`, `url`, `pid`, `parent`, `icon_class`, `view`) VALUES
(1, 'Usuarios', 'usuarios', '1', 0, 'fas fa-users', 1),
(2, 'Administrar Bot', 'bot/create_bot', '3', 3, 'fas fa-robot', 1),
(3, 'Bot', 'configuracion', '2', 0, 'fas fa-robot', 1),
(4, 'Tikets', 'tickets', '3', 0, 'fas fa-ticket-alt me-2', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `observations`
--

CREATE TABLE `observations` (
  `id` int NOT NULL,
  `comments` text,
  `tickets_id` int NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `users_id` int DEFAULT NULL,
  `state_tickets_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persistences`
--

CREATE TABLE `persistences` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `persistences`
--

INSERT INTO `persistences` (`id`, `user_id`, `code`, `created_at`, `updated_at`) VALUES
(13, 1, 'AAdLvP0xL6MEJz7SbhFFABLWzvxSYERO', '2025-02-05 20:25:52', '2025-02-05 20:25:52'),
(27, 1, 'GkviAwZj1hk0F4KfFJWy5lxkbaYjzKzM', '2025-02-06 13:11:28', '2025-02-06 13:11:28'),
(28, 1, 'WqLzCYb4now1oNDz9W3tl8FFSLxdTyDh', '2025-02-07 13:32:23', '2025-02-07 13:32:23'),
(29, 1, 'bfuT8Uf8hQaGHneuJjsZgL0YqSqSpAdJ', '2025-02-07 18:57:11', '2025-02-07 18:57:11'),
(30, 1, 'EPCMSgb7HM2ht8KbxAWwtkjLOijvLoMr', '2025-02-07 20:11:41', '2025-02-07 20:11:41'),
(31, 1, 'xmRZ6leb1tLzrEzebzKt4iwFeXE2fKVU', '2025-02-07 21:17:13', '2025-02-07 21:17:13'),
(32, 1, 'r2hTRptOwybda3zCbOG3eXAFakUBqm9f', '2025-02-10 15:46:05', '2025-02-10 15:46:05'),
(34, 1, 'c8JVyVOE4gXn4tnQ0qdt1t0oa3ohSgGS', '2025-02-10 17:29:39', '2025-02-10 17:29:39'),
(35, 1, 'fJzGucy6RsynOVUB8bfhOcYPyJEHVpni', '2025-02-10 19:59:15', '2025-02-10 19:59:15'),
(36, 1, 'lSoSltOjiZHZkOvjHkayLVZ2nxhBUJPR', '2025-02-10 21:38:51', '2025-02-10 21:38:51'),
(37, 1, 'slvpAQJRDXPpc1pJfu5r1yqNUk2W4OWJ', '2025-02-11 20:11:37', '2025-02-11 20:11:37'),
(39, 1, 'L4itXB7MACqkZTMIESrheGG9muF9uG25', '2025-02-11 20:14:03', '2025-02-11 20:14:03'),
(41, 1, 'j76k1tJA1nCHxuw6gtQMzxyDo2VICIVr', '2025-02-17 14:26:23', '2025-02-17 14:26:23'),
(44, 15, 'H3UfYvJQxGHtTB4jBkxSKzqV3tdWfCO5', '2025-02-17 20:25:28', '2025-02-17 20:25:28'),
(46, 1, 'cz1kBvd1MEHA9WyRMaQpYfhBxRsqkda0', '2025-02-19 14:39:20', '2025-02-19 14:39:20'),
(49, 1, '32bQmTMhwk27OMgmjTjvXjbfNycB7sRH', '2025-02-20 16:08:13', '2025-02-20 16:08:13'),
(53, 1, 'gWavhCxyf2hwQBWmm1J7AW2qiNUGdYXD', '2025-03-14 15:39:35', '2025-03-14 15:39:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reminders`
--

CREATE TABLE `reminders` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `completed` tinyint NOT NULL DEFAULT '0',
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int NOT NULL,
  `slug` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `permissions` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `slug`, `name`, `permissions`, `created_at`, `updated_at`) VALUES
(1, 'administrador', 'Administrador', '{\"Home\":true,\r\n\"javascript:void(0)\":true,\r\n\"Usuarios\":true,\r\n\"AddUsers\":true,\r\n\"Configuracion\":true,\r\n\"SaveConfig\":true,\r\n\"#bot\":true,\r\n\"Tickets\":true,\r\n\"AllTickets\":true,\r\n\"SaveTikect\":true,\r\n\"BOT\":true\r\n}', '2025-02-05 20:15:15', '2025-02-05 20:15:15'),
(2, 'asistentes', 'Técnico', '{}', '2025-02-07 14:10:12', '2025-02-07 14:10:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_users`
--

CREATE TABLE `role_users` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `role_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `role_users`
--

INSERT INTO `role_users` (`id`, `user_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2025-02-05 20:25:17', '2025-02-05 20:25:17'),
(12, 13, 2, '2025-02-17 19:24:23', '2025-02-17 19:24:23'),
(13, 14, 2, '2025-02-17 19:24:46', '2025-02-17 19:24:46'),
(15, 15, 1, '2025-02-17 19:25:37', '2025-02-17 19:25:37');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `state`
--

CREATE TABLE `state` (
  `id` int NOT NULL,
  `description` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `state`
--

INSERT INTO `state` (`id`, `description`) VALUES
(1, 'Habilitado'),
(2, 'Inhabilitado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `state_tickets`
--

CREATE TABLE `state_tickets` (
  `id` int NOT NULL,
  `description` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `state_tickets`
--

INSERT INTO `state_tickets` (`id`, `description`) VALUES
(1, 'En proceso'),
(2, 'Realizado'),
(3, 'Pendiente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `throttle`
--

CREATE TABLE `throttle` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `throttle`
--

INSERT INTO `throttle` (`id`, `user_id`, `type`, `ip`, `created_at`, `updated_at`) VALUES
(1, NULL, 'global', NULL, '2025-02-05 20:07:00', '2025-02-05 20:07:00'),
(2, NULL, 'ip', '::1', '2025-02-05 20:07:00', '2025-02-05 20:07:00'),
(3, NULL, 'global', NULL, '2025-02-05 20:07:07', '2025-02-05 20:07:07'),
(4, NULL, 'ip', '::1', '2025-02-05 20:07:07', '2025-02-05 20:07:07'),
(5, NULL, 'global', NULL, '2025-02-05 20:08:06', '2025-02-05 20:08:06'),
(6, NULL, 'ip', '::1', '2025-02-05 20:08:06', '2025-02-05 20:08:06'),
(7, 1, 'user', NULL, '2025-02-05 20:08:06', '2025-02-05 20:08:06'),
(8, NULL, 'global', NULL, '2025-02-07 18:57:05', '2025-02-07 18:57:05'),
(9, NULL, 'ip', '::1', '2025-02-07 18:57:05', '2025-02-07 18:57:05'),
(10, NULL, 'global', NULL, '2025-02-10 17:12:40', '2025-02-10 17:12:40'),
(11, NULL, 'ip', '::1', '2025-02-10 17:12:40', '2025-02-10 17:12:40'),
(12, NULL, 'global', NULL, '2025-02-10 17:13:37', '2025-02-10 17:13:37'),
(13, NULL, 'ip', '::1', '2025-02-10 17:13:37', '2025-02-10 17:13:37'),
(14, NULL, 'global', NULL, '2025-02-10 17:14:20', '2025-02-10 17:14:20'),
(15, NULL, 'ip', '::1', '2025-02-10 17:14:20', '2025-02-10 17:14:20'),
(16, NULL, 'global', NULL, '2025-02-10 17:15:14', '2025-02-10 17:15:14'),
(17, NULL, 'ip', '::1', '2025-02-10 17:15:14', '2025-02-10 17:15:14'),
(18, NULL, 'global', NULL, '2025-02-10 17:20:01', '2025-02-10 17:20:01'),
(19, NULL, 'ip', '::1', '2025-02-10 17:20:01', '2025-02-10 17:20:01'),
(20, NULL, 'global', NULL, '2025-02-10 17:27:51', '2025-02-10 17:27:51'),
(21, NULL, 'ip', '::1', '2025-02-10 17:27:51', '2025-02-10 17:27:51'),
(22, NULL, 'global', NULL, '2025-02-19 22:59:37', '2025-02-19 22:59:37'),
(23, NULL, 'ip', '::1', '2025-02-19 22:59:37', '2025-02-19 22:59:37'),
(24, 15, 'user', NULL, '2025-02-19 22:59:37', '2025-02-19 22:59:37'),
(25, NULL, 'global', NULL, '2025-03-07 13:25:45', '2025-03-07 13:25:45'),
(26, NULL, 'ip', '::1', '2025-03-07 13:25:45', '2025-03-07 13:25:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tickets`
--

CREATE TABLE `tickets` (
  `id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `area` varchar(45) DEFAULT NULL,
  `problem` text,
  `phone` varchar(45) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `type_message`
--

CREATE TABLE `type_message` (
  `id` int NOT NULL,
  `description` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `type_message`
--

INSERT INTO `type_message` (`id`, `description`) VALUES
(1, 'Mensaje de bienvenida');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `permissions` text,
  `last_login` timestamp NULL DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `permissions`, `last_login`, `first_name`, `last_name`, `created_at`, `updated_at`) VALUES
(1, 'mail@correo.com', '$2y$10$sPateoIW1BaTdGsu9rRVMOY6x.10c2c9kqxbiqQH2luCMDHyruAt2', NULL, '2025-03-14 20:04:01', 'prueba', 'pruebita', '2025-02-05 20:04:18', '2025-03-14 20:04:01'),
(13, 'rivera.jorge@correounivalle.edu.co', '$2y$10$/PaIdnh23RynNGSY0wznbudLv0X/txoaRZizU26pXcDB6bDBnF7jS', NULL, NULL, 'Jorge Antonio ', 'Rivera ', '2025-02-17 19:24:23', '2025-02-17 19:24:23'),
(14, 'einer.zamora@correounivalle.edu.co', '$2y$10$uSNoIs/fuG1xIRigi8Y3B.8SJ2O5a4yWOAFtkP5sfSfTJQdxaOaj.', NULL, NULL, 'Alejandro ', 'Zamora', '2025-02-17 19:24:46', '2025-02-17 19:24:46'),
(15, 'informatica@zarzal-valle.gov.co', '$2y$10$b/jHdHZt/JYAS0nc5M7ejOifgR27rQMhLwzLKuZET97Q.qsvSGkmS', NULL, '2025-02-17 20:25:28', ' Carlos Manuel ', 'Nuñez Diaz', '2025-02-17 19:25:11', '2025-02-19 22:59:16');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_analisis_sla`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_analisis_sla` (
`agente_primera_respuesta` varchar(511)
,`agente_resolucion` varchar(511)
,`area` varchar(45)
,`cumplimiento_sla_respuesta` varchar(10)
,`estado_resolucion` varchar(9)
,`fecha_creacion` datetime
,`horas_hasta_primera_respuesta` bigint
,`horas_hasta_resolucion` bigint
,`ticket_id` int
,`ticket_nombre` varchar(45)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_dashboard_principal`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_dashboard_principal` (
`dimension` varchar(45)
,`metrica` varchar(21)
,`porcentaje` decimal(26,2)
,`valor` bigint
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_desempeno_agentes`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_desempeno_agentes` (
`email` varchar(255)
,`nombre_agente` varchar(511)
,`permisos` text
,`promedio_horas_resolucion` decimal(24,4)
,`promedio_interacciones_por_ticket` decimal(24,4)
,`promedio_minutos_primera_respuesta` decimal(24,4)
,`tickets_abiertos_actuales` decimal(23,0)
,`tickets_atendidos` bigint
,`tickets_resueltos` decimal(23,0)
,`total_interacciones` bigint
,`usuario_id` int
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_historial_estados`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_historial_estados` (
`comentarios` text
,`estado_id` int
,`fecha_cambio` datetime
,`minutos_en_estado_anterior` bigint
,`nombre_estado` varchar(45)
,`nombre_usuario` varchar(511)
,`observacion_id` int
,`ticket_nombre` varchar(45)
,`tickets_id` int
,`usuario_id` int
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_metricas_por_estado`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_metricas_por_estado` (
`cantidad_tickets` bigint
,`estado_id` int
,`nombre_estado` varchar(45)
,`promedio_horas_en_estado` decimal(24,4)
,`promedio_horas_primera_respuesta` decimal(24,4)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_metricas_sla`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_metricas_sla` (
`porcentaje_cumple_sla_respondidos` decimal(24,4)
,`porcentaje_cumple_sla_respondidos_100` decimal(28,5)
,`porcentaje_cumple_sla_total` decimal(24,4)
,`porcentaje_cumple_sla_total_100` decimal(28,5)
,`tickets_con_respuesta` bigint
,`tickets_cumple_sla` bigint
,`tickets_no_cumple_sla` bigint
,`tickets_sin_respuesta` bigint
,`total_tickets` bigint
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_metricas_tiempo`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_metricas_tiempo` (
`anio` int
,`fecha` datetime
,`mes` int
,`promedio_horas_resolucion` decimal(24,4)
,`semana` varchar(9)
,`tickets_creados` bigint
,`tickets_resueltos` bigint
,`yearmonth` varchar(7)
,`yearweek` int
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_tickets_completa`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_tickets_completa` (
`agente_actual` varchar(511)
,`area` varchar(45)
,`descripcion_problema` text
,`duracion_total_dias` bigint
,`duracion_total_horas` bigint
,`duracion_total_minutos` bigint
,`duracion_total_segundos` bigint
,`estado_actual` varchar(45)
,`estado_actual_id` bigint
,`fecha_actualizacion` datetime
,`fecha_creacion` datetime
,`horas_desde_ultima_actualizacion` bigint
,`minutos_primera_respuesta` bigint
,`num_interacciones` bigint
,`primer_agente` varchar(511)
,`telefono_contacto` varchar(45)
,`ticket_id` int
,`ticket_nombre` varchar(45)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_analisis_sla`
--
DROP TABLE IF EXISTS `vw_analisis_sla`;

CREATE OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_analisis_sla`  AS SELECT `t`.`id` AS `ticket_id`, `t`.`name` AS `ticket_nombre`, `t`.`area` AS `area`, `t`.`created_at` AS `fecha_creacion`, timestampdiff(HOUR,`t`.`created_at`,min(`o`.`created_at`)) AS `horas_hasta_primera_respuesta`, (case when (timestampdiff(HOUR,`t`.`created_at`,min(`o`.`created_at`)) <= 24) then 'Cumple SLA' else 'Excede SLA' end) AS `cumplimiento_sla_respuesta`, timestampdiff(HOUR,`t`.`created_at`,(select min(`o2`.`created_at`) from (`observations` `o2` join `state_tickets` `st` on((`o2`.`state_tickets_id` = `st`.`id`))) where ((`o2`.`tickets_id` = `t`.`id`) and ((`st`.`description` like '%Realizado%') or (`st`.`description` like '%realizado%') or (`st`.`description` = 'Closed') or (`st`.`description` = 'Cerrado'))))) AS `horas_hasta_resolucion`, (case when exists(select 1 from (`observations` `o2` join `state_tickets` `st` on((`o2`.`state_tickets_id` = `st`.`id`))) where ((`o2`.`tickets_id` = `t`.`id`) and ((`st`.`description` like '%Realizado%') or (`st`.`description` like '%realizado%') or (`st`.`description` = 'Closed') or (`st`.`description` = 'Cerrado')))) then 'Resuelto' else 'Pendiente' end) AS `estado_resolucion`, (select concat(`u`.`first_name`,' ',`u`.`last_name`) from (`observations` `o2` join `users` `u` on((`o2`.`users_id` = `u`.`id`))) where (`o2`.`tickets_id` = `t`.`id`) order by `o2`.`created_at` limit 1) AS `agente_primera_respuesta`, (select concat(`u`.`first_name`,' ',`u`.`last_name`) from ((`observations` `o2` join `users` `u` on((`o2`.`users_id` = `u`.`id`))) join `state_tickets` `st` on((`o2`.`state_tickets_id` = `st`.`id`))) where ((`o2`.`tickets_id` = `t`.`id`) and ((`st`.`description` like '%realizado%') or (`st`.`description` like '%Realizado%') or (`st`.`description` = 'Closed') or (`st`.`description` = 'Cerrado'))) order by `o2`.`created_at` limit 1) AS `agente_resolucion` FROM (`tickets` `t` left join `observations` `o` on((`o`.`tickets_id` = `t`.`id`))) GROUP BY `t`.`id`, `t`.`name`, `t`.`area`, `t`.`created_at` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_dashboard_principal`
--
DROP TABLE IF EXISTS `vw_dashboard_principal`;

CREATE OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_dashboard_principal`  AS SELECT 'Total Tickets' AS `metrica`, count(0) AS `valor`, NULL AS `dimension`, NULL AS `porcentaje` FROM `tickets` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_desempeno_agentes`
--
DROP TABLE IF EXISTS `vw_desempeno_agentes`;

CREATE OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_desempeno_agentes`  AS SELECT `u`.`id` AS `usuario_id`, concat(`u`.`first_name`,' ',`u`.`last_name`) AS `nombre_agente`, `u`.`email` AS `email`, `u`.`permissions` AS `permisos`, count(distinct `o`.`tickets_id`) AS `tickets_atendidos`, sum((case when ((`st`.`description` like '%realizado%') or (`st`.`description` like '%Realizado%') or (`st`.`description` = 'Closed') or (`st`.`description` = 'Cerrado')) then 1 else 0 end)) AS `tickets_resueltos`, avg((case when (`o2`.`orden` = 1) then timestampdiff(MINUTE,`t`.`created_at`,`o2`.`created_at`) else NULL end)) AS `promedio_minutos_primera_respuesta`, avg((case when ((`st`.`description` like '%Realizado%') or (`st`.`description` like '%realizado%') or (`st`.`description` = 'Closed') or (`st`.`description` = 'Cerrado')) then timestampdiff(HOUR,`t`.`created_at`,`o`.`created_at`) else NULL end)) AS `promedio_horas_resolucion`, sum((case when ((not((`st`.`description` like '%Realizado%'))) and (not((`st`.`description` like '%Realizado%'))) and (`st`.`description` <> 'Closed') and (`st`.`description` <> 'Cerrado')) then 1 else 0 end)) AS `tickets_abiertos_actuales`, count(`o`.`id`) AS `total_interacciones`, (count(`o`.`id`) / count(distinct `o`.`tickets_id`)) AS `promedio_interacciones_por_ticket` FROM ((((`users` `u` left join `observations` `o` on((`o`.`users_id` = `u`.`id`))) left join `tickets` `t` on((`o`.`tickets_id` = `t`.`id`))) left join `state_tickets` `st` on((`o`.`state_tickets_id` = `st`.`id`))) left join (select `o`.`tickets_id` AS `tickets_id`,`o`.`users_id` AS `users_id`,`o`.`created_at` AS `created_at`,row_number() OVER (PARTITION BY `o`.`tickets_id` ORDER BY `o`.`created_at` )  AS `orden` from `observations` `o`) `o2` on(((`o2`.`tickets_id` = `o`.`tickets_id`) and (`o2`.`users_id` = `o`.`users_id`) and (`o2`.`created_at` = `o`.`created_at`)))) WHERE exists(select 1 from `role_users` `ru` where (`ru`.`user_id` = `u`.`id`)) GROUP BY `u`.`id`, `nombre_agente`, `u`.`email`, `u`.`permissions` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_historial_estados`
--
DROP TABLE IF EXISTS `vw_historial_estados`;

CREATE OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_historial_estados`  AS SELECT `o`.`id` AS `observacion_id`, `o`.`tickets_id` AS `tickets_id`, `t`.`name` AS `ticket_nombre`, `o`.`created_at` AS `fecha_cambio`, `st`.`id` AS `estado_id`, `st`.`description` AS `nombre_estado`, `u`.`id` AS `usuario_id`, concat(`u`.`first_name`,' ',`u`.`last_name`) AS `nombre_usuario`, `o`.`comments` AS `comentarios`, timestampdiff(MINUTE,lag(`o`.`created_at`) OVER (PARTITION BY `o`.`tickets_id` ORDER BY `o`.`created_at` ) ,`o`.`created_at`) AS `minutos_en_estado_anterior` FROM (((`observations` `o` join `tickets` `t` on((`o`.`tickets_id` = `t`.`id`))) join `state_tickets` `st` on((`o`.`state_tickets_id` = `st`.`id`))) join `users` `u` on((`o`.`users_id` = `u`.`id`))) ORDER BY `o`.`tickets_id` ASC, `o`.`created_at` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_metricas_por_estado`
--
DROP TABLE IF EXISTS `vw_metricas_por_estado`;

CREATE OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_metricas_por_estado`  AS SELECT `st`.`id` AS `estado_id`, `st`.`description` AS `nombre_estado`, count(distinct `o`.`tickets_id`) AS `cantidad_tickets`, avg(timestampdiff(HOUR,`t`.`created_at`,(select min(`o2`.`created_at`) from `observations` `o2` where (`o2`.`tickets_id` = `o`.`tickets_id`)))) AS `promedio_horas_primera_respuesta`, avg(timestampdiff(HOUR,`t`.`created_at`,`o`.`created_at`)) AS `promedio_horas_en_estado` FROM ((`state_tickets` `st` left join `observations` `o` on((`o`.`state_tickets_id` = `st`.`id`))) left join `tickets` `t` on((`o`.`tickets_id` = `t`.`id`))) GROUP BY `st`.`id`, `st`.`description` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_metricas_sla`
--
DROP TABLE IF EXISTS `vw_metricas_sla`;

CREATE OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_metricas_sla`  AS   with `total_tickets` as (select count(0) AS `total` from `tickets`), `tickets_con_respuesta` as (select count(0) AS `total_con_respuesta` from `tickets` `t` where exists(select 1 from `observations` `o` where (`o`.`tickets_id` = `t`.`id`))), `tickets_cumple_sla` as (select count(0) AS `total_cumple_sla` from (`tickets` `t` join (select `observations`.`tickets_id` AS `tickets_id`,min(`observations`.`created_at`) AS `primera_respuesta` from `observations` group by `observations`.`tickets_id`) `o` on((`o`.`tickets_id` = `t`.`id`))) where (timestampdiff(HOUR,`t`.`created_at`,`o`.`primera_respuesta`) <= 24)) select (select `total_tickets`.`total` from `total_tickets`) AS `total_tickets`,(select `tickets_con_respuesta`.`total_con_respuesta` from `tickets_con_respuesta`) AS `tickets_con_respuesta`,(select `tickets_cumple_sla`.`total_cumple_sla` from `tickets_cumple_sla`) AS `tickets_cumple_sla`,((select `total_tickets`.`total` from `total_tickets`) - (select `tickets_con_respuesta`.`total_con_respuesta` from `tickets_con_respuesta`)) AS `tickets_sin_respuesta`,((select `tickets_con_respuesta`.`total_con_respuesta` from `tickets_con_respuesta`) - (select `tickets_cumple_sla`.`total_cumple_sla` from `tickets_cumple_sla`)) AS `tickets_no_cumple_sla`,((select `tickets_cumple_sla`.`total_cumple_sla` from `tickets_cumple_sla`) / (select `total_tickets`.`total` from `total_tickets`)) AS `porcentaje_cumple_sla_total`,((select `tickets_cumple_sla`.`total_cumple_sla` from `tickets_cumple_sla`) / (select `tickets_con_respuesta`.`total_con_respuesta` from `tickets_con_respuesta`)) AS `porcentaje_cumple_sla_respondidos`,(((select `tickets_cumple_sla`.`total_cumple_sla` from `tickets_cumple_sla`) * 100.0) / (select `total_tickets`.`total` from `total_tickets`)) AS `porcentaje_cumple_sla_total_100`,(((select `tickets_cumple_sla`.`total_cumple_sla` from `tickets_cumple_sla`) * 100.0) / (select `tickets_con_respuesta`.`total_con_respuesta` from `tickets_con_respuesta`)) AS `porcentaje_cumple_sla_respondidos_100`  ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_metricas_tiempo`
--
DROP TABLE IF EXISTS `vw_metricas_tiempo`;

CREATE OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_metricas_tiempo`  AS   with `fechas` as (select min(`tickets`.`created_at`) AS `fecha_inicio`,curdate() AS `fecha_fin` from `tickets`), `rango_dias` as (select (`f`.`fecha_inicio` + interval ((`t1`.`seq` + `t2`.`seq`) + `t3`.`seq`) day) AS `fecha` from (((`fechas` `f` join (select 0 AS `seq` union all select 1 AS `1` union all select 2 AS `2` union all select 3 AS `3` union all select 4 AS `4` union all select 5 AS `5` union all select 6 AS `6` union all select 7 AS `7` union all select 8 AS `8` union all select 9 AS `9`) `t1`) join (select 0 AS `seq` union all select 10 AS `10` union all select 20 AS `20` union all select 30 AS `30` union all select 40 AS `40` union all select 50 AS `50` union all select 60 AS `60` union all select 70 AS `70` union all select 80 AS `80` union all select 90 AS `90`) `t2`) join (select 0 AS `seq` union all select 100 AS `100` union all select 200 AS `200` union all select 300 AS `300` union all select 400 AS `400` union all select 500 AS `500` union all select 600 AS `600` union all select 700 AS `700` union all select 800 AS `800` union all select 900 AS `900`) `t3`) where ((`f`.`fecha_inicio` + interval ((`t1`.`seq` + `t2`.`seq`) + `t3`.`seq`) day) <= `f`.`fecha_fin`)) select `rd`.`fecha` AS `fecha`,yearweek(`rd`.`fecha`,0) AS `yearweek`,concat(year(`rd`.`fecha`),'-W',lpad(week(`rd`.`fecha`,0),2,'0')) AS `semana`,date_format(`rd`.`fecha`,'%Y-%m') AS `yearmonth`,year(`rd`.`fecha`) AS `anio`,month(`rd`.`fecha`) AS `mes`,count(distinct (case when (cast(`t`.`created_at` as date) = `rd`.`fecha`) then `t`.`id` else NULL end)) AS `tickets_creados`,count(distinct (case when ((cast(`o`.`created_at` as date) = `rd`.`fecha`) and ((`st`.`description` like '%resuel%') or (`st`.`description` like '%resuelt%') or (`st`.`description` = 'Closed') or (`st`.`description` = 'Cerrado'))) then `o`.`tickets_id` else NULL end)) AS `tickets_resueltos`,avg((case when ((cast(`o`.`created_at` as date) = `rd`.`fecha`) and ((`st`.`description` like '%resuel%') or (`st`.`description` like '%resuelt%') or (`st`.`description` = 'Closed') or (`st`.`description` = 'Cerrado'))) then timestampdiff(HOUR,`t`.`created_at`,`o`.`created_at`) else NULL end)) AS `promedio_horas_resolucion` from (((`rango_dias` `rd` left join `tickets` `t` on((cast(`t`.`created_at` as date) = `rd`.`fecha`))) left join `observations` `o` on((cast(`o`.`created_at` as date) = `rd`.`fecha`))) left join `state_tickets` `st` on((`o`.`state_tickets_id` = `st`.`id`))) group by `rd`.`fecha` order by `rd`.`fecha`  ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_tickets_completa`
--
DROP TABLE IF EXISTS `vw_tickets_completa`;

CREATE OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_tickets_completa`  AS SELECT `t`.`id` AS `ticket_id`, `t`.`name` AS `ticket_nombre`, `t`.`area` AS `area`, `t`.`problem` AS `descripcion_problema`, `t`.`phone` AS `telefono_contacto`, `t`.`created_at` AS `fecha_creacion`, `t`.`updated_at` AS `fecha_actualizacion`, timestampdiff(SECOND,`t`.`created_at`,`t`.`updated_at`) AS `duracion_total_segundos`, timestampdiff(MINUTE,`t`.`created_at`,`t`.`updated_at`) AS `duracion_total_minutos`, timestampdiff(HOUR,`t`.`created_at`,`t`.`updated_at`) AS `duracion_total_horas`, timestampdiff(DAY,`t`.`created_at`,`t`.`updated_at`) AS `duracion_total_dias`, (select `st`.`description` from (`observations` `o` join `state_tickets` `st` on((`o`.`state_tickets_id` = `st`.`id`))) where (`o`.`tickets_id` = `t`.`id`) order by `o`.`created_at` desc limit 1) AS `estado_actual`, (select `o`.`state_tickets_id` from `observations` `o` where (`o`.`tickets_id` = `t`.`id`) order by `o`.`created_at` desc limit 1) AS `estado_actual_id`, (select concat(`u`.`first_name`,' ',`u`.`last_name`) from (`observations` `o` join `users` `u` on((`o`.`users_id` = `u`.`id`))) where (`o`.`tickets_id` = `t`.`id`) order by `o`.`created_at` limit 1) AS `primer_agente`, (select concat(`u`.`first_name`,' ',`u`.`last_name`) from (`observations` `o` join `users` `u` on((`o`.`users_id` = `u`.`id`))) where (`o`.`tickets_id` = `t`.`id`) order by `o`.`created_at` desc limit 1) AS `agente_actual`, (select timestampdiff(MINUTE,`t`.`created_at`,min(`o`.`created_at`)) from `observations` `o` where (`o`.`tickets_id` = `t`.`id`)) AS `minutos_primera_respuesta`, (select count(0) from `observations` `o` where (`o`.`tickets_id` = `t`.`id`)) AS `num_interacciones`, timestampdiff(HOUR,`t`.`updated_at`,now()) AS `horas_desde_ultima_actualizacion` FROM `tickets` AS `t` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `activations`
--
ALTER TABLE `activations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_activations_users1_idx` (`user_id`);

--
-- Indices de la tabla `configuration`
--
ALTER TABLE `configuration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_configuration_type_message1_idx` (`type_message_id`);

--
-- Indices de la tabla `menu_aplicacion`
--
ALTER TABLE `menu_aplicacion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `observations`
--
ALTER TABLE `observations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_observations_tickets1_idx` (`tickets_id`),
  ADD KEY `fk_observations_users1_idx` (`users_id`),
  ADD KEY `fk_observations_state_tickets1_idx` (`state_tickets_id`);

--
-- Indices de la tabla `persistences`
--
ALTER TABLE `persistences`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_persistences_users1_idx` (`user_id`),
  ADD KEY `persistences_code_unique` (`code`);

--
-- Indices de la tabla `reminders`
--
ALTER TABLE `reminders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_reminders_users1_idx` (`user_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `roles_slug_unique` (`slug`);

--
-- Indices de la tabla `role_users`
--
ALTER TABLE `role_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_role_users_users1_idx` (`user_id`),
  ADD KEY `fk_role_users_roles1_idx` (`role_id`);

--
-- Indices de la tabla `state`
--
ALTER TABLE `state`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `state_tickets`
--
ALTER TABLE `state_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `throttle`
--
ALTER TABLE `throttle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_throttle_users1_idx` (`user_id`);

--
-- Indices de la tabla `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `type_message`
--
ALTER TABLE `type_message`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `activations`
--
ALTER TABLE `activations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `configuration`
--
ALTER TABLE `configuration`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `menu_aplicacion`
--
ALTER TABLE `menu_aplicacion`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `observations`
--
ALTER TABLE `observations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `persistences`
--
ALTER TABLE `persistences`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT de la tabla `reminders`
--
ALTER TABLE `reminders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `role_users`
--
ALTER TABLE `role_users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `state`
--
ALTER TABLE `state`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `state_tickets`
--
ALTER TABLE `state_tickets`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `throttle`
--
ALTER TABLE `throttle`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `type_message`
--
ALTER TABLE `type_message`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `activations`
--
ALTER TABLE `activations`
  ADD CONSTRAINT `fk_activations_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `configuration`
--
ALTER TABLE `configuration`
  ADD CONSTRAINT `fk_configuration_type_message1` FOREIGN KEY (`type_message_id`) REFERENCES `type_message` (`id`);

--
-- Filtros para la tabla `observations`
--
ALTER TABLE `observations`
  ADD CONSTRAINT `fk_observations_state_tickets1` FOREIGN KEY (`state_tickets_id`) REFERENCES `state_tickets` (`id`),
  ADD CONSTRAINT `fk_observations_tickets1` FOREIGN KEY (`tickets_id`) REFERENCES `tickets` (`id`),
  ADD CONSTRAINT `fk_observations_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `persistences`
--
ALTER TABLE `persistences`
  ADD CONSTRAINT `fk_persistences_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `reminders`
--
ALTER TABLE `reminders`
  ADD CONSTRAINT `fk_reminders_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `role_users`
--
ALTER TABLE `role_users`
  ADD CONSTRAINT `fk_role_users_roles1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `fk_role_users_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `throttle`
--
ALTER TABLE `throttle`
  ADD CONSTRAINT `fk_throttle_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
