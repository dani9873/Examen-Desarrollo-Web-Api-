-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 21, 2023 at 04:30 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `umg`
--

-- --------------------------------------------------------

--
-- Table structure for table `carrera`
--

CREATE TABLE `carrera` (
  `idcarrera` int(11) NOT NULL,
  `nombre_carrera` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `carrera`
--

INSERT INTO `carrera` (`idcarrera`, `nombre_carrera`) VALUES
(1, 'maestria en recursos humanos'),
(2, 'maestria en finanzas'),
(3, 'maestria en marketing'),
(4, 'maestria en negocios'),
(5, 'maestria en emprendimiento'),
(6, 'maestria en gestion de operaciones'),
(7, 'maestria en gestion de restaurantes'),
(8, 'maestria en gestion de hoteles');

-- --------------------------------------------------------

--
-- Table structure for table `estudiante`
--

CREATE TABLE `estudiante` (
  `idestudiante` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `carne` varchar(100) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `cursos_aprobados` int(11) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `idcarrera` int(11) NOT NULL,
  `idsede` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `estudiante`
--

INSERT INTO `estudiante` (`idestudiante`, `nombre`, `carne`, `fecha_nacimiento`, `cursos_aprobados`, `direccion`, `idcarrera`, `idsede`) VALUES
(2, 'Sony Epson Gonzalez', '787878787', '2000-02-02', 23, 'Diagonal 1 9-56 Huehuetenango', 3, 2),
(8, 'Rosa Mesa Lopez', '999999999', '1983-04-30', 10, '8 calle 6-34 Ciudad Capital', 8, 3),
(9, 'Franco Escamilla', '333434343', '1990-05-10', 5, '8av 6-45 zona 1, Ciudad de Guatemala', 4, 6),
(10, 'Lionel Messi Guarchaj', '7111111111', '2002-12-03', 19, 'Canton Simocol, Santa Cruz del Quiché', 7, 2),
(11, 'Zoila Dolores Mendez', '222929292', '2003-06-26', 8, 'Zona 1 Zacapa', 6, 6),
(12, 'Alba Surero Garcia', '1111010101', '2023-09-16', 21, 'Colonia Guerrero, Zona 2, Chimaltenango', 8, 3),
(13, 'Juan Pérez', '100001', '2000-01-01', 30, 'Calle 123, City', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `sede`
--

CREATE TABLE `sede` (
  `idsede` int(11) NOT NULL,
  `nombre_sede` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `sede`
--

INSERT INTO `sede` (`idsede`, `nombre_sede`) VALUES
(1, 'Quetzaltenango'),
(2, 'Huehuetenango'),
(3, 'Ciudad Capital'),
(4, 'Mixco'),
(5, 'Antigua Guatemala'),
(6, 'Villa Nueva'),
(7, 'San Salvador'),
(8, 'Santa Ana');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carrera`
--
ALTER TABLE `carrera`
  ADD PRIMARY KEY (`idcarrera`);

--
-- Indexes for table `estudiante`
--
ALTER TABLE `estudiante`
  ADD PRIMARY KEY (`idestudiante`),
  ADD KEY `estudiante_carrera` (`idcarrera`),
  ADD KEY `estudiante_sede` (`idsede`);

--
-- Indexes for table `sede`
--
ALTER TABLE `sede`
  ADD PRIMARY KEY (`idsede`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carrera`
--
ALTER TABLE `carrera`
  MODIFY `idcarrera` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `estudiante`
--
ALTER TABLE `estudiante`
  MODIFY `idestudiante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `sede`
--
ALTER TABLE `sede`
  MODIFY `idsede` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `estudiante`
--
ALTER TABLE `estudiante`
  ADD CONSTRAINT `estudiante_carrera` FOREIGN KEY (`idcarrera`) REFERENCES `carrera` (`idcarrera`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `estudiante_sede` FOREIGN KEY (`idsede`) REFERENCES `sede` (`idsede`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
