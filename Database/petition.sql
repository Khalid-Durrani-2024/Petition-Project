-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 02, 2024 at 09:25 AM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `petition`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `name`, `email`, `password`, `role`) VALUES
(2, 'khan', 'khan@gmail.com', 'khan1234', 'admin'),
(3, 'Ali', 'Ali@gmail.com', 'ali123', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `university_id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `university_name` varchar(50) NOT NULL,
  `role` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`id`, `name`, `university_id`, `email`, `password`, `university_name`, `role`) VALUES
(16, 'Medics', 7, 'medics@gmail.com', 'medics123', 'شیخ زاهد پوهنتون', 'Faculty'),
(17, 'ادبیات', 7, 'khan1@gmail.com', 'ali@eewwewe', 'شیخ زاهد پوهنتون', 'Faculty'),
(18, 'IT', 4, 'it@gmail.com', 'it123', 'Tabesh', 'Faculty'),
(19, 'agriculture', 4, 'agri@gmail.com', 'agri1234', 'Tabesh', 'Faculty'),
(20, 'زراعت', 4, 'زراعت@gmail.com', 'زراعت', 'Tabesh', 'Faculty'),
(21, 'akmal', 1, 'akmal@gmail.com', '123', 'said jamaludin afghani', 'Faculty'),
(22, 'Economics', 5, 'economics@gmail.com', 'economics123', 'alfalah university', 'Faculty'),
(23, 'کمپوټر ساینس', 5, 'computer12@gmail.com', 'computer123', 'alfalah university', 'Faculty'),
(24, 'BCS', 2, 'bcs@gmail.com', 'bcs1234', 'kunar university', 'Faculty'),
(25, 'اقتصاد پوهنځی', 2, 'economic@gmial.com', '1234', 'Kunar University', 'Faculty'),
(26, 'medical', 2, 'wali@gmail.com', 'wali1234', 'Kunar University', 'Faculty'),
(27, 'bcs', 2, 'khan12@gmail.com', '123456789as', 'Kunar University', 'Faculty'),
(28, 'Math', 5, 'mat@gmail.com', 'mat123', 'alfalah university', 'Faculty'),
(29, 'زراعت', 10, 'zarat@gmail.com', 'zarat123', 'Ghalib University', 'Faculty'),
(30, 'Chemistry', 16, 'chemistry@gmail.com', 'chemistry', 'baghlan uinversity', 'Faculty');

-- --------------------------------------------------------

--
-- Table structure for table `petitions`
--

CREATE TABLE `petitions` (
  `id` int(11) NOT NULL,
  `type` varchar(100) NOT NULL,
  `date` varchar(100) NOT NULL,
  `title` varchar(100) NOT NULL,
  `sender` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `receiver` varchar(100) NOT NULL,
  `status` varchar(50) NOT NULL,
  `tracking` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `petitions`
--

INSERT INTO `petitions` (`id`, `type`, `date`, `title`, `sender`, `description`, `receiver`, `status`, `tracking`) VALUES
(1, 'General', '1402-2-3', 'Working', 'Khan', 'dsgksjdg;kja;kjsdjgsadjg;asdjg;jsadhjsa;dh;skdjg;asjgsdkgjsadkgj', 'all', 'Seen', 'Office'),
(5, 'مکتوب', '2024-07-01', 'enwan', 'Sender ', 'description', 'ننګرهار پوهنتون', 'seen', 'kabul university'),
(6, 'مکتوب', '2024-07-01', 'رخصت', 'Sender ', 'د عاشورا په مناسبت عمومي رخصت شو ټول ادارات د عاشورا په مناسبت عمومي رخصت شو ټول ادارات د عاشورا په مناسبت عمومي رخصت شو ټول ادارات د عاشورا په مناسبت عمومي رخصت شو ټول ادارات د عاشورا په مناسبت عمومي رخصت شو ټول اداراتد عاشورا په مناسبت عمومي رخصت شو ټول اداراتد عاشورا په مناسبت عمومي رخصت شو ټول اداراتد عاشورا په مناسبت عمومي رخصت شو ټول اداراتد عاشورا په مناسبت عمومي رخصت شو ټول اداراتد عاشورا په مناسبت عمومي رخصت شو ټول اداراتد عاشورا په مناسبت عمومي رخصت شو ټول اداراتد عاشورا په مناسبت عموم', 'کنړ پوهنتون', 'seen', 'kabul university'),
(7, 'مکتوب', '2024-07-01', 'رخصت', 'Sender ', 'د عاشورا په مناسبت عمومي رخصت شو ټول ادارات د عاشورا په مناسبت عمومي رخصت شو ټول ادارات د عاشورا په مناسبت عمومي رخصت شو ټول ادارات د عاشورا په مناسبت عمومي رخصت شو ټول ادارات د عاشورا په مناسبت عمومي رخصت شو ټول اداراتد عاشورا په مناسبت عمومي رخصت شو ټول اداراتد عاشورا په مناسبت عمومي رخصت شو ټول اداراتد عاشورا په مناسبت عمومي رخصت شو ټول اداراتد عاشورا په مناسبت عمومي رخصت شو ټول اداراتد عاشورا په مناسبت عمومي رخصت شو ټول اداراتد عاشورا په مناسبت عمومي رخصت شو ټول اداراتد عاشورا په مناسبت عموم', 'کنړ پوهنتون', 'seen', 'kabul university'),
(8, 'مکتوب', '2024-07-01', 'رخصتي', 'Sender ', 'د جمعی رخصتي', 'کابل پوهنتون', 'seen', 'kabul university'),
(9, 'مکتوب', '2024-07-25', 'vocation', 'Sender ', 'daily and weekly vocation', 'ننګرهار پوهنتون', 'seen', 'kabul university'),
(10, 'مکتوب', '2024-07-21', 'د اسنادو جمعه واری', 'Sender ', 'پاک شوي اسنادپاک شوي اسناد پاک شوي اسناد پاک شوي اسناد پاک شوي اسناد  ', 'کنړ پوهنتون', 'seen', 'kabul university'),
(11, 'مکتوب', '2026-07-01', 'enwan', 'Sender ', 'description descriiption', 'Sayed Jamaludding afghan', 'seen', 'kabul university'),
(13, 'مکتوب', '2024-07-09', 'رخصتي', 'khan', 'رخصت رخصت رخصت رخصت', 'Tabesh', 'seen', 'tracking'),
(14, 'مکتوب', '2024-07-10', 'پوهنتون', 'Software Engineering', 'کدرونو خبرتیا', 'Khalid University', 'seen', 'tracking'),
(15, 'مکتوب', '2024-07-10', 'سرطان میاشت', 'khan', 'د سرطان د میاشتی رخصت', 'alfalah university', 'seen', 'tracking'),
(16, 'مکتوب', '2024-07-10', 'عمومي رخصت', 'khan', 'عمومي رخصت ', 'ټول', 'seen', 'tracking'),
(17, 'مکتوب', '2024-07-17', 'حاضري', 'khan', 'حاضري رخصت دی حاضري رخصت دیحاضري رخصت دیحاضري رخصت دیحاضري رخصت دی', 'Rokhan University', 'seen', 'tracking'),
(18, 'مکتوب', '2024-07-11', 'تقاوت', 'khan', 'تقاوط تقاوط', 'Rokhan University', 'seen', 'tracking'),
(19, 'مکتوب', '2024-07-11', 'enwan', 'khan', 'aliali', 'Rokhan University', 'seen', 'tracking'),
(20, 'مکتوب', '2024-07-12', 'پوهنتون د کدرونو خبرتیا', 'khan', 'خبرتیا خبرتیا', 'شیخ زاهد پوهنتون', 'seen', 'tracking'),
(21, 'مکتوب', '2024-07-14', 'dfd', 'khan', 'dfd', 'Khalid University', 'seen', 'tracking'),
(22, 'مکتوب', '2024-07-15', 'Petition Project', 'khan', 'Petition Project Completed', 'شیخ زاهد پوهنتون', 'seen', 'tracking'),
(24, 'مکتوب', '2024-7-16', 'sdfds', 'khan', 'sdfsdfsdfdsf', 'شیخ زاهد پوهنتون', 'seen', 'tracking'),
(25, 'مکتوب', '2024-7-10', 'maktob', 'khan', 'all Universities holy day ntional', 'شیخ زاهد پوهنتون', 'seen', 'tracking'),
(26, 'مکتوب', '2024-7-21', 'روغتیا صحت مهم دی', 'khan', 'روغتیا ډیره مهمه ده', 'altaqua', 'seen', 'tracking'),
(27, 'مکتوب', '2024-7-10', 'رخصت', 'khan', 'رخصت لس ورځی', 'شیخ زاهد پوهنتون', 'seen', 'tracking'),
(28, 'مکتوب', '2024-7-22', 'د کانکور نتایج', 'khan', 'عومومی اول نمره د کابل ولایت څخه وهعومومی اول نمره د کابل ولایت څخه وهعومومی اول نمره د کابل ولایت څخه وهعومومی اول نمره د کابل ولایت څخه وهعومومی اول نمره د کابل ولایت څخه وهعومومی اول نمره د کابل ولایت څخه وهعومومی اول نمره د کابل ولایت څخه وهعومومی اول نمره د کابل ولایت څخه وهعومومی اول نمره د کابل ولایت څخه وهعومومی اول نمره د کابل ولایت څخه وهعومومی اول نمره د کابل ولایت څخه وه', 'Kunar University', 'seen', 'tracking'),
(29, 'مکتوب', '2024-7-22', 'د رخصتی په اړه ', 'payman', 'د وزارت لخوا نه یو هفته رخصتی اعلان شوه  د وزارت لخوا نه یو هفته رخصتی اعلان شوه  د وزارت لخوا نه یو هفته رخصتی اعلان شوه  د وزارت لخوا نه یو هفته رخصتی اعلان شوه  د وزارت لخوا نه یو هفته رخصتی اعلان شوه  د وزارت لخوا نه یو هفته رخصتی اعلان شوه  د وزارت لخوا نه یو هفته رخصتی اعلان شوه  د وزارت لخوا نه یو هفته رخصتی اعلان شوه  د وزارت لخوا نه یو هفته رخصتی اعلان شوه  د وزارت لخوا نه یو هفته رخصتی اعلان شوه  د وزارت لخوا نه یو هفته رخصتی اعلان شوه  د وزارت لخوا نه یو هفته رخصتی اعلان شوه  د وزارت ', 'said jamaludin afghani', 'seen', 'tracking'),
(30, 'مکتوب', '2024-7-22', 'gggggggggg', 'khan', 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb', 'said jamaludin afghani', 'seen', 'tracking'),
(31, 'مکتوب', '2024-7-9', 'رخصت', 'khan', 'سینتبمنسیتبمنسیتبمنسیتبمسنیتبسیمنبت', 'نجم', 'seen', 'tracking'),
(32, 'مکتوب', '2024-7-23', 'holidays', 'khan', 'tomarow is holiday', 'Kunar University', 'seen', 'tracking'),
(33, 'مکتوب', '2024-7-23', 'zzzzzz', 'khan', 'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz', 'said jamaludin afghani', 'seen', 'tracking'),
(34, 'عادي', '2024-7-9', 'enwan', 'khan', 'agut monh', 'altaqua', 'seen', 'tracking'),
(35, 'عادي', '2024-7-3', 'Holy Day', 'khan', 'Special Holy Day', 'alfalah university', 'seen', 'tracking'),
(36, 'جدي', '2024-7-11', 'envan', 'khan', 'maktob description', 'Ghalib University', 'seen', 'tracking'),
(37, 'محرم', '2024-7-15', 'new Petition', 'khan', 'New Petition', 'شیخ زاهد پوهنتون', 'seen', 'tracking'),
(38, 'جدي', '2024-7-21', 'جدي', 'khan', 'جدي مکتوب', 'شیخ زاهد پوهنتون', 'seen', 'tracking'),
(39, 'عادي', '2024-8-2', 'enwan', 'khan', 'tashresh', 'baghlan uinversity', 'seen', 'tracking');

-- --------------------------------------------------------

--
-- Table structure for table `received_to_faculties`
--

CREATE TABLE `received_to_faculties` (
  `id` int(11) NOT NULL,
  `petition_id` int(11) NOT NULL,
  `faculty_id` int(11) NOT NULL,
  `comment` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `received_to_faculties`
--

INSERT INTO `received_to_faculties` (`id`, `petition_id`, `faculty_id`, `comment`) VALUES
(2, 13, 18, 'emza'),
(3, 20, 16, 'emza'),
(4, 25, 16, 'مکتوب ځواب کړه'),
(5, 24, 16, 'emza sho'),
(6, 13, 19, 'emza krai'),
(7, 26, 22, 'emza kra'),
(8, 26, 22, 'additional'),
(9, 26, 23, 'emza kra'),
(10, 29, 24, 'دا مکتوب د کمپیوټر ساینس پوهنځی لخوا  جواب شو   '),
(11, 30, 25, 'khpl nazar warnade ke'),
(12, 29, 24, 'امضا'),
(13, 33, 27, 'ppppppppppppppppppp'),
(14, 33, 24, 'yessssssssssssss'),
(15, 39, 30, 'chemistry zawab');

-- --------------------------------------------------------

--
-- Table structure for table `send_from_faculty`
--

CREATE TABLE `send_from_faculty` (
  `id` int(11) NOT NULL,
  `petition_id` int(11) NOT NULL,
  `university_id` int(11) NOT NULL,
  `comment` varchar(250) NOT NULL,
  `faculty_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `send_from_faculty`
--

INSERT INTO `send_from_faculty` (`id`, `petition_id`, `university_id`, `comment`, `faculty_id`) VALUES
(1, 13, 4, 'maktob zawab sho', 19),
(2, 20, 7, 'zwab sho', 16),
(3, 29, 2, 'ok ok', 24),
(4, 30, 2, 'it is ok', 25),
(5, 33, 2, 'da pohanze  ha khawa zawab sho da maktob', 24),
(6, 39, 16, 'nazar jawab de', 30);

-- --------------------------------------------------------

--
-- Table structure for table `signatures`
--

CREATE TABLE `signatures` (
  `id` int(100) NOT NULL,
  `user_id` int(100) NOT NULL,
  `signed_at` varchar(100) NOT NULL,
  `petition_id` int(11) NOT NULL,
  `comment` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `signatures`
--

INSERT INTO `signatures` (`id`, `user_id`, `signed_at`, `petition_id`, `comment`) VALUES
(1, 1, '2024-07-08', 1, 'Petition Signed'),
(6, 1, '2024-01-02', 6, 'Petition signed'),
(7, 3, '2024-07-19', 15, 'bilal'),
(8, 7, '2024-07-20', 20, 'aliali'),
(9, 4, '2024-07-20', 13, 'seen'),
(10, 4, '2024-07-20', 13, 'seen'),
(11, 7, '2024-07-21', 22, 'jawab'),
(12, 7, '2024-07-21', 22, 'jawab'),
(13, 5, '2024-07-21', 26, 'fdkjg'),
(14, 4, '2024-07-22', 20, ' پوهنځی نظر emza پوهنتون نظر zwab sho'),
(15, 4, '2024-07-22', 13, ' پوهنځی نظر emza krai پوهنتون نظر maktob zawab sho'),
(16, 1, '2024-07-22', 28, 'ولیدل شو'),
(17, 2, '2024-07-22', 29, 'پیمان'),
(18, 2, '2024-07-22', 30, 'ok'),
(19, 15, '2024-07-23', 31, 'kahn'),
(20, 2, '2024-07-23', 29, ' پوهنځی نظر دا مکتوب د کمپیوټر ساینس پوهنځی لخوا  جواب شو    پوهنتون نظر ok ok'),
(21, 2, '2024-07-23', 29, ' پوهنځی نظر دا مکتوب د کمپیوټر ساینس پوهنځی لخوا  جواب شو    پوهنتون نظر ok ok'),
(22, 2, '2024-07-23', 29, ' پوهنځی نظر دا مکتوب د کمپیوټر ساینس پوهنځی لخوا  جواب شو    پوهنتون نظر ok ok'),
(23, 2, '2024-07-23', 20, ' پوهنځی نظر emza پوهنتون نظر zwab sho'),
(24, 2, '2024-07-23', 29, 'kahn'),
(25, 2, '2024-07-23', 20, ' پوهنځی نظر emza پوهنتون نظر zwab sho'),
(26, 2, '2024-07-23', 33, 'yes'),
(27, 2, '2024-07-23', 33, ' پوهنځی نظر yessssssssssssss پوهنتون نظر da pohanze  ha khawa zawab sho da maktob'),
(28, 3, '2024-07-30', 20, ' پوهنځی نظر emza پوهنتون نظر zwab sho'),
(29, 19, '2024-08-02', 39, 'nazar jawab de');

-- --------------------------------------------------------

--
-- Table structure for table `universities`
--

CREATE TABLE `universities` (
  `id` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `location` varchar(100) NOT NULL,
  `created_at` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `universities`
--

INSERT INTO `universities` (`id`, `name`, `location`, `created_at`) VALUES
(1, 'said jamaludin afghani', 'Kandahar', '2024'),
(2, 'Kunar University', 'Kunar', '2024-05-3'),
(4, 'Tabesh', 'Nangarhar', '2024-07-16'),
(5, 'alfalah university', 'nangarhar', '2024-07-06'),
(6, 'altaqua', 'nang', '2024-07-06'),
(7, 'شیخ زاهد پوهنتون', 'خوست', '2024-07-06'),
(9, 'kandahar University', 'Khost', '2024-07-07'),
(10, 'Ghalib University', 'Kabul', '2024-07-11'),
(11, 'البیروني پوهنتون', 'kabul', '2024-07-11'),
(12, 'Rokhan University', 'Nangarhar', '2024-07-11'),
(13, 'jbkjjkjk', 'jkjjkkjk', '2024-07-20'),
(14, 'باران', 'ننګرهار', '2024-07-21'),
(15, 'paghman university', 'kabul', '2024-07-22'),
(16, 'baghlan uinversity', 'baghlan', '2024-07-22'),
(17, 'ghor university', 'ghor', '2024-07-22'),
(19, 'نجم', 'کنړ', '2024-07-23'),
(20, 'alberoni university', 'kabul', '2024-07-23'),
(21, 'alflah university', 'nangrahar', '2024-07-23');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `university_id` int(100) NOT NULL,
  `created_at` varchar(50) NOT NULL,
  `role` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `university_id`, `created_at`, `role`) VALUES
(1, 'alikhan', 'alikhan@gmail.com', '12345', 2, '1402-02-3', 'university'),
(2, 'payman', 'payman@gmail.com', '123456789', 1, '2024-02-12', 'university'),
(3, 'zabih', 'zabih@gmail.com', 'zabih123', 5, '2024-07', 'university'),
(4, 'mohammad', 'mohammad@gmail.com', 'mohammad', 4, '2024-07-15', 'university'),
(5, 'ahmad', 'ahmad@gmail.com', 'ahmad123', 6, '2024-07-15', 'university'),
(6, 'wli', 'wli@gmail.com', 'wli123', 1, '2024-07-15', 'university'),
(7, 'eee', 'e@gmail.com', 'eeeee', 7, '2024-07-15', 'university'),
(8, 'ahmad', 'ahmadjan@gmail.com', 'ahmad123', 9, '2024-07-16', 'university'),
(9, 'aliahmad', 'aliahmad@gmail.com', 'aliahmad123', 10, '2024-07-17', 'university'),
(10, 'hljhklj', 'ljhlkj', 'klhjljhlh', 6, '2024-07-20', 'university'),
(11, 'kkk', 'll@gmail.com', 'kkkk', 4, '2024-07-20', 'university'),
(12, 'خان', 'khan1122@gmail.com', 'khan123', 14, '2024-07-21', 'university'),
(13, 'ahmadzai', 'ahmadzai@gmail.com', 'ahmzadzai', 15, '2024-07-22', 'university'),
(15, 'نجم', 'najam@gmail.com', 'najam1234', 19, '2024-07-23', 'university'),
(16, 'omer', 'omer2211@gmail.com', 'omer', 20, '2024-07-23', 'university'),
(17, 'ali', 'ali123@gmail.com', 'khan12345', 21, '2024-07-23', 'university'),
(18, 'ali', 'ali123@gmail.com', 'khan12345', 21, '2024-07-23', 'university'),
(19, 'admin', 'admin@gmail.com', 'admin123', 16, '2024-08-02', 'university');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ffk` (`university_id`);

--
-- Indexes for table `petitions`
--
ALTER TABLE `petitions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `received_to_faculties`
--
ALTER TABLE `received_to_faculties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `connecting this table to faculties table and petition` (`faculty_id`),
  ADD KEY `connecting this table to petitions` (`petition_id`);

--
-- Indexes for table `send_from_faculty`
--
ALTER TABLE `send_from_faculty`
  ADD PRIMARY KEY (`id`),
  ADD KEY `connecting faculty sign to university` (`university_id`),
  ADD KEY `connecting sign to petition from faculty` (`petition_id`);

--
-- Indexes for table `signatures`
--
ALTER TABLE `signatures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `connecting signature to user` (`user_id`),
  ADD KEY `signed_at` (`petition_id`);

--
-- Indexes for table `universities`
--
ALTER TABLE `universities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usersfk` (`university_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `faculty`
--
ALTER TABLE `faculty`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `petitions`
--
ALTER TABLE `petitions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `received_to_faculties`
--
ALTER TABLE `received_to_faculties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `send_from_faculty`
--
ALTER TABLE `send_from_faculty`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `signatures`
--
ALTER TABLE `signatures`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `universities`
--
ALTER TABLE `universities`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `faculty`
--
ALTER TABLE `faculty`
  ADD CONSTRAINT `faculty_related_to` FOREIGN KEY (`university_id`) REFERENCES `universities` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `received_to_faculties`
--
ALTER TABLE `received_to_faculties`
  ADD CONSTRAINT `connecting this table to faculties table and petition` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `connecting this table to petitions` FOREIGN KEY (`petition_id`) REFERENCES `petitions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `send_from_faculty`
--
ALTER TABLE `send_from_faculty`
  ADD CONSTRAINT `connecting faculty sign to university` FOREIGN KEY (`university_id`) REFERENCES `universities` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `connecting sign to petition from faculty` FOREIGN KEY (`petition_id`) REFERENCES `petitions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `signatures`
--
ALTER TABLE `signatures`
  ADD CONSTRAINT `Signed_by_connecting_signature_to_university_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `signed_at` FOREIGN KEY (`petition_id`) REFERENCES `petitions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_university` FOREIGN KEY (`university_id`) REFERENCES `universities` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
