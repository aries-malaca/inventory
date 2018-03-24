-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 24, 2018 at 04:52 PM
-- Server version: 10.1.28-MariaDB
-- PHP Version: 7.1.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `audits`
--

CREATE TABLE `audits` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `event` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `auditable_id` int(10) UNSIGNED NOT NULL,
  `auditable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `old_values` text COLLATE utf8mb4_unicode_ci,
  `new_values` text COLLATE utf8mb4_unicode_ci,
  `url` text COLLATE utf8mb4_unicode_ci,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tags` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audits`
--

INSERT INTO `audits` (`id`, `user_id`, `event`, `auditable_id`, `auditable_type`, `old_values`, `new_values`, `url`, `ip_address`, `user_agent`, `tags`, `created_at`, `updated_at`) VALUES
(1, NULL, 'updated', 8, 'App\\Product', '{\"pictures_data\":\"{\\\"1\\\":\\\"8_1521894969.jpg\\\"}\"}', '{\"pictures_data\":\"[]\"}', 'http://localhost:8000/api/product/updateProduct?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIxODg1OTk2LCJleHAiOjE1MjU0ODU5OTYsIm5iZiI6MTUyMTg4NTk5NiwianRpIjoiRXFhaTBaYjVQMEcxVXZBVyJ9.4lsAQ0LXnnmWjdjaqVZnzrAH_quEawnG2z3gQidQUfE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-24 04:52:01', '2018-03-24 04:52:01'),
(2, 1, 'updated', 8, 'App\\Product', '{\"pictures_data\":\"[]\"}', '{\"pictures_data\":\"[\\\"8_1521895999.jpg\\\"]\"}', 'http://localhost:8000/api/product/uploadPicture?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIxODg1OTk2LCJleHAiOjE1MjU0ODU5OTYsIm5iZiI6MTUyMTg4NTk5NiwianRpIjoiRXFhaTBaYjVQMEcxVXZBVyJ9.4lsAQ0LXnnmWjdjaqVZnzrAH_quEawnG2z3gQidQUfE&product_id=8&key=0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-24 04:53:19', '2018-03-24 04:53:19'),
(3, NULL, 'updated', 8, 'App\\Product', '{\"pictures_data\":\"[\\\"8_1521895999.jpg\\\"]\"}', '{\"pictures_data\":\"[]\"}', 'http://localhost:8000/api/product/updateProduct?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIxODg1OTk2LCJleHAiOjE1MjU0ODU5OTYsIm5iZiI6MTUyMTg4NTk5NiwianRpIjoiRXFhaTBaYjVQMEcxVXZBVyJ9.4lsAQ0LXnnmWjdjaqVZnzrAH_quEawnG2z3gQidQUfE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-24 04:53:44', '2018-03-24 04:53:44'),
(4, 1, 'updated', 8, 'App\\Product', '{\"pictures_data\":\"[]\"}', '{\"pictures_data\":\"[\\\"8_1521896105.jpg\\\"]\"}', 'http://localhost:8000/api/product/uploadPicture?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIxODg1OTk2LCJleHAiOjE1MjU0ODU5OTYsIm5iZiI6MTUyMTg4NTk5NiwianRpIjoiRXFhaTBaYjVQMEcxVXZBVyJ9.4lsAQ0LXnnmWjdjaqVZnzrAH_quEawnG2z3gQidQUfE&product_id=8&key=0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-24 04:55:06', '2018-03-24 04:55:06'),
(5, 1, 'updated', 7, 'App\\Product', '{\"pictures_data\":\"[]\"}', '{\"pictures_data\":\"[\\\"7_1521896742.jpg\\\"]\"}', 'http://localhost:8000/api/product/uploadPicture?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIxODg1OTk2LCJleHAiOjE1MjU0ODU5OTYsIm5iZiI6MTUyMTg4NTk5NiwianRpIjoiRXFhaTBaYjVQMEcxVXZBVyJ9.4lsAQ0LXnnmWjdjaqVZnzrAH_quEawnG2z3gQidQUfE&product_id=7&key=0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-24 05:05:43', '2018-03-24 05:05:43'),
(6, 1, 'created', 9, 'App\\Product', '[]', '{\"product_code\":\"test\",\"brand_name\":\"test\",\"category_id\":2,\"sub_category_id\":0,\"product_name\":\"test test\",\"product_description\":\"test\",\"is_active\":1,\"pictures_data\":\"[]\",\"id\":9}', 'http://localhost:8000/api/product/addProduct?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIxODg1OTk2LCJleHAiOjE1MjU0ODU5OTYsIm5iZiI6MTUyMTg4NTk5NiwianRpIjoiRXFhaTBaYjVQMEcxVXZBVyJ9.4lsAQ0LXnnmWjdjaqVZnzrAH_quEawnG2z3gQidQUfE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-24 07:39:56', '2018-03-24 07:39:56');

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` int(10) UNSIGNED NOT NULL,
  `branch_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_contact` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `branch_name`, `branch_address`, `branch_contact`, `branch_role`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Main Branch', 'Jaen Nueva Ecija', '0000000', 'BOTH', 1, '2017-04-29 07:55:56', '2017-05-19 21:09:18'),
