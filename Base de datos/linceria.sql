-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-02-2023 a las 23:53:50
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `linceria`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_precio_producto` (IN `n_cantidad` INT, IN `n_precio` DECIMAL(10,2), IN `codigo` INT)   BEGIN
DECLARE nueva_existencia int;
DECLARE nuevo_total decimal(10,2);
DECLARE nuevo_precio decimal(10,2);

DECLARE cant_actual int;
DECLARE pre_actual decimal(10,2);

DECLARE actual_existencia int;
DECLARE actual_precio decimal(10,2);

SELECT precio, existencia INTO actual_precio, actual_existencia FROM producto WHERE codproducto = codigo;

SET nueva_existencia = actual_existencia + n_cantidad;
SET nuevo_total = n_precio;
SET nuevo_precio = nuevo_total;

UPDATE producto SET existencia = nueva_existencia, precio = nuevo_precio WHERE codproducto = codigo;

SELECT nueva_existencia, nuevo_precio;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_detalle_temp` (`codigo` INT, `cantidad` INT, `token_user` VARCHAR(50))   BEGIN
DECLARE precio_actual decimal(10,2);
SELECT precio INTO precio_actual FROM producto WHERE codproducto = codigo;
INSERT INTO detalle_temp(token_user, codproducto, cantidad, precio_venta) VALUES (token_user, codigo, cantidad, precio_actual);
SELECT tmp.correlativo, tmp.codproducto, p.descripcion, tmp.cantidad, tmp.precio_venta FROM detalle_temp tmp INNER JOIN producto p ON tmp.codproducto = p.codproducto WHERE tmp.token_user = token_user;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `data` ()   BEGIN
DECLARE usuarios int;
DECLARE clientes int;
DECLARE proveedores int;
DECLARE productos int;
DECLARE ventas int;
SELECT COUNT(*) INTO usuarios FROM usuario;
SELECT COUNT(*) INTO clientes FROM cliente;
SELECT COUNT(*) INTO proveedores FROM proveedor;
SELECT COUNT(*) INTO productos FROM producto;
SELECT COUNT(*) INTO ventas FROM factura WHERE fecha > CURDATE();

SELECT usuarios, clientes, proveedores, productos, ventas;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `del_detalle_temp` (`id_detalle` INT, `token` VARCHAR(50))   BEGIN
DELETE FROM detalle_temp WHERE correlativo = id_detalle;
SELECT tmp.correlativo, tmp.codproducto, p.descripcion, tmp.cantidad, tmp.precio_venta FROM detalle_temp tmp INNER JOIN producto p ON tmp.codproducto = p.codproducto WHERE tmp.token_user = token;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procesar_venta` (IN `cod_usuario` INT, IN `cod_cliente` INT, IN `token` VARCHAR(50))   BEGIN
DECLARE factura INT;
DECLARE registros INT;
DECLARE total DECIMAL(10,2);
DECLARE nueva_existencia int;
DECLARE existencia_actual int;

DECLARE tmp_cod_producto int;
DECLARE tmp_cant_producto int;
DECLARE a int;
SET a = 1;

CREATE TEMPORARY TABLE tbl_tmp_tokenuser(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cod_prod BIGINT,
    cant_prod int);
SET registros = (SELECT COUNT(*) FROM detalle_temp WHERE token_user = token);
IF registros > 0 THEN
INSERT INTO tbl_tmp_tokenuser(cod_prod, cant_prod) SELECT codproducto, cantidad FROM detalle_temp WHERE token_user = token;
INSERT INTO factura (usuario,codcliente) VALUES (cod_usuario, cod_cliente);
SET factura = LAST_INSERT_ID();

INSERT INTO detallefactura(nofactura,codproducto,cantidad,precio_venta) SELECT (factura) AS nofactura, codproducto, cantidad,precio_venta FROM detalle_temp WHERE token_user = token;
WHILE a <= registros DO
	SELECT cod_prod, cant_prod INTO tmp_cod_producto,tmp_cant_producto FROM tbl_tmp_tokenuser WHERE id = a;
    SELECT existencia INTO existencia_actual FROM producto WHERE codproducto = tmp_cod_producto;
    SET nueva_existencia = existencia_actual - tmp_cant_producto;
    UPDATE producto SET existencia = nueva_existencia WHERE codproducto = tmp_cod_producto;
    SET a=a+1;
END WHILE;
SET total = (SELECT SUM(cantidad * precio_venta) FROM detalle_temp WHERE token_user = token);
UPDATE factura SET totalfactura = total WHERE nofactura = factura;
DELETE FROM detalle_temp WHERE token_user = token;
TRUNCATE TABLE tbl_tmp_tokenuser;
SELECT * FROM factura WHERE nofactura = factura;
ELSE
SELECT 0;
END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `idcliente` int(11) NOT NULL,
  `dni` int(8) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `telefono` int(15) NOT NULL,
  `direccion` varchar(200) NOT NULL,
  `usuario_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`idcliente`, `dni`, `nombre`, `telefono`, `direccion`, `usuario_id`) VALUES
