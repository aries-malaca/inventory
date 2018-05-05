-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 29, 2018 at 04:51 PM
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
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_notes` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `opening_balance` double(8,2) NOT NULL,
  `credit_limit` double(8,2) NOT NULL,
  `is_credit` int(11) NOT NULL,
  `is_active` int(11) NOT NULL,
  `branch_id` int(11) NOT NULL,
  `account_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audits`
--

CREATE TABLE `audits` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `event` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `auditable_type` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `auditable_id` int(11) NOT NULL,
  `old_values` text COLLATE utf8mb4_unicode_ci,
  `new_values` text COLLATE utf8mb4_unicode_ci,
  `url` text COLLATE utf8mb4_unicode_ci,
  `ip_address` text COLLATE utf8mb4_unicode_ci,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tags` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audits`
--

INSERT INTO `audits` (`id`, `user_id`, `event`, `auditable_type`, `auditable_id`, `old_values`, `new_values`, `url`, `ip_address`, `user_agent`, `tags`, `created_at`, `updated_at`) VALUES
(1, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 05:35:13', '2018-03-31 05:35:13'),
(2, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 06:03:19', '2018-03-31 06:03:19'),
(3, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 06:13:55', '2018-03-31 06:13:55'),
(4, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 06:15:51', '2018-03-31 06:15:51'),
(5, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 06:26:43', '2018-03-31 06:26:43'),
(6, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 06:28:26', '2018-03-31 06:28:26'),
(7, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 06:33:12', '2018-03-31 06:33:12'),
(8, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/levels/updateLevel?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 06:34:27', '2018-03-31 06:34:27'),
(9, NULL, 'updated', 'App\\User', 4, '{\"last_login\":\"2018-03-30 00:00:00\"}', '{\"last_login\":\"2018-03-31 18:39\"}', 'http://localhost:8000/auth/login?', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 06:39:06', '2018-03-31 06:39:06'),
(10, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 06:41:00', '2018-03-31 06:41:00'),
(11, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/levels/updateLevel?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 06:41:33', '2018-03-31 06:41:33'),
(12, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 06:49:24', '2018-03-31 06:49:24'),
(13, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 06:50:42', '2018-03-31 06:50:42'),
(14, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 06:56:50', '2018-03-31 06:56:50'),
(15, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 07:01:33', '2018-03-31 07:01:33'),
(16, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 07:01:43', '2018-03-31 07:01:43'),
(17, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 07:07:28', '2018-03-31 07:07:28'),
(18, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 07:08:23', '2018-03-31 07:08:23'),
(19, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 07:09:51', '2018-03-31 07:09:51'),
(20, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 07:09:51', '2018-03-31 07:09:51'),
(21, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 07:10:00', '2018-03-31 07:10:00'),
(22, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 07:51:59', '2018-03-31 07:51:59'),
(23, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 07:53:47', '2018-03-31 07:53:47'),
(24, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 07:55:03', '2018-03-31 07:55:03'),
(25, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 07:57:40', '2018-03-31 07:57:40'),
(26, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 07:57:47', '2018-03-31 07:57:47'),
(27, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:01:22', '2018-03-31 08:01:22'),
(28, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:01:27', '2018-03-31 08:01:27'),
(29, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:02:36', '2018-03-31 08:02:36'),
(30, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/levels/updateLevel?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:03:14', '2018-03-31 08:03:14'),
(31, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:03:35', '2018-03-31 08:03:35'),
(32, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:04:04', '2018-03-31 08:04:04'),
(33, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:07:01', '2018-03-31 08:07:01'),
(34, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:10:55', '2018-03-31 08:10:55'),
(35, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:10:59', '2018-03-31 08:10:59'),
(36, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/levels/updateLevel?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:11:18', '2018-03-31 08:11:18'),
(37, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:11:23', '2018-03-31 08:11:23'),
(38, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:13:22', '2018-03-31 08:13:22'),
(39, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:14:40', '2018-03-31 08:14:40'),
(40, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:15:01', '2018-03-31 08:15:01'),
(41, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:16:34', '2018-03-31 08:16:34'),
(42, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:19:02', '2018-03-31 08:19:02'),
(43, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:19:14', '2018-03-31 08:19:14'),
(44, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:20:01', '2018-03-31 08:20:01'),
(45, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/levels/updateLevel?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:24:17', '2018-03-31 08:24:17'),
(46, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:24:40', '2018-03-31 08:24:40'),
(47, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:28:49', '2018-03-31 08:28:49'),
(48, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:35:53', '2018-03-31 08:35:53'),
(49, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:36:01', '2018-03-31 08:36:01'),
(50, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:38:02', '2018-03-31 08:38:02'),
(51, 1, 'updated', 'App\\User', 4, '{\"name\":\"est\"}', '{\"name\":\"Accounting User\"}', 'http://localhost:8000/api/users/updateUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:38:22', '2018-03-31 08:38:22'),
(52, 1, 'updated', 'App\\User', 5, '{\"name\":\"sagsagkasgkljk\"}', '{\"name\":\"Product User\"}', 'http://localhost:8000/api/users/updateUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:38:32', '2018-03-31 08:38:32'),
(53, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:38:46', '2018-03-31 08:38:46'),
(54, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/levels/updateLevel?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:39:47', '2018-03-31 08:39:47'),
(55, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:39:55', '2018-03-31 08:39:55'),
(56, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 08:47:10', '2018-03-31 08:47:10'),
(57, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 18:25:20', '2018-03-31 18:25:20'),
(58, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 18:27:23', '2018-03-31 18:27:23'),
(59, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 18:41:51', '2018-03-31 18:41:51'),
(60, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 18:51:33', '2018-03-31 18:51:33'),
(61, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 18:58:45', '2018-03-31 18:58:45'),
(62, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 19:45:18', '2018-03-31 19:45:18'),
(63, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 19:48:56', '2018-03-31 19:48:56'),
(64, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 19:55:42', '2018-03-31 19:55:42'),
(65, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 19:59:14', '2018-03-31 19:59:14'),
(66, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 19:59:37', '2018-03-31 19:59:37'),
(67, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 20:06:02', '2018-03-31 20:06:02'),
(68, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 20:07:05', '2018-03-31 20:07:05'),
(69, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 20:18:42', '2018-03-31 20:18:42'),
(70, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 20:22:30', '2018-03-31 20:22:30'),
(71, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 20:23:37', '2018-03-31 20:23:37'),
(72, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 20:23:56', '2018-03-31 20:23:56'),
(73, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 20:28:24', '2018-03-31 20:28:24'),
(74, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 21:22:24', '2018-03-31 21:22:24'),
(75, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 21:45:08', '2018-03-31 21:45:08'),
(76, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 21:45:11', '2018-03-31 21:45:11'),
(77, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 21:47:55', '2018-03-31 21:47:55'),
(78, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 21:48:04', '2018-03-31 21:48:04'),
(79, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 21:48:34', '2018-03-31 21:48:34'),
(80, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 21:51:00', '2018-03-31 21:51:00'),
(81, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 21:54:18', '2018-03-31 21:54:18'),
(82, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 21:55:44', '2018-03-31 21:55:44'),
(83, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/levels/updateLevel?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 21:56:07', '2018-03-31 21:56:07'),
(84, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 21:56:29', '2018-03-31 21:56:29'),
(85, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 21:58:02', '2018-03-31 21:58:02'),
(86, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 21:58:08', '2018-03-31 21:58:08'),
(87, 4, 'updated', 'App\\User', 4, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-03-31 21:59:09', '2018-03-31 21:59:09'),
(88, NULL, 'updated', 'App\\User', 5, '{\"last_login\":\"2018-03-30 00:00:00\"}', '{\"last_login\":\"2018-04-07 20:53\"}', 'http://localhost:8000/auth/login?', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-07 16:53:10', '2018-04-07 16:53:10'),
(89, NULL, 'updated', 'App\\User', 1, '{\"last_login\":\"2018-03-30 09:51:00\"}', '{\"last_login\":\"2018-04-07 20:54\"}', 'http://localhost:8000/auth/login?', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-07 16:54:22', '2018-04-07 16:54:22'),
(90, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwMDYyLCJleHAiOjE1MjY3MjAwNjIsIm5iZiI6MTUyMzEyMDA2MiwianRpIjoidEpielUySVBxS3F0ZGg2TCJ9.gaSleGqRGa3XMKiIJxT-ButY6lYKFgHaKIcCMimCSEE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-07 16:55:10', '2018-04-07 16:55:10'),
(91, 1, 'updated', 'App\\User', 1, '[]', '[]', 'http://localhost:8000/api/levels/updateLevel?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwMDYyLCJleHAiOjE1MjY3MjAwNjIsIm5iZiI6MTUyMzEyMDA2MiwianRpIjoidEpielUySVBxS3F0ZGg2TCJ9.gaSleGqRGa3XMKiIJxT-ButY6lYKFgHaKIcCMimCSEE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-07 16:57:24', '2018-04-07 16:57:24'),
(92, NULL, 'updated', 'App\\User', 5, '{\"last_login\":\"2018-04-07 20:53:00\"}', '{\"last_login\":\"2018-04-07 20:57\"}', 'http://localhost:8000/auth/login?', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-07 16:57:32', '2018-04-07 16:57:32'),
(93, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/settings/updateSettings?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwMjUxLCJleHAiOjE1MjY3MjAyNTEsIm5iZiI6MTUyMzEyMDI1MSwianRpIjoiRzh5NzBKaElISUhOQTd0OSJ9.devzPpVVivAr89_lDdxZe9Q0JgzJfYL2sJIBxPuZERA', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-07 16:58:27', '2018-04-07 16:58:27'),
(94, NULL, 'updated', 'App\\User', 1, '{\"last_login\":\"2018-04-07 20:54:00\"}', '{\"last_login\":\"2018-04-07 20:59\"}', 'http://localhost:8000/auth/login?', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-07 16:59:02', '2018-04-07 16:59:02'),
(95, NULL, 'updated', 'App\\User', 5, '{\"last_login\":\"2018-04-07 20:57:00\"}', '{\"last_login\":\"2018-04-07 21:00\"}', 'http://localhost:8000/auth/login?', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-07 17:00:55', '2018-04-07 17:00:55'),
(96, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/product/deleteTemporaryPictures?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-07 17:01:46', '2018-04-07 17:01:46');
INSERT INTO `audits` (`id`, `user_id`, `event`, `auditable_type`, `auditable_id`, `old_values`, `new_values`, `url`, `ip_address`, `user_agent`, `tags`, `created_at`, `updated_at`) VALUES
(97, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-08 08:21:54', '2018-04-08 08:21:54'),
(98, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-08 08:22:02', '2018-04-08 08:22:02'),
(99, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-08 12:41:23', '2018-04-08 12:41:23'),
(100, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-08 12:56:41', '2018-04-08 12:56:41'),
(101, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 13:14:50', '2018-04-09 13:14:50'),
(102, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 15:01:58', '2018-04-09 15:01:58'),
(103, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 15:02:04', '2018-04-09 15:02:04'),
(104, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 15:28:36', '2018-04-09 15:28:36'),
(105, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 15:30:33', '2018-04-09 15:30:33'),
(106, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 15:31:47', '2018-04-09 15:31:47'),
(107, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 15:32:08', '2018-04-09 15:32:08'),
(108, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/product/uploadPicture?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE&product_id=7&key=1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 15:34:20', '2018-04-09 15:34:20'),
(109, 5, 'updated', 'App\\Product', 7, '{\"pictures_data\":\"[\\\"7_1521910838.jpg\\\"]\"}', '{\"pictures_data\":\"[\\\"7_1521910838.jpg\\\",\\\"7_1523288060.jpg\\\"]\"}', 'http://localhost:8000/api/product/uploadPicture?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE&product_id=7&key=1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 15:34:20', '2018-04-09 15:34:20'),
(110, 5, 'updated', 'App\\Product', 7, '{\"pictures_data\":\"[\\\"7_1521910838.jpg\\\",\\\"7_1523288060.jpg\\\"]\"}', '{\"pictures_data\":\"{\\\"1\\\":\\\"7_1523288060.jpg\\\"}\"}', 'http://localhost:8000/api/product/removePicture?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 15:34:28', '2018-04-09 15:34:28'),
(111, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 15:35:48', '2018-04-09 15:35:48'),
(112, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/product/addCategory?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 15:36:13', '2018-04-09 15:36:13'),
(113, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/product/deleteTemporaryPictures?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 15:37:30', '2018-04-09 15:37:30'),
(114, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/product/uploadPicture?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE&product_id=0&key=0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 15:40:30', '2018-04-09 15:40:30'),
(115, 5, 'created', 'App\\Product', 10, '[]', '{\"product_code\":\"01\",\"size\":\"FS\",\"brand_name\":\"COSMIC\",\"category_id\":3,\"sub_category_id\":0,\"product_name\":\"01 COSMIC HANGING FILE \\/ SUSPENSION FILE FS\",\"product_description\":\"Hanging File \\/ Suspension File\",\"is_active\":1,\"pictures_data\":\"[]\",\"id\":10}', 'http://localhost:8000/api/product/addProduct?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 15:40:33', '2018-04-09 15:40:33'),
(116, 5, 'updated', 'App\\Product', 10, '{\"pictures_data\":\"[]\"}', '{\"pictures_data\":\"[\\\"10_1523288430.jpg\\\"]\"}', 'http://localhost:8000/api/product/addProduct?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 15:40:33', '2018-04-09 15:40:33'),
(117, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 15:43:16', '2018-04-09 15:43:16'),
(118, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/product/uploadPicture?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE&product_id=0&key=0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 15:47:27', '2018-04-09 15:47:27'),
(119, 5, 'created', 'App\\Product', 11, '[]', '{\"product_code\":\"02\",\"size\":\"FS\",\"brand_name\":\"CLIPP\",\"category_id\":3,\"sub_category_id\":0,\"product_name\":\"02 CLIPP HANGING FILE \\/ SUSPENSION FILE FS\",\"product_description\":\"Hanging File \\/ Suspension File\",\"is_active\":1,\"pictures_data\":\"[]\",\"id\":11}', 'http://localhost:8000/api/product/addProduct?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 15:47:31', '2018-04-09 15:47:31'),
(120, 5, 'updated', 'App\\Product', 11, '{\"pictures_data\":\"[]\"}', '{\"pictures_data\":\"[\\\"11_1523288847.jpg\\\"]\"}', 'http://localhost:8000/api/product/addProduct?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 15:47:31', '2018-04-09 15:47:31'),
(121, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 15:57:36', '2018-04-09 15:57:36'),
(122, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 15:59:15', '2018-04-09 15:59:15'),
(123, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 16:35:53', '2018-04-09 16:35:53'),
(124, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 16:37:14', '2018-04-09 16:37:14'),
(125, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 16:39:10', '2018-04-09 16:39:10'),
(126, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 16:40:34', '2018-04-09 16:40:34'),
(127, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 16:42:09', '2018-04-09 16:42:09'),
(128, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 16:43:53', '2018-04-09 16:43:53'),
(129, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 16:45:42', '2018-04-09 16:45:42'),
(130, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 16:46:46', '2018-04-09 16:46:46'),
(131, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 17:14:42', '2018-04-09 17:14:42'),
(132, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 17:16:18', '2018-04-09 17:16:18'),
(133, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/product/uploadPicture?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE&product_id=0&key=0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 17:24:52', '2018-04-09 17:24:52'),
(134, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/product/addProduct?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 17:25:02', '2018-04-09 17:25:02'),
(135, 5, 'created', 'App\\Product', 12, '[]', '{\"product_code\":\"CPP-10ACT\",\"size\":\"A4\",\"brand_name\":\"FLAMINGO\",\"category_id\":3,\"sub_category_id\":0,\"product_name\":\"CPP-10ACT FLAMINGO PP FLAT FILE A4\",\"product_description\":\"PP Flat File\",\"is_active\":1,\"pictures_data\":\"[]\",\"id\":12}', 'http://localhost:8000/api/product/addProduct?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 17:25:02', '2018-04-09 17:25:02'),
(136, 5, 'updated', 'App\\Product', 12, '{\"pictures_data\":\"[]\"}', '{\"pictures_data\":\"[\\\"12_1523294692.jpg\\\"]\"}', 'http://localhost:8000/api/product/addProduct?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 17:25:03', '2018-04-09 17:25:03'),
(137, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 17:31:09', '2018-04-09 17:31:09'),
(138, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 17:32:05', '2018-04-09 17:32:05'),
(139, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 17:34:22', '2018-04-09 17:34:22'),
(140, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 17:36:12', '2018-04-09 17:36:12'),
(141, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 17:38:27', '2018-04-09 17:38:27'),
(142, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 17:39:19', '2018-04-09 17:39:19'),
(143, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 17:40:09', '2018-04-09 17:40:09'),
(144, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 17:41:34', '2018-04-09 17:41:34'),
(145, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 17:42:21', '2018-04-09 17:42:21'),
(146, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 17:46:19', '2018-04-09 17:46:19'),
(147, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 17:47:44', '2018-04-09 17:47:44'),
(148, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-09 18:23:38', '2018-04-09 18:23:38'),
(149, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwNDU1LCJleHAiOjE1MjY3MjA0NTUsIm5iZiI6MTUyMzEyMDQ1NSwianRpIjoiWkJQRDlSU3JMZEtkRzlpNCJ9.mwplvXmOUjHj4ebXITpnQyXxn0Xlo8INOWMv3hAt7vE', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-15 06:54:27', '2018-04-15 06:54:27'),
(150, NULL, 'updated', 'App\\User', 5, '{\"last_login\":\"2018-04-07 21:00:00\"}', '{\"last_login\":\"2018-04-15 21:20\"}', 'http://localhost:8000/auth/login?', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-15 13:20:35', '2018-04-15 13:20:35'),
(151, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/product/updateProduct?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-15 13:21:43', '2018-04-15 13:21:43'),
(152, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-15 13:22:04', '2018-04-15 13:22:04'),
(153, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 05:29:25', '2018-04-28 05:29:25'),
(154, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 05:49:17', '2018-04-28 05:49:17'),
(155, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 05:53:11', '2018-04-28 05:53:11'),
(156, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 06:18:47', '2018-04-28 06:18:47'),
(157, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 06:20:21', '2018-04-28 06:20:21'),
(158, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 06:23:43', '2018-04-28 06:23:43'),
(159, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 06:33:25', '2018-04-28 06:33:25'),
(160, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 06:40:59', '2018-04-28 06:40:59'),
(161, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 06:41:27', '2018-04-28 06:41:27'),
(162, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 06:43:30', '2018-04-28 06:43:30'),
(163, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 06:45:45', '2018-04-28 06:45:45'),
(164, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 06:46:25', '2018-04-28 06:46:25'),
(165, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 06:50:20', '2018-04-28 06:50:20'),
(166, 5, 'updated', 'App\\Product', 12, '{\"category_id\":3}', '{\"category_id\":4}', 'http://localhost:8000/api/product/updateProduct?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 06:50:35', '2018-04-28 06:50:35'),
(167, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 06:54:45', '2018-04-28 06:54:45'),
(168, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 07:13:40', '2018-04-28 07:13:40'),
(169, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/destroyToken?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 07:14:39', '2018-04-28 07:14:39'),
(170, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/destroyToken?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 07:14:39', '2018-04-28 07:14:39'),
(171, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/destroyToken?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 07:14:43', '2018-04-28 07:14:43'),
(172, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/destroyToken?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 07:14:44', '2018-04-28 07:14:44'),
(173, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/profile/uploadPicture?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U&user_id=5', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 07:15:10', '2018-04-28 07:15:10'),
(174, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/profile/uploadPicture?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U&user_id=5', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 07:15:11', '2018-04-28 07:15:11'),
(175, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 07:58:05', '2018-04-28 07:58:05'),
(176, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 10:38:24', '2018-04-28 10:38:24'),
(177, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-28 12:46:52', '2018-04-28 12:46:52'),
(178, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-29 00:12:06', '2018-04-29 00:12:06'),
(179, 5, 'updated', 'App\\User', 5, '[]', '[]', 'http://localhost:8000/api/user/getUser?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', NULL, '2018-04-29 04:06:58', '2018-04-29 04:06:58');

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
(1, 'Main Branch', 'Jaen Nueva Ecija', '0000000', 'BOTH', 1, '2017-04-29 03:55:56', '2017-05-19 17:09:18');

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
(3, 'FILES', '2018-04-09 15:36:13', '2018-04-09 15:36:13'),
(4, 'PAPERS', '2018-04-28 06:46:53', '2018-04-28 06:46:53');

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
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(10) UNSIGNED NOT NULL,
  `expense_amount` double(8,2) NOT NULL,
  `expense_date` datetime NOT NULL,
  `account_id` int(11) NOT NULL,
  `expense_notes` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payee_id` int(11) NOT NULL,
  `expense_category_id` int(11) NOT NULL,
  `expense_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `expense_category_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expense_category_icon` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expense_category_color` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_transfers`
--

CREATE TABLE `fund_transfers` (
  `id` int(10) UNSIGNED NOT NULL,
  `from_account_id` int(11) NOT NULL,
  `to_account_id` int(11) NOT NULL,
  `fund_transfer_amount` double(8,2) NOT NULL,
  `fund_transfer_notes` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fund_transfer_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fund_transfer_date` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `incomes`