(2, 'Dummy Branch', 'test', '0909', 'BOTH', 1, '2017-05-27 10:12:24', '2017-05-27 10:56:22');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category_name`, `created_at`, `updated_at`) VALUES
(1, 'Test', '2018-03-23 10:12:26', '2018-03-23 10:12:26'),
(2, 'r', '2018-03-24 00:25:44', '2018-03-24 00:25:44');

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_contact_person` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_contact_info` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_category_id` int(11) NOT NULL,
  `is_active` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `contact_person_designation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `conversions`
--

CREATE TABLE `conversions` (
  `id` int(10) UNSIGNED NOT NULL,
  `from_product_id` int(11) NOT NULL,
  `to_product_id` int(11) NOT NULL,
  `conversion` int(11) NOT NULL,
  `conversion_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventories`
--

CREATE TABLE `inventories` (
  `id` int(10) UNSIGNED NOT NULL,
  `inventory_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `branch_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `unit_id` int(11) NOT NULL,
  `purchase_price` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `levels`
--

CREATE TABLE `levels` (
  `id` int(10) UNSIGNED NOT NULL,
  `level_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` int(11) NOT NULL,
  `is_active` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `level_data` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `levels`
--

INSERT INTO `levels` (`id`, `level_name`, `level_description`, `is_default`, `is_active`, `created_at`, `updated_at`, `level_data`) VALUES
(1, 'Admin', 'Super User', 1, 1, NULL, '2017-06-01 07:30:11', '{\"permissions\":[{\"page\":\"sales\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"cancel\",\"value\":\"true\"},{\"action\":\"approve\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"},{\"action\":\"void\",\"value\":\"true\"}]},{\"page\":\"purchases\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"cancel\",\"value\":\"true\"},{\"action\":\"approve\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"},{\"action\":\"void\",\"value\":\"true\"}]},{\"page\":\"receives\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"cancel\",\"value\":\"true\"},{\"action\":\"approve\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"},{\"action\":\"void\",\"value\":\"true\"}]},{\"page\":\"transfers\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"cancel\",\"value\":\"true\"},{\"action\":\"approve\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"},{\"action\":\"void\",\"value\":\"true\"}]},{\"page\":\"products\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"}]},{\"page\":\"price\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"}]},{\"page\":\"category\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"},{\"action\":\"delete\",\"value\":\"true\"}]},{\"page\":\"price_category\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"},{\"action\":\"delete\",\"value\":\"true\"}]},{\"page\":\"clients\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"}]},{\"page\":\"suppliers\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"}]},{\"page\":\"branches\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"}]},{\"page\":\"reports\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"}]},{\"page\":\"users\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"},{\"action\":\"delete\",\"value\":\"true\"}]},{\"page\":\"levels\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"},{\"action\":\"delete\",\"value\":\"true\"}]},{\"page\":\"settings\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"}]},{\"page\":\"reconciliations\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"}]}]}'),
(2, 'Cashier', 'Sales Person', 0, 1, '2017-05-07 22:38:09', '2017-06-01 07:30:04', '{\"permissions\":[{\"page\":\"sales\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"cancel\",\"value\":\"true\"},{\"action\":\"approve\",\"value\":\"false\"},{\"action\":\"update\",\"value\":\"true\"},{\"action\":\"void\",\"value\":\"false\"}]},{\"page\":\"purchases\",\"permission\":[{\"action\":\"view\",\"value\":\"false\"},{\"action\":\"add\",\"value\":\"false\"},{\"action\":\"cancel\",\"value\":\"false\"},{\"action\":\"approve\",\"value\":\"false\"},{\"action\":\"update\",\"value\":\"false\"},{\"action\":\"void\",\"value\":\"false\"}]},{\"page\":\"receives\",\"permission\":[{\"action\":\"view\",\"value\":\"false\"},{\"action\":\"add\",\"value\":\"false\"},{\"action\":\"cancel\",\"value\":\"false\"},{\"action\":\"approve\",\"value\":\"false\"},{\"action\":\"update\",\"value\":\"false\"},{\"action\":\"void\",\"value\":\"false\"}]},{\"page\":\"transfers\",\"permission\":[{\"action\":\"view\",\"value\":\"false\"},{\"action\":\"add\",\"value\":\"false\"},{\"action\":\"cancel\",\"value\":\"false\"},{\"action\":\"approve\",\"value\":\"false\"},{\"action\":\"update\",\"value\":\"false\"},{\"action\":\"void\",\"value\":\"false\"}]},{\"page\":\"products\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"}]},{\"page\":\"price\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"false\"}]},{\"page\":\"category\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"},{\"action\":\"delete\",\"value\":\"false\"}]},{\"page\":\"sub_category\",\"permission\":[{\"action\":\"view\",\"value\":\"false\"},{\"action\":\"add\",\"value\":\"false\"},{\"action\":\"update\",\"value\":\"false\"},{\"action\":\"delete\",\"value\":\"false\"}]},{\"page\":\"price_category\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"false\"},{\"action\":\"update\",\"value\":\"false\"},{\"action\":\"delete\",\"value\":\"false\"}]},{\"page\":\"clients\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"}]},{\"page\":\"suppliers\",\"permission\":[{\"action\":\"view\",\"value\":\"false\"},{\"action\":\"add\",\"value\":\"false\"},{\"action\":\"update\",\"value\":\"false\"}]},{\"page\":\"branches\",\"permission\":[{\"action\":\"view\",\"value\":\"false\"},{\"action\":\"add\",\"value\":\"false\"},{\"action\":\"update\",\"value\":\"false\"}]},{\"page\":\"reports\",\"permission\":[{\"action\":\"view\",\"value\":\"false\"}]},{\"page\":\"users\",\"permission\":[{\"action\":\"view\",\"value\":\"false\"},{\"action\":\"add\",\"value\":\"false\"},{\"action\":\"update\",\"value\":\"false\"},{\"action\":\"delete\",\"value\":\"false\"}]},{\"page\":\"levels\",\"permission\":[{\"action\":\"view\",\"value\":\"false\"},{\"action\":\"add\",\"value\":\"false\"},{\"action\":\"update\",\"value\":\"false\"},{\"action\":\"delete\",\"value\":\"false\"}]},{\"page\":\"settings\",\"permission\":[{\"action\":\"view\",\"value\":\"false\"},{\"action\":\"update\",\"value\":\"false\"}]},{\"page\":\"reconciliations\",\"permission\":[{\"action\":\"view\",\"value\":\"false\"},{\"action\":\"add\",\"value\":\"false\"},{\"action\":\"update\",\"value\":\"false\"}]}]}'),
(3, 'Inventory', 'Product Inventory', 0, 1, '2017-05-19 21:29:50', '2017-06-01 07:31:06', '{\"permissions\":[{\"page\":\"sales\",\"permission\":[{\"action\":\"view\",\"value\":\"false\"},{\"action\":\"add\",\"value\":\"false\"},{\"action\":\"cancel\",\"value\":\"false\"},{\"action\":\"approve\",\"value\":\"false\"},{\"action\":\"update\",\"value\":\"false\"},{\"action\":\"void\",\"value\":\"false\"}]},{\"page\":\"purchases\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"cancel\",\"value\":\"true\"},{\"action\":\"approve\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"},{\"action\":\"void\",\"value\":\"true\"}]},{\"page\":\"receives\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"cancel\",\"value\":\"true\"},{\"action\":\"approve\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"},{\"action\":\"void\",\"value\":\"true\"}]},{\"page\":\"transfers\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"cancel\",\"value\":\"true\"},{\"action\":\"approve\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"},{\"action\":\"void\",\"value\":\"true\"}]},{\"page\":\"products\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"}]},{\"page\":\"price\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"false\"}]},{\"page\":\"category\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"},{\"action\":\"delete\",\"value\":\"true\"}]},{\"page\":\"price_category\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"false\"},{\"action\":\"update\",\"value\":\"false\"},{\"action\":\"delete\",\"value\":\"false\"}]},{\"page\":\"clients\",\"permission\":[{\"action\":\"view\",\"value\":\"false\"},{\"action\":\"add\",\"value\":\"false\"},{\"action\":\"update\",\"value\":\"false\"}]},{\"page\":\"suppliers\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"}]},{\"page\":\"branches\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"}]},{\"page\":\"reports\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"}]},{\"page\":\"users\",\"permission\":[{\"action\":\"view\",\"value\":\"false\"},{\"action\":\"add\",\"value\":\"false\"},{\"action\":\"update\",\"value\":\"false\"},{\"action\":\"delete\",\"value\":\"false\"}]},{\"page\":\"levels\",\"permission\":[{\"action\":\"view\",\"value\":\"false\"},{\"action\":\"add\",\"value\":\"false\"},{\"action\":\"update\",\"value\":\"false\"},{\"action\":\"delete\",\"value\":\"false\"}]},{\"page\":\"settings\",\"permission\":[{\"action\":\"view\",\"value\":\"false\"},{\"action\":\"update\",\"value\":\"false\"}]},{\"page\":\"reconciliations\",\"permission\":[{\"action\":\"view\",\"value\":\"true\"},{\"action\":\"add\",\"value\":\"true\"},{\"action\":\"update\",\"value\":\"true\"}]}]}');

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `log_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `table` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seen_by` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_machine_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(11) NOT NULL,
  `menu_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `menu_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `menu_description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `menu_icon` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `menu_order` int(11) NOT NULL,
  `menu_active` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `parent_id`, `menu_url`, `menu_title`, `menu_description`, `menu_icon`, `menu_order`, `menu_active`, `created_at`, `updated_at`) VALUES