(1, 12345678, 'hola', 987654321, 'Huanuco 20202', 1),
(2, 77723454, 'marines', 933187261, 'Jr. Huallayco 751-Galeria Victoria-stand 38-Huánuco-Perú', 1),
(3, 74235565, 'dovil', 917272772, 'LIMA', 1),
(4, 12345677, 'nuevo', 917272772, 'huanuco', 10),
(5, 7676767, 'TEFY', 917272772, 'huanuco', 4),
(6, 266543435, 'Dominguez Villanueva Lino', 916232342, 'HUARICHA_MANZANO', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente_a_credito`
--

CREATE TABLE `cliente_a_credito` (
  `idcliente` int(11) NOT NULL,
  `dni` int(8) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `telefono` int(9) NOT NULL,
  `producto` int(11) NOT NULL,
  `preciop` varchar(100) NOT NULL,
  `cantidadp` int(50) NOT NULL,
  `totalp` varchar(1000) NOT NULL,
  `fechaC` date NOT NULL,
  `pago` varchar(100) NOT NULL,
  `deuda` varchar(100) NOT NULL,
  `estado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente_a_credito`
--

INSERT INTO `cliente_a_credito` (`idcliente`, `dni`, `nombre`, `telefono`, `producto`, `preciop`, `cantidadp`, `totalp`, `fechaC`, `pago`, `deuda`, `estado`) VALUES
(1, 0, 'MILLER', 916235565, 2, '24', 2, '12', '2023-01-29', '20', '-8', 'con deuda');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE `configuracion` (
  `id` int(11) NOT NULL,
  `dni` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `razon_social` varchar(100) NOT NULL,
  `telefono` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `direccion` text NOT NULL,
  `igv` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id`, `dni`, `nombre`, `razon_social`, `telefono`, `email`, `direccion`, `igv`) VALUES
