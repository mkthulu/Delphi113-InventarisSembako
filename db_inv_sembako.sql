-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 30, 2023 at 04:13 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_inv_sembako`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id_admin` smallint(5) UNSIGNED NOT NULL,
  `username` varchar(24) NOT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(16) NOT NULL,
  `first_name` varchar(42) NOT NULL,
  `last_name` varchar(42) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id_admin`, `username`, `password`, `salt`, `first_name`, `last_name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '', 'admin8k32TcIDqOEbNRM', '8k32TcIDqOEbNRM', '', '', '2023-05-15 14:30:01', '2023-06-29 19:25:27', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `goods`
--

CREATE TABLE `goods` (
  `kd_goods` char(1) NOT NULL DEFAULT 'B',
  `id_goods` mediumint(8) UNSIGNED NOT NULL,
  `goods_name` varchar(128) NOT NULL,
  `goods_price` decimal(13,2) NOT NULL,
  `goods_stock` smallint(6) NOT NULL,
  `admin_id` smallint(5) UNSIGNED NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `goods`
--

INSERT INTO `goods` (`kd_goods`, `id_goods`, `goods_name`, `goods_price`, `goods_stock`, `admin_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
('B', 4, 'Keju', '10000.00', 0, 1, '2023-05-17 16:51:30', '2023-05-17 16:51:30', '2023-05-17 17:34:43'),
('B', 5, 'Mayo', '8000.50', 0, 1, '2023-05-17 16:59:39', '2023-05-17 16:59:39', NULL),
('B', 6, 'Keju', '6000.00', 0, 1, '2023-05-17 17:36:25', '2023-05-17 17:36:25', NULL),
('B', 7, 'Kecap', '3000.00', 0, 1, '2023-05-17 17:36:36', '2023-05-17 17:36:36', NULL),
('B', 8, 'Saos', '2000.00', 0, 1, '2023-05-17 17:37:32', '2023-05-17 17:37:32', NULL),
('B', 9, 'Beras Premium 5Kg', '25000.00', 0, 1, '2023-05-17 17:38:29', '2023-05-17 17:38:29', NULL),
('B', 10, 'Gula Pasir 500G', '7000.00', 0, 1, '2023-05-17 17:39:08', '2023-05-17 17:39:08', NULL),
('B', 11, 'Kopi Kapal Api', '2500.00', 0, 1, '2023-05-17 17:40:21', '2023-05-17 19:43:45', NULL),
('B', 12, 'Susu', '5000.00', 0, 1, '2023-05-17 17:42:17', '2023-05-17 17:42:17', NULL),
('B', 13, 'Le Minerale', '2000.00', 0, 1, '2023-05-17 17:42:39', '2023-05-17 17:42:39', NULL),
('B', 14, 'Minyak', '7000.00', 0, 1, '2023-05-17 17:43:04', '2023-05-17 17:43:04', NULL),
('B', 15, 'Cabe Rawit', '1000.00', 0, 1, '2023-05-17 17:44:22', '2023-05-17 17:44:22', NULL),
('B', 16, 'KukuBima', '4000.00', 0, 1, '2023-05-17 20:38:20', '2023-05-17 20:38:20', NULL),
('B', 17, 'Susu atu', '3123.00', 0, 1, '2023-06-29 19:08:00', '2023-06-29 19:08:00', '2023-06-29 19:08:14');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `kd_sale` char(1) NOT NULL DEFAULT 'J',
  `id_sale` int(10) UNSIGNED NOT NULL,
  `goods_id` mediumint(8) UNSIGNED NOT NULL,
  `sale_price` decimal(13,2) NOT NULL,
  `sale_qty` tinyint(3) NOT NULL,
  `buyer` varchar(128) NOT NULL,
  `admin_id` smallint(5) UNSIGNED NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`kd_sale`, `id_sale`, `goods_id`, `sale_price`, `sale_qty`, `buyer`, `admin_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
('J', 13, 12, '5000.00', 1, '', 1, '2023-05-28 21:34:08', '2023-05-28 21:34:08', '2023-05-29 13:14:17'),
('J', 14, 10, '7000.00', 2, '', 1, '2023-05-28 21:34:16', '2023-05-28 21:34:16', '2023-05-28 22:18:31');

-- --------------------------------------------------------

--
-- Table structure for table `sales_cart`
--

CREATE TABLE `sales_cart` (
  `kd_sale` char(1) NOT NULL DEFAULT 'J',
  `id_sale` int(10) UNSIGNED NOT NULL,
  `goods_id` mediumint(8) UNSIGNED NOT NULL,
  `sale_price` decimal(13,2) NOT NULL,
  `sale_qty` tinyint(3) NOT NULL,
  `buyer` varchar(128) NOT NULL,
  `admin_id` smallint(5) UNSIGNED NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `supplies`
--

CREATE TABLE `supplies` (
  `kd_supply` char(1) NOT NULL DEFAULT 'S',
  `id_supply` int(10) UNSIGNED NOT NULL,
  `goods_id` mediumint(8) UNSIGNED NOT NULL,
  `supply_price` decimal(13,2) NOT NULL,
  `supply_qty` tinyint(4) UNSIGNED NOT NULL,
  `supplier` varchar(128) NOT NULL,
  `admin_id` smallint(5) UNSIGNED NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supplies`
--

INSERT INTO `supplies` (`kd_supply`, `id_supply`, `goods_id`, `supply_price`, `supply_qty`, `supplier`, `admin_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
('S', 4, 11, '1000.00', 1, '', 1, '2023-05-28 13:07:10', '2023-05-28 13:07:10', '2023-05-29 13:14:38'),
('S', 5, 9, '5000.00', 1, '', 1, '2023-05-28 13:08:11', '2023-05-28 13:08:11', '2023-05-29 13:14:35'),
('S', 6, 8, '1000.00', 2, '', 1, '2023-05-28 13:08:19', '2023-05-28 13:08:19', '2023-05-29 13:14:33'),
('S', 7, 9, '3000.00', 3, '', 1, '2023-05-28 13:23:43', '2023-05-28 13:23:43', '2023-05-29 13:14:31'),
('S', 11, 12, '2500.00', 2, '', 1, '2023-05-28 13:41:49', '2023-05-28 13:41:49', '2023-05-29 13:14:29'),
('S', 12, 9, '2000.00', 12, '', 1, '2023-05-28 13:41:59', '2023-05-28 13:41:59', '2023-05-28 17:54:30'),
('S', 13, 12, '1500.00', 1, '', 1, '2023-05-28 13:42:11', '2023-05-28 13:42:11', '2023-05-29 13:14:25');

-- --------------------------------------------------------

--
-- Table structure for table `supplies_cart`
--

CREATE TABLE `supplies_cart` (
  `kd_supply` char(1) NOT NULL DEFAULT 'S',
  `id_supply` int(10) UNSIGNED NOT NULL,
  `goods_id` mediumint(8) UNSIGNED NOT NULL,
  `supply_price` decimal(13,2) NOT NULL,
  `supply_qty` tinyint(4) UNSIGNED NOT NULL,
  `supplier` varchar(128) NOT NULL,
  `admin_id` smallint(5) UNSIGNED NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`);
ALTER TABLE `admin` ADD FULLTEXT KEY `first_name` (`first_name`);
ALTER TABLE `admin` ADD FULLTEXT KEY `last_name` (`last_name`);
ALTER TABLE `admin` ADD FULLTEXT KEY `username` (`username`);

--
-- Indexes for table `goods`
--
ALTER TABLE `goods`
  ADD PRIMARY KEY (`id_goods`),
  ADD KEY `admin_id` (`admin_id`);
ALTER TABLE `goods` ADD FULLTEXT KEY `goods_name` (`goods_name`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id_sale`),
  ADD KEY `goods_id` (`goods_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `sales_cart`
--
ALTER TABLE `sales_cart`
  ADD PRIMARY KEY (`id_sale`),
  ADD KEY `goods_id` (`goods_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `supplies`
--
ALTER TABLE `supplies`
  ADD PRIMARY KEY (`id_supply`),
  ADD KEY `goods_id` (`goods_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `supplies_cart`
--
ALTER TABLE `supplies_cart`
  ADD PRIMARY KEY (`id_supply`),
  ADD KEY `goods_id` (`goods_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id_admin` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `goods`
--
ALTER TABLE `goods`
  MODIFY `id_goods` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id_sale` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `sales_cart`
--
ALTER TABLE `sales_cart`
  MODIFY `id_sale` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `supplies`
--
ALTER TABLE `supplies`
  MODIFY `id_supply` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `supplies_cart`
--
ALTER TABLE `supplies_cart`
  MODIFY `id_supply` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `goods`
--
ALTER TABLE `goods`
  ADD CONSTRAINT `goods_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id_admin`);

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id_admin`),
  ADD CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id_goods`);

--
-- Constraints for table `sales_cart`
--
ALTER TABLE `sales_cart`
  ADD CONSTRAINT `sales_cart_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id_admin`),
  ADD CONSTRAINT `sales_cart_ibfk_2` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id_goods`);

--
-- Constraints for table `supplies`
--
ALTER TABLE `supplies`
  ADD CONSTRAINT `supplies_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id_admin`),
  ADD CONSTRAINT `supplies_ibfk_2` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id_goods`);

--
-- Constraints for table `supplies_cart`
--
ALTER TABLE `supplies_cart`
  ADD CONSTRAINT `supplies_cart_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id_admin`),
  ADD CONSTRAINT `supplies_cart_ibfk_2` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id_goods`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