(1, 0, 'transactions', 'Transactions', '', 'fa-shopping-cart', 1, 0, NULL, NULL),
(2, 0, 'products', 'Products', '', 'fa-cubes', 2, 1, NULL, NULL),
(3, 0, 'clients', 'Clients', '', 'fa-users', 3, 0, NULL, NULL),
(4, 0, 'suppliers', 'Suppliers', '', 'fa-truck', 4, 0, NULL, NULL),
(5, 0, 'branches', 'Branches', '', 'fa-building', 5, 1, NULL, NULL),
(6, 0, 'reports', 'Reports', '', 'fa-folder-open', 7, 1, NULL, NULL),
(7, 0, 'settings', 'Settings', '', 'fa-cog', 8, 1, NULL, NULL),
(8, 0, 'accounting', 'Accounting', '', 'fa-money', 6, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2016_11_21_052708_create_menus_table', 1),
(3, '2016_11_21_065340_create_products_table', 1),
(4, '2016_11_21_065346_create_clients_table', 1),
(5, '2016_11_21_065355_create_suppliers_table', 1),
(6, '2016_11_21_070704_create_categories_table', 1),
(7, '2016_11_21_070709_create_sub_categories_table', 1),
(8, '2016_11_25_021812_create_price_categories_table', 1),
(9, '2016_12_01_131103_create_branches_table', 1),
(10, '2016_12_01_175816_create_levels_table', 1),
(11, '2016_12_01_175918_create_settings_table', 1),
(12, '2016_12_07_035752_create_logs_table', 1),
(13, '2016_12_08_162636_create_inventories_table', 1),
(14, '2016_12_13_163311_create_receives_table', 1),
(15, '2016_12_14_121410_create_receive_items_table', 1),
(16, '2016_12_15_153457_create_transfers_table', 1),
(17, '2016_12_15_153516_create_transfer_items_table', 1),
(18, '2016_12_16_142240_create_sales_table', 1),
(19, '2016_12_16_142257_create_sale_items_table', 1),
(20, '2016_12_27_162739_create_purchases_table', 1),
(21, '2017_05_01_011301_create_permissions_table', 2),
(22, '2017_05_11_133905_create_conversions_table', 3),
(23, '2017_05_11_160113_create_purchase_items_table', 3),
(24, '2017_05_16_025458_create_units_table', 4),
(25, '2017_05_30_221732_create_reconciliations_table', 5),
(26, '2017_05_30_221752_create_reconciliation_items_table', 5),
(27, '2018_02_16_122745_create_product_prices_table', 6),
(28, '2018_02_16_123357_create_product_units_table', 6),
(29, '2018_03_24_040641_create_product_selling_prices_table', 7);

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `permission_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permission_data` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `created_at`, `updated_at`, `permission_name`, `permission_data`) VALUES
(1, NULL, NULL, 'sales', '[\"view\",\"add\",\"cancel\",\"approve\",\"update\",\"void\"]'),
(2, NULL, NULL, 'purchases', '[\"view\",\"add\",\"cancel\",\"approve\",\"update\",\"void\"]'),
(3, NULL, NULL, 'receives', '[\"view\",\"add\",\"cancel\",\"approve\",\"update\",\"void\"]'),
(4, NULL, NULL, 'transfers', '[\"view\",\"add\",\"cancel\",\"approve\",\"update\",\"void\"]'),
(6, NULL, NULL, 'products', '[\"view\",\"add\",\"update\"]'),
(7, NULL, NULL, 'price', '[\"view\",\"update\"]'),
(8, NULL, NULL, 'category', '[\"view\",\"add\",\"update\",\"delete\"]'),
(10, NULL, NULL, 'price_category', '[\"view\",\"add\",\"update\",\"delete\"]'),
(11, NULL, NULL, 'clients', '[\"view\",\"add\",\"update\"]'),
(12, NULL, NULL, 'suppliers', '[\"view\",\"add\",\"update\"]'),
(13, NULL, NULL, 'branches', '[\"view\",\"add\",\"update\"]'),
(14, NULL, NULL, 'reports', '[\"view\"]'),
(15, NULL, NULL, 'users', '[\"view\",\"add\",\"update\",\"delete\"]'),
(16, NULL, NULL, 'levels', '[\"view\",\"add\",\"update\",\"delete\"]'),
(17, NULL, NULL, 'settings', '[\"view\",\"update\"]'),
(18, NULL, NULL, 'reconciliations', '[\"view\",\"add\",\"update\"]');