(1, 2147483647, 'LINCERIA MAHAL & Fashion', 'LINCERIA MAHAL', 928605197, 'maria@gmail.com', 'HUÁNUCO-PERÚ', '0.18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallefactura`
--

CREATE TABLE `detallefactura` (
  `correlativo` bigint(20) NOT NULL,
  `nofactura` bigint(20) NOT NULL,
  `codproducto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `detallefactura`
--

INSERT INTO `detallefactura` (`correlativo`, `nofactura`, `codproducto`, `cantidad`, `precio_venta`) VALUES
(24, 1, 2, 1, '24.00'),
(25, 14, 1, 1, '18.00'),
(26, 14, 2, 1, '24.00'),
(28, 15, 2, 1, '24.00'),
(29, 16, 2, 1, '24.00'),
(30, 17, 4, 1, '2.00'),
(31, 18, 1, 1, '3.00'),
(32, 18, 3, 1, '0.00'),
(33, 18, 5, 1, '3.00'),
(34, 19, 5, 1, '3.00'),
(35, 19, 5, 1, '3.00'),
(36, 20, 9, 1, '0.00'),
(37, 21, 3, 1, '0.00'),
(38, 21, 1, 1, '3.00'),
(39, 21, 2, 1, '6.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_temp`
--

CREATE TABLE `detalle_temp` (
  `correlativo` int(11) NOT NULL,
  `token_user` varchar(50) NOT NULL,
  `codproducto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entradas`
--

CREATE TABLE `entradas` (
  `correlativo` int(11) NOT NULL,
  `codproducto` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `cantidad` int(11) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `usuario_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `entradas`
--

INSERT INTO `entradas` (`correlativo`, `codproducto`, `fecha`, `cantidad`, `precio`, `usuario_id`) VALUES
(1, 7, '2023-01-22 10:12:22', 22, '15.00', 1),
(2, 8, '2023-01-23 15:19:44', 22, '3.00', 1),
(3, 1, '2023-01-23 15:26:00', 29, '3.50', 1),
(4, 1, '2023-01-29 19:02:48', 5, '18.00', 2),
(5, 1, '2023-01-30 18:45:39', 20, '3.00', 3),
(6, 2, '2023-01-30 18:46:10', 50, '6.00', 3),
(7, 3, '2023-01-30 18:46:35', 100, '0.00', 3),
(8, 1, '2023-02-11 18:48:08', 5, '34.00', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE `estado` (
  `idestado` int(11) NOT NULL,
  `estado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estado`
--

INSERT INTO `estado` (`idestado`, `estado`) VALUES
(1, 'con deuda'),
(2, 'Sin deuda');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `nofactura` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `usuario` int(11) NOT NULL,
  `codcliente` int(11) NOT NULL,
  `totalfactura` decimal(10,2) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`nofactura`, `fecha`, `usuario`, `codcliente`, `totalfactura`, `estado`) VALUES
(1, '2023-01-29 12:58:33', 1, 1, '24.00', 1),
(2, '2023-01-29 18:10:44', 2, 2, '42.00', 1),
(15, '2023-01-29 19:04:08', 2, 2, '24.00', 1),
(16, '2023-01-29 20:17:19', 2, 1, '24.00', 1),
(17, '2023-01-30 17:06:51', 10, 4, '2.00', 1),
(18, '2023-01-30 18:22:30', 4, 5, '6.00', 1),
(19, '2023-01-31 00:22:18', 3, 3, '6.00', 1),
(20, '2023-02-03 19:01:27', 10, 6, '0.00', 1),
(21, '2023-02-12 14:29:47', 3, 3, '9.00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `codproducto` int(11) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `proveedor` int(11) NOT NULL,
  `precio` decimal(11,2) NOT NULL,
  `existencia` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `precio_compra` decimal(11,2) NOT NULL,
  `precio_cuarto` decimal(11,2) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL,
  `precio_final` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`codproducto`, `descripcion`, `proveedor`, `precio`, `existencia`, `usuario_id`, `precio_compra`, `precio_cuarto`, `precio_venta`, `precio_final`) VALUES
(1, 'ALGODON DICAPRI', 1, '3.50', 23, 1, '18.00', '7.00', '19.80', '20.00'),
(2, 'ALGODON NIÑOS DICAPRI', 1, '6.00', 49, 1, '36.00', '15.00', '39.60', '40.00'),
(3, 'VESTIR DICAPRI', 1, '0.00', 98, 1, '24.00', '0.00', '26.40', '27.00'),
(4, 'MEDIAS CUALQUIER TALLA', 2, '2.00', -1, 1, '14.00', '5.00', '15.40', '15.00'),
(5, 'MEDIAS 6-8', 2, '3.00', -3, 1, '15.00', '6.00', '16.50', '17.00'),
(6, 'MEDIAS 8-11', 2, '31.00', 0, 1, '16.00', '6.00', '17.60', '17.00'),
(7, 'MEDIAS OREJITAS', 2, '0.00', 0, 1, '22.00', '0.00', '24.20', '25.00'),
(8, 'MEDIAS PLANTILLA AMANECER', 2, '0.00', 0, 1, '22.00', '0.00', '24.20', '25.00'),
(9, 'PLANTILLA SOCMARK', 2, '0.00', -1, 1, '17.00', '0.00', '18.70', '20.00'),
(10, 'MEDIAS VALERINA', 2, '0.00', 0, 1, '22.00', '0.00', '24.20', '27.00'),
(11, 'MEDIAS VALERINA ALGODÓN', 2, '0.00', 0, 1, '35.00', '0.00', '38.50', '40.00'),
(12, 'MEDIAS FELPA NIÑOS 8-10', 2, '0.00', 0, 1, '22.00', '0.00', '24.20', '28.00'),
(13, 'MEDIAS FELPA NIÑOS 6-8', 2, '0.00', 0, 1, '21.00', '0.00', '23.10', '27.00'),
(14, 'MEDIAS FELPA NIÑOS 4-6', 2, '0.00', 0, 1, '20.00', '0.00', '22.00', '25.00'),
(15, 'MEDIAS FELPA NIÑOS 2-4', 2, '0.00', 0, 1, '19.00', '0.00', '20.90', '25.00'),
(16, 'MEDIAS FELPA NIÑOS 1-2', 2, '0.00', 0, 1, '18.00', '0.00', '19.80', '25.00'),
(17, 'DUREY ADULTO TOB.', 2, '0.00', 0, 1, '36.00', '0.00', '39.60', '40.00'),
(18, 'DUREY ADULTO TAL', 2, '0.00', 0, 1, '36.00', '0.00', '39.60', '40.00'),
(19, 'DUREY NIÑO/A 0-1', 2, '0.00', 0, 1, '30.00', '0.00', '33.00', '35.00'),
(20, 'DUREY NIÑO/A 2-4', 2, '0.00', 0, 1, '30.00', '0.00', '33.00', '35.00'),
(21, 'DUREY NIÑO/A 2-5', 2, '0.00', 0, 1, '30.00', '0.00', '33.00', '35.00'),
(22, 'DUREY NIÑO/A 6-9', 2, '0.00', 0, 1, '30.00', '0.00', '33.00', '35.00'),
(23, 'DUREY NIÑO/A 10-13', 2, '0.00', 0, 1, '32.00', '0.00', '35.20', '35.00'),
(24, 'MEDIAS DE VESTIR SOCMARK', 2, '0.00', 0, 1, '20.00', '0.00', '22.00', '22.00'),
(25, 'MEDIAS DE DAMA LARGA', 2, '0.00', 0, 1, '20.00', '0.00', '22.00', '22.00'),
(26, 'MEDIAS TENNIS ALGODÓN', 2, '0.00', 0, 1, '62.00', '0.00', '68.20', '70.00'),
(27, 'MEDIAS TENNIS', 2, '0.00', 0, 1, '55.00', '0.00', '60.50', '60.00'),
(28, 'MEDIAS WIPPER  BLANCO Y NEGRO', 2, '0.00', 0, 1, '17.00', '0.00', '18.70', '19.00'),
(29, 'MEDIAS WIPPER COLORES DISEÑO', 2, '0.00', 0, 1, '16.00', '0.00', '17.60', '18.00'),
(30, 'INTERIOR VARINIA', 3, '0.00', 0, 1, '19.00', '0.00', '20.90', '21.00'),
(31, 'INTERIOR DE NIÑOS/AS', 3, '0.00', 0, 1, '19.00', '0.00', '20.90', '21.00'),
(32, 'INTERIOR DE NIÑOS/AS ECONOMICAS', 3, '0.00', 0, 1, '17.00', '0.00', '18.70', '19.00'),
(33, 'INTERIOR DIANA S/M/L', 3, '0.00', 0, 1, '26.00', '0.00', '28.60', '30.00'),
(34, 'INTERIOR DIANA XL', 3, '0.00', 0, 1, '34.00', '0.00', '37.40', '38.00'),
(35, 'ENZO S/M/L', 3, '0.00', 0, 1, '25.00', '0.00', '27.50', '27.00'),
(36, 'ENZO XL', 3, '0.00', 0, 1, '32.00', '0.00', '35.20', '35.00'),
(37, 'VIKINIS ANCHOS TALLA L', 3, '0.00', 0, 1, '21.00', '0.00', '23.10', '23.00'),
(38, 'VIKINIS ANCHOS TALLA L CON ENCAJES', 3, '0.00', 0, 1, '22.00', '0.00', '24.20', '24.00'),
(39, 'VIKINIS ESPECIALES', 3, '0.00', 0, 1, '40.00', '0.00', '44.00', '50.00'),
(40, 'VIKINIS ESPECIALES', 3, '0.00', 0, 1, '45.00', '0.00', '49.50', '50.00'),
(41, 'VIKINIS ESPECIALES', 3, '0.00', 0, 1, '46.00', '0.00', '50.60', '50.00'),
(42, 'ENCAJES DELGADOS', 3, '0.00', 0, 1, '40.00', '0.00', '44.00', '52.00'),
(43, 'ENCAJES BOXER', 3, '0.00', 0, 1, '40.00', '0.00', '44.00', '52.00'),
(44, 'BOXER  NIÑOS', 3, '0.00', 0, 1, '38.00', '0.00', '41.80', '42.00'),
(45, 'BELLA STAR  S M L similar a modoly', 3, '0.00', 0, 1, '38.00', '0.00', '41.80', '43.00'),
(46, 'CACHETRA OSHENFor', 3, '0.00', 0, 1, '40.00', '0.00', '44.00', '45.00'),
(47, 'CACHETERA  REYNITA L', 3, '0.00', 0, 1, '40.00', '0.00', '44.00', '45.00'),
(48, 'CACHETERA REYNITA S', 3, '0.00', 0, 1, '33.00', '0.00', '36.30', '37.00'),
(49, 'ANITA VIKINIS', 3, '0.00', 0, 1, '20.00', '0.00', '22.00', '22.00'),
(50, 'PIERNA ALTA', 3, '0.00', 0, 1, '22.00', '0.00', '24.20', '25.00'),
(51, 'MONINA', 3, '0.00', 0, 1, '35.00', '0.00', '38.50', '39.00'),
(52, 'VIVIRI BLANCO 44 S,M,L', 3, '0.00', 0, 1, '43.00', '0.00', '47.30', '50.00'),
(53, 'VIVIRI BLANCO XL', 3, '0.00', 0, 1, '52.00', '0.00', '57.20', '60.00'),
(54, 'BOSTON CALZONCILLO', 4, '0.00', 0, 1, '74.00', '0.00', '81.40', '80.00'),
(55, 'SUPRA CALZONCILLO', 4, '0.00', 0, 1, '70.00', '0.00', '77.00', '78.00'),
(56, 'AMERICANO CALZONCILLO RECUBIERTA', 4, '0.00', 0, 1, '60.00', '0.00', '66.00', '70.00'),
(57, 'AMERICANO CALZONCILLO', 4, '0.00', 0, 1, '66.00', '0.00', '72.60', '75.00'),
(58, 'BOXER SUPRA', 4, '0.00', 0, 1, '130.00', '0.00', '143.00', '150.00'),
(59, 'BOXER BOSTON', 4, '0.00', 0, 1, '0.00', '0.00', '0.00', '0.00'),
(60, 'BOXER SUPRA CON DISEÑO', 4, '0.00', 0, 1, '148.00', '0.00', '162.80', '170.00'),
(61, 'BOSTON NIÑOS', 4, '0.00', 0, 1, '0.00', '0.00', '0.00', '0.00'),
(62, 'SUPRA NIÑOS', 4, '0.00', 0, 1, '0.00', '0.00', '0.00', '0.00'),
(63, 'BOXER NIÑOS', 4, '0.00', 0, 1, '0.00', '0.00', '0.00', '0.00'),
(64, 'VIVIRI BLANCO', 4, '0.00', 0, 1, '106.00', '0.00', '116.60', '0.00'),
(65, 'VIKINIS  ECONOMICOS', 5, '0.00', 0, 1, '17.00', '0.00', '18.70', '0.00'),
(66, 'VIKINIS ANCHOS GRANDES', 5, '0.00', 0, 1, '22.00', '0.00', '24.20', '0.00'),
(67, 'INTERIORES NIÑAS ECONOMICO', 5, '0.00', 0, 1, '17.00', '0.00', '18.70', '0.00'),
(68, 'CACHETERO CALVIN CON DIBUJO MINI', 5, '0.00', 0, 1, '72.00', '0.00', '79.20', '0.00'),
(69, 'CACHETERO CALVIN COLOR ENTERO', 5, '0.00', 0, 1, '68.00', '0.00', '74.80', '0.00'),
(70, 'VIKINI CALVIN CON DIBUJO MINI', 5, '0.00', 0, 1, '72.00', '0.00', '79.20', '0.00'),
(71, 'VIKINI CALVIN CON DISEÑO', 5, '0.00', 0, 1, '68.00', '0.00', '74.80', '0.00'),
(72, 'VIKINI CALVIN COLOR ENTERO', 5, '0.00', 0, 1, '56.00', '0.00', '61.60', '0.00'),
(73, 'SEMIHILO CALVIN CON DIBUJO MINI', 5, '0.00', 0, 1, '72.00', '0.00', '79.20', '0.00'),
(74, 'SEMIHILO CALVIN CON DISEÑO', 5, '0.00', 0, 1, '64.00', '0.00', '70.40', '0.00'),
(75, 'SEMIHILO CALVIN COLOR ENTERO', 5, '0.00', 0, 1, '56.00', '0.00', '61.60', '0.00'),
(76, 'VARON RECUBIERTA S/M/L', 5, '0.00', 0, 1, '24.00', '0.00', '26.40', '0.00'),
(77, 'VARON RECUBIERTA XL', 5, '0.00', 0, 1, '28.00', '0.00', '30.80', '0.00'),
(78, 'MUJER XL', 5, '0.00', 0, 1, '28.00', '0.00', '30.80', '0.00'),
(79, 'INTERIORERES NIÑAS EN CAJITA', 5, '0.00', 0, 1, '42.00', '0.00', '46.20', '0.00'),
(80, 'INTERIORERES NIÑOS EN CAJITA', 5, '0.00', 0, 1, '42.00', '0.00', '46.20', '0.00'),
(81, 'BOMBACHA MUJER ECONOMICA  similar a marys', 5, '0.00', 0, 1, '24.00', '0.00', '26.40', '0.00'),
(82, 'BOMBACHA MUJER similar a diana', 5, '0.00', 0, 1, '28.00', '0.00', '30.80', '0.00'),
(83, 'PIERNA ALTA', 5, '0.00', 0, 1, '22.00', '0.00', '24.20', '0.00'),
(84, 'CACHETERA YAKU', 5, '0.00', 0, 1, '32.00', '0.00', '35.20', '0.00'),
(85, 'CACHETERA  TALLA L', 5, '0.00', 0, 1, '34.00', '0.00', '37.40', '0.00'),
(86, 'MIDOLY S,M,L', 5, '0.00', 0, 1, '47.00', '0.00', '51.70', '0.00'),
(87, 'BELLA ESTAR', 5, '0.00', 0, 1, '0.00', '0.00', '0.00', '0.00'),
(88, 'MARILIN', 5, '0.00', 0, 1, '42.00', '0.00', '46.20', '0.00'),
(89, 'ROMY CALZONES  S, M,L', 5, '0.00', 0, 1, '49.00', '0.00', '53.90', '0.00'),
(90, 'ROMY CALZONES  L y XL', 5, '0.00', 0, 1, '50.00', '0.00', '55.00', '0.00'),
(91, 'VIKINIS ESPECIALES', 5, '0.00', 0, 1, '40.00', '0.00', '44.00', '0.00'),
(92, 'VIKINIS EN CAJA', 5, '0.00', 0, 1, '1.00', '0.00', '1.10', '0.00'),
(93, 'CALZONCILLO BOSTON', 5, '0.00', 0, 1, '76.00', '0.00', '83.60', '0.00'),
(94, 'CALZONCILLO SUPRA', 5, '0.00', 0, 1, '70.00', '0.00', '77.00', '0.00'),
(95, 'CALZONCILLO AMERICANO', 5, '0.00', 0, 1, '0.00', '0.00', '0.00', '0.00'),
(96, 'BOXER SUPRA', 5, '0.00', 0, 1, '134.00', '0.00', '147.40', '0.00'),
(97, 'BOXER BOSTON', 5, '0.00', 0, 1, '145.00', '0.00', '159.50', '0.00'),
(98, 'AMERICANO CALZONCILLO RECUBIERTA', 5, '0.00', 0, 1, '60.00', '0.00', '66.00', '0.00'),
(99, 'CALVIN DAMA BOXER', 5, '0.00', 0, 1, '48.00', '0.00', '52.80', '0.00'),
(100, 'CALVIN DAMA VIKINI', 5, '0.00', 0, 1, '45.00', '0.00', '49.50', '0.00'),
(101, 'CALVIN DAMA SEMIHILO', 5, '0.00', 0, 1, '45.00', '0.00', '49.50', '0.00'),
(102, 'CALVIN DAMA CACHETERA', 5, '0.00', 0, 1, '0.00', '0.00', '0.00', '0.00'),
(103, 'RAYAS DOBLE FORRO', 5, '0.00', 0, 1, '0.00', '0.00', '0.00', '0.00'),
(104, 'RAYAS ECONOMICO', 5, '0.00', 0, 1, '0.00', '0.00', '0.00', '0.00'),
(105, 'NIÑOS ECONOMICOS', 5, '0.00', 0, 1, '17.00', '0.00', '18.70', '0.00'),
(106, 'VIKINIS ECONOMICOS', 6, '0.00', 0, 1, '17.00', '0.00', '18.70', '0.00'),
(107, 'VIKINIS GRANDES', 6, '0.00', 0, 1, '21.00', '0.00', '23.10', '0.00'),
(108, 'CACHETERA M Y L', 6, '0.00', 0, 1, '38.00', '0.00', '41.80', '0.00'),
(109, 'ELVIS', 6, '0.00', 0, 1, '23.50', '0.00', '25.85', '0.00'),
(110, 'BOMBACHA', 6, '0.00', 0, 1, '22.00', '0.00', '24.20', '0.00'),
(111, 'ANITA VIKINIS', 6, '0.00', 0, 1, '20.00', '0.00', '22.00', '0.00'),
(112, 'PIERNA ALTA ECONOMICA', 6, '0.00', 0, 1, '21.00', '0.00', '23.10', '0.00'),
(113, 'CACHETERA  V', 6, '0.00', 0, 1, '36.00', '0.00', '39.60', '0.00'),
(114, 'CACHETRA M Y L', 6, '0.00', 0, 1, '38.00', '0.00', '41.80', '0.00'),
(115, 'NIÑOS EN CAJA', 6, '0.00', 0, 1, '45.00', '0.00', '49.50', '0.00'),
(116, 'BOXER NIÑO', 6, '0.00', 0, 1, '39.00', '0.00', '42.90', '0.00'),
(117, 'BOXER ADULTO', 6, '0.00', 0, 1, '46.00', '0.00', '50.60', '0.00'),
(118, 'RAYAS DOBLE FORRO', 6, '0.00', 0, 1, '59.00', '0.00', '64.90', '0.00'),
(119, 'RAYAS ECONOMICO', 6, '0.00', 0, 1, '0.00', '0.00', '0.00', '0.00'),
(120, 'LIGA BOSTON', 6, '0.00', 0, 1, '20.00', '0.00', '22.00', '0.00'),
(121, 'RECUBIERTA ECONOMICA', 7, '0.00', 0, 1, '16.00', '0.00', '17.60', '0.00'),
(122, 'RECUBIERTA VARON', 7, '0.00', 0, 1, '23.00', '0.00', '25.30', '0.00'),
(123, 'BOMBACHA EL BUENO', 7, '0.00', 0, 1, '23.00', '0.00', '25.30', '0.00'),
(124, 'BOMBACHA ECONOMICA CON DISEÑO', 7, '0.00', 0, 1, '18.00', '0.00', '19.80', '0.00'),
(125, 'BOMBACHA ECONOMICA', 7, '0.00', 0, 1, '16.00', '0.00', '17.60', '0.00'),
(126, 'TOPCITO LIGA DELGADA', 7, '0.00', 0, 1, '16.00', '0.00', '17.60', '0.00'),
(127, 'TOP VIVIRI', 7, '0.00', 0, 1, '18.00', '0.00', '19.80', '0.00'),
(128, 'VIKINI CHACON', 7, '0.00', 0, 1, '18.00', '0.00', '19.80', '0.00'),
(129, 'VIKINI LECHUZA', 7, '0.00', 0, 1, '17.00', '0.00', '18.70', '0.00'),
(130, 'CACHETERA CON BLONDAS EN LA CINTURA', 7, '0.00', 0, 1, '42.00', '0.00', '46.20', '0.00'),
(131, 'TOPCITO CHICO CON LIGA DELGADO', 7, '0.00', 0, 1, '16.00', '0.00', '17.60', '0.00'),
(132, 'TOP CON REGULADOR', 7, '0.00', 0, 1, '22.00', '0.00', '24.20', '0.00'),
(133, 'TOP POLITA', 7, '0.00', 0, 1, '26.00', '0.00', '28.60', '0.00'),
(134, 'FORMADORES SUELTOS', 7, '0.00', 0, 1, '14.00', '0.00', '15.40', '0.00'),
(135, 'FORMADORES', 7, '0.00', 0, 1, '20.00', '0.00', '22.00', '0.00'),
(136, 'CARRELLY CHICO', 7, '0.00', 0, 1, '30.00', '0.00', '33.00', '0.00'),
(137, 'BRASIER 1 BROCHA', 7, '0.00', 0, 1, '25.00', '0.00', '27.50', '0.00'),
(138, 'BRASIER CARRELLY', 7, '0.00', 0, 1, '32.00', '0.00', '35.20', '0.00'),
(139, 'BRASIER ALGODÓN EXTRA', 7, '0.00', 0, 1, '36.00', '0.00', '39.60', '0.00'),
(140, 'BOXER NIÑO COLOR ENTERO', 7, '0.00', 0, 1, '38.00', '0.00', '41.80', '0.00'),
(141, 'BOXER NIÑO ESTAMAPADO', 7, '0.00', 0, 1, '40.00', '0.00', '44.00', '0.00'),
(142, 'PIERNA ALTA M y L', 7, '0.00', 0, 1, '20.00', '0.00', '22.00', '0.00'),
(143, 'PIERNA ALTA CHACOS', 7, '0.00', 0, 1, '22.00', '0.00', '24.20', '0.00'),
(144, 'CACHETERA S', 7, '0.00', 0, 1, '32.00', '0.00', '35.20', '0.00'),
(145, 'CACHETERA YAKU  M Y L', 7, '0.00', 0, 1, '34.00', '0.00', '37.40', '0.00'),
(146, 'CACHETERAS GRANDES SIMILAR CON CINTURAS DIFERENTES LOS AMS MONSES', 7, '0.00', 0, 1, '38.00', '0.00', '41.80', '0.00'),
(147, 'CACHETRA DAMIS (SIMILAR MIDOLY )', 7, '0.00', 0, 1, '40.00', '0.00', '44.00', '0.00'),
(148, 'CACHETRA CON CINTURA COMO CALVIN PEOR EN MESTIZAS', 7, '0.00', 0, 1, '42.00', '0.00', '46.20', '0.00'),
(149, 'INTERIORES NIÑA ECONOMICAS C', 7, '0.00', 0, 1, '15.00', '0.00', '16.50', '0.00'),
(150, 'INTERIORES NIÑA ECONOMICAS B', 7, '0.00', 0, 1, '16.00', '0.00', '17.60', '0.00'),
(151, 'INTERIORES NIÑA ECONOMICAS A', 7, '0.00', 0, 1, '17.00', '0.00', '18.70', '0.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `codproveedor` int(11) NOT NULL,
  `proveedor` varchar(100) NOT NULL,
  `contacto` varchar(100) NOT NULL,
  `telefono` int(11) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `usuario_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`codproveedor`, `proveedor`, `contacto`, `telefono`, `direccion`, `usuario_id`) VALUES
(1, 'DICAPRI', '987654321', 7654321, 'Huanuco', 1),
(2, 'MADRINA MELBER', '987654322', 7654321, 'Huanuco', 1),
(3, 'SRA YENI', '987654323', 7654321, 'Huanuco', 1),
(4, 'BOSTON', '987654324', 7654321, 'Huanuco', 1),
(5, 'SRA TERESA', '987654325', 7654321, 'Huanuco', 1),
(6, 'SRA MARYS', '987654326', 7654321, 'Huanuco', 1),
(7, 'VALVERDE', '987654327', 7654321, 'Huanuco', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `idrol` int(11) NOT NULL,
  `rol` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`idrol`, `rol`) VALUES
(1, 'Administrador'),
(2, 'Vendedor(a)');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `usuario` varchar(20) NOT NULL,
  `clave` varchar(50) NOT NULL,
  `rol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nombre`, `correo`, `usuario`, `clave`, `rol`) VALUES
(3, 'DOMINGUEZ VILLANUEVA LINO', 'dovillove1@gmail.com', 'DOMINGUEZ', 'a3d0b2c255ba7b7a1333dd982687ceaa', 1),
(4, 'ARACELLY MARINES DIAZ CASTAÑEDA', 'aracely@gmail.com', 'marines', '341de0219bc435be75cf51f588d53a7a', 3),
(9, 'vendedor1', 'vende@gmail.com', 'Vendedor 1', 'e10adc3949ba59abbe56e057f20f883e', 3),
(10, 'JUAN', 'juan@gmal.com', 'juan', 'e10adc3949ba59abbe56e057f20f883e', 2),
(12, 'MARINES ARASELLY  DIAZ CASTAÑEDA', 'marines@gmail.com', 'MARINES', '341de0219bc435be75cf51f588d53a7a', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`idcliente`);

--
-- Indices de la tabla `cliente_a_credito`
--
ALTER TABLE `cliente_a_credito`
  ADD PRIMARY KEY (`idcliente`),
  ADD KEY `producto_clientecredito` (`producto`);

--
-- Indices de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `detallefactura`
--
ALTER TABLE `detallefactura`
  ADD PRIMARY KEY (`correlativo`);

--
-- Indices de la tabla `detalle_temp`
--
ALTER TABLE `detalle_temp`
  ADD PRIMARY KEY (`correlativo`);

--
-- Indices de la tabla `entradas`
--
ALTER TABLE `entradas`
  ADD PRIMARY KEY (`correlativo`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`nofactura`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`codproducto`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`codproveedor`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`idrol`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `idcliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `detallefactura`
--
ALTER TABLE `detallefactura`
  MODIFY `correlativo` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `detalle_temp`
--
ALTER TABLE `detalle_temp`
  MODIFY `correlativo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `entradas`
--
ALTER TABLE `entradas`
  MODIFY `correlativo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `nofactura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `codproducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=152;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `codproveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `idrol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cliente_a_credito`
--
ALTER TABLE `cliente_a_credito`
  ADD CONSTRAINT `producto_clientecredito` FOREIGN KEY (`producto`) REFERENCES `producto` (`codproducto`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
