-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 20, 2019 at 12:08 PM
-- Server version: 10.3.15-MariaDB
-- PHP Version: 7.1.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `conferencehalls`
--

-- --------------------------------------------------------

--
-- Table structure for table `administrator`
--

CREATE TABLE `administrator` (
  `administrator_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `email` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `administrator_login`
--

CREATE TABLE `administrator_login` (
  `administrator_login_id` int(11) NOT NULL,
  `logged_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `administrator_id` int(11) NOT NULL,
  `ip_address` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `calendar`
--

CREATE TABLE `calendar` (
  `calendar_id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE `event` (
  `event_id` int(11) NOT NULL,
  `administrator_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `date_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `hall_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `event_picture`
--

CREATE TABLE `event_picture` (
  `event_picture_id` int(11) NOT NULL,
  `title` varchar(128) NOT NULL,
  `event_id` int(11) NOT NULL,
  `path` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `event_type`
--

CREATE TABLE `event_type` (
  `type_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `features`
--

CREATE TABLE `features` (
  `feature_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hall`
--

CREATE TABLE `hall` (
  `hall_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `description` varchar(255) NOT NULL,
  `is_visible` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hall_feature`
--

CREATE TABLE `hall_feature` (
  `hall_feature_id` int(11) NOT NULL,
  `hall_id` int(11) DEFAULT NULL,
  `feature_id` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administrator`
--
ALTER TABLE `administrator`
  ADD PRIMARY KEY (`administrator_id`),
  ADD UNIQUE KEY `uq_administrator_email` (`email`) USING BTREE;

--
-- Indexes for table `administrator_login`
--
ALTER TABLE `administrator_login`
  ADD PRIMARY KEY (`administrator_login_id`),
  ADD KEY `fk_administrator_login_administrator_id` (`administrator_id`) USING BTREE;

--
-- Indexes for table `calendar`
--
ALTER TABLE `calendar`
  ADD PRIMARY KEY (`calendar_id`) USING BTREE,
  ADD KEY `fk_calendar_event_id` (`event_id`) USING BTREE;

--
-- Indexes for table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `fk_watch_administrator_id` (`administrator_id`) USING BTREE,
  ADD KEY `type_id` (`type_id`),
  ADD KEY `hall_id` (`hall_id`);

--
-- Indexes for table `event_picture`
--
ALTER TABLE `event_picture`
  ADD PRIMARY KEY (`event_picture_id`),
  ADD UNIQUE KEY `uq_picture_path` (`path`) USING BTREE,
  ADD KEY `fk_picture_event_id` (`event_id`) USING BTREE;

--
-- Indexes for table `event_type`
--
ALTER TABLE `event_type`
  ADD PRIMARY KEY (`type_id`),
  ADD UNIQUE KEY `uq_event_name` (`name`) USING BTREE;

--
-- Indexes for table `features`
--
ALTER TABLE `features`
  ADD PRIMARY KEY (`feature_id`);

--
-- Indexes for table `hall`
--
ALTER TABLE `hall`
  ADD PRIMARY KEY (`hall_id`),
  ADD UNIQUE KEY `uq_hall_name` (`name`) USING BTREE,
  ADD KEY `fk_hall_id` (`hall_id`) USING BTREE;

--
-- Indexes for table `hall_feature`
--
ALTER TABLE `hall_feature`
  ADD PRIMARY KEY (`hall_feature_id`),
  ADD UNIQUE KEY `uq_feature_hall_id` (`hall_feature_id`) USING BTREE,
  ADD KEY `fk_feature_hall_id` (`hall_id`),
  ADD KEY `fk_feature_feature_id` (`feature_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `administrator_login`
--
ALTER TABLE `administrator_login`
  ADD CONSTRAINT `fk_administrator_login_administrator_id` FOREIGN KEY (`administrator_id`) REFERENCES `administrator` (`administrator_id`) ON UPDATE CASCADE;

--
-- Constraints for table `calendar`
--
ALTER TABLE `calendar`
  ADD CONSTRAINT `fk_calendar_event_id` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON UPDATE CASCADE;

--
-- Constraints for table `event`
--
ALTER TABLE `event`
  ADD CONSTRAINT `fk_event_type_id` FOREIGN KEY (`event_id`) REFERENCES `event_type` (`type_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_hall_id` FOREIGN KEY (`hall_id`) REFERENCES `hall` (`hall_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_watch_administrator_id` FOREIGN KEY (`administrator_id`) REFERENCES `administrator` (`administrator_id`) ON UPDATE CASCADE;

--
-- Constraints for table `event_picture`
--
ALTER TABLE `event_picture`
  ADD CONSTRAINT `fk_picture_event_id` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON UPDATE CASCADE;

--
-- Constraints for table `hall_feature`
--
ALTER TABLE `hall_feature`
  ADD CONSTRAINT `fk_feature_feature_id` FOREIGN KEY (`feature_id`) REFERENCES `features` (`feature_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_feature_hall_id` FOREIGN KEY (`hall_id`) REFERENCES `hall` (`hall_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