-- --------------------------------------------------------

--
-- Table structure for table `price_categories`
--

CREATE TABLE `price_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `price_category_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `minimum_purchase` double NOT NULL,
  `default_markup` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `price_categories`
--

INSERT INTO `price_categories` (`id`, `price_category_name`, `created_at`, `updated_at`, `minimum_purchase`, `default_markup`) VALUES
(4, 'Whole Sale', '2017-04-29 16:47:41', '2017-05-17 23:24:31', 1000, 2),
(15, 'Retail', '2017-05-13 12:34:59', '2018-02-16 04:04:51', 0, 15);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `brand_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int(11) NOT NULL,
  `sub_category_id` int(11) NOT NULL,
  `product_description` text COLLATE utf8mb4_unicode_ci,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `pictures_data` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `brand_name`, `product_code`, `category_id`, `sub_category_id`, `product_description`, `product_name`, `is_active`, `created_at`, `updated_at`, `pictures_data`) VALUES
(7, 'kkkjhjkg', '13313', 1, 0, 'k', 'kkkjhjkg k', 1, '2018-03-23 20:27:37', '2018-03-24 05:05:42', '[\"7_1521896742.jpg\"]'),
(8, '', 'ahkasl;hashklshak', 1, 0, '', ' ', 1, '2018-03-24 03:53:18', '2018-03-24 04:55:05', '[\"8_1521896105.jpg\"]'),
(9, 'test', 'test', 2, 0, 'test', 'test test', 1, '2018-03-24 07:39:55', '2018-03-24 07:39:55', '[]');

-- --------------------------------------------------------

--
-- Table structure for table `product_prices`
--

CREATE TABLE `product_prices` (
  `id` int(10) UNSIGNED NOT NULL,
  `purchase_price` double(8,2) NOT NULL,
  `product_unit_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_prices`
--

INSERT INTO `product_prices` (`id`, `purchase_price`, `product_unit_id`, `created_at`, `updated_at`, `remarks`) VALUES
(12, 10.00, 13, '2018-03-24 04:36:36', '2018-03-24 04:36:36', NULL),
(16, 1.00, 17, '2018-03-24 04:58:44', '2018-03-24 04:58:44', NULL),
(19, 4.00, 20, '2018-03-24 07:43:46', '2018-03-24 07:43:46', 'test'),
(20, 2.00, 21, '2018-03-24 07:43:47', '2018-03-24 07:43:47', 'test');

-- --------------------------------------------------------

--
-- Table structure for table `product_selling_prices`
--

CREATE TABLE `product_selling_prices` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_price_id` int(11) NOT NULL,
  `price_category_id` int(11) NOT NULL,
  `selling_price` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_selling_prices`
--

INSERT INTO `product_selling_prices` (`id`, `product_price_id`, `price_category_id`, `selling_price`, `created_at`, `updated_at`) VALUES
(21, 12, 15, 12, '2018-03-24 04:36:37', '2018-03-24 04:36:37'),
(22, 12, 4, 10.3, '2018-03-24 04:36:37', '2018-03-24 04:36:37'),
(29, 16, 15, 1.15, '2018-03-24 04:58:44', '2018-03-24 04:58:44'),
(30, 16, 4, 1.02, '2018-03-24 04:58:44', '2018-03-24 04:58:44'),
(35, 19, 15, 4.6, '2018-03-24 07:43:46', '2018-03-24 07:43:46'),
(36, 19, 4, 4.08, '2018-03-24 07:43:46', '2018-03-24 07:43:46'),
(37, 20, 15, 2.3, '2018-03-24 07:43:47', '2018-03-24 07:43:47'),
(38, 20, 4, 2.04, '2018-03-24 07:43:47', '2018-03-24 07:43:47');

-- --------------------------------------------------------

--
-- Table structure for table `product_units`
--

CREATE TABLE `product_units` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `parent_unit_id` int(11) NOT NULL,
  `quantity_per_parent` int(11) NOT NULL,
  `info` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `barcode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_units`
--

INSERT INTO `product_units` (`id`, `product_id`, `unit_id`, `parent_unit_id`, `quantity_per_parent`, `info`, `barcode`, `created_at`, `updated_at`) VALUES
(13, 7, 11, 0, 1, NULL, NULL, '2018-03-24 04:36:36', '2018-03-24 04:36:36'),
(17, 8, 6, 0, 1, NULL, NULL, '2018-03-24 04:58:43', '2018-03-24 04:58:43'),
(20, 9, 11, 0, 1, NULL, NULL, '2018-03-24 07:43:45', '2018-03-24 07:43:45'),
(21, 9, 12, 0, 2, NULL, NULL, '2018-03-24 07:43:46', '2018-03-24 07:43:46');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `receipt_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_transaction` datetime NOT NULL,
  `date_due` datetime NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `notes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `branch_id` int(11) NOT NULL,
  `purchase_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `purchase_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_data` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_items`
