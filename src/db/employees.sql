-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 13, 2018 at 04:53 PM
-- Server version: 5.7.24
-- PHP Version: 7.1.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `employee`
--

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees` (
  `id` bigint(8) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_initial` char(1) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `date_of_employment` date DEFAULT NULL,
  `status` varchar(8) DEFAULT 'ACTIVE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `first_name`, `middle_initial`, `last_name`, `date_of_birth`, `date_of_employment`, `status`) VALUES
(1, 'Bruce', 'T', 'Boss', '1966-06-20', '2016-02-15', 'INACTIVE'),
(2, 'Jeff', 'T', 'Bosswell', '1969-06-20', '2014-02-15', 'INACTIVE'),
(3, 'Junita', 'C', 'Xiao', '1979-06-20', '2018-02-15', 'INACTIVE'),
(4, 'Wan', '', 'Pin', '1976-06-20', '2013-02-15', 'INACTIVE'),
(5, 'Tish', 'B', 'Kittens', '1978-06-20', '2014-02-15', 'ACTIVE'),
(6, 'Anastat', 'W', 'Volder', '1928-06-20', '2004-02-15', 'ACTIVE'),
(7, 'Patches', 'W', 'TheDogge', '1938-06-20', '2004-02-15', 'INACTIVE'),
(8, 'Trigger', 'P', 'Tester', '1928-06-20', '2004-02-15', 'ACTIVE'),
(9, 'TriggerUUI', 'W', 'Tester', '1928-06-20', '2004-02-15', 'ACTIVE'),
(10, 'NoTriggerUUI', 'W', 'TesterDogge', '1938-06-20', '2004-02-15', 'ACTIVE'),
(11, 'Smaller', 'P', 'Payloaded', '1998-06-20', '2018-02-15', 'ACTIVE'),
(12, 'Smallest', 'V', 'Payload', '1998-06-20', '2018-02-15', 'ACTIVE'),
(13, 'Jameson', 'V', 'Weller', '1968-06-20', '2018-02-15', 'ACTIVE'),
(15, 'Default', 'V', 'Active', '1968-06-20', '2018-02-15', 'ACTIVE'),
(17, 'Default', 'V', 'Active', '1968-06-20', '2018-02-15', 'ACTIVE'),
(18, 'Default', 'V', 'Active', '1968-06-20', '2018-02-15', 'ACTIVE'),
(19, 'Default', 'V', 'Active', '1968-06-20', '2018-02-15', 'ACTIVE'),
(20, 'Bigger', 'P', 'Digger', '1998-06-20', '2018-02-15', 'ACTIVE'),
(21, 'Thomas', 'F', 'Blige', '1998-06-20', '2018-02-15', 'INACTIVE'),
(22, 'Little', 'P', 'Big', '1998-06-20', '2018-02-15', 'INACTIVE'),
(23, '那个', 'P', '龙', '1998-06-20', '2018-02-15', 'ACTIVE');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` bigint(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
COMMIT;
