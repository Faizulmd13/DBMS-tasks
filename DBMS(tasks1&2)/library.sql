-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 14, 2025 at 04:47 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `library`
--

-- --------------------------------------------------------

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
CREATE TABLE `author` (
  `author_id` int(11) NOT NULL,
  `author_name` varchar(30) DEFAULT NULL,
  `published_books` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `author`
--

INSERT INTO `author` (`author_id`, `author_name`, `published_books`) VALUES
(1, 'J.K. Rowling', 7),
(2, 'George Orwell', 4),
(3, 'Jane Austen', 6);

-- --------------------------------------------------------

--
-- Stand-in structure for view `available_books`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `available_books`;
CREATE TABLE `available_books` (
`book_id` int(11)
,`title` varchar(30)
,`available_copies` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `bookCopies`
--

DROP TABLE IF EXISTS `bookCopies`;
CREATE TABLE `bookCopies` (
  `copy_id` int(11) NOT NULL,
  `book_id` int(11) DEFAULT NULL,
  `available` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookCopies`
--

INSERT INTO `bookCopies` (`copy_id`, `book_id`, `available`) VALUES
(1003, 102, 1),
(1004, 103, 1),
(1005, 103, 1);

--
-- Triggers `bookCopies`
--
DROP TRIGGER IF EXISTS `availability`;
DELIMITER $$
CREATE TRIGGER `availability` AFTER UPDATE ON `bookCopies` FOR EACH ROW BEGIN
  IF NEW.available = TRUE THEN
    UPDATE borrowings
    SET return_date = CURRENT_DATE()
    WHERE copy_id = NEW.copy_id AND return_date IS NULL;
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
CREATE TABLE `books` (
  `book_id` int(11) NOT NULL,
  `title` varchar(30) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `genre` varchar(30) DEFAULT NULL,
  `published_year` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`book_id`, `title`, `author_id`, `genre`, `published_year`) VALUES
(102, '1984', 2, 'Dystopian', '1949-06-08'),
(103, 'Pride and Prejudice', 3, 'Romance', '1813-01-28');

-- --------------------------------------------------------

--
-- Table structure for table `borrowings`
--

DROP TABLE IF EXISTS `borrowings`;
CREATE TABLE `borrowings` (
  `borrow_id` int(11) NOT NULL,
  `member_id` int(11) DEFAULT NULL,
  `copy_id` int(11) DEFAULT NULL,
  `borrow_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `borrowings`
--

INSERT INTO `borrowings` (`borrow_id`, `member_id`, `copy_id`, `borrow_date`, `return_date`) VALUES
(302, 202, 1003, '2024-04-05', '2025-04-14');

--
-- Triggers `borrowings`
--
DROP TRIGGER IF EXISTS `unavailability`;
DELIMITER $$
CREATE TRIGGER `unavailability` AFTER INSERT ON `borrowings` FOR EACH ROW BEGIN
  UPDATE bookCopies 
  SET available = FALSE 
  WHERE copy_id = NEW.copy_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
CREATE TABLE `members` (
  `member_id` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `joined_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`member_id`, `name`, `email`, `joined_date`) VALUES
(201, 'Alice', 'alice@example.com', '2023-01-01'),
(202, 'Bob', 'bob@example.com', '2022-09-15'),
(203, 'Charlie', 'charlie@example.com', '2023-05-20');

-- --------------------------------------------------------

--
-- Structure for view `available_books`
--
DROP TABLE IF EXISTS `available_books`;

DROP VIEW IF EXISTS `available_books`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `available_books`  AS SELECT `b`.`book_id` AS `book_id`, `b`.`title` AS `title`, count(`bc`.`copy_id`) AS `available_copies` FROM (`books` `b` join `bookCopies` `bc` on(`b`.`book_id` = `bc`.`book_id`)) WHERE `bc`.`available` = 1 GROUP BY `b`.`book_id`, `b`.`title` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `author`
--
ALTER TABLE `author`
  ADD PRIMARY KEY (`author_id`);

--
-- Indexes for table `bookCopies`
--
ALTER TABLE `bookCopies`
  ADD PRIMARY KEY (`copy_id`),
  ADD KEY `book_id` (`book_id`);

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`book_id`),
  ADD KEY `author_id` (`author_id`);

--
-- Indexes for table `borrowings`
--
ALTER TABLE `borrowings`
  ADD PRIMARY KEY (`borrow_id`),
  ADD KEY `member_id` (`member_id`),
  ADD KEY `copy_id` (`copy_id`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`member_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookCopies`
--
ALTER TABLE `bookCopies`
  ADD CONSTRAINT `bookCopies_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`) ON DELETE CASCADE;

--
-- Constraints for table `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`author_id`);

--
-- Constraints for table `borrowings`
--
ALTER TABLE `borrowings`
  ADD CONSTRAINT `borrowings_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`),
  ADD CONSTRAINT `borrowings_ibfk_2` FOREIGN KEY (`copy_id`) REFERENCES `bookCopies` (`copy_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