--

CREATE TABLE `purchase_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `purchase_id` int(11) NOT NULL,
  `purchase_price` double(8,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `received_quantity` int(11) NOT NULL,
  `unit_price` float NOT NULL,
  `discount` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `receives`
--

CREATE TABLE `receives` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_branch_id` int(11) NOT NULL,
  `to_branch_id` int(11) NOT NULL,
  `date_received` datetime NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `receive_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `received_data` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `receive_items`
--

CREATE TABLE `receive_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `receive_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_cost` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reconciliations`
--

CREATE TABLE `reconciliations` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `reference_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_received` datetime NOT NULL,
  `notes` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `received_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `receive_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reconciliation_items`
--

CREATE TABLE `reconciliation_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `reconciliation_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `actual` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `beginning` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `actual_retail` int(11) NOT NULL,
  `beginning_retail` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `receipt_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_transaction` datetime NOT NULL,
  `date_due` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `notes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sales_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` int(11) NOT NULL,
  `sales_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price_category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sale_items`
--

CREATE TABLE `sale_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `sales_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `discount` double(8,2) NOT NULL,
  `original_price` double(8,2) NOT NULL,
  `selling_price` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `unit` int(11) NOT NULL,
  `sold_quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `setting_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `setting_value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `setting_label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `setting_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `setting_name`, `setting_value`, `setting_label`, `setting_type`, `created_at`, `updated_at`) VALUES
(1, 'auto_launch_sales_form', '0', 'Auto Launch Sales Form', 'yes_no', '2018-02-16 09:41:17', '2018-02-16 01:41:17'),
(2, 'default_vat_percentage', '12', 'Default VAT %', 'number', '2018-02-16 09:41:17', '2018-02-16 01:41:17'),
(3, 'pos_vat_inclusive', '1', 'POS VAT Inclusive', 'yes_no', '2018-02-16 09:41:17', '2018-02-16 01:41:17'),
(4, 'pos_vat_enabled', '1', 'POS VAT Enabled', 'yes_no', '2018-02-16 09:41:18', '2018-02-16 01:41:18'),
(5, 'transaction_password', 'password', 'Transaction Password', 'string', '2018-02-16 09:41:18', '2018-02-16 01:41:18'),
(6, 'pos_receipt_message', 'Thank you!!!', 'POS Receipt Message', 'string', '2018-02-16 09:41:18', '2018-02-16 01:41:18'),
(9, 'default_client_id', '2', 'Default Client ID', 'number', '2018-02-16 09:41:18', '2018-02-16 01:41:18'),
(10, 'product_search_length', '100', 'Product Search Length', 'number', '2018-02-16 09:41:18', '2018-02-16 01:41:18');

-- --------------------------------------------------------

--
-- Table structure for table `sub_categories`
--

CREATE TABLE `sub_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(11) NOT NULL,
  `sub_category_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(10) UNSIGNED NOT NULL,
  `supplier_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `supplier_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_contact_person` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `contact_person_designation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_telephone_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_mobile_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_fax` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