--

CREATE TABLE `incomes` (
  `id` int(10) UNSIGNED NOT NULL,
  `income_amount` double(8,2) NOT NULL,
  `income_date` datetime NOT NULL,
  `account_id` int(11) NOT NULL,
  `income_notes` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payer_id` int(11) NOT NULL,
  `income_category_id` int(11) NOT NULL,
  `income_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `income_categories`
--

CREATE TABLE `income_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `income_category_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `income_category_icon` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `income_category_color` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` int(11) NOT NULL,
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
(1, 'Super Admin', 'SuperAdmin', 1, 1, NULL, '2018-03-31 08:24:17', '{\"permissions\":{\"products\":[\"view\",\"add\",\"update\"],\"categories\":[\"view\",\"update\",\"add\"],\"prices\":[\"update\",\"view\",\"add\"],\"units\":[\"view\",\"add\",\"update\"],\"branches\":[\"update\",\"add\",\"view\"],\"accounts\":[\"view\",\"add\",\"update\"],\"payers\":[\"view\",\"add\",\"update\"],\"payees\":[\"view\",\"add\",\"update\"],\"incomes\":[\"view\",\"add\",\"update\"],\"expenses\":[\"view\",\"add\",\"update\"],\"settings\":[\"view\",\"update\"],\"users\":[\"update\",\"add\",\"view\"],\"database\":[\"view\",\"backup\",\"restore\"],\"reports\":[\"view\"]},\"reports\":[],\"system\":\"Product Inquiry\",\"dashboard\":\"ProductDashboard\"}'),
(4, 'Administrator - Accounting', 'Accounting Admin', 0, 1, '2018-03-29 13:09:11', '2018-03-31 21:56:07', '{\"permissions\":{\"products\":[],\"categories\":[],\"prices\":[],\"units\":[],\"branches\":[\"view\",\"add\",\"update\"],\"accounts\":[\"view\",\"add\",\"update\"],\"payers\":[\"view\",\"add\",\"update\"],\"payees\":[\"view\",\"add\",\"update\"],\"incomes\":[\"view\",\"add\",\"update\"],\"expenses\":[\"view\",\"add\",\"update\"],\"settings\":[],\"users\":[],\"database\":[],\"reports\":[\"view\",\"product_reports\"]},\"reports\":[],\"system\":\"Accounting System\",\"dashboard\":\"AccountingDashboard\"}'),
(5, 'Administrator - Products', 'Products', 0, 1, '2018-03-30 18:48:29', '2018-04-07 16:57:24', '{\"permissions\":{\"products\":[\"add\",\"view\",\"update\"],\"categories\":[\"view\",\"add\",\"update\"],\"prices\":[\"update\",\"add\",\"view\"],\"units\":[\"view\",\"add\",\"update\"],\"branches\":[],\"accounts\":[],\"payers\":[],\"payees\":[],\"incomes\":[],\"expenses\":[],\"settings\":[\"view\",\"update\"],\"users\":[],\"database\":[\"restore\",\"view\",\"backup\"],\"reports\":[\"product_reports\",\"view\"]},\"reports\":[],\"system\":\"Product Inquiry\",\"dashboard\":\"ProductDashboard\"}');

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
(6, 0, 'reports', 'Reports', '', 'fa-folder-open', 10, 1, NULL, NULL),
(7, 0, 'settings', 'Settings', '', 'fa-cog', 9, 1, NULL, NULL),
(8, 0, 'accounts', 'Accounts', '', 'fa-money', 6, 1, NULL, NULL),
(9, 0, 'incomes', 'Incomes', '', 'fa-money', 7, 1, NULL, NULL),
(10, 0, 'expenses', 'Expenses', '', 'fa-money', 8, 1, NULL, NULL);

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
(29, '2018_03_24_040641_create_product_selling_prices_table', 7),
(32, '2018_03_24_081846_create_audits_table', 8),
(41, '2018_04_01_071540_create_accounts_table', 9),
(42, '2018_04_01_071631_create_incomes_table', 9),
(43, '2018_04_01_071639_create_expenses_table', 9),
(44, '2018_04_01_071647_create_payees_table', 9),
(45, '2018_04_01_071653_create_payers_table', 9),
(46, '2018_04_01_071702_create_income_categories_table', 9),
(47, '2018_04_01_071711_create_expense_categories_table', 9),
(48, '2018_04_01_072007_create_fund_transfers_table', 9);

-- --------------------------------------------------------

--
-- Table structure for table `payees`
--

CREATE TABLE `payees` (
  `id` int(10) UNSIGNED NOT NULL,
  `payee_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payee_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payee_mobile` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payee_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payers`
--

CREATE TABLE `payers` (
  `id` int(10) UNSIGNED NOT NULL,
  `payer_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payer_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payer_mobile` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payer_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(4, 'Whole Sale', '2017-04-29 12:47:41', '2017-05-17 19:24:31', 1000, 2),
(15, 'Retail', '2017-05-13 08:34:59', '2018-02-16 00:04:51', 0, 15);

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
  `pictures_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `brand_name`, `product_code`, `category_id`, `sub_category_id`, `product_description`, `product_name`, `is_active`, `created_at`, `updated_at`, `pictures_data`, `size`) VALUES
(10, 'COSMIC', '01', 3, 0, 'Hanging File / Suspension File', '01 COSMIC HANGING FILE / SUSPENSION FILE FS', 1, '2018-04-09 15:40:33', '2018-04-09 15:40:33', '[\"10_1523288430.jpg\"]', 'FS'),
(11, 'CLIPP', '02', 3, 0, 'Hanging File / Suspension File', '02 CLIPP HANGING FILE / SUSPENSION FILE FS', 1, '2018-04-09 15:47:31', '2018-04-09 15:47:31', '[\"11_1523288847.jpg\"]', 'FS'),
(12, 'FLAMINGO', 'CPP-10ACT', 4, 0, 'PP Flat File', 'CPP-10ACT FLAMINGO PP FLAT FILE A4', 1, '2018-04-09 17:25:02', '2018-04-28 06:50:35', '[\"12_1523294692.jpg\"]', 'A4');

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
(25, 100.00, 26, '2018-03-24 04:57:19', '2018-03-24 04:57:19', 'test'),
(26, 50.00, 27, '2018-03-24 04:57:20', '2018-03-24 04:57:20', 'test'),
(27, 1.00, 28, '2018-03-24 13:49:06', '2018-03-24 13:49:06', NULL),
(31, 10.00, 32, '2018-03-29 22:59:37', '2018-03-29 22:59:37', NULL),
(34, 47.00, 35, '2018-04-09 15:47:31', '2018-04-09 15:47:31', NULL),
(35, 0.94, 36, '2018-04-09 15:47:31', '2018-04-09 15:47:31', NULL),
(38, 37.50, 39, '2018-04-15 13:21:45', '2018-04-15 13:21:45', NULL),
(39, 0.75, 40, '2018-04-15 13:21:46', '2018-04-15 13:21:46', NULL),
(40, 63.00, 41, '2018-04-28 06:50:35', '2018-04-28 06:50:35', NULL),
(41, 1.05, 42, '2018-04-28 06:50:35', '2018-04-28 06:50:35', NULL);

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
(47, 25, 15, 115, '2018-03-24 04:57:19', '2018-03-24 04:57:19'),
(48, 25, 4, 102, '2018-03-24 04:57:19', '2018-03-24 04:57:19'),
(49, 26, 15, 57.5, '2018-03-24 04:57:20', '2018-03-24 04:57:20'),
(50, 26, 4, 51, '2018-03-24 04:57:20', '2018-03-24 04:57:20'),
(51, 27, 15, 1.15, '2018-03-24 13:49:06', '2018-03-24 13:49:06'),
(52, 27, 4, 1.02, '2018-03-24 13:49:06', '2018-03-24 13:49:06'),
(59, 31, 15, 12, '2018-03-29 22:59:37', '2018-03-29 22:59:37'),
(60, 31, 4, 10.3, '2018-03-29 22:59:38', '2018-03-29 22:59:38'),
(65, 34, 15, 99.75, '2018-04-09 15:47:31', '2018-04-09 15:47:31'),
(66, 34, 4, 0, '2018-04-09 15:47:31', '2018-04-09 15:47:31'),
(67, 35, 15, 2.85, '2018-04-09 15:47:31', '2018-04-09 15:47:31'),
(68, 35, 4, 0, '2018-04-09 15:47:31', '2018-04-09 15:47:31'),
(73, 38, 15, 99.75, '2018-04-15 13:21:45', '2018-04-15 13:21:45'),
(74, 38, 4, 50, '2018-04-15 13:21:45', '2018-04-15 13:21:45'),
(75, 39, 15, 2.86, '2018-04-15 13:21:46', '2018-04-15 13:21:46'),
(76, 39, 4, 2, '2018-04-15 13:21:46', '2018-04-15 13:21:46'),
(77, 40, 15, 110.25, '2018-04-28 06:50:35', '2018-04-28 06:50:35'),
(78, 40, 4, 0, '2018-04-28 06:50:35', '2018-04-28 06:50:35'),
(79, 41, 15, 1.9, '2018-04-28 06:50:35', '2018-04-28 06:50:35'),
(80, 41, 4, 0, '2018-04-28 06:50:35', '2018-04-28 06:50:35');

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
(26, 9, 11, 0, 1, NULL, NULL, '2018-03-24 04:57:19', '2018-03-24 04:57:19'),
(27, 9, 12, 0, 2, NULL, NULL, '2018-03-24 04:57:20', '2018-03-24 04:57:20'),
(28, 8, 6, 0, 1, NULL, NULL, '2018-03-24 13:49:06', '2018-03-24 13:49:06'),
(32, 7, 11, 0, 1, NULL, NULL, '2018-03-29 22:59:37', '2018-03-29 22:59:37'),
(35, 11, 21, 0, 1, NULL, NULL, '2018-04-09 15:47:31', '2018-04-09 15:47:31'),
(36, 11, 4, 0, 50, NULL, NULL, '2018-04-09 15:47:31', '2018-04-09 15:47:31'),
(39, 10, 21, 0, 1, NULL, NULL, '2018-04-15 13:21:45', '2018-04-15 13:21:45'),
(40, 10, 4, 0, 50, NULL, NULL, '2018-04-15 13:21:46', '2018-04-15 13:21:46'),
(41, 12, 21, 0, 1, NULL, NULL, '2018-04-28 06:50:35', '2018-04-28 06:50:35'),
(42, 12, 4, 0, 60, NULL, NULL, '2018-04-28 06:50:35', '2018-04-28 06:50:35');

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
(1, 'default_vat_percentage', '5', 'Default VAT %', 'number', '2018-04-07 16:58:27', '2018-04-07 16:58:27');

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
(6, 'Bottle', NULL, '2017-05-15 02:49:14'),
(7, 'Ream', NULL, NULL),
(9, 'Roll', '2017-05-17 11:21:30', '2017-05-17 11:21:30'),
(10, 'Bundle', '2017-05-17 11:21:39', '2017-05-17 11:21:39'),
(11, 'Book', '2017-05-17 11:22:38', '2017-05-17 11:22:38'),
(12, 'Tube', '2017-05-17 11:23:11', '2017-05-17 11:23:11'),
(13, 'Pack', '2017-05-17 11:26:06', '2017-05-17 11:26:06'),
(14, 'Loose', '2017-05-20 03:15:08', '2017-05-20 03:15:08'),
(15, 'Meter', '2017-05-21 01:40:01', '2017-05-21 01:40:01'),
(16, 'Sheet', '2017-05-21 04:32:54', '2017-05-21 04:32:54'),
(17, 'Tie', '2017-05-21 08:04:32', '2017-05-21 08:04:32'),
(18, 'Gram', '2017-05-21 09:29:26', '2017-05-21 09:29:26'),
(19, 'Unit', '2017-05-21 11:02:16', '2017-05-21 11:02:16'),
(20, 'Yard', '2017-05-24 16:48:48', '2017-05-24 16:48:48'),
(21, 'Carton', '2018-04-09 15:37:37', '2018-04-09 15:37:37');

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
(1, 'Admin', 'admin@test.com', '$2y$10$KeFh1WIxgFrJnJ6gtOAyuuXzdvZUSYQoBm5zHBtwFd670sNSumvUu', 'Las Pinas City, Philippines2', '0909111112222', '1_1522407836.jpg', 1, 1, 1, 'RZ4XEzNjeWKXCgfjpAuage6eLGpfnrnvCYSHRuAgK4LLrwuBlA5MUp9aiLhb', '2017-04-26 20:00:00', '2018-04-07 16:59:05', '2018-04-07 20:59:00', '[{\"token\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwMzQyLCJleHAiOjE1MjY3MjAzNDIsIm5iZiI6MTUyMzEyMDM0MiwianRpIjoiZGRIN3JkMTRBMWJUUTZzSCJ9.EUGxwZw0GMZZ1eJjtQfHl2-5jyFteRJivAHr49z38YQ\",\"type\":\"WEB\",\"device_info\":\"Mozilla\\/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/65.0.3325.181 Safari\\/537.36\",\"registered\":\"2018-04-07 20:59\",\"last_activity\":\"2018-04-07 20:59\"},{\"token\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzMTIwMDYyLCJleHAiOjE1MjY3MjAwNjIsIm5iZiI6MTUyMzEyMDA2MiwianRpIjoidEpielUySVBxS3F0ZGg2TCJ9.gaSleGqRGa3XMKiIJxT-ButY6lYKFgHaKIcCMimCSEE\",\"type\":\"WEB\",\"device_info\":\"Mozilla\\/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/65.0.3325.181 Safari\\/537.36\",\"registered\":\"2018-04-07 20:54\",\"last_activity\":\"2018-04-07 20:57\"},{\"token\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNDAzNDg3LCJleHAiOjE1MjYwMDM0ODcsIm5iZiI6MTUyMjQwMzQ4NywianRpIjoiR1hWR0R4TUFxY1pHaHNvSiJ9.JfJgnE8SWbGGdftgFSH4vUPJ6yzN8ynfISm6iE1rRgk\",\"type\":\"WEB\",\"device_info\":\"Mozilla\\/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/65.0.3325.181 Safari\\/537.36\",\"registered\":\"2018-03-30 09:51\",\"last_activity\":\"2018-04-01 09:58\"}]', '{}', '2018-04-07 20:59:00'),
(4, 'Accounting User', 'test@yes.com', '$2y$10$Oc/uOJcor9BzEi5LDl10y.h2kPiO33hm2kjw3uTONP6sPwUSTDpx2', 'test', '2552', 'default.jpg', 4, 1, 1, NULL, '2018-03-29 22:43:45', '2018-03-31 21:59:16', '2018-03-31 18:39:00', '[{\"token\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIyNTA3MTQ2LCJleHAiOjE1MjYxMDcxNDYsIm5iZiI6MTUyMjUwNzE0NiwianRpIjoiOVhtb013MjlCWEg4Rm1hbyJ9.-fhK_y7ljTgDOWpYhJKXVZGqTe3FmX6RRmuGfzK1tYY\",\"type\":\"WEB\",\"device_info\":\"Mozilla\\/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/65.0.3325.181 Safari\\/537.36\",\"registered\":\"2018-03-31 18:39\",\"last_activity\":\"2018-04-01 09:59\"}]', '{}', '2018-04-01 09:59:00'),
(5, 'Product User', 'aaa@test.com', '$2y$10$KeFh1WIxgFrJnJ6gtOAyuuXzdvZUSYQoBm5zHBtwFd670sNSumvUu', 'asgasg', ';l;l', '5_1524914111.jpg', 5, 1, 1, NULL, '2018-03-29 22:47:45', '2018-04-29 04:06:58', '2018-04-15 21:20:00', '[{\"token\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdXRoL2xvZ2luIiwiaWF0IjoxNTIzODEyODM1LCJleHAiOjE1Mjc0MTI4MzUsIm5iZiI6MTUyMzgxMjgzNSwianRpIjoiamJMV0QwSmhGdmpuYW1FOSJ9.inrqMJw0XS2Pu4HoTaVa_oQbLGTYQz4SQq7CANIIL0U\",\"type\":\"WEB\",\"device_info\":\"Mozilla\\/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/65.0.3325.181 Safari\\/537.36\",\"registered\":\"2018-04-15 21:20\",\"last_activity\":\"2018-04-29 12:06\"}]', '{}', '2018-04-29 12:06:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fund_transfers`
--
ALTER TABLE `fund_transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `incomes`
--
ALTER TABLE `incomes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `income_categories`
--
ALTER TABLE `income_categories`
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
-- Indexes for table `payees`
--
ALTER TABLE `payees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payers`
--
ALTER TABLE `payers`
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
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audits`
--
ALTER TABLE `audits`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=180;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fund_transfers`
--
ALTER TABLE `fund_transfers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `incomes`
--
ALTER TABLE `incomes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `income_categories`
--
ALTER TABLE `income_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventories`
--
ALTER TABLE `inventories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `levels`
--
ALTER TABLE `levels`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `payees`
--
ALTER TABLE `payees`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payers`
--
ALTER TABLE `payers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `price_categories`
--
ALTER TABLE `price_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `product_prices`
--
ALTER TABLE `product_prices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `product_selling_prices`
--
ALTER TABLE `product_selling_prices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `product_units`
--
ALTER TABLE `product_units`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sub_categories`
--
ALTER TABLE `sub_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