CREATE TABLE `transfers` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_branch_id` int(11) NOT NULL,
  `to_branch_id` int(11) NOT NULL,
  `date_transferred` datetime NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `transfer_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transfer_items`
--

CREATE TABLE `transfer_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `receive_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` int(10) UNSIGNED NOT NULL,
  `unit_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `unit_name`, `created_at`, `updated_at`) VALUES
(1, 'Box', NULL, NULL),
(2, 'Case', NULL, NULL),
(3, 'Pad', NULL, NULL),
(4, 'Piece', NULL, NULL),
(5, 'Set', NULL, NULL),
(6, 'Bottle', NULL, '2017-05-15 06:49:14'),
(7, 'Ream', NULL, NULL),
(9, 'Roll', '2017-05-17 15:21:30', '2017-05-17 15:21:30'),
(10, 'Bundle', '2017-05-17 15:21:39', '2017-05-17 15:21:39'),
(11, 'Book', '2017-05-17 15:22:38', '2017-05-17 15:22:38'),
(12, 'Tube', '2017-05-17 15:23:11', '2017-05-17 15:23:11'),
(13, 'Pack', '2017-05-17 15:26:06', '2017-05-17 15:26:06'),
(14, 'Loose', '2017-05-20 07:15:08', '2017-05-20 07:15:08'),
(15, 'Meter', '2017-05-21 05:40:01', '2017-05-21 05:40:01'),
(16, 'Sheet', '2017-05-21 08:32:54', '2017-05-21 08:32:54'),
(17, 'Tie', '2017-05-21 12:04:32', '2017-05-21 12:04:32'),
(18, 'Gram', '2017-05-21 13:29:26', '2017-05-21 13:29:26'),
(19, 'Unit', '2017-05-21 15:02:16', '2017-05-21 15:02:16'),
(20, 'Yard', '2017-05-24 20:48:48', '2017-05-24 20:48:48');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` int(11) NOT NULL,
  `branch_id` int(11) NOT NULL,
  `is_active` int(11) NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `last_login` datetime NOT NULL,
  `device_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `address`, `mobile`, `photo`, `level`, `branch_id`, `is_active`, `remember_token`, `created_at`, `updated_at`, `last_login`, `device_data`, `user_data`, `last_activity`) VALUES
(1, 'Admin', 'admin@test.com', '$2y$10$BSQJpZCvU0Zah01NmNXv8.FDtovfYwj3KTOuySbS2AWL9zwayQaNC', 'Philippines', '090911111', 'default.jpg', 1, 1, 1, 'RZ4XEzNjeWKXCgfjpAuage6eLGpfnrnvCYSHRuAgK4LLrwuBlA5MUp9aiLhb', '2017-04-27 00:00:00', '2018-03-24 07:43:43', '2018-03-24 10:06:00', '[{\"token\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIxODg1OTk2LCJleHAiOjE1MjU0ODU5OTYsIm5iZiI6MTUyMTg4NTk5NiwianRpIjoiRXFhaTBaYjVQMEcxVXZBVyJ9.4lsAQ0LXnnmWjdjaqVZnzrAH_quEawnG2z3gQidQUfE\",\"type\":\"WEB\",\"device_info\":\"Mozilla\\/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/65.0.3325.181 Safari\\/537.36\",\"registered\":\"2018-03-24 10:06\",\"last_activity\":\"2018-03-24 15:43\"},{\"token\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIxODg1NzEyLCJleHAiOjE1MjU0ODU3MTIsIm5iZiI6MTUyMTg4NTcxMiwianRpIjoiTTYxQkRHODV2WkMzU1hTaSJ9.Q2nzVInKNz7qJaxD6A2CHJsQX1k5kBfxD1-OLxKqMeo\",\"type\":\"WEB\",\"device_info\":\"Mozilla\\/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/65.0.3325.181 Safari\\/537.36\",\"registered\":\"2018-03-24 10:01\",\"last_activity\":\"2018-03-24 10:04\"},{\"token\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIxODY2NjU4LCJleHAiOjE1MjU0NjY2NTgsIm5iZiI6MTUyMTg2NjY1OCwianRpIjoiVjVRYnpHQkw0dlpqbHptViJ9.8SIfQcCVxGc8n-HfhHF1t-ZBP_wgUFukh7cpSNC1zgs\",\"type\":\"WEB\",\"device_info\":\"Mozilla\\/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/65.0.3325.181 Safari\\/537.36\",\"registered\":\"2018-03-24 04:44\",\"last_activity\":\"2018-03-24 09:49\"},{\"token\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QvYXV0aC9sb2dpbiIsImlhdCI6MTUxODI0MjE2NSwiZXhwIjoxNTIxODQyMTY1LCJuYmYiOjE1MTgyNDIxNjUsImp0aSI6IkNMN0pkY1JyMkdSZmthdWkifQ.tvYOoCJfxIK4zIhwVvpTBwWRyTaly5qYVIwWwvo04m0\",\"type\":\"WEB\",\"device_info\":\"Mozilla\\/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/63.0.3239.132 Safari\\/537.36\",\"registered\":\"2018-02-10 05:56\",\"last_activity\":\"2018-03-23 18:19\"},{\"token\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QvYXV0aC9sb2dpbiIsImlhdCI6MTUxODIzNzUxNywiZXhwIjoxNTE4MjQxMTE3LCJuYmYiOjE1MTgyMzc1MTcsImp0aSI6IjR0TnZ5dHl0QUVSSE9McHgifQ.m1gt20Y17Z297n2K1-c8cBE73dbzX7ax0k7O70XZG7o\",\"type\":\"WEB\",\"device_info\":\"Mozilla\\/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/63.0.3239.132 Safari\\/537.36\",\"registered\":\"2018-02-10 04:38\",\"last_activity\":\"2018-02-10 05:38\"},{\"token\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QvYXV0aC9sb2dpbiIsImlhdCI6MTUxODE5NDg4NiwiZXhwIjoxNTE4MTk4NDg2LCJuYmYiOjE1MTgxOTQ4ODYsImp0aSI6ImlWVWtGaTVUTnRZYXNBUTMifQ.e-69iLYswnHBiSXXzAktZb8d-_9Ks951OdXXXf45ay0\",\"type\":\"WEB\",\"device_info\":\"Mozilla\\/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/63.0.3239.132 Safari\\/537.36\",\"registered\":\"2018-02-09 16:48\",\"last_activity\":\"2018-02-09 16:48\"},{\"token\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QvYXV0aC9sb2dpbiIsImlhdCI6MTUxODE5NDcwMywiZXhwIjoxNTE4MTk4MzAzLCJuYmYiOjE1MTgxOTQ3MDMsImp0aSI6IjY0YnAwT1d2cUE1MDZNSVoifQ.-Ij7hFJX5IvsDgJnSmRtnNoCVVwMek3E-xcrQs_MYDA\",\"type\":\"WEB\",\"device_info\":\"Mozilla\\/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/63.0.3239.132 Safari\\/537.36\",\"registered\":\"2018-02-09 16:45\",\"last_activity\":\"2018-02-09 16:45\"}]', '{}', '2018-03-24 15:43:00'),
(2, 'Cashier', 'test@test1.com', '$2y$10$IFoB29Z.TLfUDDlx1o6ddOtsGDi/f8lThEhLtVMjGbmEHtFAB2rNe', 'Test', '12345', 'default.jpg', 2, 1, 1, NULL, '2017-05-07 14:38:43', '2017-05-20 12:26:08', '0000-00-00 00:00:00', '[]', '{}', '0000-00-00 00:00:00'),
(3, 'Inventory', 'test@test.com', '$2y$10$EeZ0uedDpuucIcQCmSSmLumoU7jnbBZOA0heProLU4tZvoY651vAW', 'test', 'test', 'default.jpg', 3, 1, 1, 'w8LlVd4Y3dTbXqqZCl5L8N3xQtk6L3SoNVMvHREkZAQOpG7RyI7RM7YkamNh', '2017-05-19 13:30:21', '2017-05-19 13:30:21', '0000-00-00 00:00:00', '[]', '{}', '0000-00-00 00:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audits`
--
ALTER TABLE `audits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `conversions`
--
ALTER TABLE `conversions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventories`
--
ALTER TABLE `inventories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `levels`
--
ALTER TABLE `levels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `price_categories`
--
ALTER TABLE `price_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_prices`
--
ALTER TABLE `product_prices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_selling_prices`
--
ALTER TABLE `product_selling_prices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_units`
--
ALTER TABLE `product_units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `receives`
--
ALTER TABLE `receives`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `receive_items`
--
ALTER TABLE `receive_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reconciliations`
--
ALTER TABLE `reconciliations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reconciliation_items`
--
ALTER TABLE `reconciliation_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transfers`
--
ALTER TABLE `transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transfer_items`
--
ALTER TABLE `transfer_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audits`
--
ALTER TABLE `audits`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `conversions`
--
ALTER TABLE `conversions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventories`
--
ALTER TABLE `inventories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `levels`
--
ALTER TABLE `levels`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `price_categories`
--
ALTER TABLE `price_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `product_prices`
--
ALTER TABLE `product_prices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `product_selling_prices`
--
ALTER TABLE `product_selling_prices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `product_units`
--
ALTER TABLE `product_units`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_items`
--
ALTER TABLE `purchase_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `receives`
--
ALTER TABLE `receives`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `receive_items`
--
ALTER TABLE `receive_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reconciliations`
--
ALTER TABLE `reconciliations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reconciliation_items`
--
ALTER TABLE `reconciliation_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sale_items`
--
ALTER TABLE `sale_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `sub_categories`
--
ALTER TABLE `sub_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transfers`
--
ALTER TABLE `transfers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transfer_items`
--
ALTER TABLE `transfer_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
