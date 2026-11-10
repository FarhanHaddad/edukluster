-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 10, 2026 at 07:01 AM
-- Server version: 8.4.3
-- PHP Version: 8.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `edukluster_widuri`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `username`, `password`, `created_at`, `updated_at`, `status`) VALUES
(1, 'SatNaing', 'satnaing', '$2b$10$sU/F6u.OGJhdctk9mzj4RexSLiis/QXUgt7Lz9gMzsFFghyyh7Dta', '2026-10-01 05:36:19', '2026-10-01 05:36:19', 1),
(5, 'guru_bk', 'guru_bk', '$2b$10$GTAgX6w9jSRqco9BjihQce4C5WypgWoDTsBlaRLOSIX1409zBWr9i', '2026-10-06 13:05:00', '2026-10-06 13:05:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `category_assignment`
--

CREATE TABLE `category_assignment` (
  `id` bigint NOT NULL,
  `periode_id` bigint NOT NULL,
  `field_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `standard_value` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category_assignment`
--

INSERT INTO `category_assignment` (`id`, `periode_id`, `field_name`, `standard_value`, `option_id`) VALUES
(1, 1, 'ekstrakurikuler', 'futsal', 2),
(2, 1, 'ekstrakurikuler', 'basket', 2),
(3, 1, 'ekstrakurikuler', 'badminton', 2),
(4, 1, 'ekstrakurikuler', 'taekwondo', 2),
(5, 1, 'ekstrakurikuler', 'tari tradisional', 3),
(6, 1, 'ekstrakurikuler', 'band', 3),
(7, 1, 'ekstrakurikuler', 'modern dance', 3),
(8, 1, 'ekstrakurikuler', 'kir', 4),
(9, 1, 'ekstrakurikuler', 'mading', 5),
(10, 1, 'prestasi', 'tidak', 6),
(11, 1, 'prestasi', 'juara 1 lomba futsal di sma penabur bintaro jaya 2024', 7),
(12, 1, 'prestasi', 'juara 1 kejuaraan taekwondo liga dki', 7),
(13, 1, 'prestasi', 'juara 2 solo vokal m25 cup sma muhammadh 25 pamulang 2024', 8),
(14, 1, 'prestasi', 'juara harapan 1 fls2n', 8),
(15, 1, 'prestasi', 'juara 3 lomba mobile legends tingkat sma', 9),
(16, 1, 'prestasi', 'runner up puteri remaja indonesia lingkungan jakarta 2024', 10),
(17, 1, 'prestasi', 'juara 2 kejuaraan pelajar nasional', 11),
(18, 1, 'kemampuan', 'bela diri', 13),
(19, 1, 'kemampuan', 'bermain futsal', 13),
(20, 1, 'kemampuan', 'main basket', 13),
(21, 1, 'kemampuan', 'atletik', 13),
(22, 1, 'kemampuan', 'main gitar', 14),
(23, 1, 'kemampuan', 'menyanyi', 14),
(24, 1, 'kemampuan', 'main drum', 14),
(25, 1, 'kemampuan', 'menari', 15),
(26, 1, 'kemampuan', 'menggambar', 15),
(27, 1, 'kemampuan', 'melukis', 15),
(28, 1, 'kemampuan', 'gaming', 16),
(29, 1, 'kemampuan', 'desain', 16),
(30, 1, 'kemampuan', 'editing', 16),
(31, 1, 'kemampuan', 'fotografi', 16),
(32, 1, 'kemampuan', 'videografi', 16),
(33, 1, 'kemampuan', 'bisnis', 17),
(34, 1, 'kemampuan', 'wirausaha', 17),
(35, 1, 'kemampuan', 'modifikasi motor', 18),
(36, 1, 'kemampuan', 'analisis', 18),
(37, 1, 'kemampuan', 'memasak', 19),
(38, 1, 'kemampuan', 'public speaking', 20),
(39, 1, 'organisasi', 'tidak', 21),
(40, 1, 'organisasi', 'basket', 22),
(41, 1, 'organisasi', 'badminton', 22),
(42, 1, 'organisasi', 'karang taruna', 23),
(43, 1, 'organisasi', 'osis', 24),
(44, 1, 'organisasi', 'pmr', 25),
(45, 1, 'kursus', 'tidak', 26),
(46, 1, 'kursus', 'bimbel', 27),
(47, 1, 'kursus', 'kursus toefl', 28),
(48, 1, 'kursus', 'pelatihan saksi partai', 29),
(49, 1, 'kursus', 'melukis', 30),
(50, 1, 'jurusan_1', 'teknik mesin', 33),
(51, 1, 'jurusan_1', 'teknik industri', 33),
(52, 1, 'jurusan_1', 'ilmu komputer', 34),
(53, 1, 'jurusan_1', 'teknik informatika', 34),
(54, 1, 'jurusan_1', 'manajemen', 35),
(55, 1, 'jurusan_1', 'akuntansi', 35),
(56, 1, 'jurusan_1', 'ilmu komunikasi', 36),
(57, 1, 'jurusan_1', 'hukum', 36),
(58, 1, 'jurusan_1', 'psikologi', 36),
(59, 1, 'jurusan_1', 'sastra inggris', 37),
(60, 1, 'jurusan_1', 'seni rupa', 38),
(61, 1, 'jurusan_1', 'dkv', 38),
(62, 1, 'jurusan_1', 'ilmu keperawatan', 39),
(63, 1, 'jurusan_1', 'kedokteran', 39),
(64, 1, 'jurusan_1', 'ilmu keolahragaan', 40),
(65, 1, 'jurusan_1', 'pendidikan jasmani', 40),
(66, 1, 'jurusan_1', 'teknologi pangan', 41),
(67, 1, 'jurusan_1', 'arsitektur', 42),
(68, 1, 'jurusan_2', 'teknik elektro', 45),
(69, 1, 'jurusan_2', 'teknik industri', 45),
(70, 1, 'jurusan_2', 'teknik mesin', 45),
(71, 1, 'jurusan_2', 'teknik informatika', 46),
(72, 1, 'jurusan_2', 'sistem informasi', 46),
(73, 1, 'jurusan_2', 'manajemen', 47),
(74, 1, 'jurusan_2', 'akuntansi', 47),
(75, 1, 'jurusan_2', 'ekonomi', 47),
(76, 1, 'jurusan_2', 'hukum', 48),
(77, 1, 'jurusan_2', 'psikologi', 48),
(78, 1, 'jurusan_2', 'ilmu komunikasi', 48),
(79, 1, 'jurusan_2', 'sastra inggris', 49),
(80, 1, 'jurusan_2', 'sastra indonesia', 49),
(81, 1, 'jurusan_2', 'dkv', 50),
(82, 1, 'jurusan_2', 'seni rupa', 50),
(83, 1, 'jurusan_2', 'farmasi', 51),
(84, 1, 'jurusan_2', 'ilmu keperawatan', 51),
(85, 1, 'jurusan_2', 'pendidikan jasmani', 52),
(86, 1, 'jurusan_2', 'ilmu keolahragaan', 52),
(87, 1, 'jurusan_2', 'teknologi pangan', 53),
(88, 1, 'jurusan_2', 'arsitektur', 54),
(89, 1, 'jurusan_2', 'pgsd', 55);

-- --------------------------------------------------------

--
-- Table structure for table `category_mapping`
--

CREATE TABLE `category_mapping` (
  `id` bigint NOT NULL,
  `preprocessing_run_id` bigint NOT NULL,
  `field_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `raw_value` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `standard_value` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category_mapping`
--

INSERT INTO `category_mapping` (`id`, `preprocessing_run_id`, `field_name`, `raw_value`, `standard_value`, `created_at`, `updated_at`) VALUES
(1, 1, 'ekstrakurikuler', 'badminton', 'Badminton', NULL, NULL),
(2, 1, 'ekstrakurikuler', 'futsal', 'Futsal', NULL, NULL),
(3, 1, 'ekstrakurikuler', 'band', 'Band', NULL, NULL),
(4, 1, 'ekstrakurikuler', 'modern dance', 'Modern Dance', NULL, NULL),
(5, 1, 'ekstrakurikuler', 'taekwondo', 'Taekwondo', NULL, NULL),
(6, 1, 'ekstrakurikuler', 'basket', 'Basket', NULL, NULL),
(7, 1, 'ekstrakurikuler', 'tari tradisional', 'Tari Tradisional', NULL, NULL),
(8, 1, 'ekstrakurikuler', 'mading', 'Mading', NULL, NULL),
(9, 1, 'ekstrakurikuler', 'kir', 'KIR', NULL, NULL),
(10, 1, 'prestasi', 'tidak', 'Tidak', NULL, NULL),
(11, 1, 'prestasi', 'runner up puteri remaja indonesia lingkungan jakarta 2024', 'Runner Up Puteri Remaja Indonesia Lingkungan Jakarta 2024', NULL, NULL),
(12, 1, 'prestasi', 'juara harapan 1 fls2n', 'Juara harapan 1 FLS2N', NULL, NULL),
(13, 1, 'prestasi', 'juara 1 lomba futsal di sma penabur bintaro jaya 2024', 'Juara 1 Lomba Futsal di SMA Penabur Bintaro Jaya 2024', NULL, NULL),
(14, 1, 'prestasi', 'juara 1 kejuaraan taekwondo liga dki', 'Juara 1 kejuaraan taekwondo liga DKI', NULL, NULL),
(15, 1, 'prestasi', 'juara 2 kejuaraan pelajar nasional', 'Juara 2 kejuaraan pelajar nasional', NULL, NULL),
(16, 1, 'prestasi', 'juara 3 lomba mobile legends tingkat sma', 'Juara 3 lomba mobile legends tingkat SMA', NULL, NULL),
(17, 1, 'prestasi', 'juara 2 solo vokal m25 cup sma muhammadh 25 pamulang 2024', 'Juara 2 Solo Vokal M25 Cup SMA Muhammadh 25 Pamulang 2024', NULL, NULL),
(18, 1, 'kemampuan', 'modifikasi motor', 'Modifikasi Motor', NULL, NULL),
(19, 1, 'kemampuan', 'bermain futsal', 'Bermain Futsal', NULL, NULL),
(20, 1, 'kemampuan', 'main gitar', 'Main Gitar', NULL, NULL),
(21, 1, 'kemampuan', 'bisnis', 'Bisnis', NULL, NULL),
(22, 1, 'kemampuan', 'public speaking', 'Public Speaking', NULL, NULL),
(23, 1, 'kemampuan', 'bela diri', 'Bela Diri', NULL, NULL),
(24, 1, 'kemampuan', 'main basket', 'Main Basket', NULL, NULL),
(25, 1, 'kemampuan', 'menari', 'Menari', NULL, NULL),
(26, 1, 'kemampuan', 'menggambar', 'Menggambar', NULL, NULL),
(27, 1, 'kemampuan', 'fotografi', 'Fotografi', NULL, NULL),
(28, 1, 'kemampuan', 'videografi', 'Videografi', NULL, NULL),
(29, 1, 'kemampuan', 'editing', 'Editing', NULL, NULL),
(30, 1, 'kemampuan', 'analisis', 'Analisis', NULL, NULL),
(31, 1, 'kemampuan', 'gaming', 'Gaming', NULL, NULL),
(32, 1, 'kemampuan', 'wirausaha', 'Wirausaha', NULL, NULL),
(33, 1, 'kemampuan', 'desain', 'Desain', NULL, NULL),
(34, 1, 'kemampuan', 'atletik', 'Atletik', NULL, NULL),
(35, 1, 'kemampuan', 'main drum', 'Main Drum', NULL, NULL),
(36, 1, 'kemampuan', 'melukis', 'Melukis', NULL, NULL),
(37, 1, 'kemampuan', 'memasak', 'Memasak', NULL, NULL),
(38, 1, 'kemampuan', 'menyanyi', 'Menyanyi', NULL, NULL),
(39, 1, 'organisasi', 'badminton', 'Badminton', NULL, NULL),
(40, 1, 'organisasi', 'karang taruna', 'Karang Taruna', NULL, NULL),
(41, 1, 'organisasi', 'osis', 'OSIS', NULL, NULL),
(42, 1, 'organisasi', 'tidak', 'Tidak', NULL, NULL),
(43, 1, 'organisasi', 'basket', 'Basket', NULL, NULL),
(44, 1, 'organisasi', 'pmr', 'PMR', NULL, NULL),
(45, 1, 'kursus', 'tidak', 'Tidak', NULL, NULL),
(46, 1, 'kursus', 'bimbel', 'Bimbel', NULL, NULL),
(47, 1, 'kursus', 'kursus toefl', 'Kursus TOEFL', NULL, NULL),
(48, 1, 'kursus', 'pelatihan saksi partai', 'Pelatihan Saksi Partai', NULL, NULL),
(49, 1, 'kursus', 'melukis', 'Melukis', NULL, NULL),
(50, 1, 'jurusan_1', 'teknik mesin', 'Teknik Mesin', NULL, NULL),
(51, 1, 'jurusan_1', 'manajemen', 'Manajemen', NULL, NULL),
(52, 1, 'jurusan_1', 'psikologi', 'Psikologi', NULL, NULL),
(53, 1, 'jurusan_1', 'sastra inggris', 'Sastra Inggris', NULL, NULL),
(54, 1, 'jurusan_1', 'ilmu keolahragaan', 'Ilmu Keolahragaan', NULL, NULL),
(55, 1, 'jurusan_1', 'teknik industri', 'Teknik Industri', NULL, NULL),
(56, 1, 'jurusan_1', 'ilmu komunikasi', 'Ilmu Komunikasi', NULL, NULL),
(57, 1, 'jurusan_1', 'arsitektur', 'Arsitektur', NULL, NULL),
(58, 1, 'jurusan_1', 'dkv', 'DKV', NULL, NULL),
(59, 1, 'jurusan_1', 'teknik informatika', 'Teknik Informatika', NULL, NULL),
(60, 1, 'jurusan_1', 'akuntansi', 'Akuntansi', NULL, NULL),
(61, 1, 'jurusan_1', 'kedokteran', 'Kedokteran', NULL, NULL),
(62, 1, 'jurusan_1', 'pendidikan jasmani', 'Pendidikan Jasmani', NULL, NULL),
(63, 1, 'jurusan_1', 'hukum', 'Hukum', NULL, NULL),
(64, 1, 'jurusan_1', 'seni rupa', 'Seni Rupa', NULL, NULL),
(65, 1, 'jurusan_1', 'ilmu keperawatan', 'Ilmu Keperawatan', NULL, NULL),
(66, 1, 'jurusan_1', 'teknologi pangan', 'Teknologi Pangan', NULL, NULL),
(67, 1, 'jurusan_1', 'ilmu komputer', 'Ilmu Komputer', NULL, NULL),
(68, 1, 'jurusan_2', 'pendidikan jasmani', 'Pendidikan Jasmani', NULL, NULL),
(69, 1, 'jurusan_2', 'ilmu keolahragaan', 'Ilmu Keolahragaan', NULL, NULL),
(70, 1, 'jurusan_2', 'sastra indonesia', 'Sastra Indonesia', NULL, NULL),
(71, 1, 'jurusan_2', 'ekonomi', 'Ekonomi', NULL, NULL),
(72, 1, 'jurusan_2', 'akuntansi', 'Akuntansi', NULL, NULL),
(73, 1, 'jurusan_2', 'ilmu komunikasi', 'Ilmu Komunikasi', NULL, NULL),
(74, 1, 'jurusan_2', 'teknik elektro', 'Teknik Elektro', NULL, NULL),
(75, 1, 'jurusan_2', 'hukum', 'Hukum', NULL, NULL),
(76, 1, 'jurusan_2', 'psikologi', 'Psikologi', NULL, NULL),
(77, 1, 'jurusan_2', 'dkv', 'DKV', NULL, NULL),
(78, 1, 'jurusan_2', 'manajemen', 'Manajemen', NULL, NULL),
(79, 1, 'jurusan_2', 'teknik informatika', 'Teknik Informatika', NULL, NULL),
(80, 1, 'jurusan_2', 'sistem informasi', 'Sistem Informasi', NULL, NULL),
(81, 1, 'jurusan_2', 'farmasi', 'Farmasi', NULL, NULL),
(82, 1, 'jurusan_2', 'arsitektur', 'Arsitektur', NULL, NULL),
(83, 1, 'jurusan_2', 'sastra inggris', 'Sastra Inggris', NULL, NULL),
(84, 1, 'jurusan_2', 'teknik industri', 'Teknik Industri', NULL, NULL),
(85, 1, 'jurusan_2', 'teknik mesin', 'Teknik Mesin', NULL, NULL),
(86, 1, 'jurusan_2', 'teknologi pangan', 'Teknologi Pangan', NULL, NULL),
(87, 1, 'jurusan_2', 'pgsd', 'PGSD', NULL, NULL),
(88, 1, 'jurusan_2', 'seni rupa', 'Seni Rupa', NULL, NULL),
(89, 1, 'jurusan_2', 'ilmu keperawatan', 'Ilmu Keperawatan', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `category_option`
--

CREATE TABLE `category_option` (
  `id` bigint NOT NULL,
  `periode_id` bigint NOT NULL,
  `field_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category_option`
--

INSERT INTO `category_option` (`id`, `periode_id`, `field_name`, `name`, `code`) VALUES
(1, 1, 'ekstrakurikuler', 'Tidak Ada', 0),
(2, 1, 'ekstrakurikuler', 'Olahraga', 1),
(3, 1, 'ekstrakurikuler', 'Seni', 2),
(4, 1, 'ekstrakurikuler', 'Sains', 3),
(5, 1, 'ekstrakurikuler', 'Literasi', 4),
(6, 1, 'prestasi', 'Tidak Ada', 0),
(7, 1, 'prestasi', 'Olahraga', 1),
(8, 1, 'prestasi', 'Seni', 2),
(9, 1, 'prestasi', 'E-Sport', 3),
(10, 1, 'prestasi', 'Sosial', 4),
(11, 1, 'prestasi', 'Sains', 5),
(12, 1, 'kemampuan', 'Tidak Ada', 0),
(13, 1, 'kemampuan', 'Olahraga', 1),
(14, 1, 'kemampuan', 'Musik', 2),
(15, 1, 'kemampuan', 'Seni', 3),
(16, 1, 'kemampuan', 'Digital', 4),
(17, 1, 'kemampuan', 'Bisnis', 5),
(18, 1, 'kemampuan', 'Sains&Teknik', 6),
(19, 1, 'kemampuan', 'Tata boga', 7),
(20, 1, 'kemampuan', 'Komunikasi', 8),
(21, 1, 'organisasi', 'Tidak Ada', 0),
(22, 1, 'organisasi', 'Olahraga', 1),
(23, 1, 'organisasi', 'Sosial', 2),
(24, 1, 'organisasi', 'Kepemimpinan', 3),
(25, 1, 'organisasi', 'Kesehatan', 4),
(26, 1, 'kursus', 'Tidak Ada', 0),
(27, 1, 'kursus', 'Akademik', 1),
(28, 1, 'kursus', 'Bahasa Inggris', 2),
(29, 1, 'kursus', 'Hukum', 3),
(30, 1, 'kursus', 'Seni', 4),
(32, 1, 'jurusan_1', 'Tidak Ada', 0),
(33, 1, 'jurusan_1', 'Teknik', 1),
(34, 1, 'jurusan_1', 'Komputer', 2),
(35, 1, 'jurusan_1', 'Ekonomi', 3),
(36, 1, 'jurusan_1', 'Sosial', 4),
(37, 1, 'jurusan_1', 'Bahasa', 5),
(38, 1, 'jurusan_1', 'Seni', 6),
(39, 1, 'jurusan_1', 'Kesehatan', 7),
(40, 1, 'jurusan_1', 'Olahraga', 8),
(41, 1, 'jurusan_1', 'Sains Terapan', 9),
(42, 1, 'jurusan_1', 'Perancangan Bangunan', 10),
(44, 1, 'jurusan_2', 'Tidak Ada', 0),
(45, 1, 'jurusan_2', 'Teknik', 1),
(46, 1, 'jurusan_2', 'Komputer', 2),
(47, 1, 'jurusan_2', 'Ekonomi', 3),
(48, 1, 'jurusan_2', 'Sosial', 4),
(49, 1, 'jurusan_2', 'Bahasa', 5),
(50, 1, 'jurusan_2', 'Seni', 6),
(51, 1, 'jurusan_2', 'Kesehatan', 7),
(52, 1, 'jurusan_2', 'Olahraga', 8),
(53, 1, 'jurusan_2', 'Sains Terapan', 9),
(54, 1, 'jurusan_2', 'Perancangan Bangunan', 10),
(55, 1, 'jurusan_2', 'Pendidikan Guru', 11);

-- --------------------------------------------------------

--
-- Table structure for table `centroid`
--

CREATE TABLE `centroid` (
  `id` bigint NOT NULL,
  `kmeans_iteration_id` bigint NOT NULL,
  `cluster_code` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `agama` decimal(8,4) DEFAULT NULL,
  `pkn` decimal(8,4) DEFAULT NULL,
  `b_indonesia` decimal(8,4) DEFAULT NULL,
  `b_inggris` decimal(8,4) DEFAULT NULL,
  `mtk_wajib` decimal(8,4) DEFAULT NULL,
  `sejarah` decimal(8,4) DEFAULT NULL,
  `pjok` decimal(8,4) DEFAULT NULL,
  `seni_rupa` decimal(8,4) DEFAULT NULL,
  `b_jepang` decimal(8,4) DEFAULT NULL,
  `biologi` decimal(8,4) DEFAULT NULL,
  `fisika` decimal(8,4) DEFAULT NULL,
  `kimia` decimal(8,4) DEFAULT NULL,
  `informatika` decimal(8,4) DEFAULT NULL,
  `mtk_lanjut` decimal(8,4) DEFAULT NULL,
  `geografi` decimal(8,4) DEFAULT NULL,
  `sosial` decimal(8,4) DEFAULT NULL,
  `pkwu` decimal(8,4) DEFAULT NULL,
  `ekonomi` decimal(8,4) DEFAULT NULL,
  `ekstrakurikuler` decimal(8,4) DEFAULT NULL,
  `prestasi` decimal(8,4) DEFAULT NULL,
  `kemampuan` decimal(8,4) DEFAULT NULL,
  `organisasi` decimal(8,4) DEFAULT NULL,
  `kursus` decimal(8,4) DEFAULT NULL,
  `jurusan_1` decimal(8,4) DEFAULT NULL,
  `jurusan_2` decimal(8,4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cleaned_data`
--

CREATE TABLE `cleaned_data` (
  `id` bigint NOT NULL,
  `preprocessing_run_id` bigint NOT NULL,
  `siswa_periode_id` bigint NOT NULL,
  `agama` decimal(8,4) DEFAULT NULL,
  `pkn` decimal(8,4) DEFAULT NULL,
  `b_indonesia` decimal(8,4) DEFAULT NULL,
  `b_inggris` decimal(8,4) DEFAULT NULL,
  `mtk_wajib` decimal(8,4) DEFAULT NULL,
  `sejarah` decimal(8,4) DEFAULT NULL,
  `pjok` decimal(8,4) DEFAULT NULL,
  `seni_rupa` decimal(8,4) DEFAULT NULL,
  `b_jepang` decimal(8,4) DEFAULT NULL,
  `biologi` decimal(8,4) DEFAULT NULL,
  `fisika` decimal(8,4) DEFAULT NULL,
  `kimia` decimal(8,4) DEFAULT NULL,
  `informatika` decimal(8,4) DEFAULT NULL,
  `mtk_lanjut` decimal(8,4) DEFAULT NULL,
  `geografi` decimal(8,4) DEFAULT NULL,
  `sosial` decimal(8,4) DEFAULT NULL,
  `pkwu` decimal(8,4) DEFAULT NULL,
  `ekonomi` decimal(8,4) DEFAULT NULL,
  `ekstrakurikuler` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prestasi` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kemampuan` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organisasi` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kursus` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jurusan_1` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jurusan_2` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cleaned_data`
--

INSERT INTO `cleaned_data` (`id`, `preprocessing_run_id`, `siswa_periode_id`, `agama`, `pkn`, `b_indonesia`, `b_inggris`, `mtk_wajib`, `sejarah`, `pjok`, `seni_rupa`, `b_jepang`, `biologi`, `fisika`, `kimia`, `informatika`, `mtk_lanjut`, `geografi`, `sosial`, `pkwu`, `ekonomi`, `ekstrakurikuler`, `prestasi`, `kemampuan`, `organisasi`, `kursus`, `jurusan_1`, `jurusan_2`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 96.6667, 92.0000, 87.0000, 85.0000, 83.3333, 88.0000, 84.3333, 83.6667, 76.6667, 96.0000, 95.0000, 76.6667, 86.0000, 77.3333, 72.0182, 76.0242, 80.1818, 82.7170, 'Badminton', 'Tidak', 'Modifikasi Motor', 'Badminton', 'Tidak', 'Teknik Mesin', 'Pendidikan Jasmani', NULL, NULL),
(2, 1, 2, 80.0000, 79.3333, 79.0000, 81.6667, 73.0000, 81.6667, 77.6667, 75.3333, 69.3333, 78.0000, 64.0000, 68.0000, 83.0000, 67.6667, 72.0182, 76.0242, 80.1818, 82.7170, 'Futsal', 'Tidak', 'Bermain Futsal', 'Karang Taruna', 'Tidak', 'Manajemen', 'Ilmu Keolahragaan', NULL, NULL),
(3, 1, 3, 88.3333, 86.0000, 81.6667, 88.3333, 79.3333, 80.3333, 85.6667, 75.3333, 78.3333, 93.3333, 75.6667, 75.6667, 85.3333, 69.3333, 72.0182, 76.0242, 80.1818, 82.7170, 'Band', 'Tidak', 'Main Gitar', 'OSIS', 'Bimbel', 'Psikologi', 'Sastra Indonesia', NULL, NULL),
(4, 1, 4, 75.0000, 75.0000, 75.0000, 81.6667, 76.6667, 87.6667, 71.6667, 62.0000, 53.3333, 78.0000, 78.6667, 45.3333, 80.3333, 70.0000, 72.0182, 76.0242, 80.1818, 82.7170, 'Futsal', 'Tidak', 'Bermain Futsal', 'Tidak', 'Tidak', 'Manajemen', 'Ekonomi', NULL, NULL),
(5, 1, 5, 90.0000, 88.3333, 81.6667, 80.0000, 78.0000, 89.3333, 82.0000, 81.6667, 75.0000, 95.6667, 82.0000, 75.3333, 87.3333, 76.0000, 72.0182, 76.0242, 80.1818, 82.7170, 'Modern Dance', 'Tidak', 'Bisnis', 'Karang Taruna', 'Tidak', 'Manajemen', 'Akuntansi', NULL, NULL),
(6, 1, 6, 88.3333, 78.3333, 81.6667, 88.3333, 83.6667, 71.0000, 76.0000, 81.6667, 70.0000, 88.0000, 55.3333, 57.6667, 87.3333, 81.0000, 72.0182, 76.0242, 80.1818, 82.7170, 'Badminton', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Sastra Inggris', 'Ilmu Komunikasi', NULL, NULL),
(7, 1, 7, 81.6667, 73.3333, 77.0000, 76.6667, 73.0000, 57.3333, 74.6667, 63.6667, 73.3333, 74.3333, 70.0000, 56.6667, 79.6667, 68.3333, 72.0182, 76.0242, 80.1818, 82.7170, 'Taekwondo', 'Tidak', 'Bela Diri', 'Tidak', 'Tidak', 'Ilmu Keolahragaan', 'Pendidikan Jasmani', NULL, NULL),
(8, 1, 8, 81.0000, 80.0000, 76.6667, 78.3333, 73.3333, 66.6667, 79.3333, 78.6667, 76.6667, 86.0000, 60.6667, 75.0000, 85.6667, 69.3333, 72.0182, 76.0242, 80.1818, 82.7170, 'Badminton', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Industri', 'Teknik Elektro', NULL, NULL),
(9, 1, 9, 93.3333, 87.6667, 88.0000, 88.3333, 87.0000, 87.6667, 82.6667, 85.0000, 85.0000, 92.6667, 86.3333, 85.6667, 87.6667, 75.6667, 72.0182, 76.0242, 80.1818, 82.7170, 'Basket', 'Tidak', 'Main Basket', 'Tidak', 'Tidak', 'Manajemen', 'Hukum', NULL, NULL),
(10, 1, 10, 78.3333, 82.6667, 78.0000, 88.3333, 82.3333, 72.3333, 79.3333, 80.3333, 80.0000, 95.0000, 64.3333, 74.6667, 86.3333, 79.0000, 72.0182, 76.0242, 80.1818, 82.7170, 'Tari Tradisional', 'Runner Up Puteri Remaja Indonesia Lingkungan Jakarta 2024', 'Menari', 'OSIS', 'Bimbel', 'Ilmu Komunikasi', 'Psikologi', NULL, NULL),
(11, 1, 11, 88.3333, 80.0000, 79.6667, 90.0000, 83.3333, 74.0000, 85.0000, 86.6667, 78.3333, 92.6667, 74.6667, 65.0000, 90.0000, 80.0000, 72.0182, 76.0242, 80.1818, 82.7170, 'Badminton', 'Tidak', 'Menggambar', 'Badminton', 'Bimbel', 'Arsitektur', 'DKV', NULL, NULL),
(12, 1, 12, 83.3333, 81.6667, 78.0000, 85.0000, 86.6667, 77.0000, 80.0000, 83.3333, 75.0000, 77.3333, 69.0000, 63.0000, 89.3333, 83.3333, 72.0182, 76.0242, 80.1818, 82.7170, 'Mading', 'Tidak', 'Fotografi', 'Tidak', 'Bimbel', 'DKV', 'Manajemen', NULL, NULL),
(13, 1, 13, 90.6667, 80.0000, 88.0000, 87.3333, 79.0000, 81.6667, 84.3333, 81.6667, 65.0000, 87.6667, 77.3333, 63.0000, 84.0000, 75.3333, 72.0182, 76.0242, 80.1818, 82.7170, 'Futsal', 'Tidak', 'Videografi', 'Karang Taruna', 'Bimbel', 'DKV', 'Teknik Informatika', NULL, NULL),
(14, 1, 14, 91.6667, 85.0000, 85.0000, 88.3333, 77.6667, 83.3333, 87.6667, 85.0000, 68.3333, 90.6667, 76.3333, 66.0000, 87.3333, 71.0000, 72.0182, 76.0242, 80.1818, 82.7170, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Mesin', 'Hukum', NULL, NULL),
(15, 1, 15, 95.0000, 82.3333, 85.0000, 90.0000, 72.0000, 83.3333, 66.0000, 85.0000, 73.3333, 90.0000, 93.3333, 74.6667, 87.3333, 72.3333, 72.0182, 76.0242, 80.1818, 82.7170, 'Basket', 'Tidak', 'Editing', 'Tidak', 'Tidak', 'Teknik Informatika', 'DKV', NULL, NULL),
(16, 1, 16, 81.6667, 66.0000, 67.6667, 80.0000, 74.0000, 77.3333, 66.0000, 78.3333, 65.0000, 84.3333, 76.3333, 62.6667, 74.0000, 75.0000, 72.0182, 76.0242, 80.1818, 82.7170, 'Futsal', 'Tidak', 'Bisnis', 'Basket', 'Tidak', 'Akuntansi', 'Manajemen', NULL, NULL),
(17, 1, 17, 71.6667, 71.6667, 73.0000, 88.3333, 87.0000, 73.3333, 74.6667, 73.6667, 58.3333, 84.0000, 58.3333, 48.0000, 87.0000, 89.0000, 72.0182, 76.0242, 80.1818, 82.7170, 'KIR', 'Tidak', 'Analisis', 'OSIS', 'Bimbel', 'Kedokteran', 'Teknik Informatika', NULL, NULL),
(18, 1, 18, 90.0000, 82.6667, 86.3333, 85.0000, 76.3333, 76.0000, 88.0000, 85.0000, 71.6667, 86.6667, 75.6667, 70.3333, 85.3333, 70.0000, 72.0182, 76.0242, 80.1818, 82.7170, 'Basket', 'Tidak', 'Gaming', 'Basket', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', NULL, NULL),
(19, 1, 19, 96.6667, 85.3333, 80.0000, 85.0000, 84.3333, 79.0000, 84.0000, 81.6667, 80.0000, 87.3333, 73.6667, 68.0000, 86.3333, 85.0000, 72.0182, 76.0242, 80.1818, 82.7170, 'Modern Dance', 'Tidak', 'Wirausaha', 'OSIS', 'Bimbel', 'Manajemen', 'Farmasi', NULL, NULL),
(20, 1, 20, 96.6667, 76.6667, 85.0000, 80.0000, 72.6667, 81.6667, 81.0000, 86.6667, 71.6667, 88.3333, 79.3333, 71.3333, 85.6667, 69.3333, 72.0182, 76.0242, 80.1818, 82.7170, 'Futsal', 'Tidak', 'Desain', 'Tidak', 'Tidak', 'DKV', 'Arsitektur', NULL, NULL),
(21, 1, 21, 91.6667, 82.3333, 84.6667, 85.0000, 64.6667, 80.0000, 83.3333, 83.3333, 66.6667, 80.0000, 71.3333, 65.0000, 85.3333, 62.3333, 72.0182, 76.0242, 80.1818, 82.7170, 'Basket', 'Tidak', 'Bisnis', 'Karang Taruna', 'Tidak', 'Manajemen', 'Ekonomi', NULL, NULL),
(22, 1, 22, 95.0000, 88.6667, 87.0000, 86.6667, 84.0000, 77.3333, 86.3333, 83.3333, 75.0000, 96.0000, 84.6667, 75.6667, 85.0000, 79.0000, 72.0182, 76.0242, 80.1818, 82.7170, 'Taekwondo', 'Tidak', 'Bela Diri', 'OSIS', 'Tidak', 'Ilmu Keolahragaan', 'Hukum', NULL, NULL),
(23, 1, 23, 93.3333, 86.6667, 87.0000, 88.3333, 71.0000, 82.6667, 83.3333, 82.0000, 76.6667, 84.0000, 74.3333, 77.0000, 87.3333, 68.3333, 72.0182, 76.0242, 80.1818, 82.7170, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Tidak', 'Tidak', 'Teknik Industri', 'Teknik Elektro', NULL, NULL),
(24, 1, 24, 81.6667, 84.3333, 75.0000, 83.3333, 77.0000, 75.6667, 84.3333, 82.0000, 76.6667, 72.6667, 62.3333, 76.3333, 84.3333, 81.6667, 72.0182, 76.0242, 80.1818, 82.7170, 'KIR', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Psikologi', NULL, NULL),
(25, 1, 25, 85.0000, 89.3333, 67.0000, 83.3333, 74.6667, 79.0000, 74.3333, 78.6667, 70.0000, 82.0470, 71.6867, 68.4867, 90.3333, 74.7667, 78.6667, 82.3333, 84.0000, 79.0000, 'Tari Tradisional', 'Tidak', 'Wirausaha', 'Karang Taruna', 'Bimbel', 'Manajemen', 'Akuntansi', NULL, NULL),
(26, 1, 26, 87.6667, 89.0000, 80.0000, 90.0000, 79.0000, 85.0000, 79.0000, 80.0000, 75.0000, 82.0470, 71.6867, 68.4867, 86.6667, 74.7667, 90.0000, 85.0000, 92.0000, 87.3333, 'Tari Tradisional', 'Juara harapan 1 FLS2N', 'Desain', 'Tidak', 'Bimbel', 'DKV', 'Arsitektur', NULL, NULL),
(27, 1, 27, 83.3333, 85.0000, 75.3333, 70.0000, 70.0000, 81.0000, 76.6667, 68.6667, 80.0000, 82.0470, 71.6867, 68.4867, 87.6667, 74.7667, 62.6667, 76.0000, 76.0000, 80.0000, 'Futsal', 'Juara 1 Lomba Futsal di SMA Penabur Bintaro Jaya 2024', 'Bermain Futsal', 'Karang Taruna', 'Tidak', 'Ilmu Keolahragaan', 'Teknik Elektro', NULL, NULL),
(28, 1, 28, 89.3333, 71.0000, 68.3333, 90.0000, 72.6667, 74.6667, 71.3333, 70.3333, 75.0000, 82.0470, 71.6867, 68.4867, 72.0000, 74.7667, 72.3333, 87.3333, 77.3333, 84.6667, 'Band', 'Tidak', 'Gaming', 'Tidak', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', NULL, NULL),
(29, 1, 29, 85.0000, 86.6667, 68.6667, 76.6667, 74.6667, 71.6667, 70.0000, 77.0000, 68.3333, 82.0470, 71.6867, 68.4867, 81.0000, 74.7667, 75.6667, 78.3333, 72.6667, 78.0000, 'Futsal', 'Tidak', 'Atletik', 'Tidak', 'Tidak', 'Pendidikan Jasmani', 'Ilmu Keolahragaan', NULL, NULL),
(30, 1, 30, 88.3333, 87.6667, 73.3333, 81.6667, 81.6667, 80.6667, 76.0000, 81.6667, 78.3333, 82.0470, 71.6867, 68.4867, 85.3333, 74.7667, 78.6667, 77.6667, 81.0000, 86.0000, 'Basket', 'Tidak', 'Public Speaking', 'Basket', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Sastra Inggris', NULL, NULL),
(31, 1, 31, 70.0000, 76.6667, 71.3333, 75.0000, 61.6667, 59.6667, 69.6667, 70.3333, 68.3333, 82.0470, 71.6867, 68.4867, 67.6667, 74.7667, 65.0000, 57.6667, 74.3333, 78.3333, 'Futsal', 'Tidak', 'Modifikasi Motor', 'OSIS', 'Tidak', 'Teknik Mesin', 'Teknik Industri', NULL, NULL),
(32, 1, 32, 75.0000, 80.0000, 68.3333, 78.3333, 63.0000, 68.0000, 72.3333, 70.3333, 66.6667, 82.0470, 71.6867, 68.4867, 74.3333, 74.7667, 57.6667, 69.3333, 74.0000, 81.6667, 'KIR', 'Tidak', 'Analisis', 'Tidak', 'Tidak', 'Hukum', 'Psikologi', NULL, NULL),
(33, 1, 33, 91.6667, 90.0000, 80.0000, 85.0000, 72.6667, 81.0000, 78.0000, 73.6667, 83.3333, 82.0470, 71.6867, 68.4867, 89.3333, 74.7667, 72.0000, 87.3333, 77.6667, 85.0000, 'Taekwondo', 'Tidak', 'Bela Diri', 'Karang Taruna', 'Pelatihan Saksi Partai', 'Hukum', 'Ilmu Komunikasi', NULL, NULL),
(34, 1, 34, 88.3333, 88.3333, 80.0000, 91.6667, 85.3333, 82.3333, 83.3333, 80.0000, 76.6667, 82.0470, 71.6867, 68.4867, 86.6667, 74.7667, 86.6667, 77.6667, 86.0000, 84.0000, 'Taekwondo', 'Juara 1 kejuaraan taekwondo liga DKI', 'Bela Diri', 'OSIS', 'Tidak', 'Hukum', 'Pendidikan Jasmani', NULL, NULL),
(35, 1, 35, 85.0000, 86.6667, 73.0000, 86.6667, 78.6667, 69.6667, 69.0000, 81.6667, 71.6667, 82.0470, 71.6867, 68.4867, 73.3333, 74.7667, 69.3333, 79.0000, 81.0000, 79.6667, 'Badminton', 'Tidak', 'Atletik', 'Badminton', 'Tidak', 'Pendidikan Jasmani', 'Sastra Indonesia', NULL, NULL),
(36, 1, 36, 88.3333, 91.0000, 80.0000, 85.0000, 71.3333, 82.6667, 83.0000, 77.0000, 83.3333, 82.0470, 71.6867, 68.4867, 81.6667, 74.7667, 82.0000, 84.6667, 72.3333, 85.0000, 'Taekwondo', 'Tidak', 'Bela Diri', 'Tidak', 'Tidak', 'Ilmu Keolahragaan', 'Teknik Mesin', NULL, NULL),
(37, 1, 37, 66.6667, 67.6667, 53.0000, 61.6667, 49.3333, 64.0000, 48.6667, 67.0000, 51.0000, 82.0470, 71.6867, 68.4867, 60.3333, 74.7667, 43.0000, 60.6667, 62.3333, 66.3333, 'Band', 'Tidak', 'Main Drum', 'OSIS', 'Tidak', 'Manajemen', 'Teknik Industri', NULL, NULL),
(38, 1, 38, 71.6667, 66.6667, 71.3333, 70.0000, 57.6667, 66.3333, 81.0000, 70.3333, 72.6667, 82.0470, 71.6867, 68.4867, 77.0000, 74.7667, 58.6667, 72.3333, 67.3333, 71.3333, 'Badminton', 'Tidak', 'Videografi', 'Badminton', 'Tidak', 'DKV', 'Teknik Informatika', NULL, NULL),
(39, 1, 39, 83.3333, 79.3333, 75.0000, 81.6667, 66.0000, 72.0000, 81.0000, 81.6667, 72.6667, 82.0470, 71.6867, 68.4867, 92.6667, 74.7667, 72.0000, 71.0000, 85.0000, 81.6667, 'Modern Dance', 'Tidak', 'Bisnis', 'Karang Taruna', 'Bimbel', 'Hukum', 'Akuntansi', NULL, NULL),
(40, 1, 40, 90.0000, 86.6667, 75.0000, 85.0000, 66.0000, 80.0000, 66.6667, 83.3333, 73.3333, 82.0470, 71.6867, 68.4867, 90.3333, 74.7667, 82.0000, 84.3333, 86.3333, 90.0000, 'Futsal', 'Juara 1 Lomba Futsal di SMA Penabur Bintaro Jaya 2024', 'Bermain Futsal', 'Karang Taruna', 'Tidak', 'Ilmu Komunikasi', 'Manajemen', NULL, NULL),
(41, 1, 41, 88.3333, 88.3333, 83.3333, 86.6667, 80.6667, 79.0000, 74.6667, 77.0000, 76.6667, 82.0470, 71.6867, 68.4867, 86.0000, 74.7667, 72.0000, 82.6667, 84.0000, 86.3333, 'Mading', 'Tidak', 'Melukis', 'Tidak', 'Bimbel', 'Manajemen', 'DKV', NULL, NULL),
(42, 1, 42, 70.0000, 66.6667, 56.6667, 73.3333, 78.3333, 51.3333, 52.3333, 67.0000, 58.3333, 82.0470, 71.6867, 68.4867, 72.6667, 74.7667, 69.0000, 61.6667, 70.6667, 75.0000, 'Tari Tradisional', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Psikologi', NULL, NULL),
(43, 1, 43, 91.6667, 90.0000, 81.0000, 88.3333, 82.0000, 89.6667, 77.6667, 78.6667, 75.0000, 82.0470, 71.6867, 68.4867, 87.3333, 74.7667, 85.0000, 89.3333, 89.0000, 90.0000, 'Modern Dance', 'Tidak', 'Wirausaha', 'Tidak', 'Bimbel', 'Manajemen', 'Akuntansi', NULL, NULL),
(44, 1, 44, 80.0000, 88.3333, 83.0000, 83.3333, 73.0000, 77.0000, 79.6667, 73.6667, 85.0000, 82.0470, 71.6867, 68.4867, 90.0000, 74.7667, 82.0000, 82.6667, 86.0000, 76.6667, 'Mading', 'Tidak', 'Menggambar', 'Karang Taruna', 'Tidak', 'Seni Rupa', 'DKV', NULL, NULL),
(45, 1, 45, 86.6667, 89.0000, 81.6667, 90.0000, 79.3333, 80.0000, 74.6667, 78.3333, 75.0000, 82.0470, 71.6867, 68.4867, 90.3333, 74.7667, 81.3333, 85.0000, 86.3333, 86.0000, 'KIR', 'Tidak', 'Analisis', 'PMR', 'Tidak', 'Ilmu Keperawatan', 'Farmasi', NULL, NULL),
(46, 1, 46, 83.3333, 89.3333, 71.6667, 85.0000, 73.3333, 86.0000, 78.0000, 77.0000, 77.6667, 82.0470, 71.6867, 68.4867, 89.3333, 74.7667, 78.6667, 81.0000, 72.3333, 85.3333, 'Band', 'Tidak', 'Main Gitar', 'Karang Taruna', 'Tidak', 'Manajemen', 'Hukum', NULL, NULL),
(47, 1, 47, 94.3333, 92.0000, 85.0000, 90.0000, 86.3333, 90.0000, 83.0000, 81.6667, 80.0000, 82.0470, 71.6867, 68.4867, 90.0000, 74.7667, 91.6667, 91.6667, 93.6667, 90.0000, 'KIR', 'Tidak', 'Analisis', 'PMR', 'Bimbel', 'Ilmu Keperawatan', 'Teknologi Pangan', NULL, NULL),
(48, 1, 48, 86.6667, 91.6667, 79.3333, 81.6667, 86.0000, 77.3333, 74.3333, 75.3333, 76.6667, 82.0470, 71.6867, 68.4867, 83.6667, 74.7667, 78.0000, 85.0000, 83.0000, 85.0000, 'Tari Tradisional', 'Tidak', 'Bisnis', 'OSIS', 'Bimbel', 'Akuntansi', 'Ekonomi', NULL, NULL),
(49, 1, 49, 83.3333, 88.3333, 79.3333, 81.6667, 72.0000, 78.3333, 72.6667, 72.0000, 75.0000, 82.0470, 71.6867, 68.4867, 77.3333, 74.7667, 79.0000, 83.0000, 77.6667, 82.3333, 'Badminton', 'Tidak', 'Public Speaking', 'Badminton', 'Kursus TOEFL', 'Sastra Inggris', 'Ilmu Komunikasi', NULL, NULL),
(50, 1, 50, 78.3333, 88.3333, 79.3333, 83.3333, 66.6667, 78.3333, 74.6667, 72.0000, 75.0000, 82.0470, 71.6867, 68.4867, 89.3333, 74.7667, 63.3333, 83.3333, 71.0000, 86.6667, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Tidak', 'Tidak', 'Teknik Industri', 'Teknik Elektro', NULL, NULL),
(51, 1, 51, 93.3333, 90.3333, 88.0000, 86.6667, 70.0000, 89.6667, 79.3333, 78.6667, 81.6667, 82.0470, 71.6867, 68.4867, 84.3333, 74.7667, 88.3333, 86.3333, 93.6667, 86.6667, 'Tari Tradisional', 'Tidak', 'Bisnis', 'Karang Taruna', 'Bimbel', 'Akuntansi', 'Hukum', NULL, NULL),
(52, 1, 52, 75.0000, 87.6667, 78.3333, 85.0000, 71.3333, 78.3333, 72.6667, 77.0000, 74.3333, 66.3333, 60.6667, 56.6667, 83.1983, 70.0000, 72.0182, 76.0242, 80.1818, 81.6667, 'KIR', 'Juara 2 kejuaraan pelajar nasional', 'Analisis', 'OSIS', 'Tidak', 'Teknologi Pangan', 'Arsitektur', NULL, NULL),
(53, 1, 53, 82.6667, 86.0000, 81.0000, 88.3333, 78.0000, 71.0000, 73.6667, 78.3333, 78.3333, 81.6667, 65.6667, 70.3333, 83.1983, 76.0000, 72.0182, 76.0242, 80.1818, 81.6667, 'Tari Tradisional', 'Tidak', 'Memasak', 'Tidak', 'Bimbel', 'Teknologi Pangan', 'Ilmu Komunikasi', NULL, NULL),
(54, 1, 54, 83.3333, 85.0000, 82.6667, 88.3333, 75.6667, 77.6667, 73.6667, 78.3333, 67.6667, 77.6667, 68.0000, 59.0000, 83.1983, 78.3333, 72.0182, 76.0242, 80.1818, 85.0000, 'Modern Dance', 'Tidak', 'Menari', 'Karang Taruna', 'Tidak', 'Seni Rupa', 'PGSD', NULL, NULL),
(55, 1, 55, 90.0000, 81.6667, 80.3333, 85.0000, 76.3333, 91.3333, 79.3333, 81.6667, 81.6667, 92.3333, 73.0000, 75.6667, 83.1983, 82.3333, 72.0182, 76.0242, 80.1818, 81.6667, 'Mading', 'Tidak', 'Videografi', 'Tidak', 'Bimbel', 'DKV', 'Teknik Informatika', NULL, NULL),
(56, 1, 56, 89.3333, 81.0000, 81.6667, 87.3333, 71.3333, 75.3333, 82.6667, 77.0000, 81.6667, 88.3333, 68.6667, 62.6667, 83.1983, 71.3333, 72.0182, 76.0242, 80.1818, 87.0000, 'Band', 'Tidak', 'Modifikasi Motor', 'OSIS', 'Bimbel', 'Teknik Mesin', 'Teknik Elektro', NULL, NULL),
(57, 1, 57, 90.0000, 88.3333, 75.0000, 93.3333, 77.3333, 91.6667, 78.0000, 81.6667, 83.3333, 88.6667, 69.3333, 86.6667, 83.1983, 80.6667, 72.0182, 76.0242, 80.1818, 83.3333, 'Mading', 'Tidak', 'Menggambar', 'Tidak', 'Bimbel', 'DKV', 'Arsitektur', NULL, NULL),
(58, 1, 58, 80.0000, 55.0000, 76.3333, 83.3333, 80.0000, 70.6667, 64.3333, 75.3333, 81.6667, 70.3333, 64.6667, 50.0000, 83.1983, 78.3333, 72.0182, 76.0242, 80.1818, 83.6667, 'Basket', 'Tidak', 'Bisnis', 'Basket', 'Tidak', 'Manajemen', 'Psikologi', NULL, NULL),
(59, 1, 59, 81.6667, 66.0000, 75.0000, 83.3333, 81.3333, 72.0000, 67.6667, 75.3333, 80.0000, 69.0000, 57.6667, 58.3333, 83.1983, 81.0000, 72.0182, 76.0242, 80.1818, 86.3333, 'Taekwondo', 'Tidak', 'Bela Diri', 'Karang Taruna', 'Tidak', 'Pendidikan Jasmani', 'Hukum', NULL, NULL),
(60, 1, 60, 81.6667, 88.3333, 79.6667, 83.3333, 73.3333, 74.3333, 84.6667, 77.0000, 78.3333, 66.6667, 61.6667, 63.3333, 83.1983, 66.0000, 72.0182, 76.0242, 80.1818, 81.6667, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Industri', 'Manajemen', NULL, NULL),
(61, 1, 61, 76.6667, 66.6667, 68.0000, 83.3333, 71.6667, 61.3333, 69.6667, 77.0000, 73.3333, 72.6667, 67.0000, 67.3333, 83.1983, 70.6667, 72.0182, 76.0242, 80.1818, 76.6667, 'Badminton', 'Tidak', 'Editing', 'Tidak', 'Tidak', 'DKV', 'Teknik Informatika', NULL, NULL),
(62, 1, 62, 81.6667, 73.3333, 73.3333, 86.6667, 86.0000, 80.6667, 71.0000, 80.0000, 73.3333, 88.3333, 65.0000, 78.3333, 83.1983, 85.0000, 72.0182, 76.0242, 80.1818, 87.6667, 'Mading', 'Tidak', 'Menggambar', 'Tidak', 'Tidak', 'Arsitektur', 'DKV', NULL, NULL),
(63, 1, 63, 90.0000, 80.6667, 83.3333, 88.3333, 83.3333, 81.0000, 81.3333, 83.3333, 85.0000, 90.6667, 80.6667, 76.3333, 83.1983, 80.6667, 72.0182, 76.0242, 80.1818, 90.0000, 'Futsal', 'Tidak', 'Wirausaha', 'Tidak', 'Tidak', 'Manajemen', 'Ekonomi', NULL, NULL),
(64, 1, 64, 78.3333, 77.3333, 66.6667, 80.0000, 63.3333, 75.3333, 62.0000, 76.6667, 78.3333, 76.6667, 52.3333, 63.3333, 83.1983, 61.0000, 72.0182, 76.0242, 80.1818, 75.3333, 'Futsal', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Tidak', 'Tidak', 'Teknik Informatika', 'Manajemen', NULL, NULL),
(65, 1, 65, 88.3333, 90.0000, 76.6667, 85.0000, 76.3333, 78.6667, 76.3333, 78.6667, 85.0000, 90.3333, 82.0000, 68.3333, 83.1983, 66.0000, 72.0182, 76.0242, 80.1818, 86.6667, 'Basket', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'OSIS', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', NULL, NULL),
(66, 1, 66, 78.3333, 81.6667, 79.6667, 73.3333, 73.3333, 78.6667, 79.6667, 77.0000, 74.3333, 68.6667, 60.3333, 68.6667, 83.1983, 61.6667, 72.0182, 76.0242, 80.1818, 77.3333, 'Futsal', 'Tidak', 'Public Speaking', 'Karang Taruna', 'Tidak', 'Hukum', 'Ilmu Komunikasi', NULL, NULL),
(67, 1, 67, 93.3333, 84.3333, 78.3333, 88.3333, 79.6667, 87.3333, 86.3333, 80.0000, 86.6667, 95.0000, 84.6667, 81.6667, 83.1983, 69.0000, 72.0182, 76.0242, 80.1818, 85.0000, 'Badminton', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Badminton', 'Tidak', 'Teknik Informatika', 'Teknik Elektro', NULL, NULL),
(68, 1, 68, 65.0000, 74.3333, 66.6667, 81.6667, 66.3333, 58.3333, 75.3333, 67.0000, 77.6667, 68.6667, 60.6667, 49.6667, 83.1983, 59.0000, 72.0182, 76.0242, 80.1818, 74.6667, 'Basket', 'Tidak', 'Videografi', 'Karang Taruna', 'Tidak', 'DKV', 'Manajemen', NULL, NULL),
(69, 1, 69, 92.6667, 80.0000, 78.3333, 71.6667, 86.6667, 76.0000, 73.0000, 75.3333, 75.0000, 88.3333, 64.6667, 66.3333, 83.1983, 78.3333, 72.0182, 76.0242, 80.1818, 79.3333, 'KIR', 'Tidak', 'Public Speaking', 'Tidak', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Sastra Inggris', NULL, NULL),
(70, 1, 70, 87.6667, 79.3333, 78.3333, 81.6667, 83.0000, 78.3333, 79.6667, 75.3333, 83.3333, 81.0000, 63.6667, 70.3333, 83.1983, 72.6667, 72.0182, 76.0242, 80.1818, 81.6667, 'Band', 'Juara 2 Solo Vokal M25 Cup SMA Muhammadh 25 Pamulang 2024', 'Menyanyi', 'OSIS', 'Tidak', 'Ilmu Komunikasi', 'Sastra Indonesia', NULL, NULL),
(71, 1, 71, 85.0000, 71.6667, 71.6667, 80.0000, 81.6667, 74.0000, 60.6667, 82.0000, 60.0000, 88.3333, 80.3333, 67.0000, 83.1983, 80.0000, 72.0182, 76.0242, 80.1818, 75.0000, 'Mading', 'Tidak', 'Melukis', 'Tidak', 'Melukis', 'Seni Rupa', 'DKV', NULL, NULL),
(72, 1, 72, 88.3333, 86.6667, 86.6667, 83.3333, 89.6667, 77.3333, 74.3333, 77.0000, 85.0000, 86.3333, 68.3333, 72.6667, 83.1983, 87.6667, 72.0182, 76.0242, 80.1818, 87.3333, 'Tari Tradisional', 'Tidak', 'Bisnis', 'Karang Taruna', 'Bimbel', 'Akuntansi', 'Ekonomi', NULL, NULL),
(73, 1, 73, 88.3333, 84.0000, 75.0000, 75.0000, 87.3333, 80.6667, 76.3333, 77.0000, 81.6667, 87.3333, 80.0000, 78.6667, 83.1983, 79.3333, 72.0182, 76.0242, 80.1818, 84.3333, 'Tari Tradisional', 'Tidak', 'Memasak', 'Tidak', 'Bimbel', 'Ilmu Keperawatan', 'Teknologi Pangan', NULL, NULL),
(74, 1, 74, 74.0000, 74.3333, 82.6667, 83.3333, 86.6667, 63.0000, 75.3333, 78.6667, 88.3333, 85.3333, 65.0000, 75.0000, 83.1983, 84.3333, 72.0182, 76.0242, 80.1818, 83.0000, 'KIR', 'Tidak', 'Analisis', 'Tidak', 'Bimbel', 'Arsitektur', 'Farmasi', NULL, NULL),
(75, 1, 75, 81.6667, 76.6667, 78.6667, 81.6667, 71.6667, 78.3333, 86.6667, 78.6667, 71.6667, 80.0000, 71.6667, 73.3333, 83.1983, 71.0000, 72.0182, 76.0242, 80.1818, 87.6667, 'Futsal', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Karang Taruna', 'Tidak', 'Manajemen', 'Teknik Informatika', NULL, NULL),
(76, 1, 76, 82.6667, 86.6667, 73.6667, 83.3333, 74.6667, 85.6667, 76.0000, 77.0000, 73.3333, 81.6667, 78.6667, 73.3333, 83.1983, 69.3333, 72.0182, 76.0242, 80.1818, 85.3333, 'Badminton', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Tidak', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', NULL, NULL),
(77, 1, 77, 90.0000, 87.0000, 75.3333, 83.3333, 82.6667, 70.0000, 63.3333, 65.3333, 78.3333, 87.3333, 91.3333, 74.6667, 83.1983, 83.3333, 72.0182, 76.0242, 80.1818, 87.0000, 'Tari Tradisional', 'Tidak', 'Wirausaha', 'Karang Taruna', 'Tidak', 'Akuntansi', 'Manajemen', NULL, NULL),
(78, 1, 78, 90.0000, 81.6667, 76.6667, 83.3333, 66.0000, 81.6667, 80.0000, 80.0000, 73.3333, 79.6667, 71.6867, 68.4867, 85.3333, 74.7667, 73.3333, 69.3333, 82.0000, 82.7170, 'Band', 'Tidak', 'Main Gitar', 'Karang Taruna', 'Pelatihan Saksi Partai', 'Hukum', 'Sastra Indonesia', NULL, NULL),
(79, 1, 79, 68.3333, 79.3333, 75.0000, 81.6667, 69.6667, 56.3333, 72.6667, 80.0000, 72.6667, 78.0000, 71.6867, 68.4867, 85.0000, 74.7667, 70.3333, 57.0000, 75.6667, 82.7170, 'Futsal', 'Tidak', 'Editing', 'Karang Taruna', 'Tidak', 'DKV', 'Teknik Informatika', NULL, NULL),
(80, 1, 80, 88.3333, 83.3333, 79.6667, 88.3333, 76.3333, 72.3333, 74.3333, 80.3333, 81.6667, 88.0000, 71.6867, 68.4867, 84.0000, 74.7667, 76.3333, 81.6667, 90.6667, 82.7170, 'Modern Dance', 'Tidak', 'Menari', 'Tidak', 'Tidak', 'Pendidikan Jasmani', 'Seni Rupa', NULL, NULL),
(81, 1, 81, 90.0000, 90.6667, 75.0000, 91.6667, 81.3333, 84.6667, 74.3333, 68.6667, 78.3333, 90.0000, 71.6867, 68.4867, 80.0000, 74.7667, 75.3333, 85.6667, 90.0000, 82.7170, 'Modern Dance', 'Tidak', 'Memasak', 'OSIS', 'Bimbel', 'Teknologi Pangan', 'Farmasi', NULL, NULL),
(82, 1, 82, 81.6667, 78.3333, 76.6667, 81.6667, 76.6667, 72.0000, 72.0000, 80.0000, 78.3333, 82.6667, 71.6867, 68.4867, 78.6667, 74.7667, 71.6667, 86.6667, 80.0000, 82.7170, 'KIR', 'Tidak', 'Wirausaha', 'OSIS', 'Tidak', 'Manajemen', 'Ekonomi', NULL, NULL),
(83, 1, 83, 71.6667, 80.6667, 73.3333, 86.6667, 82.6667, 74.3333, 64.3333, 67.0000, 71.6667, 82.3333, 71.6867, 68.4867, 80.0000, 74.7667, 58.0000, 72.3333, 66.6667, 82.7170, 'Mading', 'Tidak', 'Menggambar', 'Tidak', 'Tidak', 'DKV', 'Arsitektur', NULL, NULL),
(84, 1, 84, 80.0000, 63.3333, 71.6667, 85.0000, 85.0000, 48.6667, 67.3333, 68.6667, 71.6667, 82.6667, 71.6867, 68.4867, 75.3333, 74.7667, 69.0000, 67.0000, 75.0000, 82.7170, 'KIR', 'Tidak', 'Fotografi', 'PMR', 'Tidak', 'DKV', 'Ilmu Keperawatan', NULL, NULL),
(85, 1, 85, 63.3333, 65.6667, 61.3333, 81.6667, 59.3333, 48.3333, 75.3333, 70.3333, 66.6667, 72.0000, 71.6867, 68.4867, 71.0000, 74.7667, 47.6667, 52.3333, 62.6667, 82.7170, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Tidak', 'Tidak', 'Teknik Industri', 'Teknik Elektro', NULL, NULL),
(86, 1, 86, 71.6667, 73.3333, 61.3333, 56.6667, 64.3333, 67.3333, 69.3333, 70.3333, 67.6667, 56.6667, 71.6867, 68.4867, 87.3333, 74.7667, 52.6667, 67.6667, 74.3333, 82.7170, 'Band', 'Tidak', 'Analisis', 'Tidak', 'Bimbel', 'Kedokteran', 'Teknik Industri', NULL, NULL),
(87, 1, 87, 63.3333, 70.0000, 71.3333, 86.6667, 64.3333, 57.6667, 82.6667, 72.0000, 64.3333, 75.0000, 71.6867, 68.4867, 84.0000, 74.7667, 67.3333, 66.0000, 67.3333, 82.7170, 'Taekwondo', 'Tidak', 'Bisnis', 'Tidak', 'Tidak', 'Teknik Informatika', 'Pendidikan Jasmani', NULL, NULL),
(88, 1, 88, 85.0000, 75.6667, 73.3333, 86.6667, 74.0000, 74.3333, 79.3333, 77.0000, 70.0000, 84.0000, 71.6867, 68.4867, 84.6667, 74.7667, 70.0000, 67.6667, 85.0000, 82.7170, 'Basket', 'Tidak', 'Gaming', 'Basket', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', NULL, NULL),
(89, 1, 89, 78.3333, 72.6667, 76.6667, 90.0000, 71.6667, 79.0000, 80.0000, 81.6667, 74.3333, 75.3333, 71.6867, 68.4867, 81.6667, 74.7667, 78.0000, 80.0000, 81.0000, 82.7170, 'Futsal', 'Tidak', 'Desain', 'Tidak', 'Tidak', 'DKV', 'Teknik Informatika', NULL, NULL),
(90, 1, 90, 80.0000, 70.0000, 78.3333, 86.6667, 79.6667, 86.3333, 74.3333, 81.6667, 64.3333, 78.0000, 71.6867, 68.4867, 77.6667, 74.7667, 82.0000, 79.6667, 86.0000, 82.7170, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Industri', 'Hukum', NULL, NULL),
(91, 1, 91, 80.0000, 81.6667, 74.6667, 86.6667, 71.6667, 74.3333, 74.6667, 72.0000, 78.3333, 72.0000, 71.6867, 68.4867, 86.6667, 74.7667, 77.0000, 72.3333, 82.3333, 82.7170, 'Badminton', 'Tidak', 'Public Speaking', 'OSIS', 'Tidak', 'Hukum', 'Psikologi', NULL, NULL),
(92, 1, 92, 68.3333, 62.6667, 51.6667, 78.3333, 51.3333, 68.0000, 74.0000, 73.6667, 56.6667, 69.3333, 71.6867, 68.4867, 81.6667, 74.7667, 59.3333, 69.6667, 74.0000, 82.7170, 'KIR', 'Tidak', 'Bisnis', 'OSIS', 'Tidak', 'Manajemen', 'Akuntansi', NULL, NULL),
(93, 1, 93, 78.3333, 74.3333, 84.6667, 90.0000, 68.0000, 78.0000, 74.0000, 75.3333, 76.0000, 83.0000, 71.6867, 68.4867, 88.0000, 74.7667, 70.6667, 79.0000, 74.0000, 82.7170, 'KIR', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Sastra Inggris', NULL, NULL),
(94, 1, 94, 75.0000, 71.0000, 64.6667, 80.0000, 48.0000, 71.6667, 76.0000, 72.0000, 71.0000, 73.0000, 71.6867, 68.4867, 76.0000, 74.7667, 69.3333, 69.0000, 78.0000, 82.7170, 'Futsal', 'Tidak', 'Desain', 'Tidak', 'Tidak', 'Ilmu Komputer', 'DKV', NULL, NULL),
(95, 1, 95, 68.3333, 75.0000, 65.6667, 76.6667, 50.0000, 63.0000, 78.0000, 76.6667, 70.0000, 70.6667, 71.6867, 68.4867, 79.3333, 74.7667, 56.0000, 71.3333, 73.0000, 82.7170, 'Taekwondo', 'Tidak', 'Bela Diri', 'Karang Taruna', 'Tidak', 'Pendidikan Jasmani', 'Sastra Indonesia', NULL, NULL),
(96, 1, 96, 80.0000, 81.6667, 83.3333, 86.6667, 52.6667, 78.3333, 72.6667, 75.3333, 73.3333, 89.6667, 71.6867, 68.4867, 83.3333, 74.7667, 70.6667, 77.3333, 81.0000, 82.7170, 'Basket', 'Tidak', 'Atletik', 'Basket', 'Tidak', 'Ilmu Keolahragaan', 'Pendidikan Jasmani', NULL, NULL),
(97, 1, 97, 81.6667, 80.0000, 68.3333, 91.6667, 78.3333, 67.3333, 76.0000, 72.0000, 73.3333, 89.6667, 71.6867, 68.4867, 80.6667, 74.7667, 79.6667, 86.0000, 89.3333, 82.7170, 'KIR', 'Tidak', 'Desain', 'OSIS', 'Kursus TOEFL', 'Sastra Inggris', 'Ilmu Komunikasi', NULL, NULL),
(98, 1, 98, 83.3333, 71.6667, 63.3333, 73.3333, 78.3333, 63.3333, 62.6667, 75.0000, 70.0000, 76.6667, 71.6867, 68.4867, 81.3333, 74.7667, 71.6667, 64.3333, 77.6667, 82.7170, 'Modern Dance', 'Tidak', 'Bisnis', 'Tidak', 'Tidak', 'Akuntansi', 'Manajemen', NULL, NULL),
(99, 1, 99, 81.6667, 82.6667, 66.0000, 81.6667, 80.6667, 70.0000, 69.6667, 70.3333, 70.0000, 73.0000, 71.6867, 68.4867, 87.6667, 74.7667, 60.3333, 61.6667, 86.0000, 82.7170, 'Modern Dance', 'Tidak', 'Public Speaking', 'OSIS', 'Bimbel', 'Ilmu Komunikasi', 'Sastra Inggris', NULL, NULL),
(100, 1, 100, 85.0000, 83.6667, 78.3333, 81.6667, 66.0000, 70.6667, 78.0000, 72.0000, 65.0000, 83.3333, 71.6867, 68.4867, 83.0000, 74.7667, 77.3333, 76.6667, 87.3333, 82.7170, 'Badminton', 'Tidak', 'Atletik', 'Badminton', 'Tidak', 'Ilmu Keolahragaan', 'Pendidikan Jasmani', NULL, NULL),
(101, 1, 101, 86.6667, 86.6667, 75.0000, 88.3333, 80.6667, 81.0000, 72.3333, 76.6667, 83.3333, 85.3333, 71.6867, 68.4867, 89.3333, 74.7667, 79.6667, 87.3333, 90.0000, 82.7170, 'Tari Tradisional', 'Tidak', 'Memasak', 'Tidak', 'Bimbel', 'Teknologi Pangan', 'Farmasi', NULL, NULL),
(102, 1, 102, 83.3333, 85.0000, 80.0000, 88.3333, 82.3333, 83.0000, 74.3333, 75.3333, 80.0000, 81.6667, 71.6867, 68.4867, 89.6667, 74.7667, 80.3333, 82.6667, 88.3333, 82.7170, 'Mading', 'Tidak', 'Public Speaking', 'Karang Taruna', 'Tidak', 'Psikologi', 'Ilmu Komunikasi', NULL, NULL),
(103, 1, 103, 64.6667, 56.0000, 45.0000, 56.6667, 81.6667, 51.6667, 54.6667, 52.0000, 50.0000, 64.6667, 71.6867, 68.4867, 53.3333, 74.7667, 47.6667, 50.6667, 73.3333, 82.7170, 'Modern Dance', 'Tidak', 'Bisnis', 'Tidak', 'Tidak', 'Manajemen', 'Ekonomi', NULL, NULL),
(104, 1, 104, 88.3333, 75.0000, 71.6667, 81.6667, 78.3333, 74.0000, 64.6667, 72.0000, 71.6667, 82.0000, 71.6867, 68.4867, 84.6667, 74.7667, 71.6667, 72.3333, 91.3333, 82.7170, 'Mading', 'Tidak', 'Menggambar', 'Karang Taruna', 'Bimbel', 'Arsitektur', 'DKV', NULL, NULL),
(105, 1, 105, 90.0000, 87.3333, 80.0000, 83.3333, 80.0000, 77.6667, 74.6667, 73.6667, 80.0000, 85.0000, 71.6867, 68.4867, 89.6667, 74.7667, 83.3333, 85.6667, 91.3333, 82.7170, 'Basket', 'Tidak', 'Bisnis', 'Basket', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Manajemen', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cluster_assignment`
--

CREATE TABLE `cluster_assignment` (
  `id` bigint NOT NULL,
  `kmeans_iteration_id` bigint NOT NULL,
  `siswa_periode_id` bigint NOT NULL,
  `cluster_code` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nearest_distance` decimal(12,8) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cluster_profile`
--

CREATE TABLE `cluster_profile` (
  `id` bigint NOT NULL,
  `kmeans_run_id` bigint NOT NULL,
  `cluster_code` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bidang_studi` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jurusan_spesifik` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cluster_result`
--

CREATE TABLE `cluster_result` (
  `id` bigint NOT NULL,
  `kmeans_run_id` bigint NOT NULL,
  `siswa_periode_id` bigint NOT NULL,
  `cluster_code` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `distance` decimal(12,8) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `integrated_data`
--

CREATE TABLE `integrated_data` (
  `id` bigint NOT NULL,
  `preprocessing_run_id` bigint NOT NULL,
  `siswa_periode_id` bigint NOT NULL,
  `agama` decimal(8,4) DEFAULT NULL,
  `pkn` decimal(8,4) DEFAULT NULL,
  `b_indonesia` decimal(8,4) DEFAULT NULL,
  `b_inggris` decimal(8,4) DEFAULT NULL,
  `mtk_wajib` decimal(8,4) DEFAULT NULL,
  `sejarah` decimal(8,4) DEFAULT NULL,
  `pjok` decimal(8,4) DEFAULT NULL,
  `seni_rupa` decimal(8,4) DEFAULT NULL,
  `b_jepang` decimal(8,4) DEFAULT NULL,
  `biologi` decimal(8,4) DEFAULT NULL,
  `fisika` decimal(8,4) DEFAULT NULL,
  `kimia` decimal(8,4) DEFAULT NULL,
  `informatika` decimal(8,4) DEFAULT NULL,
  `mtk_lanjut` decimal(8,4) DEFAULT NULL,
  `geografi` decimal(8,4) DEFAULT NULL,
  `sosial` decimal(8,4) DEFAULT NULL,
  `pkwu` decimal(8,4) DEFAULT NULL,
  `ekonomi` decimal(8,4) DEFAULT NULL,
  `ekstrakurikuler` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prestasi` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kemampuan` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organisasi` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kursus` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jurusan_1` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jurusan_2` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `integrated_data`
--

INSERT INTO `integrated_data` (`id`, `preprocessing_run_id`, `siswa_periode_id`, `agama`, `pkn`, `b_indonesia`, `b_inggris`, `mtk_wajib`, `sejarah`, `pjok`, `seni_rupa`, `b_jepang`, `biologi`, `fisika`, `kimia`, `informatika`, `mtk_lanjut`, `geografi`, `sosial`, `pkwu`, `ekonomi`, `ekstrakurikuler`, `prestasi`, `kemampuan`, `organisasi`, `kursus`, `jurusan_1`, `jurusan_2`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 96.6667, 92.0000, 87.0000, 85.0000, 83.3333, 88.0000, 84.3333, 83.6667, 76.6667, 96.0000, 95.0000, 76.6667, 86.0000, 77.3333, NULL, NULL, NULL, NULL, 'Badminton', 'Tidak', 'Modifikasi Motor', 'Badminton', 'Tidak', 'Teknik Mesin', 'Pendidikan Jasmani', NULL, NULL),
(2, 1, 2, 80.0000, 79.3333, 79.0000, 81.6667, 73.0000, 81.6667, 77.6667, 75.3333, 69.3333, 78.0000, 64.0000, 68.0000, 83.0000, 67.6667, NULL, NULL, NULL, NULL, 'Futsal', 'Tidak', 'Bermain Futsal', 'Karang Taruna', 'Tidak', 'Manajemen', 'Ilmu Keolahragaan', NULL, NULL),
(3, 1, 3, 88.3333, 86.0000, 81.6667, 88.3333, 79.3333, 80.3333, 85.6667, 75.3333, 78.3333, 93.3333, 75.6667, 75.6667, 85.3333, 69.3333, NULL, NULL, NULL, NULL, 'Band', 'Tidak', 'Main Gitar', 'OSIS', 'Bimbel', 'Psikologi', 'Sastra Indonesia', NULL, NULL),
(4, 1, 4, 75.0000, 75.0000, 75.0000, 81.6667, 76.6667, 87.6667, 71.6667, 62.0000, 53.3333, 78.0000, 78.6667, 45.3333, 80.3333, 70.0000, NULL, NULL, NULL, NULL, 'Futsal', 'Tidak', 'Bermain Futsal', 'Tidak', 'Tidak', 'Manajemen', 'Ekonomi', NULL, NULL),
(5, 1, 5, 90.0000, 88.3333, 81.6667, 80.0000, 78.0000, 89.3333, 82.0000, 81.6667, 75.0000, 95.6667, 82.0000, 75.3333, 87.3333, 76.0000, NULL, NULL, NULL, NULL, 'Modern Dance', 'Tidak', 'Bisnis', 'Karang Taruna', 'Tidak', 'Manajemen', 'Akuntansi', NULL, NULL),
(6, 1, 6, 88.3333, 78.3333, 81.6667, 88.3333, 83.6667, 71.0000, 76.0000, 81.6667, 70.0000, 88.0000, 55.3333, 57.6667, 87.3333, 81.0000, NULL, NULL, NULL, NULL, 'Badminton', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Sastra Inggris', 'Ilmu Komunikasi', NULL, NULL),
(7, 1, 7, 81.6667, 73.3333, 77.0000, 76.6667, 73.0000, 57.3333, 74.6667, 63.6667, 73.3333, 74.3333, 70.0000, 56.6667, 79.6667, 68.3333, NULL, NULL, NULL, NULL, 'Taekwondo', 'Tidak', 'Bela Diri', 'Tidak', 'Tidak', 'Ilmu Keolahragaan', 'Pendidikan Jasmani', NULL, NULL),
(8, 1, 8, 81.0000, 80.0000, 76.6667, 78.3333, 73.3333, 66.6667, 79.3333, 78.6667, 76.6667, 86.0000, 60.6667, 75.0000, 85.6667, 69.3333, NULL, NULL, NULL, NULL, 'Badminton', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Industri', 'Teknik Elektro', NULL, NULL),
(9, 1, 9, 93.3333, 87.6667, 88.0000, 88.3333, 87.0000, 87.6667, 82.6667, 85.0000, 85.0000, 92.6667, 86.3333, 85.6667, 87.6667, 75.6667, NULL, NULL, NULL, NULL, 'Basket', 'Tidak', 'Main Basket', 'Tidak', 'Tidak', 'Manajemen', 'Hukum', NULL, NULL),
(10, 1, 10, 78.3333, 82.6667, 78.0000, 88.3333, 82.3333, 72.3333, 79.3333, 80.3333, 80.0000, 95.0000, 64.3333, 74.6667, 86.3333, 79.0000, NULL, NULL, NULL, NULL, 'Tari Tradisional', 'Runner Up Puteri Remaja Indonesia Lingkungan Jakarta 2024', 'Menari', 'OSIS', 'Bimbel', 'Ilmu Komunikasi', 'Psikologi', NULL, NULL),
(11, 1, 11, 88.3333, 80.0000, 79.6667, 90.0000, 83.3333, 74.0000, 85.0000, 86.6667, 78.3333, 92.6667, 74.6667, 65.0000, 90.0000, 80.0000, NULL, NULL, NULL, NULL, 'Badminton', 'Tidak', 'Menggambar', 'Badminton', 'Bimbel', 'Arsitektur', 'DKV', NULL, NULL),
(12, 1, 12, 83.3333, 81.6667, 78.0000, 85.0000, 86.6667, 77.0000, 80.0000, 83.3333, 75.0000, 77.3333, 69.0000, 63.0000, 89.3333, 83.3333, NULL, NULL, NULL, NULL, 'Mading', 'Tidak', 'Fotografi', 'Tidak', 'Bimbel', 'DKV', 'Manajemen', NULL, NULL),
(13, 1, 13, 90.6667, 80.0000, 88.0000, 87.3333, 79.0000, 81.6667, 84.3333, 81.6667, 65.0000, 87.6667, 77.3333, 63.0000, 84.0000, 75.3333, NULL, NULL, NULL, NULL, 'Futsal', 'Tidak', 'Videografi', 'Karang Taruna', 'Bimbel', 'DKV', 'Teknik Informatika', NULL, NULL),
(14, 1, 14, 91.6667, 85.0000, 85.0000, 88.3333, 77.6667, 83.3333, 87.6667, 85.0000, 68.3333, 90.6667, 76.3333, 66.0000, 87.3333, 71.0000, NULL, NULL, NULL, NULL, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Mesin', 'Hukum', NULL, NULL),
(15, 1, 15, 95.0000, 82.3333, 85.0000, 90.0000, 72.0000, 83.3333, 66.0000, 85.0000, 73.3333, 90.0000, 93.3333, 74.6667, 87.3333, 72.3333, NULL, NULL, NULL, NULL, 'Basket', 'Tidak', 'Editing', 'Tidak', 'Tidak', 'Teknik Informatika', 'DKV', NULL, NULL),
(16, 1, 16, 81.6667, 66.0000, 67.6667, 80.0000, 74.0000, 77.3333, 66.0000, 78.3333, 65.0000, 84.3333, 76.3333, 62.6667, 74.0000, 75.0000, NULL, NULL, NULL, NULL, 'Futsal', 'Tidak', 'Bisnis', 'Basket', 'Tidak', 'Akuntansi', 'Manajemen', NULL, NULL),
(17, 1, 17, 71.6667, 71.6667, 73.0000, 88.3333, 87.0000, 73.3333, 74.6667, 73.6667, 58.3333, 84.0000, 58.3333, 48.0000, 87.0000, 89.0000, NULL, NULL, NULL, NULL, 'KIR', 'Tidak', 'Analisis', 'OSIS', 'Bimbel', 'Kedokteran', 'Teknik Informatika', NULL, NULL),
(18, 1, 18, 90.0000, 82.6667, 86.3333, 85.0000, 76.3333, 76.0000, 88.0000, 85.0000, 71.6667, 86.6667, 75.6667, 70.3333, 85.3333, 70.0000, NULL, NULL, NULL, NULL, 'Basket', 'Tidak', 'Gaming', 'Basket', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', NULL, NULL),
(19, 1, 19, 96.6667, 85.3333, 80.0000, 85.0000, 84.3333, 79.0000, 84.0000, 81.6667, 80.0000, 87.3333, 73.6667, 68.0000, 86.3333, 85.0000, NULL, NULL, NULL, NULL, 'Modern Dance', 'Tidak', 'Wirausaha', 'OSIS', 'Bimbel', 'Manajemen', 'Farmasi', NULL, NULL),
(20, 1, 20, 96.6667, 76.6667, 85.0000, 80.0000, 72.6667, 81.6667, 81.0000, 86.6667, 71.6667, 88.3333, 79.3333, 71.3333, 85.6667, 69.3333, NULL, NULL, NULL, NULL, 'Futsal', 'Tidak', 'Desain', 'Tidak', 'Tidak', 'DKV', 'Arsitektur', NULL, NULL),
(21, 1, 21, 91.6667, 82.3333, 84.6667, 85.0000, 64.6667, 80.0000, 83.3333, 83.3333, 66.6667, 80.0000, 71.3333, 65.0000, 85.3333, 62.3333, NULL, NULL, NULL, NULL, 'Basket', 'Tidak', 'Bisnis', 'Karang Taruna', 'Tidak', 'Manajemen', 'Ekonomi', NULL, NULL),
(22, 1, 22, 95.0000, 88.6667, 87.0000, 86.6667, 84.0000, 77.3333, 86.3333, 83.3333, 75.0000, 96.0000, 84.6667, 75.6667, 85.0000, 79.0000, NULL, NULL, NULL, NULL, 'Taekwondo', 'Tidak', 'Bela Diri', 'OSIS', 'Tidak', 'Ilmu Keolahragaan', 'Hukum', NULL, NULL),
(23, 1, 23, 93.3333, 86.6667, 87.0000, 88.3333, 71.0000, 82.6667, 83.3333, 82.0000, 76.6667, 84.0000, 74.3333, 77.0000, 87.3333, 68.3333, NULL, NULL, NULL, NULL, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Tidak', 'Tidak', 'Teknik Industri', 'Teknik Elektro', NULL, NULL),
(24, 1, 24, 81.6667, 84.3333, 75.0000, 83.3333, 77.0000, 75.6667, 84.3333, 82.0000, 76.6667, 72.6667, 62.3333, 76.3333, 84.3333, 81.6667, NULL, NULL, NULL, NULL, 'KIR', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Psikologi', NULL, NULL),
(25, 1, 25, 85.0000, 89.3333, 67.0000, 83.3333, 74.6667, 79.0000, 74.3333, 78.6667, 70.0000, NULL, NULL, NULL, 90.3333, NULL, 78.6667, 82.3333, 84.0000, 79.0000, 'Tari Tradisional', 'Tidak', 'Wirausaha', 'Karang Taruna', 'Bimbel', 'Manajemen', 'Akuntansi', NULL, NULL),
(26, 1, 26, 87.6667, 89.0000, 80.0000, 90.0000, 79.0000, 85.0000, 79.0000, 80.0000, 75.0000, NULL, NULL, NULL, 86.6667, NULL, 90.0000, 85.0000, 92.0000, 87.3333, 'Tari Tradisional', 'Juara harapan 1 FLS2N', 'Desain', 'Tidak', 'Bimbel', 'DKV', 'Arsitektur', NULL, NULL),
(27, 1, 27, 83.3333, 85.0000, 75.3333, 70.0000, 70.0000, 81.0000, 76.6667, 68.6667, 80.0000, NULL, NULL, NULL, 87.6667, NULL, 62.6667, 76.0000, 76.0000, 80.0000, 'Futsal', 'Juara 1 Lomba Futsal di SMA Penabur Bintaro Jaya 2024', 'Bermain Futsal', 'Karang Taruna', 'Tidak', 'Ilmu Keolahragaan', 'Teknik Elektro', NULL, NULL),
(28, 1, 28, 89.3333, 71.0000, 68.3333, 90.0000, 72.6667, 74.6667, 71.3333, 70.3333, 75.0000, NULL, NULL, NULL, 72.0000, NULL, 72.3333, 87.3333, 77.3333, 84.6667, 'Band', 'Tidak', 'Gaming', 'Tidak', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', NULL, NULL),
(29, 1, 29, 85.0000, 86.6667, 68.6667, 76.6667, 74.6667, 71.6667, 70.0000, 77.0000, 68.3333, NULL, NULL, NULL, 81.0000, NULL, 75.6667, 78.3333, 72.6667, 78.0000, 'Futsal', 'Tidak', 'Atletik', 'Tidak', 'Tidak', 'Pendidikan Jasmani', 'Ilmu Keolahragaan', NULL, NULL),
(30, 1, 30, 88.3333, 87.6667, 73.3333, 81.6667, 81.6667, 80.6667, 76.0000, 81.6667, 78.3333, NULL, NULL, NULL, 85.3333, NULL, 78.6667, 77.6667, 81.0000, 86.0000, 'Basket', 'Tidak', 'Public Speaking', 'Basket', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Sastra Inggris', NULL, NULL),
(31, 1, 31, 70.0000, 76.6667, 71.3333, 75.0000, 61.6667, 59.6667, 69.6667, 70.3333, 68.3333, NULL, NULL, NULL, 67.6667, NULL, 65.0000, 57.6667, 74.3333, 78.3333, 'Futsal', 'Tidak', 'Modifikasi Motor', 'OSIS', 'Tidak', 'Teknik Mesin', 'Teknik Industri', NULL, NULL),
(32, 1, 32, 75.0000, 80.0000, 68.3333, 78.3333, 63.0000, 68.0000, 72.3333, 70.3333, 66.6667, NULL, NULL, NULL, 74.3333, NULL, 57.6667, 69.3333, 74.0000, 81.6667, 'KIR', 'Tidak', 'Analisis', 'Tidak', 'Tidak', 'Hukum', 'Psikologi', NULL, NULL),
(33, 1, 33, 91.6667, 90.0000, 80.0000, 85.0000, 72.6667, 81.0000, 78.0000, 73.6667, 83.3333, NULL, NULL, NULL, 89.3333, NULL, 72.0000, 87.3333, 77.6667, 85.0000, 'Taekwondo', 'Tidak', 'Bela Diri', 'Karang Taruna', 'Pelatihan Saksi Partai', 'Hukum', 'Ilmu Komunikasi', NULL, NULL),
(34, 1, 34, 88.3333, 88.3333, 80.0000, 91.6667, 85.3333, 82.3333, 83.3333, 80.0000, 76.6667, NULL, NULL, NULL, 86.6667, NULL, 86.6667, 77.6667, 86.0000, 84.0000, 'Taekwondo', 'Juara 1 kejuaraan taekwondo liga DKI', 'Bela Diri', 'OSIS', 'Tidak', 'Hukum', 'Pendidikan Jasmani', NULL, NULL),
(35, 1, 35, 85.0000, 86.6667, 73.0000, 86.6667, 78.6667, 69.6667, 69.0000, 81.6667, 71.6667, NULL, NULL, NULL, 73.3333, NULL, 69.3333, 79.0000, 81.0000, 79.6667, 'Badminton', 'Tidak', 'Atletik', 'Badminton', 'Tidak', 'Pendidikan Jasmani', 'Sastra Indonesia', NULL, NULL),
(36, 1, 36, 88.3333, 91.0000, 80.0000, 85.0000, 71.3333, 82.6667, 83.0000, 77.0000, 83.3333, NULL, NULL, NULL, 81.6667, NULL, 82.0000, 84.6667, 72.3333, 85.0000, 'Taekwondo', 'Tidak', 'Bela Diri', 'Tidak', 'Tidak', 'Ilmu Keolahragaan', 'Teknik Mesin', NULL, NULL),
(37, 1, 37, 66.6667, 67.6667, 53.0000, 61.6667, 49.3333, 64.0000, 48.6667, 67.0000, 51.0000, NULL, NULL, NULL, 60.3333, NULL, 43.0000, 60.6667, 62.3333, 66.3333, 'Band', 'Tidak', 'Main Drum', 'OSIS', 'Tidak', 'Manajemen', 'Teknik Industri', NULL, NULL),
(38, 1, 38, 71.6667, 66.6667, 71.3333, 70.0000, 57.6667, 66.3333, 81.0000, 70.3333, 72.6667, NULL, NULL, NULL, 77.0000, NULL, 58.6667, 72.3333, 67.3333, 71.3333, 'Badminton', 'Tidak', 'Videografi', 'Badminton', 'Tidak', 'DKV', 'Teknik Informatika', NULL, NULL),
(39, 1, 39, 83.3333, 79.3333, 75.0000, 81.6667, 66.0000, 72.0000, 81.0000, 81.6667, 72.6667, NULL, NULL, NULL, 92.6667, NULL, 72.0000, 71.0000, 85.0000, 81.6667, 'Modern Dance', 'Tidak', 'Bisnis', 'Karang Taruna', 'Bimbel', 'Hukum', 'Akuntansi', NULL, NULL),
(40, 1, 40, 90.0000, 86.6667, 75.0000, 85.0000, 66.0000, 80.0000, 66.6667, 83.3333, 73.3333, NULL, NULL, NULL, 90.3333, NULL, 82.0000, 84.3333, 86.3333, 90.0000, 'Futsal', 'Juara 1 Lomba Futsal di SMA Penabur Bintaro Jaya 2024', 'Bermain Futsal', 'Karang Taruna', 'Tidak', 'Ilmu Komunikasi', 'Manajemen', NULL, NULL),
(41, 1, 41, 88.3333, 88.3333, 83.3333, 86.6667, 80.6667, 79.0000, 74.6667, 77.0000, 76.6667, NULL, NULL, NULL, 86.0000, NULL, 72.0000, 82.6667, 84.0000, 86.3333, 'Mading', 'Tidak', 'Melukis', 'Tidak', 'Bimbel', 'Manajemen', 'DKV', NULL, NULL),
(42, 1, 42, 70.0000, 66.6667, 56.6667, 73.3333, 78.3333, 51.3333, 52.3333, 67.0000, 58.3333, NULL, NULL, NULL, 72.6667, NULL, 69.0000, 61.6667, 70.6667, 75.0000, 'Tari Tradisional', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Psikologi', NULL, NULL),
(43, 1, 43, 91.6667, 90.0000, 81.0000, 88.3333, 82.0000, 89.6667, 77.6667, 78.6667, 75.0000, NULL, NULL, NULL, 87.3333, NULL, 85.0000, 89.3333, 89.0000, 90.0000, 'Modern Dance', 'Tidak', 'Wirausaha', 'Tidak', 'Bimbel', 'Manajemen', 'Akuntansi', NULL, NULL),
(44, 1, 44, 80.0000, 88.3333, 83.0000, 83.3333, 73.0000, 77.0000, 79.6667, 73.6667, 85.0000, NULL, NULL, NULL, 90.0000, NULL, 82.0000, 82.6667, 86.0000, 76.6667, 'Mading', 'Tidak', 'Menggambar', 'Karang Taruna', 'Tidak', 'Seni Rupa', 'DKV', NULL, NULL),
(45, 1, 45, 86.6667, 89.0000, 81.6667, 90.0000, 79.3333, 80.0000, 74.6667, 78.3333, 75.0000, NULL, NULL, NULL, 90.3333, NULL, 81.3333, 85.0000, 86.3333, 86.0000, 'KIR', 'Tidak', 'Analisis', 'PMR', 'Tidak', 'Ilmu Keperawatan', 'Farmasi', NULL, NULL),
(46, 1, 46, 83.3333, 89.3333, 71.6667, 85.0000, 73.3333, 86.0000, 78.0000, 77.0000, 77.6667, NULL, NULL, NULL, 89.3333, NULL, 78.6667, 81.0000, 72.3333, 85.3333, 'Band', 'Tidak', 'Main Gitar', 'Karang Taruna', 'Tidak', 'Manajemen', 'Hukum', NULL, NULL),
(47, 1, 47, 94.3333, 92.0000, 85.0000, 90.0000, 86.3333, 90.0000, 83.0000, 81.6667, 80.0000, NULL, NULL, NULL, 90.0000, NULL, 91.6667, 91.6667, 93.6667, 90.0000, 'KIR', 'Tidak', 'Analisis', 'PMR', 'Bimbel', 'Ilmu Keperawatan', 'Teknologi Pangan', NULL, NULL),
(48, 1, 48, 86.6667, 91.6667, 79.3333, 81.6667, 86.0000, 77.3333, 74.3333, 75.3333, 76.6667, NULL, NULL, NULL, 83.6667, NULL, 78.0000, 85.0000, 83.0000, 85.0000, 'Tari Tradisional', 'Tidak', 'Bisnis', 'OSIS', 'Bimbel', 'Akuntansi', 'Ekonomi', NULL, NULL),
(49, 1, 49, 83.3333, 88.3333, 79.3333, 81.6667, 72.0000, 78.3333, 72.6667, 72.0000, 75.0000, NULL, NULL, NULL, 77.3333, NULL, 79.0000, 83.0000, 77.6667, 82.3333, 'Badminton', 'Tidak', 'Public Speaking', 'Badminton', 'Kursus TOEFL', 'Sastra Inggris', 'Ilmu Komunikasi', NULL, NULL),
(50, 1, 50, 78.3333, 88.3333, 79.3333, 83.3333, 66.6667, 78.3333, 74.6667, 72.0000, 75.0000, NULL, NULL, NULL, 89.3333, NULL, 63.3333, 83.3333, 71.0000, 86.6667, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Tidak', 'Tidak', 'Teknik Industri', 'Teknik Elektro', NULL, NULL),
(51, 1, 51, 93.3333, 90.3333, 88.0000, 86.6667, 70.0000, 89.6667, 79.3333, 78.6667, 81.6667, NULL, NULL, NULL, 84.3333, NULL, 88.3333, 86.3333, 93.6667, 86.6667, 'Tari Tradisional', 'Tidak', 'Bisnis', 'Karang Taruna', 'Bimbel', 'Akuntansi', 'Hukum', NULL, NULL),
(52, 1, 52, 75.0000, 87.6667, 78.3333, 85.0000, 71.3333, 78.3333, 72.6667, 77.0000, 74.3333, 66.3333, 60.6667, 56.6667, NULL, 70.0000, NULL, NULL, NULL, 81.6667, 'KIR', 'Juara 2 kejuaraan pelajar nasional', 'Analisis', 'OSIS', 'Tidak', 'Teknologi Pangan', 'Arsitektur', NULL, NULL),
(53, 1, 53, 82.6667, 86.0000, 81.0000, 88.3333, 78.0000, 71.0000, 73.6667, 78.3333, 78.3333, 81.6667, 65.6667, 70.3333, NULL, 76.0000, NULL, NULL, NULL, 81.6667, 'Tari Tradisional', 'Tidak', 'Memasak', 'Tidak', 'Bimbel', 'Teknologi Pangan', 'Ilmu Komunikasi', NULL, NULL),
(54, 1, 54, 83.3333, 85.0000, 82.6667, 88.3333, 75.6667, 77.6667, 73.6667, 78.3333, 67.6667, 77.6667, 68.0000, 59.0000, NULL, 78.3333, NULL, NULL, NULL, 85.0000, 'Modern Dance', 'Tidak', 'Menari', 'Karang Taruna', 'Tidak', 'Seni Rupa', 'PGSD', NULL, NULL),
(55, 1, 55, 90.0000, 81.6667, 80.3333, 85.0000, 76.3333, 91.3333, 79.3333, 81.6667, 81.6667, 92.3333, 73.0000, 75.6667, NULL, 82.3333, NULL, NULL, NULL, 81.6667, 'Mading', 'Tidak', 'Videografi', 'Tidak', 'Bimbel', 'DKV', 'Teknik Informatika', NULL, NULL),
(56, 1, 56, 89.3333, 81.0000, 81.6667, 87.3333, 71.3333, 75.3333, 82.6667, 77.0000, 81.6667, 88.3333, 68.6667, 62.6667, NULL, 71.3333, NULL, NULL, NULL, 87.0000, 'Band', 'Tidak', 'Modifikasi Motor', 'OSIS', 'Bimbel', 'Teknik Mesin', 'Teknik Elektro', NULL, NULL),
(57, 1, 57, 90.0000, 88.3333, 75.0000, 93.3333, 77.3333, 91.6667, 78.0000, 81.6667, 83.3333, 88.6667, 69.3333, 86.6667, NULL, 80.6667, NULL, NULL, NULL, 83.3333, 'Mading', 'Tidak', 'Menggambar', 'Tidak', 'Bimbel', 'DKV', 'Arsitektur', NULL, NULL),
(58, 1, 58, 80.0000, 55.0000, 76.3333, 83.3333, 80.0000, 70.6667, 64.3333, 75.3333, 81.6667, 70.3333, 64.6667, 50.0000, NULL, 78.3333, NULL, NULL, NULL, 83.6667, 'Basket', 'Tidak', 'Bisnis', 'Basket', 'Tidak', 'Manajemen', 'Psikologi', NULL, NULL),
(59, 1, 59, 81.6667, 66.0000, 75.0000, 83.3333, 81.3333, 72.0000, 67.6667, 75.3333, 80.0000, 69.0000, 57.6667, 58.3333, NULL, 81.0000, NULL, NULL, NULL, 86.3333, 'Taekwondo', 'Tidak', 'Bela Diri', 'Karang Taruna', 'Tidak', 'Pendidikan Jasmani', 'Hukum', NULL, NULL),
(60, 1, 60, 81.6667, 88.3333, 79.6667, 83.3333, 73.3333, 74.3333, 84.6667, 77.0000, 78.3333, 66.6667, 61.6667, 63.3333, NULL, 66.0000, NULL, NULL, NULL, 81.6667, 'futsal', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Industri', 'Manajemen', NULL, NULL),
(61, 1, 61, 76.6667, 66.6667, 68.0000, 83.3333, 71.6667, 61.3333, 69.6667, 77.0000, 73.3333, 72.6667, 67.0000, 67.3333, NULL, 70.6667, NULL, NULL, NULL, 76.6667, 'Badminton', 'Tidak', 'Editing', 'Tidak', 'Tidak', 'DKV', 'Teknik Informatika', NULL, NULL),
(62, 1, 62, 81.6667, 73.3333, 73.3333, 86.6667, 86.0000, 80.6667, 71.0000, 80.0000, 73.3333, 88.3333, 65.0000, 78.3333, NULL, 85.0000, NULL, NULL, NULL, 87.6667, 'Mading', 'Tidak', 'Menggambar', 'Tidak', 'Tidak', 'Arsitektur', 'DKV', NULL, NULL),
(63, 1, 63, 90.0000, 80.6667, 83.3333, 88.3333, 83.3333, 81.0000, 81.3333, 83.3333, 85.0000, 90.6667, 80.6667, 76.3333, NULL, 80.6667, NULL, NULL, NULL, 90.0000, 'futsal', 'Tidak', 'Wirausaha', 'Tidak', 'Tidak', 'Manajemen', 'Ekonomi', NULL, NULL),
(64, 1, 64, 78.3333, 77.3333, 66.6667, 80.0000, 63.3333, 75.3333, 62.0000, 76.6667, 78.3333, 76.6667, 52.3333, 63.3333, NULL, 61.0000, NULL, NULL, NULL, 75.3333, 'Futsal', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Tidak', 'Tidak', 'Teknik Informatika', 'Manajemen', NULL, NULL),
(65, 1, 65, 88.3333, 90.0000, 76.6667, 85.0000, 76.3333, 78.6667, 76.3333, 78.6667, 85.0000, 90.3333, 82.0000, 68.3333, NULL, 66.0000, NULL, NULL, NULL, 86.6667, 'basket', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'OSIS', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', NULL, NULL),
(66, 1, 66, 78.3333, 81.6667, 79.6667, 73.3333, 73.3333, 78.6667, 79.6667, 77.0000, 74.3333, 68.6667, 60.3333, 68.6667, NULL, 61.6667, NULL, NULL, NULL, 77.3333, 'Futsal', 'Tidak', 'Public Speaking', 'Karang Taruna', 'Tidak', 'Hukum', 'Ilmu Komunikasi', NULL, NULL),
(67, 1, 67, 93.3333, 84.3333, 78.3333, 88.3333, 79.6667, 87.3333, 86.3333, 80.0000, 86.6667, 95.0000, 84.6667, 81.6667, NULL, 69.0000, NULL, NULL, NULL, 85.0000, 'Badminton', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Badminton', 'Tidak', 'Teknik Informatika', 'Teknik Elektro', NULL, NULL),
(68, 1, 68, 65.0000, 74.3333, 66.6667, 81.6667, 66.3333, 58.3333, 75.3333, 67.0000, 77.6667, 68.6667, 60.6667, 49.6667, NULL, 59.0000, NULL, NULL, NULL, 74.6667, 'Basket', 'Tidak', 'Videografi', 'Karang Taruna', 'Tidak', 'DKV', 'Manajemen', NULL, NULL),
(69, 1, 69, 92.6667, 80.0000, 78.3333, 71.6667, 86.6667, 76.0000, 73.0000, 75.3333, 75.0000, 88.3333, 64.6667, 66.3333, NULL, 78.3333, NULL, NULL, NULL, 79.3333, 'KIR', 'Tidak', 'Public Speaking', 'Tidak', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Sastra Inggris', NULL, NULL),
(70, 1, 70, 87.6667, 79.3333, 78.3333, 81.6667, 83.0000, 78.3333, 79.6667, 75.3333, 83.3333, 81.0000, 63.6667, 70.3333, NULL, 72.6667, NULL, NULL, NULL, 81.6667, 'Band', 'Juara 2 Solo Vokal M25 Cup SMA Muhammadh 25 Pamulang 2024', 'Menyanyi', 'OSIS', 'Tidak', 'Ilmu Komunikasi', 'Sastra Indonesia', NULL, NULL),
(71, 1, 71, 85.0000, 71.6667, 71.6667, 80.0000, 81.6667, 74.0000, 60.6667, 82.0000, 60.0000, 88.3333, 80.3333, 67.0000, NULL, 80.0000, NULL, NULL, NULL, 75.0000, 'Mading', 'Tidak', 'Melukis', 'Tidak', 'Melukis', 'Seni Rupa', 'DKV', NULL, NULL),
(72, 1, 72, 88.3333, 86.6667, 86.6667, 83.3333, 89.6667, 77.3333, 74.3333, 77.0000, 85.0000, 86.3333, 68.3333, 72.6667, NULL, 87.6667, NULL, NULL, NULL, 87.3333, 'Tari Tradisional', 'Tidak', 'Bisnis', 'Karang Taruna', 'Bimbel', 'Akuntansi', 'Ekonomi', NULL, NULL),
(73, 1, 73, 88.3333, 84.0000, 75.0000, 75.0000, 87.3333, 80.6667, 76.3333, 77.0000, 81.6667, 87.3333, 80.0000, 78.6667, NULL, 79.3333, NULL, NULL, NULL, 84.3333, 'Tari Tradisional', 'Tidak', 'Memasak', 'Tidak', 'Bimbel', 'Ilmu Keperawatan', 'Teknologi Pangan', NULL, NULL),
(74, 1, 74, 74.0000, 74.3333, 82.6667, 83.3333, 86.6667, 63.0000, 75.3333, 78.6667, 88.3333, 85.3333, 65.0000, 75.0000, NULL, 84.3333, NULL, NULL, NULL, 83.0000, 'KIR', 'Tidak', 'Analisis', 'Tidak', 'Bimbel', 'Arsitektur', 'Farmasi', NULL, NULL),
(75, 1, 75, 81.6667, 76.6667, 78.6667, 81.6667, 71.6667, 78.3333, 86.6667, 78.6667, 71.6667, 80.0000, 71.6667, 73.3333, NULL, 71.0000, NULL, NULL, NULL, 87.6667, 'Futsal', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Karang Taruna', 'Tidak', 'Manajemen', 'Teknik Informatika', NULL, NULL),
(76, 1, 76, 82.6667, 86.6667, 73.6667, 83.3333, 74.6667, 85.6667, 76.0000, 77.0000, 73.3333, 81.6667, 78.6667, 73.3333, NULL, 69.3333, NULL, NULL, NULL, 85.3333, 'Badminton', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Tidak', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', NULL, NULL),
(77, 1, 77, 90.0000, 87.0000, 75.3333, 83.3333, 82.6667, 70.0000, 63.3333, 65.3333, 78.3333, 87.3333, 91.3333, 74.6667, NULL, 83.3333, NULL, NULL, NULL, 87.0000, 'Tari Tradisional', 'Tidak', 'Wirausaha', 'Karang Taruna', 'Tidak', 'Akuntansi', 'Manajemen', NULL, NULL),
(78, 1, 78, 90.0000, 81.6667, 76.6667, 83.3333, 66.0000, 81.6667, 80.0000, 80.0000, 73.3333, 79.6667, NULL, NULL, 85.3333, NULL, 73.3333, 69.3333, 82.0000, NULL, 'Band', 'Tidak', 'Main Gitar', 'Karang Taruna', 'Pelatihan Saksi Partai', 'Hukum', 'Sastra Indonesia', NULL, NULL),
(79, 1, 79, 68.3333, 79.3333, 75.0000, 81.6667, 69.6667, 56.3333, 72.6667, 80.0000, 72.6667, 78.0000, NULL, NULL, 85.0000, NULL, 70.3333, 57.0000, 75.6667, NULL, 'Futsal', 'Tidak', 'Editing', 'Karang Taruna', 'Tidak', 'DKV', 'Teknik Informatika', NULL, NULL),
(80, 1, 80, 88.3333, 83.3333, 79.6667, 88.3333, 76.3333, 72.3333, 74.3333, 80.3333, 81.6667, 88.0000, NULL, NULL, 84.0000, NULL, 76.3333, 81.6667, 90.6667, NULL, 'Modern Dance', 'Tidak', 'Menari', 'Tidak', 'Tidak', 'Pendidikan Jasmani', 'Seni Rupa', NULL, NULL),
(81, 1, 81, 90.0000, 90.6667, 75.0000, 91.6667, 81.3333, 84.6667, 74.3333, 68.6667, 78.3333, 90.0000, NULL, NULL, 80.0000, NULL, 75.3333, 85.6667, 90.0000, NULL, 'Modern Dance', 'Tidak', 'Memasak', 'OSIS', 'Bimbel', 'Teknologi Pangan', 'Farmasi', NULL, NULL),
(82, 1, 82, 81.6667, 78.3333, 76.6667, 81.6667, 76.6667, 72.0000, 72.0000, 80.0000, 78.3333, 82.6667, NULL, NULL, 78.6667, NULL, 71.6667, 86.6667, 80.0000, NULL, 'KIR', 'Tidak', 'Wirausaha', 'OSIS', 'Tidak', 'Manajemen', 'Ekonomi', NULL, NULL),
(83, 1, 83, 71.6667, 80.6667, 73.3333, 86.6667, 82.6667, 74.3333, 64.3333, 67.0000, 71.6667, 82.3333, NULL, NULL, 80.0000, NULL, 58.0000, 72.3333, 66.6667, NULL, 'Mading', 'Tidak', 'Menggambar', 'Tidak', 'Tidak', 'DKV', 'Arsitektur', NULL, NULL),
(84, 1, 84, 80.0000, 63.3333, 71.6667, 85.0000, 85.0000, 48.6667, 67.3333, 68.6667, 71.6667, 82.6667, NULL, NULL, 75.3333, NULL, 69.0000, 67.0000, 75.0000, NULL, 'KIR', 'Tidak', 'Fotografi', 'PMR', 'Tidak', 'DKV', 'Ilmu Keperawatan', NULL, NULL),
(85, 1, 85, 63.3333, 65.6667, 61.3333, 81.6667, 59.3333, 48.3333, 75.3333, 70.3333, 66.6667, 72.0000, NULL, NULL, 71.0000, NULL, 47.6667, 52.3333, 62.6667, NULL, 'futsal', 'Tidak', 'Modifikasi Motor', 'Tidak', 'Tidak', 'Teknik Industri', 'Teknik Elektro', NULL, NULL),
(86, 1, 86, 71.6667, 73.3333, 61.3333, 56.6667, 64.3333, 67.3333, 69.3333, 70.3333, 67.6667, 56.6667, NULL, NULL, 87.3333, NULL, 52.6667, 67.6667, 74.3333, NULL, 'Band', 'Tidak', 'Analisis', 'Tidak', 'Bimbel', 'Kedokteran', 'Teknik Industri', NULL, NULL),
(87, 1, 87, 63.3333, 70.0000, 71.3333, 86.6667, 64.3333, 57.6667, 82.6667, 72.0000, 64.3333, 75.0000, NULL, NULL, 84.0000, NULL, 67.3333, 66.0000, 67.3333, NULL, 'Taekwondo', 'Tidak', 'Bisnis', 'Tidak', 'Tidak', 'Teknik Informatika', 'Pendidikan Jasmani', NULL, NULL),
(88, 1, 88, 85.0000, 75.6667, 73.3333, 86.6667, 74.0000, 74.3333, 79.3333, 77.0000, 70.0000, 84.0000, NULL, NULL, 84.6667, NULL, 70.0000, 67.6667, 85.0000, NULL, 'Basket', 'Tidak', 'Gaming', 'Basket', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', NULL, NULL),
(89, 1, 89, 78.3333, 72.6667, 76.6667, 90.0000, 71.6667, 79.0000, 80.0000, 81.6667, 74.3333, 75.3333, NULL, NULL, 81.6667, NULL, 78.0000, 80.0000, 81.0000, NULL, 'Futsal', 'Tidak', 'Desain', 'Tidak', 'Tidak', 'DKV', 'Teknik Informatika', NULL, NULL),
(90, 1, 90, 80.0000, 70.0000, 78.3333, 86.6667, 79.6667, 86.3333, 74.3333, 81.6667, 64.3333, 78.0000, NULL, NULL, 77.6667, NULL, 82.0000, 79.6667, 86.0000, NULL, 'futsal', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Industri', 'Hukum', NULL, NULL),
(91, 1, 91, 80.0000, 81.6667, 74.6667, 86.6667, 71.6667, 74.3333, 74.6667, 72.0000, 78.3333, 72.0000, NULL, NULL, 86.6667, NULL, 77.0000, 72.3333, 82.3333, NULL, 'Badminton', 'Tidak', 'Public Speaking', 'OSIS', 'Tidak', 'Hukum', 'Psikologi', NULL, NULL),
(92, 1, 92, 68.3333, 62.6667, 51.6667, 78.3333, 51.3333, 68.0000, 74.0000, 73.6667, 56.6667, 69.3333, NULL, NULL, 81.6667, NULL, 59.3333, 69.6667, 74.0000, NULL, 'KIR', 'Tidak', 'Bisnis', 'OSIS', 'Tidak', 'Manajemen', 'Akuntansi', NULL, NULL),
(93, 1, 93, 78.3333, 74.3333, 84.6667, 90.0000, 68.0000, 78.0000, 74.0000, 75.3333, 76.0000, 83.0000, NULL, NULL, 88.0000, NULL, 70.6667, 79.0000, 74.0000, NULL, 'KIR', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Sastra Inggris', NULL, NULL),
(94, 1, 94, 75.0000, 71.0000, 64.6667, 80.0000, 48.0000, 71.6667, 76.0000, 72.0000, 71.0000, 73.0000, NULL, NULL, 76.0000, NULL, 69.3333, 69.0000, 78.0000, NULL, 'Futsal', 'Tidak', 'Desain', 'Tidak', 'Tidak', 'Ilmu Komputer', 'DKV', NULL, NULL),
(95, 1, 95, 68.3333, 75.0000, 65.6667, 76.6667, 50.0000, 63.0000, 78.0000, 76.6667, 70.0000, 70.6667, NULL, NULL, 79.3333, NULL, 56.0000, 71.3333, 73.0000, NULL, 'Taekwondo', 'Tidak', 'Bela Diri', 'Karang Taruna', 'Tidak', 'Pendidikan Jasmani', 'Sastra Indonesia', NULL, NULL),
(96, 1, 96, 80.0000, 81.6667, 83.3333, 86.6667, 52.6667, 78.3333, 72.6667, 75.3333, 73.3333, 89.6667, NULL, NULL, 83.3333, NULL, 70.6667, 77.3333, 81.0000, NULL, 'Basket', 'Tidak', 'Atletik', 'Basket', 'Tidak', 'Ilmu Keolahragaan', 'Pendidikan Jasmani', NULL, NULL),
(97, 1, 97, 81.6667, 80.0000, 68.3333, 91.6667, 78.3333, 67.3333, 76.0000, 72.0000, 73.3333, 89.6667, NULL, NULL, 80.6667, NULL, 79.6667, 86.0000, 89.3333, NULL, 'KIR', 'Tidak', 'Desain', 'OSIS', 'Kursus TOEFL', 'Sastra Inggris', 'Ilmu Komunikasi', NULL, NULL),
(98, 1, 98, 83.3333, 71.6667, 63.3333, 73.3333, 78.3333, 63.3333, 62.6667, 75.0000, 70.0000, 76.6667, NULL, NULL, 81.3333, NULL, 71.6667, 64.3333, 77.6667, NULL, 'Modern Dance', 'Tidak', 'Bisnis', 'Tidak', 'Tidak', 'Akuntansi', 'Manajemen', NULL, NULL),
(99, 1, 99, 81.6667, 82.6667, 66.0000, 81.6667, 80.6667, 70.0000, 69.6667, 70.3333, 70.0000, 73.0000, NULL, NULL, 87.6667, NULL, 60.3333, 61.6667, 86.0000, NULL, 'Modern Dance', 'Tidak', 'Public Speaking', 'OSIS', 'Bimbel', 'Ilmu Komunikasi', 'Sastra Inggris', NULL, NULL),
(100, 1, 100, 85.0000, 83.6667, 78.3333, 81.6667, 66.0000, 70.6667, 78.0000, 72.0000, 65.0000, 83.3333, NULL, NULL, 83.0000, NULL, 77.3333, 76.6667, 87.3333, NULL, 'Badminton', 'Tidak', 'Atletik', 'Badminton', 'Tidak', 'Ilmu Keolahragaan', 'Pendidikan Jasmani', NULL, NULL),
(101, 1, 101, 86.6667, 86.6667, 75.0000, 88.3333, 80.6667, 81.0000, 72.3333, 76.6667, 83.3333, 85.3333, NULL, NULL, 89.3333, NULL, 79.6667, 87.3333, 90.0000, NULL, 'Tari Tradisional', 'Tidak', 'Memasak', 'Tidak', 'Bimbel', 'Teknologi Pangan', 'Farmasi', NULL, NULL),
(102, 1, 102, 83.3333, 85.0000, 80.0000, 88.3333, 82.3333, 83.0000, 74.3333, 75.3333, 80.0000, 81.6667, NULL, NULL, 89.6667, NULL, 80.3333, 82.6667, 88.3333, NULL, 'Mading', 'Tidak', 'Public Speaking', 'Karang Taruna', 'Tidak', 'Psikologi', 'Ilmu Komunikasi', NULL, NULL),
(103, 1, 103, 64.6667, 56.0000, 45.0000, 56.6667, 81.6667, 51.6667, 54.6667, 52.0000, 50.0000, 64.6667, NULL, NULL, 53.3333, NULL, 47.6667, 50.6667, 73.3333, NULL, 'Modern Dance', 'Tidak', 'Bisnis', 'Tidak', 'Tidak', 'Manajemen', 'Ekonomi', NULL, NULL),
(104, 1, 104, 88.3333, 75.0000, 71.6667, 81.6667, 78.3333, 74.0000, 64.6667, 72.0000, 71.6667, 82.0000, NULL, NULL, 84.6667, NULL, 71.6667, 72.3333, 91.3333, NULL, 'Mading', 'Tidak', 'Menggambar', 'Karang Taruna', 'Bimbel', 'Arsitektur', 'DKV', NULL, NULL),
(105, 1, 105, 90.0000, 87.3333, 80.0000, 83.3333, 80.0000, 77.6667, 74.6667, 73.6667, 80.0000, 85.0000, NULL, NULL, 89.6667, NULL, 83.3333, 85.6667, 91.3333, NULL, 'Basket', 'Tidak', 'Bisnis', 'Basket', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Manajemen', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `kmeans_iteration`
--

CREATE TABLE `kmeans_iteration` (
  `id` bigint NOT NULL,
  `kmeans_run_id` bigint NOT NULL,
  `iteration_number` int DEFAULT NULL,
  `is_converged` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kmeans_run`
--

CREATE TABLE `kmeans_run` (
  `id` bigint NOT NULL,
  `preprocessing_run_id` bigint NOT NULL,
  `admin_id` bigint NOT NULL,
  `k` int DEFAULT '10',
  `distance_method` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_iteration` int DEFAULT NULL,
  `converged` tinyint(1) DEFAULT NULL,
  `started_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `dbi_score` decimal(12,8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nilai_akademik`
--

CREATE TABLE `nilai_akademik` (
  `id` bigint NOT NULL,
  `siswa_periode_id` bigint NOT NULL,
  `jenis_nilai` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `agama` decimal(5,2) DEFAULT NULL,
  `pkn` decimal(5,2) DEFAULT NULL,
  `b_indonesia` decimal(5,2) DEFAULT NULL,
  `b_inggris` decimal(5,2) DEFAULT NULL,
  `mtk_wajib` decimal(5,2) DEFAULT NULL,
  `sejarah` decimal(5,2) DEFAULT NULL,
  `pjok` decimal(5,2) DEFAULT NULL,
  `seni_rupa` decimal(5,2) DEFAULT NULL,
  `b_jepang` decimal(5,2) DEFAULT NULL,
  `biologi` decimal(5,2) DEFAULT NULL,
  `fisika` decimal(5,2) DEFAULT NULL,
  `kimia` decimal(5,2) DEFAULT NULL,
  `informatika` decimal(5,2) DEFAULT NULL,
  `mtk_lanjut` decimal(5,2) DEFAULT NULL,
  `geografi` decimal(5,2) DEFAULT NULL,
  `sosial` decimal(5,2) DEFAULT NULL,
  `pkwu` decimal(5,2) DEFAULT NULL,
  `ekonomi` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nilai_akademik`
--

INSERT INTO `nilai_akademik` (`id`, `siswa_periode_id`, `jenis_nilai`, `agama`, `pkn`, `b_indonesia`, `b_inggris`, `mtk_wajib`, `sejarah`, `pjok`, `seni_rupa`, `b_jepang`, `biologi`, `fisika`, `kimia`, `informatika`, `mtk_lanjut`, `geografi`, `sosial`, `pkwu`, `ekonomi`, `created_at`, `updated_at`) VALUES
(1, 1, 'rapor', 95.00, 91.00, 96.00, 90.00, 90.00, 94.00, 88.00, 76.00, 90.00, 93.00, 90.00, 90.00, 93.00, 92.00, NULL, NULL, NULL, NULL, '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(2, 1, 'pts', 100.00, 85.00, 75.00, 85.00, 85.00, 90.00, 75.00, 90.00, 80.00, 95.00, 100.00, 80.00, 75.00, 70.00, NULL, NULL, NULL, NULL, '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(3, 1, 'pas', 95.00, 100.00, 90.00, 80.00, 75.00, 80.00, 90.00, 85.00, 60.00, 100.00, 95.00, 60.00, 90.00, 70.00, NULL, NULL, NULL, NULL, '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(4, 2, 'rapor', 80.00, 83.00, 87.00, 85.00, 79.00, 85.00, 88.00, 76.00, 83.00, 84.00, 77.00, 79.00, 89.00, 78.00, NULL, NULL, NULL, NULL, '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(5, 2, 'pts', 85.00, 55.00, 65.00, 75.00, 70.00, 70.00, 65.00, 80.00, 60.00, 50.00, 80.00, 60.00, 75.00, 60.00, NULL, NULL, NULL, NULL, '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(6, 2, 'pas', 75.00, 100.00, 85.00, 85.00, 70.00, 90.00, 80.00, 70.00, 65.00, 100.00, 35.00, 65.00, 85.00, 65.00, NULL, NULL, NULL, NULL, '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(7, 3, 'rapor', 85.00, 88.00, 90.00, 85.00, 88.00, 86.00, 87.00, 76.00, 90.00, 90.00, 87.00, 82.00, 91.00, 83.00, NULL, NULL, NULL, NULL, '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(8, 3, 'pts', 95.00, 70.00, 75.00, 85.00, 75.00, 65.00, 80.00, 85.00, 85.00, 90.00, 85.00, 85.00, 75.00, 60.00, NULL, NULL, NULL, NULL, '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(9, 3, 'pas', 85.00, 100.00, 80.00, 95.00, 75.00, 90.00, 90.00, 65.00, 60.00, 100.00, 55.00, 60.00, 90.00, 65.00, NULL, NULL, NULL, NULL, '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(10, 4, 'rapor', 70.00, 75.00, 75.00, 80.00, 75.00, 83.00, 85.00, 76.00, 80.00, 79.00, 76.00, 76.00, 86.00, 75.00, NULL, NULL, NULL, NULL, '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(11, 4, 'pts', 80.00, 55.00, 65.00, 95.00, 85.00, 85.00, 70.00, 55.00, 40.00, 75.00, 85.00, 20.00, 75.00, 65.00, NULL, NULL, NULL, NULL, '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(12, 4, 'pas', 75.00, 95.00, 85.00, 70.00, 70.00, 95.00, 60.00, 55.00, 40.00, 80.00, 75.00, 40.00, 80.00, 70.00, NULL, NULL, NULL, NULL, '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(13, 5, 'rapor', 90.00, 90.00, 95.00, 90.00, 84.00, 88.00, 86.00, 80.00, 85.00, 92.00, 86.00, 86.00, 92.00, 83.00, NULL, NULL, NULL, NULL, '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(14, 5, 'pts', 95.00, 75.00, 65.00, 80.00, 70.00, 85.00, 75.00, 85.00, 75.00, 95.00, 95.00, 75.00, 80.00, 70.00, NULL, NULL, NULL, NULL, '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(15, 5, 'pas', 85.00, 100.00, 85.00, 70.00, 80.00, 95.00, 85.00, 80.00, 65.00, 100.00, 65.00, 65.00, 90.00, 75.00, NULL, NULL, NULL, NULL, '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(16, 6, 'rapor', 90.00, 90.00, 95.00, 90.00, 86.00, 88.00, 88.00, 80.00, 90.00, 89.00, 86.00, 83.00, 92.00, 83.00, NULL, NULL, NULL, NULL, '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(17, 6, 'pts', 90.00, 60.00, 70.00, 85.00, 85.00, 45.00, 65.00, 85.00, 40.00, 85.00, 40.00, 40.00, 80.00, 80.00, NULL, NULL, NULL, NULL, '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(18, 6, 'pas', 85.00, 85.00, 80.00, 90.00, 80.00, 80.00, 75.00, 80.00, 80.00, 90.00, 40.00, 50.00, 90.00, 80.00, NULL, NULL, NULL, NULL, '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(19, 7, 'rapor', 85.00, 90.00, 91.00, 85.00, 84.00, 87.00, 89.00, 76.00, 90.00, 88.00, 85.00, 80.00, 89.00, 85.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(20, 7, 'pts', 80.00, 55.00, 60.00, 75.00, 70.00, 50.00, 60.00, 70.00, 55.00, 45.00, 85.00, 55.00, 65.00, 65.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(21, 7, 'pas', 80.00, 75.00, 80.00, 70.00, 65.00, 35.00, 75.00, 45.00, 75.00, 90.00, 40.00, 35.00, 85.00, 55.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(22, 8, 'rapor', 78.00, 85.00, 90.00, 85.00, 80.00, 85.00, 88.00, 76.00, 85.00, 88.00, 77.00, 80.00, 92.00, 78.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(23, 8, 'pts', 90.00, 60.00, 60.00, 80.00, 70.00, 40.00, 75.00, 85.00, 70.00, 70.00, 70.00, 70.00, 75.00, 70.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(24, 8, 'pas', 75.00, 95.00, 80.00, 70.00, 70.00, 75.00, 75.00, 75.00, 75.00, 100.00, 35.00, 75.00, 90.00, 60.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(25, 9, 'rapor', 95.00, 88.00, 94.00, 90.00, 91.00, 93.00, 88.00, 80.00, 90.00, 93.00, 89.00, 92.00, 93.00, 92.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(26, 9, 'pts', 85.00, 75.00, 85.00, 85.00, 90.00, 80.00, 80.00, 95.00, 85.00, 85.00, 90.00, 85.00, 80.00, 60.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(27, 9, 'pas', 100.00, 100.00, 85.00, 90.00, 80.00, 90.00, 80.00, 80.00, 80.00, 100.00, 80.00, 80.00, 90.00, 75.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(28, 10, 'rapor', 80.00, 88.00, 94.00, 95.00, 82.00, 87.00, 88.00, 76.00, 85.00, 90.00, 83.00, 84.00, 94.00, 82.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(29, 10, 'pts', 80.00, 70.00, 55.00, 90.00, 80.00, 60.00, 80.00, 90.00, 65.00, 95.00, 75.00, 65.00, 70.00, 80.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(30, 10, 'pas', 75.00, 90.00, 85.00, 80.00, 85.00, 70.00, 70.00, 75.00, 90.00, 100.00, 35.00, 75.00, 95.00, 75.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(31, 11, 'rapor', 95.00, 90.00, 94.00, 90.00, 85.00, 92.00, 85.00, 85.00, 85.00, 88.00, 84.00, 85.00, 95.00, 85.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(32, 11, 'pts', 85.00, 60.00, 60.00, 90.00, 75.00, 60.00, 80.00, 90.00, 60.00, 90.00, 70.00, 60.00, 80.00, 75.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(33, 11, 'pas', 85.00, 90.00, 85.00, 90.00, 90.00, 70.00, 90.00, 85.00, 90.00, 100.00, 70.00, 50.00, 95.00, 80.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(34, 12, 'rapor', 90.00, 90.00, 94.00, 90.00, 80.00, 91.00, 85.00, 80.00, 85.00, 92.00, 87.00, 84.00, 93.00, 80.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(35, 12, 'pts', 85.00, 60.00, 50.00, 80.00, 90.00, 65.00, 70.00, 90.00, 60.00, 55.00, 60.00, 60.00, 80.00, 85.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(36, 12, 'pas', 75.00, 95.00, 90.00, 85.00, 90.00, 75.00, 85.00, 80.00, 80.00, 85.00, 60.00, 45.00, 95.00, 85.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(37, 13, 'rapor', 92.00, 90.00, 94.00, 87.00, 82.00, 90.00, 88.00, 80.00, 90.00, 93.00, 87.00, 84.00, 92.00, 86.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(38, 13, 'pts', 90.00, 60.00, 80.00, 85.00, 85.00, 65.00, 80.00, 85.00, 65.00, 80.00, 95.00, 65.00, 70.00, 75.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(39, 13, 'pas', 90.00, 90.00, 90.00, 90.00, 70.00, 90.00, 85.00, 80.00, 40.00, 90.00, 50.00, 40.00, 90.00, 65.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(40, 14, 'rapor', 95.00, 90.00, 95.00, 90.00, 83.00, 90.00, 88.00, 80.00, 90.00, 92.00, 84.00, 83.00, 92.00, 83.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(41, 14, 'pts', 90.00, 70.00, 70.00, 85.00, 75.00, 70.00, 85.00, 95.00, 70.00, 80.00, 90.00, 70.00, 80.00, 70.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(42, 14, 'pas', 90.00, 95.00, 90.00, 90.00, 75.00, 90.00, 90.00, 80.00, 45.00, 100.00, 55.00, 45.00, 90.00, 60.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(43, 15, 'rapor', 95.00, 92.00, 95.00, 85.00, 86.00, 90.00, 88.00, 85.00, 90.00, 90.00, 90.00, 94.00, 92.00, 87.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(44, 15, 'pts', 95.00, 75.00, 75.00, 90.00, 75.00, 75.00, 70.00, 85.00, 80.00, 90.00, 100.00, 80.00, 80.00, 80.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(45, 15, 'pas', 95.00, 80.00, 85.00, 95.00, 55.00, 85.00, 40.00, 85.00, 50.00, 90.00, 90.00, 50.00, 90.00, 50.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(46, 16, 'rapor', 80.00, 88.00, 93.00, 85.00, 82.00, 87.00, 88.00, 80.00, 90.00, 88.00, 84.00, 83.00, 82.00, 85.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(47, 16, 'pts', 80.00, 50.00, 30.00, 80.00, 70.00, 55.00, 55.00, 75.00, 65.00, 85.00, 80.00, 65.00, 70.00, 75.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(48, 16, 'pas', 85.00, 60.00, 80.00, 75.00, 70.00, 90.00, 55.00, 80.00, 40.00, 80.00, 65.00, 40.00, 70.00, 65.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(49, 17, 'rapor', 80.00, 90.00, 94.00, 90.00, 81.00, 90.00, 89.00, 76.00, 85.00, 87.00, 85.00, 84.00, 91.00, 82.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(50, 17, 'pts', 60.00, 55.00, 60.00, 90.00, 85.00, 40.00, 55.00, 75.00, 55.00, 75.00, 30.00, 25.00, 80.00, 90.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(51, 17, 'pas', 75.00, 70.00, 65.00, 85.00, 95.00, 90.00, 80.00, 70.00, 35.00, 90.00, 60.00, 35.00, 90.00, 95.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(52, 18, 'rapor', 90.00, 88.00, 94.00, 85.00, 84.00, 88.00, 89.00, 80.00, 90.00, 90.00, 87.00, 86.00, 91.00, 80.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(53, 18, 'pts', 90.00, 65.00, 75.00, 85.00, 70.00, 60.00, 85.00, 95.00, 75.00, 75.00, 85.00, 75.00, 75.00, 70.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(54, 18, 'pas', 90.00, 95.00, 90.00, 85.00, 75.00, 80.00, 90.00, 80.00, 50.00, 95.00, 55.00, 50.00, 90.00, 60.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(55, 19, 'rapor', 95.00, 91.00, 95.00, 90.00, 88.00, 87.00, 87.00, 80.00, 85.00, 92.00, 86.00, 89.00, 89.00, 90.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(56, 19, 'pts', 95.00, 70.00, 60.00, 90.00, 75.00, 65.00, 85.00, 85.00, 75.00, 80.00, 80.00, 75.00, 85.00, 80.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(57, 19, 'pas', 100.00, 95.00, 85.00, 75.00, 90.00, 85.00, 80.00, 80.00, 80.00, 90.00, 55.00, 40.00, 85.00, 85.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(58, 20, 'rapor', 90.00, 90.00, 95.00, 85.00, 83.00, 90.00, 88.00, 85.00, 85.00, 90.00, 88.00, 84.00, 92.00, 83.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(59, 20, 'pts', 100.00, 55.00, 70.00, 85.00, 70.00, 70.00, 65.00, 90.00, 65.00, 80.00, 80.00, 65.00, 75.00, 65.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(60, 20, 'pas', 100.00, 85.00, 90.00, 70.00, 65.00, 85.00, 90.00, 85.00, 65.00, 95.00, 70.00, 65.00, 90.00, 60.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(61, 21, 'rapor', 90.00, 87.00, 94.00, 90.00, 79.00, 85.00, 90.00, 80.00, 85.00, 90.00, 79.00, 80.00, 91.00, 77.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(62, 21, 'pts', 90.00, 70.00, 65.00, 80.00, 45.00, 70.00, 70.00, 90.00, 75.00, 55.00, 80.00, 75.00, 75.00, 50.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(63, 21, 'pas', 95.00, 90.00, 95.00, 85.00, 70.00, 85.00, 90.00, 80.00, 40.00, 95.00, 55.00, 40.00, 90.00, 60.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(64, 22, 'rapor', 95.00, 91.00, 96.00, 90.00, 92.00, 92.00, 89.00, 80.00, 90.00, 93.00, 89.00, 92.00, 90.00, 92.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(65, 22, 'pts', 95.00, 80.00, 70.00, 85.00, 85.00, 65.00, 80.00, 95.00, 80.00, 100.00, 95.00, 80.00, 80.00, 80.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(66, 22, 'pas', 95.00, 95.00, 95.00, 85.00, 75.00, 75.00, 90.00, 75.00, 55.00, 95.00, 70.00, 55.00, 85.00, 65.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(67, 23, 'rapor', 95.00, 90.00, 91.00, 85.00, 83.00, 88.00, 90.00, 76.00, 85.00, 92.00, 88.00, 86.00, 92.00, 80.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(68, 23, 'pts', 90.00, 75.00, 75.00, 95.00, 65.00, 75.00, 75.00, 95.00, 90.00, 65.00, 80.00, 90.00, 80.00, 70.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(69, 23, 'pas', 95.00, 95.00, 95.00, 85.00, 65.00, 85.00, 85.00, 75.00, 55.00, 95.00, 55.00, 55.00, 90.00, 55.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(70, 24, 'rapor', 80.00, 88.00, 95.00, 90.00, 81.00, 87.00, 88.00, 76.00, 85.00, 88.00, 82.00, 84.00, 88.00, 80.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(71, 24, 'pts', 80.00, 75.00, 55.00, 80.00, 80.00, 75.00, 85.00, 85.00, 75.00, 70.00, 75.00, 75.00, 80.00, 85.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(72, 24, 'pas', 85.00, 90.00, 75.00, 80.00, 70.00, 65.00, 80.00, 85.00, 70.00, 60.00, 30.00, 70.00, 85.00, 80.00, NULL, NULL, NULL, NULL, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(73, 25, 'rapor', 85.00, 88.00, 91.00, 90.00, 79.00, 87.00, 88.00, 76.00, 85.00, NULL, NULL, NULL, 91.00, NULL, 85.00, 87.00, 92.00, 82.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(74, 25, 'pts', 90.00, 80.00, 45.00, 75.00, 75.00, 80.00, 55.00, 85.00, 55.00, NULL, NULL, NULL, 90.00, NULL, 71.00, 70.00, 80.00, 70.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(75, 25, 'pas', 80.00, 100.00, 65.00, 85.00, 70.00, 70.00, 80.00, 75.00, 70.00, NULL, NULL, NULL, 90.00, NULL, 80.00, 90.00, 80.00, 85.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(76, 26, 'rapor', 93.00, 92.00, 95.00, 95.00, 82.00, 90.00, 87.00, 80.00, 90.00, NULL, NULL, NULL, 90.00, NULL, 90.00, 90.00, 96.00, 92.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(77, 26, 'pts', 80.00, 75.00, 65.00, 90.00, 80.00, 80.00, 75.00, 85.00, 75.00, NULL, NULL, NULL, 80.00, NULL, 100.00, 80.00, 85.00, 85.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(78, 26, 'pas', 90.00, 100.00, 80.00, 85.00, 75.00, 85.00, 75.00, 75.00, 60.00, NULL, NULL, NULL, 90.00, NULL, 80.00, 85.00, 95.00, 85.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(79, 27, 'rapor', 90.00, 90.00, 91.00, 80.00, 80.00, 88.00, 90.00, 76.00, 85.00, NULL, NULL, NULL, 93.00, NULL, 85.00, 88.00, 88.00, 90.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(80, 27, 'pts', 75.00, 65.00, 45.00, 50.00, 75.00, 70.00, 80.00, 65.00, 80.00, NULL, NULL, NULL, 75.00, NULL, 43.00, 50.00, 65.00, 70.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(81, 27, 'pas', 85.00, 100.00, 90.00, 80.00, 55.00, 85.00, 60.00, 65.00, 75.00, NULL, NULL, NULL, 95.00, NULL, 60.00, 90.00, 75.00, 80.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(82, 28, 'rapor', 88.00, 88.00, 95.00, 90.00, 83.00, 89.00, 89.00, 76.00, 90.00, NULL, NULL, NULL, 86.00, NULL, 90.00, 92.00, 92.00, 89.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(83, 28, 'pts', 95.00, 45.00, 50.00, 90.00, 70.00, 55.00, 60.00, 70.00, 60.00, NULL, NULL, NULL, 50.00, NULL, 57.00, 80.00, 65.00, 75.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(84, 28, 'pas', 85.00, 80.00, 60.00, 90.00, 65.00, 80.00, 65.00, 65.00, 75.00, NULL, NULL, NULL, 80.00, NULL, 70.00, 90.00, 75.00, 90.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(85, 29, 'rapor', 80.00, 85.00, 91.00, 85.00, 79.00, 85.00, 90.00, 76.00, 85.00, NULL, NULL, NULL, 83.00, NULL, 85.00, 80.00, 88.00, 84.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(86, 29, 'pts', 90.00, 80.00, 40.00, 60.00, 75.00, 50.00, 50.00, 80.00, 50.00, NULL, NULL, NULL, 85.00, NULL, 67.00, 70.00, 55.00, 65.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(87, 29, 'pas', 85.00, 95.00, 75.00, 85.00, 70.00, 80.00, 70.00, 75.00, 70.00, NULL, NULL, NULL, 75.00, NULL, 75.00, 85.00, 75.00, 85.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(88, 30, 'rapor', 90.00, 93.00, 90.00, 90.00, 80.00, 87.00, 88.00, 80.00, 85.00, NULL, NULL, NULL, 91.00, NULL, 85.00, 88.00, 88.00, 88.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(89, 30, 'pts', 90.00, 70.00, 50.00, 75.00, 80.00, 75.00, 65.00, 85.00, 65.00, NULL, NULL, NULL, 75.00, NULL, 76.00, 60.00, 80.00, 90.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(90, 30, 'pas', 85.00, 100.00, 80.00, 80.00, 85.00, 80.00, 75.00, 80.00, 85.00, NULL, NULL, NULL, 90.00, NULL, 75.00, 85.00, 75.00, 80.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(91, 31, 'rapor', 85.00, 90.00, 89.00, 85.00, 80.00, 84.00, 89.00, 76.00, 85.00, NULL, NULL, NULL, 83.00, NULL, 88.00, 78.00, 88.00, 80.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(92, 31, 'pts', 55.00, 45.00, 45.00, 65.00, 55.00, 45.00, 45.00, 65.00, 45.00, NULL, NULL, NULL, 45.00, NULL, 62.00, 55.00, 50.00, 80.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(93, 31, 'pas', 70.00, 95.00, 80.00, 75.00, 50.00, 50.00, 75.00, 70.00, 75.00, NULL, NULL, NULL, 75.00, NULL, 45.00, 40.00, 85.00, 75.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(94, 32, 'rapor', 80.00, 90.00, 80.00, 80.00, 79.00, 84.00, 92.00, 76.00, 85.00, NULL, NULL, NULL, 88.00, NULL, 80.00, 78.00, 82.00, 80.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(95, 32, 'pts', 65.00, 60.00, 60.00, 75.00, 65.00, 35.00, 55.00, 70.00, 55.00, NULL, NULL, NULL, 50.00, NULL, 48.00, 55.00, 65.00, 85.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(96, 32, 'pas', 80.00, 90.00, 65.00, 80.00, 45.00, 85.00, 70.00, 65.00, 60.00, NULL, NULL, NULL, 85.00, NULL, 45.00, 75.00, 75.00, 80.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(97, 33, 'rapor', 95.00, 90.00, 95.00, 85.00, 83.00, 88.00, 89.00, 76.00, 90.00, NULL, NULL, NULL, 93.00, NULL, 90.00, 92.00, 88.00, 90.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(98, 33, 'pts', 90.00, 80.00, 55.00, 90.00, 80.00, 70.00, 70.00, 80.00, 70.00, NULL, NULL, NULL, 80.00, NULL, 86.00, 80.00, 60.00, 85.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(99, 33, 'pas', 90.00, 100.00, 90.00, 80.00, 55.00, 85.00, 75.00, 65.00, 90.00, NULL, NULL, NULL, 95.00, NULL, 40.00, 90.00, 85.00, 80.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(100, 34, 'rapor', 90.00, 90.00, 95.00, 95.00, 86.00, 87.00, 90.00, 80.00, 90.00, NULL, NULL, NULL, 90.00, NULL, 80.00, 88.00, 88.00, 92.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(101, 34, 'pts', 85.00, 75.00, 60.00, 90.00, 80.00, 80.00, 70.00, 80.00, 70.00, NULL, NULL, NULL, 80.00, NULL, 95.00, 50.00, 85.00, 70.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(102, 34, 'pas', 90.00, 100.00, 85.00, 90.00, 90.00, 80.00, 90.00, 80.00, 70.00, NULL, NULL, NULL, 90.00, NULL, 85.00, 95.00, 85.00, 90.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(103, 35, 'rapor', 90.00, 90.00, 94.00, 95.00, 81.00, 89.00, 87.00, 80.00, 85.00, NULL, NULL, NULL, 85.00, NULL, 85.00, 87.00, 88.00, 89.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(104, 35, 'pts', 85.00, 80.00, 65.00, 85.00, 90.00, 80.00, 50.00, 85.00, 50.00, NULL, NULL, NULL, 60.00, NULL, 48.00, 75.00, 75.00, 80.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(105, 35, 'pas', 80.00, 90.00, 60.00, 80.00, 65.00, 40.00, 70.00, 80.00, 80.00, NULL, NULL, NULL, 75.00, NULL, 75.00, 75.00, 80.00, 70.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(106, 36, 'rapor', 90.00, 88.00, 90.00, 85.00, 79.00, 88.00, 89.00, 76.00, 90.00, NULL, NULL, NULL, 85.00, NULL, 85.00, 89.00, 82.00, 90.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(107, 36, 'pts', 90.00, 85.00, 60.00, 90.00, 80.00, 70.00, 85.00, 80.00, 85.00, NULL, NULL, NULL, 80.00, NULL, 76.00, 70.00, 55.00, 85.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(108, 36, 'pas', 85.00, 100.00, 90.00, 80.00, 55.00, 90.00, 75.00, 75.00, 75.00, NULL, NULL, NULL, 80.00, NULL, 85.00, 95.00, 80.00, 80.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(109, 37, 'rapor', 75.00, 83.00, 79.00, 80.00, 78.00, 82.00, 86.00, 76.00, 83.00, NULL, NULL, NULL, 76.00, NULL, 80.00, 77.00, 82.00, 79.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(110, 37, 'pts', 60.00, 50.00, 30.00, 50.00, 30.00, 40.00, 35.00, 70.00, 35.00, NULL, NULL, NULL, 55.00, NULL, 29.00, 45.00, 50.00, 65.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(111, 37, 'pas', 65.00, 70.00, 50.00, 55.00, 40.00, 70.00, 25.00, 55.00, 35.00, NULL, NULL, NULL, 50.00, NULL, 20.00, 60.00, 55.00, 55.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(112, 38, 'rapor', 75.00, 85.00, 79.00, 80.00, 78.00, 84.00, 88.00, 76.00, 83.00, NULL, NULL, NULL, 81.00, NULL, 80.00, 77.00, 82.00, 79.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(113, 38, 'pts', 60.00, 65.00, 75.00, 75.00, 45.00, 55.00, 75.00, 75.00, 75.00, NULL, NULL, NULL, 80.00, NULL, 71.00, 80.00, 55.00, 70.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(114, 38, 'pas', 80.00, 50.00, 60.00, 55.00, 50.00, 60.00, 80.00, 60.00, 60.00, NULL, NULL, NULL, 70.00, NULL, 25.00, 60.00, 65.00, 65.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(115, 39, 'rapor', 85.00, 88.00, 90.00, 85.00, 78.00, 86.00, 88.00, 80.00, 83.00, NULL, NULL, NULL, 93.00, NULL, 85.00, 78.00, 85.00, 85.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(116, 39, 'pts', 85.00, 70.00, 70.00, 75.00, 55.00, 65.00, 80.00, 80.00, 80.00, NULL, NULL, NULL, 90.00, NULL, 81.00, 75.00, 80.00, 75.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(117, 39, 'pas', 80.00, 80.00, 65.00, 85.00, 65.00, 65.00, 75.00, 85.00, 55.00, NULL, NULL, NULL, 95.00, NULL, 50.00, 60.00, 90.00, 85.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(118, 40, 'rapor', 95.00, 90.00, 95.00, 90.00, 88.00, 90.00, 90.00, 80.00, 90.00, NULL, NULL, NULL, 91.00, NULL, 90.00, 88.00, 94.00, 95.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(119, 40, 'pts', 90.00, 70.00, 50.00, 80.00, 40.00, 80.00, 70.00, 90.00, 70.00, NULL, NULL, NULL, 90.00, NULL, 81.00, 80.00, 80.00, 90.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(120, 40, 'pas', 85.00, 100.00, 80.00, 85.00, 70.00, 70.00, 40.00, 80.00, 60.00, NULL, NULL, NULL, 90.00, NULL, 75.00, 85.00, 85.00, 85.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(121, 41, 'rapor', 90.00, 90.00, 95.00, 90.00, 82.00, 87.00, 89.00, 76.00, 90.00, NULL, NULL, NULL, 88.00, NULL, 85.00, 88.00, 92.00, 94.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(122, 41, 'pts', 85.00, 75.00, 70.00, 80.00, 70.00, 70.00, 60.00, 80.00, 60.00, NULL, NULL, NULL, 85.00, NULL, 81.00, 65.00, 75.00, 75.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(123, 41, 'pas', 90.00, 100.00, 85.00, 90.00, 90.00, 80.00, 75.00, 75.00, 80.00, NULL, NULL, NULL, 85.00, NULL, 50.00, 95.00, 85.00, 90.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(124, 42, 'rapor', 80.00, 90.00, 90.00, 90.00, 80.00, 84.00, 87.00, 76.00, 85.00, NULL, NULL, NULL, 83.00, NULL, 80.00, 80.00, 92.00, 80.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(125, 42, 'pts', 60.00, 35.00, 35.00, 55.00, 75.00, 35.00, 30.00, 60.00, 30.00, NULL, NULL, NULL, 60.00, NULL, 62.00, 50.00, 50.00, 70.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(126, 42, 'pas', 70.00, 75.00, 45.00, 75.00, 80.00, 35.00, 40.00, 65.00, 60.00, NULL, NULL, NULL, 75.00, NULL, 65.00, 55.00, 70.00, 75.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(127, 43, 'rapor', 90.00, 90.00, 93.00, 95.00, 81.00, 94.00, 88.00, 76.00, 90.00, NULL, NULL, NULL, 92.00, NULL, 90.00, 93.00, 92.00, 95.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(128, 43, 'pts', 100.00, 80.00, 65.00, 85.00, 80.00, 80.00, 70.00, 85.00, 70.00, NULL, NULL, NULL, 80.00, NULL, 100.00, 85.00, 85.00, 90.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(129, 43, 'pas', 85.00, 100.00, 85.00, 85.00, 85.00, 95.00, 75.00, 75.00, 65.00, NULL, NULL, NULL, 90.00, NULL, 65.00, 90.00, 90.00, 85.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(130, 44, 'rapor', 80.00, 90.00, 94.00, 90.00, 79.00, 86.00, 89.00, 76.00, 85.00, NULL, NULL, NULL, 90.00, NULL, 80.00, 83.00, 88.00, 80.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(131, 44, 'pts', 90.00, 75.00, 75.00, 80.00, 65.00, 70.00, 75.00, 80.00, 75.00, NULL, NULL, NULL, 90.00, NULL, 81.00, 75.00, 80.00, 70.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(132, 44, 'pas', 70.00, 100.00, 80.00, 80.00, 75.00, 75.00, 75.00, 65.00, 95.00, NULL, NULL, NULL, 90.00, NULL, 85.00, 90.00, 90.00, 80.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(133, 45, 'rapor', 90.00, 92.00, 95.00, 95.00, 83.00, 90.00, 89.00, 80.00, 90.00, NULL, NULL, NULL, 91.00, NULL, 88.00, 90.00, 94.00, 93.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(134, 45, 'pts', 85.00, 75.00, 70.00, 90.00, 70.00, 70.00, 75.00, 75.00, 75.00, NULL, NULL, NULL, 90.00, NULL, 81.00, 75.00, 70.00, 80.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(135, 45, 'pas', 85.00, 100.00, 80.00, 85.00, 85.00, 80.00, 60.00, 80.00, 60.00, NULL, NULL, NULL, 90.00, NULL, 75.00, 90.00, 95.00, 85.00, '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(136, 46, 'rapor', 85.00, 88.00, 90.00, 80.00, 80.00, 88.00, 89.00, 76.00, 83.00, NULL, NULL, NULL, 93.00, NULL, 80.00, 83.00, 82.00, 86.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(137, 46, 'pts', 85.00, 80.00, 55.00, 80.00, 70.00, 70.00, 70.00, 80.00, 70.00, NULL, NULL, NULL, 80.00, NULL, 86.00, 80.00, 50.00, 75.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(138, 46, 'pas', 80.00, 100.00, 70.00, 95.00, 70.00, 100.00, 75.00, 75.00, 80.00, NULL, NULL, NULL, 95.00, NULL, 70.00, 80.00, 85.00, 95.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(139, 47, 'rapor', 93.00, 91.00, 95.00, 95.00, 89.00, 95.00, 89.00, 80.00, 90.00, NULL, NULL, NULL, 95.00, NULL, 90.00, 95.00, 96.00, 95.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(140, 47, 'pts', 100.00, 85.00, 75.00, 90.00, 80.00, 80.00, 80.00, 85.00, 80.00, NULL, NULL, NULL, 80.00, NULL, 100.00, 85.00, 85.00, 90.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(141, 47, 'pas', 90.00, 100.00, 85.00, 85.00, 90.00, 95.00, 80.00, 80.00, 70.00, NULL, NULL, NULL, 95.00, NULL, 85.00, 95.00, 100.00, 85.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(142, 48, 'rapor', 90.00, 90.00, 93.00, 90.00, 83.00, 87.00, 88.00, 76.00, 90.00, NULL, NULL, NULL, 91.00, NULL, 88.00, 90.00, 94.00, 95.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(143, 48, 'pts', 90.00, 85.00, 65.00, 75.00, 90.00, 70.00, 65.00, 75.00, 65.00, NULL, NULL, NULL, 70.00, NULL, 86.00, 75.00, 80.00, 80.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(144, 48, 'pas', 80.00, 100.00, 80.00, 80.00, 85.00, 75.00, 70.00, 75.00, 75.00, NULL, NULL, NULL, 90.00, NULL, 60.00, 90.00, 75.00, 80.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(145, 49, 'rapor', 85.00, 90.00, 93.00, 90.00, 81.00, 85.00, 88.00, 76.00, 85.00, NULL, NULL, NULL, 87.00, NULL, 85.00, 89.00, 88.00, 87.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(146, 49, 'pts', 90.00, 75.00, 65.00, 70.00, 65.00, 75.00, 60.00, 65.00, 60.00, NULL, NULL, NULL, 60.00, NULL, 67.00, 70.00, 60.00, 75.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(147, 49, 'pas', 75.00, 100.00, 80.00, 85.00, 70.00, 75.00, 70.00, 75.00, 80.00, NULL, NULL, NULL, 85.00, NULL, 85.00, 90.00, 85.00, 85.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(148, 50, 'rapor', 85.00, 90.00, 93.00, 85.00, 80.00, 85.00, 89.00, 76.00, 85.00, NULL, NULL, NULL, 93.00, NULL, 88.00, 85.00, 88.00, 85.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(149, 50, 'pts', 70.00, 75.00, 55.00, 80.00, 65.00, 65.00, 75.00, 75.00, 75.00, NULL, NULL, NULL, 80.00, NULL, 67.00, 75.00, 45.00, 90.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(150, 50, 'pas', 80.00, 100.00, 90.00, 85.00, 55.00, 85.00, 60.00, 65.00, 65.00, NULL, NULL, NULL, 95.00, NULL, 35.00, 90.00, 80.00, 85.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(151, 51, 'rapor', 95.00, 91.00, 94.00, 90.00, 85.00, 94.00, 88.00, 76.00, 85.00, NULL, NULL, NULL, 88.00, NULL, 90.00, 94.00, 96.00, 95.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(152, 51, 'pts', 95.00, 80.00, 85.00, 90.00, 50.00, 80.00, 75.00, 85.00, 75.00, NULL, NULL, NULL, 80.00, NULL, 95.00, 75.00, 85.00, 85.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(153, 51, 'pas', 90.00, 100.00, 85.00, 80.00, 75.00, 95.00, 75.00, 75.00, 85.00, NULL, NULL, NULL, 85.00, NULL, 80.00, 90.00, 100.00, 80.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(154, 52, 'rapor', 75.00, 88.00, 90.00, 85.00, 79.00, 85.00, 93.00, 76.00, 83.00, 84.00, 77.00, 80.00, NULL, 75.00, NULL, NULL, NULL, 80.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(155, 52, 'pts', 70.00, 75.00, 55.00, 90.00, 70.00, 65.00, 55.00, 80.00, 80.00, 50.00, 65.00, 55.00, NULL, 75.00, NULL, NULL, NULL, 90.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(156, 52, 'pas', 80.00, 100.00, 90.00, 80.00, 65.00, 85.00, 70.00, 75.00, 60.00, 65.00, 40.00, 35.00, NULL, 60.00, NULL, NULL, NULL, 75.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(157, 53, 'rapor', 83.00, 88.00, 93.00, 90.00, 84.00, 88.00, 86.00, 80.00, 90.00, 90.00, 82.00, 86.00, NULL, 83.00, NULL, NULL, NULL, 95.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(158, 53, 'pts', 85.00, 70.00, 70.00, 90.00, 80.00, 40.00, 50.00, 75.00, 75.00, 75.00, 70.00, 65.00, NULL, 80.00, NULL, NULL, NULL, 70.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(159, 53, 'pas', 80.00, 100.00, 80.00, 85.00, 70.00, 85.00, 85.00, 80.00, 70.00, 80.00, 45.00, 60.00, NULL, 65.00, NULL, NULL, NULL, 80.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(160, 54, 'rapor', 85.00, 90.00, 93.00, 90.00, 82.00, 88.00, 86.00, 80.00, 83.00, 88.00, 84.00, 82.00, NULL, 80.00, NULL, NULL, NULL, 90.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(161, 54, 'pts', 85.00, 75.00, 75.00, 90.00, 75.00, 65.00, 50.00, 75.00, 75.00, 70.00, 70.00, 45.00, NULL, 85.00, NULL, NULL, NULL, 80.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(162, 54, 'pas', 80.00, 90.00, 80.00, 85.00, 70.00, 80.00, 85.00, 80.00, 45.00, 75.00, 50.00, 50.00, NULL, 70.00, NULL, NULL, NULL, 85.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(163, 55, 'rapor', 90.00, 90.00, 91.00, 90.00, 84.00, 89.00, 88.00, 80.00, 90.00, 92.00, 84.00, 92.00, NULL, 82.00, NULL, NULL, NULL, 95.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(164, 55, 'pts', 100.00, 65.00, 70.00, 80.00, 70.00, 90.00, 65.00, 85.00, 85.00, 90.00, 80.00, 70.00, NULL, 90.00, NULL, NULL, NULL, 70.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(165, 55, 'pas', 80.00, 90.00, 80.00, 85.00, 75.00, 95.00, 85.00, 80.00, 70.00, 95.00, 55.00, 65.00, NULL, 75.00, NULL, NULL, NULL, 80.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(166, 56, 'rapor', 93.00, 88.00, 90.00, 87.00, 84.00, 86.00, 88.00, 76.00, 85.00, 90.00, 86.00, 83.00, NULL, 89.00, NULL, NULL, NULL, 96.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(167, 56, 'pts', 80.00, 60.00, 65.00, 85.00, 65.00, 65.00, 75.00, 80.00, 80.00, 80.00, 75.00, 60.00, NULL, 80.00, NULL, NULL, NULL, 90.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(168, 56, 'pas', 95.00, 95.00, 90.00, 90.00, 65.00, 75.00, 85.00, 75.00, 80.00, 95.00, 45.00, 45.00, NULL, 45.00, NULL, NULL, NULL, 75.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(169, 57, 'rapor', 95.00, 90.00, 95.00, 90.00, 87.00, 90.00, 89.00, 80.00, 90.00, 91.00, 83.00, 90.00, NULL, 87.00, NULL, NULL, NULL, 90.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(170, 57, 'pts', 90.00, 75.00, 55.00, 95.00, 75.00, 85.00, 60.00, 85.00, 85.00, 90.00, 70.00, 75.00, NULL, 70.00, NULL, NULL, NULL, 80.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(171, 57, 'pas', 85.00, 100.00, 75.00, 95.00, 70.00, 100.00, 85.00, 80.00, 75.00, 85.00, 55.00, 95.00, NULL, 85.00, NULL, NULL, NULL, 80.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(172, 58, 'rapor', 85.00, 85.00, 94.00, 90.00, 80.00, 87.00, 88.00, 76.00, 85.00, 86.00, 79.00, 80.00, NULL, 80.00, NULL, NULL, NULL, 86.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(173, 58, 'pts', 75.00, 40.00, 55.00, 80.00, 80.00, 40.00, 45.00, 75.00, 75.00, 75.00, 65.00, 35.00, NULL, 80.00, NULL, NULL, NULL, 75.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(174, 58, 'pas', 80.00, 40.00, 80.00, 80.00, 80.00, 85.00, 60.00, 75.00, 85.00, 50.00, 50.00, 35.00, NULL, 75.00, NULL, NULL, NULL, 90.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(175, 59, 'rapor', 80.00, 88.00, 90.00, 85.00, 79.00, 86.00, 88.00, 76.00, 85.00, 82.00, 78.00, 80.00, NULL, 78.00, NULL, NULL, NULL, 84.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(176, 59, 'pts', 85.00, 55.00, 55.00, 90.00, 80.00, 45.00, 55.00, 75.00, 75.00, 70.00, 55.00, 40.00, NULL, 90.00, NULL, NULL, NULL, 90.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(177, 59, 'pas', 80.00, 55.00, 80.00, 75.00, 85.00, 85.00, 60.00, 75.00, 80.00, 55.00, 40.00, 55.00, NULL, 75.00, NULL, NULL, NULL, 85.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(178, 60, 'rapor', 80.00, 90.00, 89.00, 85.00, 80.00, 88.00, 89.00, 76.00, 85.00, 80.00, 80.00, 80.00, NULL, 78.00, NULL, NULL, NULL, 80.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(179, 60, 'pts', 90.00, 80.00, 55.00, 80.00, 70.00, 65.00, 85.00, 80.00, 80.00, 55.00, 70.00, 65.00, NULL, 70.00, NULL, NULL, NULL, 90.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(180, 60, 'pas', 75.00, 95.00, 95.00, 85.00, 70.00, 70.00, 80.00, 75.00, 70.00, 65.00, 35.00, 45.00, NULL, 50.00, NULL, NULL, NULL, 75.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(181, 61, 'rapor', 80.00, 75.00, 89.00, 95.00, 80.00, 84.00, 89.00, 76.00, 85.00, 88.00, 81.00, 82.00, NULL, 77.00, NULL, NULL, NULL, 80.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(182, 61, 'pts', 85.00, 45.00, 50.00, 80.00, 60.00, 55.00, 65.00, 70.00, 70.00, 65.00, 50.00, 55.00, NULL, 65.00, NULL, NULL, NULL, 85.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(183, 61, 'pas', 65.00, 80.00, 65.00, 75.00, 75.00, 45.00, 55.00, 85.00, 65.00, 65.00, 70.00, 65.00, NULL, 70.00, NULL, NULL, NULL, 65.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(184, 62, 'rapor', 90.00, 90.00, 90.00, 90.00, 83.00, 87.00, 88.00, 85.00, 90.00, 90.00, 85.00, 85.00, NULL, 85.00, NULL, NULL, NULL, 88.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(185, 62, 'pts', 70.00, 60.00, 55.00, 80.00, 85.00, 70.00, 50.00, 70.00, 70.00, 80.00, 80.00, 75.00, NULL, 85.00, NULL, NULL, NULL, 85.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(186, 62, 'pas', 85.00, 70.00, 75.00, 90.00, 90.00, 85.00, 75.00, 85.00, 60.00, 95.00, 30.00, 75.00, NULL, 85.00, NULL, NULL, NULL, 90.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(187, 63, 'rapor', 95.00, 92.00, 90.00, 85.00, 90.00, 93.00, 89.00, 85.00, 90.00, 92.00, 87.00, 89.00, NULL, 92.00, NULL, NULL, NULL, 95.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(188, 63, 'pts', 90.00, 70.00, 75.00, 95.00, 75.00, 75.00, 70.00, 80.00, 80.00, 90.00, 90.00, 80.00, NULL, 80.00, NULL, NULL, NULL, 80.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(189, 63, 'pas', 85.00, 80.00, 85.00, 85.00, 85.00, 75.00, 85.00, 85.00, 85.00, 90.00, 65.00, 60.00, NULL, 70.00, NULL, NULL, NULL, 95.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(190, 64, 'rapor', 80.00, 87.00, 90.00, 85.00, 80.00, 86.00, 86.00, 80.00, 85.00, 85.00, 82.00, 80.00, NULL, 78.00, NULL, NULL, NULL, 81.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(191, 64, 'pts', 80.00, 50.00, 55.00, 80.00, 70.00, 75.00, 50.00, 70.00, 70.00, 55.00, 40.00, 55.00, NULL, 70.00, NULL, NULL, NULL, 70.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(192, 64, 'pas', 75.00, 95.00, 55.00, 75.00, 40.00, 65.00, 50.00, 80.00, 80.00, 90.00, 35.00, 55.00, NULL, 35.00, NULL, NULL, NULL, 75.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(193, 65, 'rapor', 90.00, 90.00, 95.00, 85.00, 89.00, 86.00, 89.00, 76.00, 90.00, 91.00, 86.00, 85.00, NULL, 88.00, NULL, NULL, NULL, 95.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(194, 65, 'pts', 85.00, 80.00, 50.00, 80.00, 70.00, 65.00, 75.00, 85.00, 85.00, 80.00, 90.00, 70.00, NULL, 50.00, NULL, NULL, NULL, 85.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(195, 65, 'pas', 90.00, 100.00, 85.00, 90.00, 70.00, 85.00, 65.00, 75.00, 80.00, 100.00, 70.00, 50.00, NULL, 60.00, NULL, NULL, NULL, 80.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(196, 66, 'rapor', 80.00, 90.00, 89.00, 80.00, 80.00, 86.00, 89.00, 76.00, 83.00, 86.00, 86.00, 81.00, NULL, 80.00, NULL, NULL, NULL, 82.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(197, 66, 'pts', 70.00, 60.00, 65.00, 65.00, 65.00, 60.00, 70.00, 80.00, 80.00, 50.00, 50.00, 70.00, NULL, 40.00, NULL, NULL, NULL, 80.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(198, 66, 'pas', 85.00, 95.00, 85.00, 75.00, 75.00, 90.00, 80.00, 75.00, 60.00, 70.00, 45.00, 55.00, NULL, 65.00, NULL, NULL, NULL, 70.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(199, 67, 'rapor', 95.00, 88.00, 90.00, 85.00, 89.00, 87.00, 89.00, 80.00, 90.00, 90.00, 89.00, 90.00, NULL, 92.00, NULL, NULL, NULL, 95.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(200, 67, 'pts', 90.00, 80.00, 65.00, 95.00, 70.00, 85.00, 85.00, 80.00, 80.00, 100.00, 95.00, 80.00, NULL, 45.00, NULL, NULL, NULL, 90.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(201, 67, 'pas', 95.00, 85.00, 80.00, 85.00, 80.00, 90.00, 85.00, 80.00, 90.00, 95.00, 70.00, 75.00, NULL, 70.00, NULL, NULL, NULL, 70.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(202, 68, 'rapor', 80.00, 78.00, 85.00, 85.00, 79.00, 80.00, 86.00, 76.00, 83.00, 81.00, 77.00, 79.00, NULL, 77.00, NULL, NULL, NULL, 79.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(203, 68, 'pts', 35.00, 60.00, 40.00, 80.00, 55.00, 30.00, 60.00, 55.00, 55.00, 45.00, 35.00, 15.00, NULL, 40.00, NULL, NULL, NULL, 65.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(204, 68, 'pas', 80.00, 85.00, 75.00, 80.00, 65.00, 65.00, 80.00, 70.00, 95.00, 80.00, 70.00, 55.00, NULL, 60.00, NULL, NULL, NULL, 80.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(205, 69, 'rapor', 93.00, 90.00, 90.00, 90.00, 80.00, 88.00, 89.00, 76.00, 85.00, 90.00, 84.00, 84.00, NULL, 80.00, NULL, NULL, NULL, 83.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(206, 69, 'pts', 90.00, 55.00, 60.00, 65.00, 90.00, 55.00, 55.00, 80.00, 80.00, 80.00, 50.00, 60.00, NULL, 70.00, NULL, NULL, NULL, 80.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(207, 69, 'pas', 95.00, 95.00, 85.00, 60.00, 90.00, 85.00, 75.00, 70.00, 60.00, 95.00, 60.00, 55.00, NULL, 85.00, NULL, NULL, NULL, 75.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(208, 70, 'rapor', 93.00, 88.00, 90.00, 90.00, 79.00, 85.00, 89.00, 76.00, 85.00, 88.00, 81.00, 81.00, NULL, 78.00, NULL, NULL, NULL, 80.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(209, 70, 'pts', 75.00, 50.00, 65.00, 80.00, 85.00, 70.00, 65.00, 75.00, 75.00, 70.00, 55.00, 65.00, NULL, 65.00, NULL, NULL, NULL, 90.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(210, 70, 'pas', 95.00, 100.00, 80.00, 75.00, 85.00, 80.00, 85.00, 75.00, 90.00, 85.00, 55.00, 65.00, NULL, 75.00, NULL, NULL, NULL, 75.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(211, 71, 'rapor', 90.00, 90.00, 90.00, 90.00, 80.00, 87.00, 87.00, 76.00, 85.00, 90.00, 86.00, 81.00, NULL, 80.00, NULL, NULL, NULL, 95.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(212, 71, 'pts', 75.00, 55.00, 65.00, 75.00, 80.00, 40.00, 50.00, 80.00, 80.00, 90.00, 70.00, 45.00, NULL, 80.00, NULL, NULL, NULL, 60.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(213, 71, 'pas', 90.00, 70.00, 60.00, 75.00, 85.00, 95.00, 45.00, 90.00, 15.00, 85.00, 85.00, 75.00, NULL, 80.00, NULL, NULL, NULL, 70.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(214, 72, 'rapor', 90.00, 90.00, 95.00, 90.00, 89.00, 92.00, 88.00, 76.00, 85.00, 89.00, 85.00, 83.00, NULL, 88.00, NULL, NULL, NULL, 92.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(215, 72, 'pts', 95.00, 80.00, 70.00, 90.00, 90.00, 65.00, 55.00, 80.00, 80.00, 85.00, 60.00, 55.00, NULL, 90.00, NULL, NULL, NULL, 75.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(216, 72, 'pas', 80.00, 90.00, 95.00, 70.00, 90.00, 75.00, 80.00, 75.00, 90.00, 85.00, 60.00, 80.00, NULL, 85.00, NULL, NULL, NULL, 95.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(217, 73, 'rapor', 90.00, 92.00, 95.00, 90.00, 82.00, 92.00, 89.00, 76.00, 85.00, 92.00, 85.00, 86.00, NULL, 88.00, NULL, NULL, NULL, 88.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(218, 73, 'pts', 95.00, 60.00, 55.00, 70.00, 90.00, 70.00, 60.00, 85.00, 85.00, 75.00, 75.00, 75.00, NULL, 70.00, NULL, NULL, NULL, 85.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(219, 73, 'pas', 80.00, 100.00, 75.00, 65.00, 90.00, 80.00, 80.00, 70.00, 75.00, 95.00, 80.00, 75.00, NULL, 80.00, NULL, NULL, NULL, 80.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(220, 74, 'rapor', 82.00, 88.00, 93.00, 90.00, 80.00, 84.00, 86.00, 76.00, 85.00, 86.00, 80.00, 80.00, NULL, 78.00, NULL, NULL, NULL, 84.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(221, 74, 'pts', 65.00, 40.00, 65.00, 85.00, 85.00, 45.00, 75.00, 85.00, 85.00, 80.00, 70.00, 70.00, NULL, 85.00, NULL, NULL, NULL, 85.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(222, 74, 'pas', 75.00, 95.00, 90.00, 75.00, 95.00, 60.00, 65.00, 75.00, 95.00, 90.00, 45.00, 75.00, NULL, 90.00, NULL, NULL, NULL, 80.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(223, 75, 'rapor', 85.00, 85.00, 91.00, 85.00, 85.00, 85.00, 90.00, 76.00, 85.00, 90.00, 80.00, 80.00, NULL, 83.00, NULL, NULL, NULL, 88.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(224, 75, 'pts', 75.00, 55.00, 60.00, 85.00, 75.00, 65.00, 85.00, 85.00, 85.00, 50.00, 70.00, 70.00, NULL, 80.00, NULL, NULL, NULL, 90.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(225, 75, 'pas', 85.00, 90.00, 85.00, 75.00, 55.00, 85.00, 85.00, 75.00, 45.00, 100.00, 65.00, 70.00, NULL, 50.00, NULL, NULL, NULL, 85.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(226, 76, 'rapor', 83.00, 85.00, 91.00, 85.00, 89.00, 87.00, 88.00, 76.00, 85.00, 90.00, 86.00, 85.00, NULL, 88.00, NULL, NULL, NULL, 86.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(227, 76, 'pts', 85.00, 75.00, 55.00, 90.00, 75.00, 75.00, 60.00, 80.00, 80.00, 65.00, 80.00, 75.00, NULL, 75.00, NULL, NULL, NULL, 90.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(228, 76, 'pas', 80.00, 100.00, 75.00, 75.00, 60.00, 95.00, 80.00, 75.00, 55.00, 90.00, 70.00, 60.00, NULL, 45.00, NULL, NULL, NULL, 80.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(229, 77, 'rapor', 90.00, 91.00, 96.00, 90.00, 88.00, 90.00, 90.00, 76.00, 85.00, 92.00, 89.00, 89.00, NULL, 90.00, NULL, NULL, NULL, 96.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(230, 77, 'pts', 95.00, 90.00, 55.00, 80.00, 85.00, 60.00, 50.00, 65.00, 65.00, 80.00, 85.00, 70.00, NULL, 90.00, NULL, NULL, NULL, 75.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(231, 77, 'pas', 85.00, 80.00, 75.00, 80.00, 75.00, 60.00, 50.00, 55.00, 85.00, 90.00, 100.00, 65.00, NULL, 70.00, NULL, NULL, NULL, 90.00, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(232, 78, 'rapor', 90.00, 90.00, 95.00, 90.00, 83.00, 90.00, 90.00, 80.00, 90.00, 89.00, NULL, NULL, 91.00, NULL, 88.00, 88.00, 96.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(233, 78, 'pts', 90.00, 65.00, 55.00, 75.00, 45.00, 70.00, 70.00, 80.00, 65.00, 75.00, NULL, NULL, 80.00, NULL, 67.00, 60.00, 75.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(234, 78, 'pas', 90.00, 90.00, 80.00, 85.00, 70.00, 85.00, 80.00, 80.00, 65.00, 75.00, NULL, NULL, 85.00, NULL, 65.00, 60.00, 75.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(235, 79, 'rapor', 80.00, 88.00, 90.00, 85.00, 79.00, 84.00, 88.00, 80.00, 83.00, 84.00, NULL, NULL, 90.00, NULL, 85.00, 76.00, 82.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(236, 79, 'pts', 70.00, 60.00, 65.00, 80.00, 65.00, 25.00, 55.00, 80.00, 60.00, 80.00, NULL, NULL, 75.00, NULL, 71.00, 30.00, 70.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(237, 79, 'pas', 55.00, 90.00, 70.00, 80.00, 65.00, 60.00, 75.00, 80.00, 75.00, 70.00, NULL, NULL, 90.00, NULL, 55.00, 65.00, 75.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(238, 80, 'rapor', 90.00, 90.00, 94.00, 95.00, 84.00, 87.00, 88.00, 76.00, 90.00, 89.00, NULL, NULL, 92.00, NULL, 88.00, 90.00, 92.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(239, 80, 'pts', 90.00, 70.00, 70.00, 85.00, 70.00, 60.00, 65.00, 90.00, 70.00, 85.00, NULL, NULL, 70.00, NULL, 71.00, 75.00, 85.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(240, 80, 'pas', 85.00, 90.00, 75.00, 85.00, 75.00, 70.00, 70.00, 75.00, 85.00, 90.00, NULL, NULL, 90.00, NULL, 70.00, 80.00, 95.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(241, 81, 'rapor', 90.00, 92.00, 95.00, 95.00, 89.00, 89.00, 88.00, 76.00, 85.00, 90.00, NULL, NULL, 85.00, NULL, 90.00, 92.00, 90.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(242, 81, 'pts', 100.00, 80.00, 60.00, 95.00, 75.00, 90.00, 60.00, 80.00, 80.00, 95.00, NULL, NULL, 75.00, NULL, 71.00, 70.00, 80.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(243, 81, 'pas', 80.00, 100.00, 70.00, 85.00, 80.00, 75.00, 75.00, 50.00, 70.00, 85.00, NULL, NULL, 80.00, NULL, 65.00, 95.00, 100.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(244, 82, 'rapor', 85.00, 90.00, 90.00, 90.00, 80.00, 86.00, 86.00, 80.00, 90.00, 88.00, NULL, NULL, 86.00, NULL, 88.00, 90.00, 90.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(245, 82, 'pts', 75.00, 65.00, 70.00, 75.00, 80.00, 70.00, 60.00, 80.00, 65.00, 75.00, NULL, NULL, 70.00, NULL, 67.00, 80.00, 65.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(246, 82, 'pas', 85.00, 80.00, 70.00, 80.00, 70.00, 60.00, 70.00, 80.00, 80.00, 85.00, NULL, NULL, 80.00, NULL, 60.00, 90.00, 85.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(247, 83, 'rapor', 80.00, 92.00, 95.00, 90.00, 83.00, 88.00, 88.00, 76.00, 90.00, 87.00, NULL, NULL, 85.00, NULL, 90.00, 87.00, 90.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(248, 83, 'pts', 65.00, 55.00, 45.00, 80.00, 85.00, 45.00, 40.00, 75.00, 55.00, 80.00, NULL, NULL, 75.00, NULL, 29.00, 50.00, 55.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(249, 83, 'pas', 70.00, 95.00, 80.00, 90.00, 80.00, 90.00, 65.00, 50.00, 70.00, 80.00, NULL, NULL, 80.00, NULL, 55.00, 80.00, 55.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(250, 84, 'rapor', 85.00, 90.00, 95.00, 90.00, 80.00, 86.00, 87.00, 76.00, 90.00, 88.00, NULL, NULL, 81.00, NULL, 85.00, 86.00, 90.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(251, 84, 'pts', 80.00, 35.00, 50.00, 90.00, 80.00, 20.00, 60.00, 70.00, 35.00, 90.00, NULL, NULL, 75.00, NULL, 57.00, 60.00, 60.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(252, 84, 'pas', 75.00, 65.00, 70.00, 75.00, 95.00, 40.00, 55.00, 60.00, 90.00, 70.00, NULL, NULL, 70.00, NULL, 65.00, 55.00, 75.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(253, 85, 'rapor', 75.00, 82.00, 89.00, 90.00, 78.00, 85.00, 86.00, 76.00, 90.00, 86.00, NULL, NULL, 83.00, NULL, 80.00, 77.00, 88.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(254, 85, 'pts', 50.00, 45.00, 40.00, 75.00, 55.00, 30.00, 60.00, 70.00, 45.00, 75.00, NULL, NULL, 55.00, NULL, 33.00, 35.00, 45.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(255, 85, 'pas', 65.00, 70.00, 55.00, 80.00, 45.00, 30.00, 80.00, 65.00, 65.00, 55.00, NULL, NULL, 75.00, NULL, 30.00, 45.00, 55.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(256, 86, 'rapor', 75.00, 80.00, 79.00, 85.00, 78.00, 82.00, 88.00, 76.00, 83.00, 80.00, NULL, NULL, 92.00, NULL, 80.00, 78.00, 88.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(257, 86, 'pts', 60.00, 45.00, 45.00, 30.00, 60.00, 30.00, 35.00, 65.00, 45.00, 30.00, NULL, NULL, 75.00, NULL, 43.00, 35.00, 70.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(258, 86, 'pas', 80.00, 95.00, 60.00, 55.00, 55.00, 90.00, 85.00, 70.00, 75.00, 60.00, NULL, NULL, 95.00, NULL, 35.00, 90.00, 65.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(259, 87, 'rapor', 75.00, 80.00, 89.00, 85.00, 78.00, 83.00, 88.00, 76.00, 83.00, 80.00, NULL, NULL, 87.00, NULL, 85.00, 78.00, 82.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(260, 87, 'pts', 65.00, 50.00, 60.00, 85.00, 55.00, 35.00, 80.00, 75.00, 50.00, 85.00, NULL, NULL, 80.00, NULL, 57.00, 55.00, 70.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(261, 87, 'pas', 50.00, 80.00, 65.00, 90.00, 60.00, 55.00, 80.00, 65.00, 60.00, 60.00, NULL, NULL, 85.00, NULL, 60.00, 65.00, 50.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(262, 88, 'rapor', 90.00, 92.00, 95.00, 90.00, 82.00, 88.00, 88.00, 76.00, 85.00, 87.00, NULL, NULL, 89.00, NULL, 88.00, 88.00, 90.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(263, 88, 'pts', 80.00, 50.00, 55.00, 80.00, 70.00, 50.00, 70.00, 80.00, 50.00, 80.00, NULL, NULL, 80.00, NULL, 52.00, 55.00, 90.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(264, 88, 'pas', 85.00, 85.00, 70.00, 90.00, 70.00, 85.00, 80.00, 75.00, 75.00, 85.00, NULL, NULL, 85.00, NULL, 70.00, 60.00, 75.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(265, 89, 'rapor', 80.00, 88.00, 90.00, 90.00, 80.00, 87.00, 90.00, 80.00, 83.00, 81.00, NULL, NULL, 85.00, NULL, 88.00, 75.00, 88.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(266, 89, 'pts', 80.00, 60.00, 60.00, 85.00, 65.00, 75.00, 70.00, 85.00, 60.00, 85.00, NULL, NULL, 80.00, NULL, 71.00, 75.00, 75.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(267, 89, 'pas', 75.00, 70.00, 80.00, 95.00, 70.00, 75.00, 80.00, 80.00, 80.00, 60.00, NULL, NULL, 80.00, NULL, 75.00, 90.00, 80.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(268, 90, 'rapor', 80.00, 80.00, 90.00, 85.00, 89.00, 94.00, 88.00, 80.00, 83.00, 89.00, NULL, NULL, 83.00, NULL, 90.00, 84.00, 88.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(269, 90, 'pts', 80.00, 55.00, 65.00, 85.00, 70.00, 75.00, 65.00, 85.00, 55.00, 85.00, NULL, NULL, 75.00, NULL, 81.00, 75.00, 80.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01');
INSERT INTO `nilai_akademik` (`id`, `siswa_periode_id`, `jenis_nilai`, `agama`, `pkn`, `b_indonesia`, `b_inggris`, `mtk_wajib`, `sejarah`, `pjok`, `seni_rupa`, `b_jepang`, `biologi`, `fisika`, `kimia`, `informatika`, `mtk_lanjut`, `geografi`, `sosial`, `pkwu`, `ekonomi`, `created_at`, `updated_at`) VALUES
(270, 90, 'pas', 80.00, 75.00, 80.00, 90.00, 80.00, 90.00, 70.00, 80.00, 55.00, 60.00, NULL, NULL, 75.00, NULL, 75.00, 80.00, 90.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(271, 91, 'rapor', 80.00, 85.00, 89.00, 85.00, 80.00, 88.00, 89.00, 76.00, 85.00, 81.00, NULL, NULL, 90.00, NULL, 85.00, 77.00, 92.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(272, 91, 'pts', 80.00, 65.00, 60.00, 80.00, 75.00, 55.00, 70.00, 75.00, 65.00, 80.00, NULL, NULL, 80.00, NULL, 76.00, 50.00, 75.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(273, 91, 'pas', 80.00, 95.00, 75.00, 95.00, 60.00, 80.00, 65.00, 65.00, 85.00, 55.00, NULL, NULL, 90.00, NULL, 70.00, 90.00, 80.00, NULL, '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(274, 92, 'rapor', 75.00, 78.00, 80.00, 85.00, 79.00, 84.00, 92.00, 76.00, 85.00, 83.00, NULL, NULL, 85.00, NULL, 85.00, 79.00, 82.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(275, 92, 'pts', 65.00, 45.00, 30.00, 65.00, 25.00, 35.00, 60.00, 75.00, 45.00, 65.00, NULL, NULL, 80.00, NULL, 43.00, 50.00, 80.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(276, 92, 'pas', 65.00, 65.00, 45.00, 85.00, 50.00, 85.00, 70.00, 70.00, 40.00, 60.00, NULL, NULL, 80.00, NULL, 50.00, 80.00, 60.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(277, 93, 'rapor', 75.00, 78.00, 94.00, 90.00, 79.00, 84.00, 87.00, 76.00, 83.00, 79.00, NULL, NULL, 94.00, NULL, 80.00, 82.00, 82.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(278, 93, 'pts', 80.00, 50.00, 70.00, 90.00, 65.00, 60.00, 60.00, 80.00, 50.00, 90.00, NULL, NULL, 75.00, NULL, 67.00, 60.00, 55.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(279, 93, 'pas', 80.00, 95.00, 90.00, 90.00, 60.00, 90.00, 75.00, 70.00, 95.00, 80.00, NULL, NULL, 95.00, NULL, 65.00, 95.00, 85.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(280, 94, 'rapor', 75.00, 78.00, 89.00, 85.00, 79.00, 85.00, 88.00, 76.00, 83.00, 79.00, NULL, NULL, 93.00, NULL, 80.00, 77.00, 84.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(281, 94, 'pts', 70.00, 45.00, 20.00, 65.00, 20.00, 40.00, 60.00, 65.00, 45.00, 65.00, NULL, NULL, 40.00, NULL, 43.00, 50.00, 65.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(282, 94, 'pas', 80.00, 90.00, 85.00, 90.00, 45.00, 90.00, 80.00, 75.00, 85.00, 75.00, NULL, NULL, 95.00, NULL, 85.00, 80.00, 85.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(283, 95, 'rapor', 75.00, 80.00, 82.00, 85.00, 80.00, 84.00, 89.00, 80.00, 85.00, 82.00, NULL, NULL, 83.00, NULL, 85.00, 79.00, 84.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(284, 95, 'pts', 60.00, 55.00, 45.00, 70.00, 30.00, 25.00, 60.00, 70.00, 55.00, 70.00, NULL, NULL, 80.00, NULL, 38.00, 55.00, 70.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(285, 95, 'pas', 70.00, 90.00, 70.00, 75.00, 40.00, 80.00, 85.00, 80.00, 70.00, 60.00, NULL, NULL, 75.00, NULL, 45.00, 80.00, 65.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(286, 96, 'rapor', 85.00, 90.00, 80.00, 85.00, 78.00, 85.00, 88.00, 76.00, 90.00, 89.00, NULL, NULL, 85.00, NULL, 80.00, 87.00, 88.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(287, 96, 'pts', 85.00, 65.00, 85.00, 90.00, 30.00, 70.00, 60.00, 80.00, 65.00, 90.00, NULL, NULL, 85.00, NULL, 62.00, 55.00, 65.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(288, 96, 'pas', 70.00, 90.00, 85.00, 85.00, 50.00, 80.00, 70.00, 70.00, 65.00, 90.00, NULL, NULL, 80.00, NULL, 70.00, 90.00, 90.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(289, 97, 'rapor', 75.00, 90.00, 90.00, 95.00, 80.00, 87.00, 88.00, 76.00, 90.00, 89.00, NULL, NULL, 87.00, NULL, 88.00, 88.00, 88.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(290, 97, 'pts', 95.00, 55.00, 50.00, 95.00, 75.00, 35.00, 55.00, 75.00, 55.00, 95.00, NULL, NULL, 70.00, NULL, 71.00, 90.00, 90.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(291, 97, 'pas', 75.00, 95.00, 65.00, 85.00, 80.00, 80.00, 85.00, 65.00, 75.00, 85.00, NULL, NULL, 85.00, NULL, 80.00, 80.00, 90.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(292, 98, 'rapor', 80.00, 85.00, 90.00, 85.00, 80.00, 85.00, 88.00, 80.00, 85.00, 85.00, NULL, NULL, 84.00, NULL, 88.00, 83.00, 88.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(293, 98, 'pts', 90.00, 60.00, 40.00, 60.00, 80.00, 45.00, 40.00, 65.00, 60.00, 70.00, NULL, NULL, 85.00, NULL, 67.00, 60.00, 80.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(294, 98, 'pas', 80.00, 70.00, 60.00, 75.00, 75.00, 60.00, 60.00, 80.00, 65.00, 75.00, NULL, NULL, 75.00, NULL, 60.00, 50.00, 65.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(295, 99, 'rapor', 85.00, 88.00, 93.00, 90.00, 82.00, 90.00, 89.00, 76.00, 85.00, 84.00, NULL, NULL, 93.00, NULL, 88.00, 85.00, 88.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(296, 99, 'pts', 75.00, 65.00, 30.00, 75.00, 75.00, 30.00, 50.00, 70.00, 65.00, 75.00, NULL, NULL, 75.00, NULL, 38.00, 35.00, 85.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(297, 99, 'pas', 85.00, 95.00, 75.00, 80.00, 85.00, 90.00, 70.00, 65.00, 60.00, 60.00, NULL, NULL, 95.00, NULL, 55.00, 65.00, 85.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(298, 100, 'rapor', 90.00, 91.00, 95.00, 90.00, 83.00, 92.00, 89.00, 76.00, 90.00, 90.00, NULL, NULL, 89.00, NULL, 90.00, 90.00, 92.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(299, 100, 'pts', 85.00, 60.00, 60.00, 75.00, 40.00, 75.00, 75.00, 85.00, 60.00, 65.00, NULL, NULL, 75.00, NULL, 67.00, 70.00, 75.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(300, 100, 'pas', 80.00, 100.00, 80.00, 80.00, 75.00, 45.00, 70.00, 55.00, 45.00, 95.00, NULL, NULL, 85.00, NULL, 75.00, 70.00, 95.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(301, 101, 'rapor', 90.00, 90.00, 90.00, 90.00, 82.00, 88.00, 87.00, 80.00, 85.00, 86.00, NULL, NULL, 93.00, NULL, 88.00, 92.00, 90.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(302, 101, 'pts', 85.00, 80.00, 55.00, 95.00, 85.00, 70.00, 60.00, 80.00, 80.00, 80.00, NULL, NULL, 80.00, NULL, 86.00, 80.00, 85.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(303, 101, 'pas', 85.00, 90.00, 80.00, 80.00, 75.00, 85.00, 70.00, 70.00, 85.00, 90.00, NULL, NULL, 95.00, NULL, 65.00, 90.00, 95.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(304, 102, 'rapor', 85.00, 90.00, 90.00, 90.00, 82.00, 89.00, 88.00, 76.00, 85.00, 85.00, NULL, NULL, 94.00, NULL, 85.00, 88.00, 90.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(305, 102, 'pts', 80.00, 70.00, 70.00, 85.00, 85.00, 70.00, 65.00, 85.00, 70.00, 80.00, NULL, NULL, 80.00, NULL, 86.00, 80.00, 90.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(306, 102, 'pas', 85.00, 95.00, 80.00, 90.00, 80.00, 90.00, 70.00, 65.00, 85.00, 80.00, NULL, NULL, 95.00, NULL, 70.00, 80.00, 85.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(307, 103, 'rapor', 74.00, 88.00, 80.00, 85.00, 80.00, 85.00, 89.00, 76.00, 85.00, 84.00, NULL, NULL, 85.00, NULL, 80.00, 77.00, 90.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(308, 103, 'pts', 55.00, 30.00, 15.00, 30.00, 80.00, 20.00, 20.00, 25.00, 30.00, 70.00, NULL, NULL, 30.00, NULL, 33.00, 35.00, 85.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(309, 103, 'pas', 65.00, 50.00, 40.00, 55.00, 85.00, 50.00, 55.00, 55.00, 35.00, 40.00, NULL, NULL, 45.00, NULL, 30.00, 40.00, 45.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(310, 104, 'rapor', 90.00, 90.00, 90.00, 90.00, 80.00, 87.00, 89.00, 76.00, 85.00, 86.00, NULL, NULL, 89.00, NULL, 88.00, 92.00, 94.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(311, 104, 'pts', 90.00, 60.00, 50.00, 80.00, 80.00, 55.00, 45.00, 60.00, 60.00, 75.00, NULL, NULL, 80.00, NULL, 67.00, 55.00, 90.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(312, 104, 'pas', 85.00, 75.00, 75.00, 75.00, 75.00, 80.00, 60.00, 80.00, 70.00, 85.00, NULL, NULL, 85.00, NULL, 60.00, 70.00, 90.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(313, 105, 'rapor', 90.00, 92.00, 95.00, 90.00, 85.00, 88.00, 89.00, 76.00, 90.00, 90.00, NULL, NULL, 94.00, NULL, 90.00, 92.00, 94.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(314, 105, 'pts', 90.00, 75.00, 70.00, 90.00, 85.00, 55.00, 65.00, 75.00, 75.00, 80.00, NULL, NULL, 80.00, NULL, 90.00, 80.00, 85.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(315, 105, 'pas', 90.00, 95.00, 75.00, 70.00, 70.00, 90.00, 70.00, 70.00, 75.00, 85.00, NULL, NULL, 95.00, NULL, 70.00, 85.00, 95.00, NULL, '2026-11-02 21:04:02', '2026-11-02 21:04:02');

-- --------------------------------------------------------

--
-- Table structure for table `non_akademik`
--

CREATE TABLE `non_akademik` (
  `id` bigint NOT NULL,
  `siswa_periode_id` bigint NOT NULL,
  `ekstrakurikuler` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prestasi` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kemampuan` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organisasi` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kursus` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jurusan_1` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jurusan_2` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `non_akademik`
--

INSERT INTO `non_akademik` (`id`, `siswa_periode_id`, `ekstrakurikuler`, `prestasi`, `kemampuan`, `organisasi`, `kursus`, `jurusan_1`, `jurusan_2`, `created_at`, `updated_at`) VALUES
(1, 1, 'Badminton', 'Tidak', 'Modifikasi Motor', 'Badminton', 'Tidak', 'Teknik Mesin', 'Pendidikan Jasmani', '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(2, 2, 'Futsal', 'Tidak', 'Bermain Futsal', 'Karang Taruna', 'Tidak', 'Manajemen', 'Ilmu Keolahragaan', '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(3, 3, 'Band', 'Tidak', 'Main Gitar', 'OSIS', 'Bimbel', 'Psikologi', 'Sastra Indonesia', '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(4, 4, 'Futsal', 'Tidak', 'Bermain Futsal', 'Tidak', 'Tidak', 'Manajemen', 'Ekonomi', '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(5, 5, 'Modern Dance', 'Tidak', 'Bisnis', 'Karang Taruna', 'Tidak', 'Manajemen', 'Akuntansi', '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(6, 6, 'Badminton', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Sastra Inggris', 'Ilmu Komunikasi', '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(7, 7, 'Taekwondo', 'Tidak', 'Bela Diri', 'Tidak', 'Tidak', 'Ilmu Keolahragaan', 'Pendidikan Jasmani', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(8, 8, 'Badminton', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Industri', 'Teknik Elektro', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(9, 9, 'Basket', 'Tidak', 'Main Basket', 'Tidak', 'Tidak', 'Manajemen', 'Hukum', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(10, 10, 'Tari Tradisional', 'Runner Up Puteri Remaja Indonesia Lingkungan Jakarta 2024', 'Menari', 'OSIS', 'Bimbel', 'Ilmu Komunikasi', 'Psikologi', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(11, 11, 'Badminton', 'Tidak', 'Menggambar', 'Badminton', 'Bimbel', 'Arsitektur', 'DKV', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(12, 12, 'Mading', 'Tidak', 'Fotografi', 'Tidak', 'Bimbel', 'DKV', 'Manajemen', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(13, 13, 'Futsal', 'Tidak', 'Videografi', 'Karang Taruna', 'Bimbel', 'DKV', 'Teknik Informatika', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(14, 14, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Mesin', 'Hukum', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(15, 15, 'Basket', 'Tidak', 'Editing', 'Tidak', 'Tidak', 'Teknik Informatika', 'DKV', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(16, 16, 'Futsal', 'Tidak', 'Bisnis', 'Basket', 'Tidak', 'Akuntansi', 'Manajemen', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(17, 17, 'KIR', 'Tidak', 'Analisis', 'OSIS', 'Bimbel', 'Kedokteran', 'Teknik Informatika', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(18, 18, 'Basket', 'Tidak', 'Gaming', 'Basket', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(19, 19, 'Modern Dance', 'Tidak', 'Wirausaha', 'OSIS', 'Bimbel', 'Manajemen', 'Farmasi', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(20, 20, 'Futsal', 'Tidak', 'Desain', 'Tidak', 'Tidak', 'DKV', 'Arsitektur', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(21, 21, 'Basket', 'Tidak', 'Bisnis', 'Karang Taruna', 'Tidak', 'Manajemen', 'Ekonomi', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(22, 22, 'Taekwondo', 'Tidak', 'Bela Diri', 'OSIS', 'Tidak', 'Ilmu Keolahragaan', 'Hukum', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(23, 23, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Tidak', 'Tidak', 'Teknik Industri', 'Teknik Elektro', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(24, 24, 'KIR', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Psikologi', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(25, 25, 'Tari Tradisional', 'Tidak', 'Wirausaha', 'Karang Taruna', 'Bimbel', 'Manajemen', 'Akuntansi', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(26, 26, 'Tari Tradisional', 'Juara harapan 1 FLS2N', 'Desain', 'Tidak', 'Bimbel', 'DKV', 'Arsitektur', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(27, 27, 'Futsal', 'Juara 1 Lomba Futsal di SMA Penabur Bintaro Jaya 2024', 'Bermain Futsal', 'Karang Taruna', 'Tidak', 'Ilmu Keolahragaan', 'Teknik Elektro', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(28, 28, 'Band', 'Tidak', 'Gaming', 'Tidak', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(29, 29, 'Futsal', 'Tidak', 'Atletik', 'Tidak', 'Tidak', 'Pendidikan Jasmani', 'Ilmu Keolahragaan', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(30, 30, 'Basket', 'Tidak', 'Public Speaking', 'Basket', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Sastra Inggris', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(31, 31, 'Futsal', 'Tidak', 'Modifikasi Motor', 'OSIS', 'Tidak', 'Teknik Mesin', 'Teknik Industri', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(32, 32, 'KIR', 'Tidak', 'Analisis', 'Tidak', 'Tidak', 'Hukum', 'Psikologi', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(33, 33, 'Taekwondo', 'Tidak', 'Bela Diri', 'Karang Taruna', 'Pelatihan Saksi Partai', 'Hukum', 'Ilmu Komunikasi', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(34, 34, 'Taekwondo', 'Juara 1 kejuaraan taekwondo liga DKI', 'Bela Diri', 'OSIS', 'Tidak', 'Hukum', 'Pendidikan Jasmani', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(35, 35, 'Badminton', 'Tidak', 'Atletik', 'Badminton', 'Tidak', 'Pendidikan Jasmani', 'Sastra Indonesia', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(36, 36, 'Taekwondo', 'Tidak', 'Bela Diri', 'Tidak', 'Tidak', 'Ilmu Keolahragaan', 'Teknik Mesin', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(37, 37, 'Band', 'Tidak', 'Main Drum', 'OSIS', 'Tidak', 'Manajemen', 'Teknik Industri', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(38, 38, 'Badminton', 'Tidak', 'Videografi', 'Badminton', 'Tidak', 'DKV', 'Teknik Informatika', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(39, 39, 'Modern Dance', 'Tidak', 'Bisnis', 'Karang Taruna', 'Bimbel', 'Hukum', 'Akuntansi', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(40, 40, 'Futsal', 'Juara 1 Lomba Futsal di SMA Penabur Bintaro Jaya 2024', 'Bermain Futsal', 'Karang Taruna', 'Tidak', 'Ilmu Komunikasi', 'Manajemen', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(41, 41, 'Mading', 'Tidak', 'Melukis', 'Tidak', 'Bimbel', 'Manajemen', 'DKV', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(42, 42, 'Tari Tradisional', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Psikologi', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(43, 43, 'Modern Dance', 'Tidak', 'Wirausaha', 'Tidak', 'Bimbel', 'Manajemen', 'Akuntansi', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(44, 44, 'Mading', 'Tidak', 'Menggambar', 'Karang Taruna', 'Tidak', 'Seni Rupa', 'DKV', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(45, 45, 'KIR', 'Tidak', 'Analisis', 'PMR', 'Tidak', 'Ilmu Keperawatan', 'Farmasi', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(46, 46, 'Band', 'Tidak', 'Main Gitar', 'Karang Taruna', 'Tidak', 'Manajemen', 'Hukum', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(47, 47, 'KIR', 'Tidak', 'Analisis', 'PMR', 'Bimbel', 'Ilmu Keperawatan', 'Teknologi Pangan', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(48, 48, 'Tari Tradisional', 'Tidak', 'Bisnis', 'OSIS', 'Bimbel', 'Akuntansi', 'Ekonomi', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(49, 49, 'Badminton', 'Tidak', 'Public Speaking', 'Badminton', 'Kursus TOEFL', 'Sastra Inggris', 'Ilmu Komunikasi', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(50, 50, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Tidak', 'Tidak', 'Teknik Industri', 'Teknik Elektro', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(51, 51, 'Tari Tradisional', 'Tidak', 'Bisnis', 'Karang Taruna', 'Bimbel', 'Akuntansi', 'Hukum', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(52, 52, 'KIR', 'Juara 2 kejuaraan pelajar nasional', 'Analisis', 'OSIS', 'Tidak', 'Teknologi Pangan', 'Arsitektur', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(53, 53, 'Tari Tradisional', 'Tidak', 'Memasak', 'Tidak', 'Bimbel', 'Teknologi Pangan', 'Ilmu Komunikasi', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(54, 54, 'Modern Dance', 'Tidak', 'Menari', 'Karang Taruna', 'Tidak', 'Seni Rupa', 'PGSD', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(55, 55, 'Mading', 'Tidak', 'Videografi', 'Tidak', 'Bimbel', 'DKV', 'Teknik Informatika', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(56, 56, 'Band', 'Tidak', 'Modifikasi Motor', 'OSIS', 'Bimbel', 'Teknik Mesin', 'Teknik Elektro', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(57, 57, 'Mading', 'Tidak', 'Menggambar', 'Tidak', 'Bimbel', 'DKV', 'Arsitektur', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(58, 58, 'Basket', 'Tidak', 'Bisnis', 'Basket', 'Tidak', 'Manajemen', 'Psikologi', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(59, 59, 'Taekwondo', 'Tidak', 'Bela Diri', 'Karang Taruna', 'Tidak', 'Pendidikan Jasmani', 'Hukum', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(60, 60, 'futsal', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Industri', 'Manajemen', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(61, 61, 'Badminton', 'Tidak', 'Editing', 'Tidak', 'Tidak', 'DKV', 'Teknik Informatika', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(62, 62, 'Mading', 'Tidak', 'Menggambar', 'Tidak', 'Tidak', 'Arsitektur', 'DKV', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(63, 63, 'futsal', 'Tidak', 'Wirausaha', 'Tidak', 'Tidak', 'Manajemen', 'Ekonomi', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(64, 64, 'Futsal', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Tidak', 'Tidak', 'Teknik Informatika', 'Manajemen', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(65, 65, 'basket', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'OSIS', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(66, 66, 'Futsal', 'Tidak', 'Public Speaking', 'Karang Taruna', 'Tidak', 'Hukum', 'Ilmu Komunikasi', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(67, 67, 'Badminton', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Badminton', 'Tidak', 'Teknik Informatika', 'Teknik Elektro', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(68, 68, 'Basket', 'Tidak', 'Videografi', 'Karang Taruna', 'Tidak', 'DKV', 'Manajemen', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(69, 69, 'KIR', 'Tidak', 'Public Speaking', 'Tidak', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Sastra Inggris', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(70, 70, 'Band', 'Juara 2 Solo Vokal M25 Cup SMA Muhammadh 25 Pamulang 2024', 'Menyanyi', 'OSIS', 'Tidak', 'Ilmu Komunikasi', 'Sastra Indonesia', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(71, 71, 'Mading', 'Tidak', 'Melukis', 'Tidak', 'Melukis', 'Seni Rupa', 'DKV', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(72, 72, 'Tari Tradisional', 'Tidak', 'Bisnis', 'Karang Taruna', 'Bimbel', 'Akuntansi', 'Ekonomi', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(73, 73, 'Tari Tradisional', 'Tidak', 'Memasak', 'Tidak', 'Bimbel', 'Ilmu Keperawatan', 'Teknologi Pangan', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(74, 74, 'KIR', 'Tidak', 'Analisis', 'Tidak', 'Bimbel', 'Arsitektur', 'Farmasi', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(75, 75, 'Futsal', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Karang Taruna', 'Tidak', 'Manajemen', 'Teknik Informatika', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(76, 76, 'Badminton', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Tidak', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(77, 77, 'Tari Tradisional', 'Tidak', 'Wirausaha', 'Karang Taruna', 'Tidak', 'Akuntansi', 'Manajemen', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(78, 78, 'Band', 'Tidak', 'Main Gitar', 'Karang Taruna', 'Pelatihan Saksi Partai', 'Hukum', 'Sastra Indonesia', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(79, 79, 'Futsal', 'Tidak', 'Editing', 'Karang Taruna', 'Tidak', 'DKV', 'Teknik Informatika', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(80, 80, 'Modern Dance', 'Tidak', 'Menari', 'Tidak', 'Tidak', 'Pendidikan Jasmani', 'Seni Rupa', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(81, 81, 'Modern Dance', 'Tidak', 'Memasak', 'OSIS', 'Bimbel', 'Teknologi Pangan', 'Farmasi', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(82, 82, 'KIR', 'Tidak', 'Wirausaha', 'OSIS', 'Tidak', 'Manajemen', 'Ekonomi', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(83, 83, 'Mading', 'Tidak', 'Menggambar', 'Tidak', 'Tidak', 'DKV', 'Arsitektur', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(84, 84, 'KIR', 'Tidak', 'Fotografi', 'PMR', 'Tidak', 'DKV', 'Ilmu Keperawatan', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(85, 85, 'futsal', 'Tidak', 'Modifikasi Motor', 'Tidak', 'Tidak', 'Teknik Industri', 'Teknik Elektro', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(86, 86, 'Band', 'Tidak', 'Analisis', 'Tidak', 'Bimbel', 'Kedokteran', 'Teknik Industri', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(87, 87, 'Taekwondo', 'Tidak', 'Bisnis', 'Tidak', 'Tidak', 'Teknik Informatika', 'Pendidikan Jasmani', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(88, 88, 'Basket', 'Tidak', 'Gaming', 'Basket', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(89, 89, 'Futsal', 'Tidak', 'Desain', 'Tidak', 'Tidak', 'DKV', 'Teknik Informatika', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(90, 90, 'futsal', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Industri', 'Hukum', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(91, 91, 'Badminton', 'Tidak', 'Public Speaking', 'OSIS', 'Tidak', 'Hukum', 'Psikologi', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(92, 92, 'KIR', 'Tidak', 'Bisnis', 'OSIS', 'Tidak', 'Manajemen', 'Akuntansi', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(93, 93, 'KIR', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Sastra Inggris', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(94, 94, 'Futsal', 'Tidak', 'Desain', 'Tidak', 'Tidak', 'Ilmu Komputer', 'DKV', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(95, 95, 'Taekwondo', 'Tidak', 'Bela Diri', 'Karang Taruna', 'Tidak', 'Pendidikan Jasmani', 'Sastra Indonesia', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(96, 96, 'Basket', 'Tidak', 'Atletik', 'Basket', 'Tidak', 'Ilmu Keolahragaan', 'Pendidikan Jasmani', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(97, 97, 'KIR', 'Tidak', 'Desain', 'OSIS', 'Kursus TOEFL', 'Sastra Inggris', 'Ilmu Komunikasi', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(98, 98, 'Modern Dance', 'Tidak', 'Bisnis', 'Tidak', 'Tidak', 'Akuntansi', 'Manajemen', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(99, 99, 'Modern Dance', 'Tidak', 'Public Speaking', 'OSIS', 'Bimbel', 'Ilmu Komunikasi', 'Sastra Inggris', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(100, 100, 'Badminton', 'Tidak', 'Atletik', 'Badminton', 'Tidak', 'Ilmu Keolahragaan', 'Pendidikan Jasmani', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(101, 101, 'Tari Tradisional', 'Tidak', 'Memasak', 'Tidak', 'Bimbel', 'Teknologi Pangan', 'Farmasi', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(102, 102, 'Mading', 'Tidak', 'Public Speaking', 'Karang Taruna', 'Tidak', 'Psikologi', 'Ilmu Komunikasi', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(103, 103, 'Modern Dance', 'Tidak', 'Bisnis', 'Tidak', 'Tidak', 'Manajemen', 'Ekonomi', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(104, 104, 'Mading', 'Tidak', 'Menggambar', 'Karang Taruna', 'Bimbel', 'Arsitektur', 'DKV', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(105, 105, 'Basket', 'Tidak', 'Bisnis', 'Basket', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Manajemen', '2026-11-02 21:04:02', '2026-11-02 21:04:02');

-- --------------------------------------------------------

--
-- Table structure for table `periode`
--

CREATE TABLE `periode` (
  `id` bigint NOT NULL,
  `tahun_ajaran` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `semester` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_periode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `periode`
--

INSERT INTO `periode` (`id`, `tahun_ajaran`, `semester`, `nama_periode`, `status`, `created_at`, `updated_at`) VALUES
(1, '2025/2026', 'GANJIL', '2025/2026 Ganjil', 'AKTIF', NULL, '2026-11-04 09:42:46'),
(2, '2026/2027', 'GANJIL', '2026/2027 Ganjil', 'SELESAI', NULL, '2026-11-04 09:42:46'),
(5, '2025/2026', 'GENAP', '2025/2026 Genap', 'NONAKTIF', NULL, '2026-10-05 05:35:13');

-- --------------------------------------------------------

--
-- Table structure for table `preprocessing_run`
--

CREATE TABLE `preprocessing_run` (
  `id` bigint NOT NULL,
  `periode_id` bigint NOT NULL,
  `admin_id` bigint NOT NULL,
  `imputation_method` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `started_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `cleaned_at` datetime DEFAULT NULL,
  `cleaned_duration_ms` int DEFAULT NULL,
  `integrated_at` datetime DEFAULT NULL,
  `integrated_duration_ms` int DEFAULT NULL,
  `reduced_at` datetime DEFAULT NULL,
  `reduced_duration_ms` int DEFAULT NULL,
  `reduced_invalidated_at` datetime DEFAULT NULL,
  `transformed_at` datetime DEFAULT NULL,
  `transformed_duration_ms` int DEFAULT NULL,
  `transformed_invalidated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `preprocessing_run`
--

INSERT INTO `preprocessing_run` (`id`, `periode_id`, `admin_id`, `imputation_method`, `status`, `started_at`, `completed_at`, `created_at`, `updated_at`, `cleaned_at`, `cleaned_duration_ms`, `integrated_at`, `integrated_duration_ms`, `reduced_at`, `reduced_duration_ms`, `reduced_invalidated_at`, `transformed_at`, `transformed_duration_ms`, `transformed_invalidated_at`) VALUES
(1, 1, 1, 'mean', 'COMPLETED', '2026-11-03 04:11:45', NULL, NULL, NULL, '2026-11-03 04:15:06', 200, '2026-11-03 04:11:46', 261, '2026-11-03 04:28:04', 8, NULL, '2026-11-03 04:28:01', 46, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `recommendation`
--

CREATE TABLE `recommendation` (
  `id` bigint NOT NULL,
  `kmeans_run_id` bigint NOT NULL,
  `siswa_periode_id` bigint NOT NULL,
  `cluster_code` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recommendation_1` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bobot_1` decimal(5,2) DEFAULT NULL,
  `recommendation_2` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bobot_2` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reduced_data`
--

CREATE TABLE `reduced_data` (
  `id` bigint NOT NULL,
  `preprocessing_run_id` bigint NOT NULL,
  `siswa_periode_id` bigint NOT NULL,
  `agama` decimal(8,4) DEFAULT NULL,
  `pkn` decimal(8,4) DEFAULT NULL,
  `b_indonesia` decimal(8,4) DEFAULT NULL,
  `b_inggris` decimal(8,4) DEFAULT NULL,
  `mtk_wajib` decimal(8,4) DEFAULT NULL,
  `sejarah` decimal(8,4) DEFAULT NULL,
  `pjok` decimal(8,4) DEFAULT NULL,
  `seni_rupa` decimal(8,4) DEFAULT NULL,
  `b_jepang` decimal(8,4) DEFAULT NULL,
  `biologi` decimal(8,4) DEFAULT NULL,
  `fisika` decimal(8,4) DEFAULT NULL,
  `kimia` decimal(8,4) DEFAULT NULL,
  `informatika` decimal(8,4) DEFAULT NULL,
  `mtk_lanjut` decimal(8,4) DEFAULT NULL,
  `geografi` decimal(8,4) DEFAULT NULL,
  `sosial` decimal(8,4) DEFAULT NULL,
  `pkwu` decimal(8,4) DEFAULT NULL,
  `ekonomi` decimal(8,4) DEFAULT NULL,
  `ekstrakurikuler` decimal(8,4) DEFAULT NULL,
  `prestasi` decimal(8,4) DEFAULT NULL,
  `kemampuan` decimal(8,4) DEFAULT NULL,
  `organisasi` decimal(8,4) DEFAULT NULL,
  `kursus` decimal(8,4) DEFAULT NULL,
  `jurusan_1` decimal(8,4) DEFAULT NULL,
  `jurusan_2` decimal(8,4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reduced_data`
--

INSERT INTO `reduced_data` (`id`, `preprocessing_run_id`, `siswa_periode_id`, `agama`, `pkn`, `b_indonesia`, `b_inggris`, `mtk_wajib`, `sejarah`, `pjok`, `seni_rupa`, `b_jepang`, `biologi`, `fisika`, `kimia`, `informatika`, `mtk_lanjut`, `geografi`, `sosial`, `pkwu`, `ekonomi`, `ekstrakurikuler`, `prestasi`, `kemampuan`, `organisasi`, `kursus`, `jurusan_1`, `jurusan_2`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1.0000, 1.0000, 0.9767, 0.7727, 0.8480, 0.9154, 0.9068, 0.9135, 0.6957, 1.0000, 1.0000, 0.7581, 0.8305, 0.6111, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.7500, 0.2500, 0.0000, 0.1000, 0.7273, NULL, NULL),
(2, 1, 2, 0.5000, 0.6577, 0.7907, 0.6818, 0.6000, 0.7692, 0.7373, 0.6731, 0.5043, 0.5424, 0.2734, 0.5484, 0.7542, 0.2889, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.1250, 0.5000, 0.0000, 0.3000, 0.7273, NULL, NULL),
(3, 1, 3, 0.7500, 0.8378, 0.8527, 0.8636, 0.7520, 0.7385, 0.9407, 0.6731, 0.7391, 0.9322, 0.5469, 0.7339, 0.8136, 0.3444, 0.5963, 0.6185, 0.5696, 0.6923, 0.5000, 0.0000, 0.2500, 0.7500, 0.2500, 0.4000, 0.4545, NULL, NULL),
(4, 1, 4, 0.3500, 0.5405, 0.6977, 0.6818, 0.6880, 0.9077, 0.5847, 0.2885, 0.0870, 0.5424, 0.6172, 0.0000, 0.6864, 0.3667, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.1250, 0.0000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(5, 1, 5, 0.8000, 0.9009, 0.8527, 0.6364, 0.7200, 0.9462, 0.8475, 0.8558, 0.6522, 0.9915, 0.6953, 0.7258, 0.8644, 0.5667, 0.5963, 0.6185, 0.5696, 0.6923, 0.5000, 0.0000, 0.6250, 0.5000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(6, 1, 6, 0.7500, 0.6306, 0.8527, 0.8636, 0.8560, 0.5231, 0.6949, 0.8558, 0.5217, 0.7966, 0.0703, 0.2984, 0.8644, 0.7333, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 1.0000, 0.7500, 0.5000, 0.5000, 0.3636, NULL, NULL),
(7, 1, 7, 0.5500, 0.4955, 0.7442, 0.5455, 0.6000, 0.2077, 0.6610, 0.3365, 0.6087, 0.4492, 0.4141, 0.2742, 0.6695, 0.3111, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.1250, 0.0000, 0.0000, 0.8000, 0.7273, NULL, NULL),
(8, 1, 8, 0.5300, 0.6757, 0.7364, 0.5909, 0.6080, 0.4231, 0.7797, 0.7692, 0.6957, 0.7458, 0.1953, 0.7177, 0.8220, 0.3444, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.7500, 0.5000, 0.0000, 0.1000, 0.0909, NULL, NULL),
(9, 1, 9, 0.9000, 0.8829, 1.0000, 0.8636, 0.9360, 0.9077, 0.8644, 0.9519, 0.9130, 0.9153, 0.7969, 0.9758, 0.8729, 0.5556, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.1250, 0.0000, 0.0000, 0.3000, 0.3636, NULL, NULL),
(10, 1, 10, 0.4500, 0.7477, 0.7674, 0.8636, 0.8240, 0.5538, 0.7797, 0.8173, 0.7826, 0.9746, 0.2812, 0.7097, 0.8390, 0.6667, 0.5963, 0.6185, 0.5696, 0.6923, 0.5000, 0.8000, 0.3750, 0.7500, 0.2500, 0.4000, 0.3636, NULL, NULL),
(11, 1, 11, 0.7500, 0.6757, 0.8062, 0.9091, 0.8480, 0.5923, 0.9237, 1.0000, 0.7391, 0.9153, 0.5234, 0.4758, 0.9322, 0.7000, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.3750, 0.2500, 0.2500, 1.0000, 0.5455, NULL, NULL),
(12, 1, 12, 0.6000, 0.7207, 0.7674, 0.7727, 0.9280, 0.6615, 0.7966, 0.9038, 0.6522, 0.5254, 0.3906, 0.4274, 0.9153, 0.8111, 0.5963, 0.6185, 0.5696, 0.6923, 1.0000, 0.0000, 0.5000, 0.0000, 0.2500, 0.6000, 0.2727, NULL, NULL),
(13, 1, 13, 0.8200, 0.6757, 1.0000, 0.8364, 0.7440, 0.7692, 0.9068, 0.8558, 0.3913, 0.7881, 0.5859, 0.4274, 0.7797, 0.5444, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.5000, 0.5000, 0.2500, 0.6000, 0.1818, NULL, NULL),
(14, 1, 14, 0.8500, 0.8108, 0.9302, 0.8636, 0.7120, 0.8077, 0.9915, 0.9519, 0.4783, 0.8644, 0.5625, 0.5000, 0.8644, 0.4000, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.7500, 0.5000, 0.0000, 0.1000, 0.3636, NULL, NULL),
(15, 1, 15, 0.9500, 0.7387, 0.9302, 0.9091, 0.5760, 0.8077, 0.4407, 0.9519, 0.6087, 0.8475, 0.9609, 0.7097, 0.8644, 0.4444, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.5000, 0.0000, 0.0000, 0.2000, 0.5455, NULL, NULL),
(16, 1, 16, 0.5500, 0.2973, 0.5271, 0.6364, 0.6240, 0.6692, 0.4407, 0.7596, 0.3913, 0.7034, 0.5625, 0.4194, 0.5254, 0.5333, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.6250, 0.2500, 0.0000, 0.3000, 0.2727, NULL, NULL),
(17, 1, 17, 0.2500, 0.4505, 0.6512, 0.8636, 0.9360, 0.5769, 0.6610, 0.6250, 0.2174, 0.6949, 0.1406, 0.0645, 0.8559, 1.0000, 0.5963, 0.6185, 0.5696, 0.6923, 0.7500, 0.0000, 0.7500, 0.7500, 0.2500, 0.7000, 0.1818, NULL, NULL),
(18, 1, 18, 0.8000, 0.7477, 0.9612, 0.7727, 0.6800, 0.6385, 1.0000, 0.9519, 0.5652, 0.7627, 0.5469, 0.6048, 0.8136, 0.3667, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.5000, 0.2500, 0.0000, 0.2000, 0.1818, NULL, NULL),
(19, 1, 19, 1.0000, 0.8198, 0.8140, 0.7727, 0.8720, 0.7077, 0.8983, 0.8558, 0.7826, 0.7797, 0.5000, 0.5484, 0.8390, 0.8667, 0.5963, 0.6185, 0.5696, 0.6923, 0.5000, 0.0000, 0.6250, 0.7500, 0.2500, 0.3000, 0.6364, NULL, NULL),
(20, 1, 20, 1.0000, 0.5856, 0.9302, 0.6364, 0.5920, 0.7692, 0.8220, 1.0000, 0.5652, 0.8051, 0.6328, 0.6290, 0.8220, 0.3444, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.5000, 0.0000, 0.0000, 0.6000, 0.9091, NULL, NULL),
(21, 1, 21, 0.8500, 0.7387, 0.9225, 0.7727, 0.4000, 0.7308, 0.8814, 0.9038, 0.4348, 0.5932, 0.4453, 0.4758, 0.8136, 0.1111, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.6250, 0.5000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(22, 1, 22, 0.9500, 0.9099, 0.9767, 0.8182, 0.8640, 0.6692, 0.9576, 0.9038, 0.6522, 1.0000, 0.7578, 0.7339, 0.8051, 0.6667, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.1250, 0.7500, 0.0000, 0.8000, 0.3636, NULL, NULL),
(23, 1, 23, 0.9000, 0.8559, 0.9767, 0.8636, 0.5520, 0.7923, 0.8814, 0.8654, 0.6957, 0.6949, 0.5156, 0.7661, 0.8644, 0.3111, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.7500, 0.0000, 0.0000, 0.1000, 0.0909, NULL, NULL),
(24, 1, 24, 0.5500, 0.7928, 0.6977, 0.7273, 0.6960, 0.6308, 0.9068, 0.8654, 0.6957, 0.4068, 0.2344, 0.7500, 0.7881, 0.7556, 0.5963, 0.6185, 0.5696, 0.6923, 0.7500, 0.0000, 1.0000, 0.7500, 0.5000, 0.4000, 0.3636, NULL, NULL),
(25, 1, 25, 0.6500, 0.9279, 0.5116, 0.7273, 0.6400, 0.7077, 0.6525, 0.7692, 0.5217, 0.6453, 0.4536, 0.5602, 0.9407, 0.5256, 0.7329, 0.7724, 0.6915, 0.5352, 0.5000, 0.0000, 0.6250, 0.5000, 0.2500, 0.3000, 0.2727, NULL, NULL),
(26, 1, 26, 0.7300, 0.9189, 0.8140, 0.9091, 0.7440, 0.8462, 0.7712, 0.8077, 0.6522, 0.6453, 0.4536, 0.5602, 0.8475, 0.5256, 0.9658, 0.8374, 0.9468, 0.8873, 0.5000, 0.4000, 0.5000, 0.0000, 0.2500, 0.6000, 0.9091, NULL, NULL),
(27, 1, 27, 0.6000, 0.8108, 0.7054, 0.3636, 0.5280, 0.7538, 0.7119, 0.4808, 0.7826, 0.6453, 0.4536, 0.5602, 0.8729, 0.5256, 0.4041, 0.6179, 0.4362, 0.5775, 0.2500, 0.2000, 0.1250, 0.5000, 0.0000, 0.8000, 0.0909, NULL, NULL),
(28, 1, 28, 0.7800, 0.4324, 0.5426, 0.9091, 0.5920, 0.6077, 0.5763, 0.5288, 0.6522, 0.6453, 0.4536, 0.5602, 0.4746, 0.5256, 0.6027, 0.8943, 0.4787, 0.7746, 0.5000, 0.0000, 0.5000, 0.0000, 0.0000, 0.2000, 0.1818, NULL, NULL),
(29, 1, 29, 0.6500, 0.8559, 0.5504, 0.5455, 0.6400, 0.5385, 0.5424, 0.7212, 0.4783, 0.6453, 0.4536, 0.5602, 0.7034, 0.5256, 0.6712, 0.6748, 0.3298, 0.4930, 0.2500, 0.0000, 0.1250, 0.0000, 0.0000, 0.8000, 0.7273, NULL, NULL),
(30, 1, 30, 0.7500, 0.8829, 0.6589, 0.6818, 0.8080, 0.7462, 0.6949, 0.8558, 0.7391, 0.6453, 0.4536, 0.5602, 0.8136, 0.5256, 0.7329, 0.6585, 0.5957, 0.8310, 0.2500, 0.0000, 1.0000, 0.2500, 0.5000, 0.4000, 0.4545, NULL, NULL),
(31, 1, 31, 0.2000, 0.5856, 0.6124, 0.5000, 0.3280, 0.2615, 0.5339, 0.5288, 0.4783, 0.6453, 0.4536, 0.5602, 0.3644, 0.5256, 0.4521, 0.1707, 0.3830, 0.5070, 0.2500, 0.0000, 0.7500, 0.7500, 0.0000, 0.1000, 0.0909, NULL, NULL),
(32, 1, 32, 0.3500, 0.6757, 0.5426, 0.5909, 0.3600, 0.4538, 0.6017, 0.5288, 0.4348, 0.6453, 0.4536, 0.5602, 0.5339, 0.5256, 0.3014, 0.4553, 0.3723, 0.6479, 0.7500, 0.0000, 0.7500, 0.0000, 0.0000, 0.4000, 0.3636, NULL, NULL),
(33, 1, 33, 0.8500, 0.9459, 0.8140, 0.7727, 0.5920, 0.7538, 0.7458, 0.6250, 0.8696, 0.6453, 0.4536, 0.5602, 0.9153, 0.5256, 0.5959, 0.8943, 0.4894, 0.7887, 0.2500, 0.0000, 0.1250, 0.5000, 0.7500, 0.4000, 0.3636, NULL, NULL),
(34, 1, 34, 0.7500, 0.9009, 0.8140, 0.9545, 0.8960, 0.7846, 0.8814, 0.8077, 0.6957, 0.6453, 0.4536, 0.5602, 0.8475, 0.5256, 0.8973, 0.6585, 0.7553, 0.7465, 0.2500, 0.2000, 0.1250, 0.7500, 0.0000, 0.4000, 0.7273, NULL, NULL),
(35, 1, 35, 0.6500, 0.8559, 0.6512, 0.8182, 0.7360, 0.4923, 0.5169, 0.8558, 0.5652, 0.6453, 0.4536, 0.5602, 0.5085, 0.5256, 0.5411, 0.6911, 0.5957, 0.5634, 0.2500, 0.0000, 0.1250, 0.2500, 0.0000, 0.8000, 0.4545, NULL, NULL),
(36, 1, 36, 0.7500, 0.9730, 0.8140, 0.7727, 0.5600, 0.7923, 0.8729, 0.7212, 0.8696, 0.6453, 0.4536, 0.5602, 0.7203, 0.5256, 0.8014, 0.8293, 0.3191, 0.7887, 0.2500, 0.0000, 0.1250, 0.0000, 0.0000, 0.8000, 0.0909, NULL, NULL),
(37, 1, 37, 0.1000, 0.3423, 0.1860, 0.1364, 0.0320, 0.3615, 0.0000, 0.4327, 0.0261, 0.6453, 0.4536, 0.5602, 0.1780, 0.5256, 0.0000, 0.2439, 0.0000, 0.0000, 0.5000, 0.0000, 0.2500, 0.7500, 0.0000, 0.3000, 0.0909, NULL, NULL),
(38, 1, 38, 0.2500, 0.3153, 0.6124, 0.3636, 0.2320, 0.4154, 0.8220, 0.5288, 0.5913, 0.6453, 0.4536, 0.5602, 0.6017, 0.5256, 0.3219, 0.5285, 0.1596, 0.2113, 0.2500, 0.0000, 0.5000, 0.2500, 0.0000, 0.6000, 0.1818, NULL, NULL),
(39, 1, 39, 0.6000, 0.6577, 0.6977, 0.6818, 0.4320, 0.5462, 0.8220, 0.8558, 0.5913, 0.6453, 0.4536, 0.5602, 1.0000, 0.5256, 0.5959, 0.4959, 0.7234, 0.6479, 0.5000, 0.0000, 0.6250, 0.5000, 0.2500, 0.4000, 0.2727, NULL, NULL),
(40, 1, 40, 0.8000, 0.8559, 0.6977, 0.7727, 0.4320, 0.7308, 0.4576, 0.9038, 0.6087, 0.6453, 0.4536, 0.5602, 0.9407, 0.5256, 0.8014, 0.8211, 0.7660, 1.0000, 0.2500, 0.2000, 0.1250, 0.5000, 0.0000, 0.4000, 0.2727, NULL, NULL),
(41, 1, 41, 0.7500, 0.9009, 0.8915, 0.8182, 0.7840, 0.7077, 0.6610, 0.7212, 0.6957, 0.6453, 0.4536, 0.5602, 0.8305, 0.5256, 0.5959, 0.7805, 0.6915, 0.8451, 1.0000, 0.0000, 0.3750, 0.0000, 0.2500, 0.3000, 0.5455, NULL, NULL),
(42, 1, 42, 0.2000, 0.3153, 0.2713, 0.4545, 0.7280, 0.0692, 0.0932, 0.4327, 0.2174, 0.6453, 0.4536, 0.5602, 0.4915, 0.5256, 0.5342, 0.2683, 0.2660, 0.3662, 0.5000, 0.0000, 1.0000, 0.7500, 0.5000, 0.4000, 0.3636, NULL, NULL),
(43, 1, 43, 0.8500, 0.9459, 0.8372, 0.8636, 0.8160, 0.9538, 0.7373, 0.7692, 0.6522, 0.6453, 0.4536, 0.5602, 0.8644, 0.5256, 0.8630, 0.9431, 0.8511, 1.0000, 0.5000, 0.0000, 0.6250, 0.0000, 0.2500, 0.3000, 0.2727, NULL, NULL),
(44, 1, 44, 0.5000, 0.9009, 0.8837, 0.7273, 0.6000, 0.6615, 0.7881, 0.6250, 0.9130, 0.6453, 0.4536, 0.5602, 0.9322, 0.5256, 0.8014, 0.7805, 0.7553, 0.4366, 1.0000, 0.0000, 0.3750, 0.5000, 0.0000, 0.6000, 0.5455, NULL, NULL),
(45, 1, 45, 0.7000, 0.9189, 0.8527, 0.9091, 0.7520, 0.7308, 0.6610, 0.7596, 0.6522, 0.6453, 0.4536, 0.5602, 0.9407, 0.5256, 0.7877, 0.8374, 0.7660, 0.8310, 0.7500, 0.0000, 0.7500, 1.0000, 0.0000, 0.7000, 0.6364, NULL, NULL),
(46, 1, 46, 0.6000, 0.9279, 0.6202, 0.7727, 0.6080, 0.8692, 0.7458, 0.7212, 0.7217, 0.6453, 0.4536, 0.5602, 0.9153, 0.5256, 0.7329, 0.7398, 0.3191, 0.8028, 0.5000, 0.0000, 0.2500, 0.5000, 0.0000, 0.3000, 0.3636, NULL, NULL),
(47, 1, 47, 0.9300, 1.0000, 0.9302, 0.9091, 0.9200, 0.9615, 0.8729, 0.8558, 0.7826, 0.6453, 0.4536, 0.5602, 0.9322, 0.5256, 1.0000, 1.0000, 1.0000, 1.0000, 0.7500, 0.0000, 0.7500, 1.0000, 0.2500, 0.7000, 0.8182, NULL, NULL),
(48, 1, 48, 0.7000, 0.9910, 0.7984, 0.6818, 0.9120, 0.6692, 0.6525, 0.6731, 0.6957, 0.6453, 0.4536, 0.5602, 0.7712, 0.5256, 0.7192, 0.8374, 0.6596, 0.7887, 0.5000, 0.0000, 0.6250, 0.7500, 0.2500, 0.3000, 0.2727, NULL, NULL),
(49, 1, 49, 0.6000, 0.9009, 0.7984, 0.6818, 0.5760, 0.6923, 0.6102, 0.5769, 0.6522, 0.6453, 0.4536, 0.5602, 0.6102, 0.5256, 0.7397, 0.7886, 0.4894, 0.6761, 0.2500, 0.0000, 1.0000, 0.2500, 0.5000, 0.5000, 0.3636, NULL, NULL),
(50, 1, 50, 0.4500, 0.9009, 0.7984, 0.7273, 0.4480, 0.6923, 0.6610, 0.5769, 0.6522, 0.6453, 0.4536, 0.5602, 0.9153, 0.5256, 0.4178, 0.7967, 0.2766, 0.8592, 0.2500, 0.0000, 0.7500, 0.0000, 0.0000, 0.1000, 0.0909, NULL, NULL),
(51, 1, 51, 0.9000, 0.9550, 1.0000, 0.8182, 0.5280, 0.9538, 0.7797, 0.7692, 0.8261, 0.6453, 0.4536, 0.5602, 0.7881, 0.5256, 0.9315, 0.8699, 1.0000, 0.8592, 0.5000, 0.0000, 0.6250, 0.5000, 0.2500, 0.3000, 0.3636, NULL, NULL),
(52, 1, 52, 0.3500, 0.8829, 0.7752, 0.7727, 0.5600, 0.6923, 0.6102, 0.7212, 0.6348, 0.2458, 0.1953, 0.2742, 0.7593, 0.3667, 0.5963, 0.6185, 0.5696, 0.6479, 0.7500, 1.0000, 0.7500, 0.7500, 0.0000, 0.9000, 0.9091, NULL, NULL),
(53, 1, 53, 0.5800, 0.8378, 0.8372, 0.8636, 0.7200, 0.5231, 0.6356, 0.7596, 0.7391, 0.6356, 0.3125, 0.6048, 0.7593, 0.5667, 0.5963, 0.6185, 0.5696, 0.6479, 0.5000, 0.0000, 0.8750, 0.0000, 0.2500, 0.9000, 0.3636, NULL, NULL),
(54, 1, 54, 0.6000, 0.8108, 0.8760, 0.8636, 0.6640, 0.6769, 0.6356, 0.7596, 0.4609, 0.5339, 0.3672, 0.3306, 0.7593, 0.6444, 0.5963, 0.6185, 0.5696, 0.7887, 0.5000, 0.0000, 0.3750, 0.5000, 0.0000, 0.6000, 1.0000, NULL, NULL),
(55, 1, 55, 0.8000, 0.7207, 0.8217, 0.7727, 0.6800, 0.9923, 0.7797, 0.8558, 0.8261, 0.9068, 0.4844, 0.7339, 0.7593, 0.7778, 0.5963, 0.6185, 0.5696, 0.6479, 1.0000, 0.0000, 0.5000, 0.0000, 0.2500, 0.6000, 0.1818, NULL, NULL),
(56, 1, 56, 0.7800, 0.7027, 0.8527, 0.8364, 0.5600, 0.6231, 0.8644, 0.7212, 0.8261, 0.8051, 0.3828, 0.4194, 0.7593, 0.4111, 0.5963, 0.6185, 0.5696, 0.8732, 0.5000, 0.0000, 0.7500, 0.7500, 0.2500, 0.1000, 0.0909, NULL, NULL),
(57, 1, 57, 0.8000, 0.9009, 0.6977, 1.0000, 0.7040, 1.0000, 0.7458, 0.8558, 0.8696, 0.8136, 0.3984, 1.0000, 0.7593, 0.7222, 0.5963, 0.6185, 0.5696, 0.7183, 1.0000, 0.0000, 0.3750, 0.0000, 0.2500, 0.6000, 0.9091, NULL, NULL),
(58, 1, 58, 0.5000, 0.0000, 0.7287, 0.7273, 0.7680, 0.5154, 0.3983, 0.6731, 0.8261, 0.3475, 0.2891, 0.1129, 0.7593, 0.6444, 0.5963, 0.6185, 0.5696, 0.7324, 0.2500, 0.0000, 0.6250, 0.2500, 0.0000, 0.3000, 0.3636, NULL, NULL),
(59, 1, 59, 0.5500, 0.2973, 0.6977, 0.7273, 0.8000, 0.5462, 0.4831, 0.6731, 0.7826, 0.3136, 0.1250, 0.3145, 0.7593, 0.7333, 0.5963, 0.6185, 0.5696, 0.8451, 0.2500, 0.0000, 0.1250, 0.5000, 0.0000, 0.8000, 0.3636, NULL, NULL),
(60, 1, 60, 0.5500, 0.9009, 0.8062, 0.7273, 0.6080, 0.6000, 0.9153, 0.7212, 0.7391, 0.2542, 0.2188, 0.4355, 0.7593, 0.2333, 0.5963, 0.6185, 0.5696, 0.6479, 0.2500, 0.0000, 0.7500, 0.5000, 0.0000, 0.1000, 0.2727, NULL, NULL),
(61, 1, 61, 0.4000, 0.3153, 0.5349, 0.7273, 0.5680, 0.3000, 0.5339, 0.7212, 0.6087, 0.4068, 0.3438, 0.5323, 0.7593, 0.3889, 0.5963, 0.6185, 0.5696, 0.4366, 0.2500, 0.0000, 0.5000, 0.0000, 0.0000, 0.6000, 0.1818, NULL, NULL),
(62, 1, 62, 0.5500, 0.4955, 0.6589, 0.8182, 0.9120, 0.7462, 0.5678, 0.8077, 0.6087, 0.8051, 0.2969, 0.7984, 0.7593, 0.8667, 0.5963, 0.6185, 0.5696, 0.9014, 1.0000, 0.0000, 0.3750, 0.0000, 0.0000, 1.0000, 0.5455, NULL, NULL),
(63, 1, 63, 0.8000, 0.6937, 0.8915, 0.8636, 0.8480, 0.7538, 0.8305, 0.9038, 0.9130, 0.8644, 0.6641, 0.7500, 0.7593, 0.7222, 0.5963, 0.6185, 0.5696, 1.0000, 0.2500, 0.0000, 0.6250, 0.0000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(64, 1, 64, 0.4500, 0.6036, 0.5039, 0.6364, 0.3680, 0.6231, 0.3390, 0.7115, 0.7391, 0.5085, 0.0000, 0.4355, 0.7593, 0.0667, 0.5963, 0.6185, 0.5696, 0.3803, 0.2500, 0.6000, 0.5000, 0.0000, 0.0000, 0.2000, 0.2727, NULL, NULL),
(65, 1, 65, 0.7500, 0.9459, 0.7364, 0.7727, 0.6800, 0.7000, 0.7034, 0.7692, 0.9130, 0.8559, 0.6953, 0.5565, 0.7593, 0.2333, 0.5963, 0.6185, 0.5696, 0.8592, 0.2500, 0.6000, 0.5000, 0.7500, 0.0000, 0.2000, 0.1818, NULL, NULL),
(66, 1, 66, 0.4500, 0.7207, 0.8062, 0.4545, 0.6080, 0.7000, 0.7881, 0.7212, 0.6348, 0.3051, 0.1875, 0.5645, 0.7593, 0.0889, 0.5963, 0.6185, 0.5696, 0.4648, 0.2500, 0.0000, 1.0000, 0.5000, 0.0000, 0.4000, 0.3636, NULL, NULL),
(67, 1, 67, 0.9000, 0.7928, 0.7752, 0.8636, 0.7600, 0.9000, 0.9576, 0.8077, 0.9565, 0.9746, 0.7578, 0.8790, 0.7593, 0.3333, 0.5963, 0.6185, 0.5696, 0.7887, 0.2500, 0.6000, 0.5000, 0.2500, 0.0000, 0.2000, 0.0909, NULL, NULL),
(68, 1, 68, 0.0500, 0.5225, 0.5039, 0.6818, 0.4400, 0.2308, 0.6780, 0.4327, 0.7217, 0.3051, 0.1953, 0.1048, 0.7593, 0.0000, 0.5963, 0.6185, 0.5696, 0.3521, 0.2500, 0.0000, 0.5000, 0.5000, 0.0000, 0.6000, 0.2727, NULL, NULL),
(69, 1, 69, 0.8800, 0.6757, 0.7752, 0.4091, 0.9280, 0.6385, 0.6186, 0.6731, 0.6522, 0.8051, 0.2891, 0.5081, 0.7593, 0.6444, 0.5963, 0.6185, 0.5696, 0.5493, 0.7500, 0.0000, 1.0000, 0.0000, 0.5000, 0.4000, 0.4545, NULL, NULL),
(70, 1, 70, 0.7300, 0.6577, 0.7752, 0.6818, 0.8400, 0.6923, 0.7881, 0.6731, 0.8696, 0.6186, 0.2656, 0.6048, 0.7593, 0.4556, 0.5963, 0.6185, 0.5696, 0.6479, 0.5000, 0.4000, 0.2500, 0.7500, 0.0000, 0.4000, 0.4545, NULL, NULL),
(71, 1, 71, 0.6500, 0.4505, 0.6202, 0.6364, 0.8080, 0.5923, 0.3051, 0.8654, 0.2609, 0.8051, 0.6562, 0.5242, 0.7593, 0.7000, 0.5963, 0.6185, 0.5696, 0.3662, 1.0000, 0.0000, 0.3750, 0.0000, 1.0000, 0.6000, 0.5455, NULL, NULL),
(72, 1, 72, 0.7500, 0.8559, 0.9690, 0.7273, 1.0000, 0.6692, 0.6525, 0.7212, 0.9130, 0.7542, 0.3750, 0.6613, 0.7593, 0.9556, 0.5963, 0.6185, 0.5696, 0.8873, 0.5000, 0.0000, 0.6250, 0.5000, 0.2500, 0.3000, 0.2727, NULL, NULL),
(73, 1, 73, 0.7500, 0.7838, 0.6977, 0.5000, 0.9440, 0.7462, 0.7034, 0.7212, 0.8261, 0.7797, 0.6484, 0.8065, 0.7593, 0.6778, 0.5963, 0.6185, 0.5696, 0.7606, 0.5000, 0.0000, 0.8750, 0.0000, 0.2500, 0.7000, 0.8182, NULL, NULL),
(74, 1, 74, 0.3200, 0.5225, 0.8760, 0.7273, 0.9280, 0.3385, 0.6780, 0.7692, 1.0000, 0.7288, 0.2969, 0.7177, 0.7593, 0.8444, 0.5963, 0.6185, 0.5696, 0.7042, 0.7500, 0.0000, 0.7500, 0.0000, 0.2500, 1.0000, 0.6364, NULL, NULL),
(75, 1, 75, 0.5500, 0.5856, 0.7829, 0.6818, 0.5680, 0.6923, 0.9661, 0.7692, 0.5652, 0.5932, 0.4531, 0.6774, 0.7593, 0.4000, 0.5963, 0.6185, 0.5696, 0.9014, 0.2500, 0.6000, 0.5000, 0.5000, 0.0000, 0.3000, 0.1818, NULL, NULL),
(76, 1, 76, 0.5800, 0.8559, 0.6667, 0.7273, 0.6400, 0.8615, 0.6949, 0.7212, 0.6087, 0.6356, 0.6172, 0.6774, 0.7593, 0.3444, 0.5963, 0.6185, 0.5696, 0.8028, 0.2500, 0.6000, 0.5000, 0.0000, 0.0000, 0.2000, 0.1818, NULL, NULL),
(77, 1, 77, 0.8000, 0.8649, 0.7054, 0.7273, 0.8320, 0.5000, 0.3729, 0.3846, 0.7391, 0.7797, 0.9141, 0.7097, 0.7593, 0.8111, 0.5963, 0.6185, 0.5696, 0.8732, 0.5000, 0.0000, 0.6250, 0.5000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(78, 1, 78, 0.8000, 0.7207, 0.7364, 0.7273, 0.4320, 0.7692, 0.7966, 0.8077, 0.6087, 0.5847, 0.4536, 0.5602, 0.8136, 0.5256, 0.6233, 0.4553, 0.6277, 0.6923, 0.5000, 0.0000, 0.2500, 0.5000, 0.7500, 0.4000, 0.4545, NULL, NULL),
(79, 1, 79, 0.1500, 0.6577, 0.6977, 0.6818, 0.5200, 0.1846, 0.6102, 0.8077, 0.5913, 0.5424, 0.4536, 0.5602, 0.8051, 0.5256, 0.5616, 0.1545, 0.4255, 0.6923, 0.2500, 0.0000, 0.5000, 0.5000, 0.0000, 0.6000, 0.1818, NULL, NULL),
(80, 1, 80, 0.7500, 0.7658, 0.8062, 0.8636, 0.6800, 0.5538, 0.6525, 0.8173, 0.8261, 0.7966, 0.4536, 0.5602, 0.7797, 0.5256, 0.6849, 0.7561, 0.9043, 0.6923, 0.5000, 0.0000, 0.3750, 0.0000, 0.0000, 0.8000, 0.5455, NULL, NULL),
(81, 1, 81, 0.8000, 0.9640, 0.6977, 0.9545, 0.8000, 0.8385, 0.6525, 0.4808, 0.7391, 0.8475, 0.4536, 0.5602, 0.6780, 0.5256, 0.6644, 0.8537, 0.8830, 0.6923, 0.5000, 0.0000, 0.8750, 0.7500, 0.2500, 0.9000, 0.6364, NULL, NULL),
(82, 1, 82, 0.5500, 0.6306, 0.7364, 0.6818, 0.6880, 0.5462, 0.5932, 0.8077, 0.7391, 0.6610, 0.4536, 0.5602, 0.6441, 0.5256, 0.5890, 0.8780, 0.5638, 0.6923, 0.7500, 0.0000, 0.6250, 0.7500, 0.0000, 0.3000, 0.2727, NULL, NULL),
(83, 1, 83, 0.2500, 0.6937, 0.6589, 0.8182, 0.8320, 0.6000, 0.3983, 0.4327, 0.5652, 0.6525, 0.4536, 0.5602, 0.6780, 0.5256, 0.3082, 0.5285, 0.1383, 0.6923, 1.0000, 0.0000, 0.3750, 0.0000, 0.0000, 0.6000, 0.9091, NULL, NULL),
(84, 1, 84, 0.5000, 0.2252, 0.6202, 0.7727, 0.8880, 0.0077, 0.4746, 0.4808, 0.5652, 0.6610, 0.4536, 0.5602, 0.5593, 0.5256, 0.5342, 0.3984, 0.4043, 0.6923, 0.7500, 0.0000, 0.5000, 1.0000, 0.0000, 0.6000, 0.6364, NULL, NULL),
(85, 1, 85, 0.0000, 0.2883, 0.3798, 0.6818, 0.2720, 0.0000, 0.6780, 0.5288, 0.4348, 0.3898, 0.4536, 0.5602, 0.4492, 0.5256, 0.0959, 0.0406, 0.0106, 0.6923, 0.2500, 0.0000, 0.7500, 0.0000, 0.0000, 0.1000, 0.0909, NULL, NULL),
(86, 1, 86, 0.2500, 0.4955, 0.3798, 0.0000, 0.3920, 0.4385, 0.5254, 0.5288, 0.4609, 0.0000, 0.4536, 0.5602, 0.8644, 0.5256, 0.1986, 0.4146, 0.3830, 0.6923, 0.5000, 0.0000, 0.7500, 0.0000, 0.2500, 0.7000, 0.0909, NULL, NULL),
(87, 1, 87, 0.0000, 0.4054, 0.6124, 0.8182, 0.3920, 0.2154, 0.8644, 0.5769, 0.3739, 0.4661, 0.4536, 0.5602, 0.7797, 0.5256, 0.5000, 0.3740, 0.1596, 0.6923, 0.2500, 0.0000, 0.6250, 0.0000, 0.0000, 0.2000, 0.7273, NULL, NULL),
(88, 1, 88, 0.6500, 0.5586, 0.6589, 0.8182, 0.6240, 0.6000, 0.7797, 0.7212, 0.5217, 0.6949, 0.4536, 0.5602, 0.7966, 0.5256, 0.5548, 0.4146, 0.7234, 0.6923, 0.2500, 0.0000, 0.5000, 0.2500, 0.0000, 0.2000, 0.1818, NULL, NULL),
(89, 1, 89, 0.4500, 0.4775, 0.7364, 0.9091, 0.5680, 0.7077, 0.7966, 0.8558, 0.6348, 0.4746, 0.4536, 0.5602, 0.7203, 0.5256, 0.7192, 0.7154, 0.5957, 0.6923, 0.2500, 0.0000, 0.5000, 0.0000, 0.0000, 0.6000, 0.1818, NULL, NULL),
(90, 1, 90, 0.5000, 0.4054, 0.7752, 0.8182, 0.7600, 0.8769, 0.6525, 0.8558, 0.3739, 0.5424, 0.4536, 0.5602, 0.6186, 0.5256, 0.8014, 0.7073, 0.7553, 0.6923, 0.2500, 0.0000, 0.7500, 0.5000, 0.0000, 0.1000, 0.3636, NULL, NULL),
(91, 1, 91, 0.5000, 0.7207, 0.6899, 0.8182, 0.5680, 0.6000, 0.6610, 0.5769, 0.7391, 0.3898, 0.4536, 0.5602, 0.8475, 0.5256, 0.6986, 0.5285, 0.6383, 0.6923, 0.2500, 0.0000, 1.0000, 0.7500, 0.0000, 0.4000, 0.3636, NULL, NULL),
(92, 1, 92, 0.1500, 0.2072, 0.1550, 0.5909, 0.0800, 0.4538, 0.6441, 0.6250, 0.1739, 0.3220, 0.4536, 0.5602, 0.7203, 0.5256, 0.3356, 0.4634, 0.3723, 0.6923, 0.7500, 0.0000, 0.6250, 0.7500, 0.0000, 0.3000, 0.2727, NULL, NULL),
(93, 1, 93, 0.4500, 0.5225, 0.9225, 0.9091, 0.4800, 0.6846, 0.6441, 0.6731, 0.6783, 0.6695, 0.4536, 0.5602, 0.8814, 0.5256, 0.5685, 0.6911, 0.3723, 0.6923, 0.7500, 0.0000, 1.0000, 0.7500, 0.5000, 0.4000, 0.4545, NULL, NULL),
(94, 1, 94, 0.3500, 0.4324, 0.4574, 0.6364, 0.0000, 0.5385, 0.6949, 0.5769, 0.5478, 0.4153, 0.4536, 0.5602, 0.5763, 0.5256, 0.5411, 0.4472, 0.5000, 0.6923, 0.2500, 0.0000, 0.5000, 0.0000, 0.0000, 0.2000, 0.5455, NULL, NULL),
(95, 1, 95, 0.1500, 0.5405, 0.4806, 0.5455, 0.0480, 0.3385, 0.7458, 0.7115, 0.5217, 0.3559, 0.4536, 0.5602, 0.6610, 0.5256, 0.2671, 0.5041, 0.3404, 0.6923, 0.2500, 0.0000, 0.1250, 0.5000, 0.0000, 0.8000, 0.4545, NULL, NULL),
(96, 1, 96, 0.5000, 0.7207, 0.8915, 0.8182, 0.1120, 0.6923, 0.6102, 0.6731, 0.6087, 0.8390, 0.4536, 0.5602, 0.7627, 0.5256, 0.5685, 0.6504, 0.5957, 0.6923, 0.2500, 0.0000, 0.1250, 0.2500, 0.0000, 0.8000, 0.7273, NULL, NULL),
(97, 1, 97, 0.5500, 0.6757, 0.5426, 0.9545, 0.7280, 0.4385, 0.6949, 0.5769, 0.6087, 0.8390, 0.4536, 0.5602, 0.6949, 0.5256, 0.7534, 0.8618, 0.8617, 0.6923, 0.7500, 0.0000, 0.5000, 0.7500, 0.5000, 0.5000, 0.3636, NULL, NULL),
(98, 1, 98, 0.6000, 0.4505, 0.4264, 0.4545, 0.7280, 0.3462, 0.3559, 0.6635, 0.5217, 0.5085, 0.4536, 0.5602, 0.7119, 0.5256, 0.5890, 0.3333, 0.4894, 0.6923, 0.5000, 0.0000, 0.6250, 0.0000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(99, 1, 99, 0.5500, 0.7477, 0.4884, 0.6818, 0.7840, 0.5000, 0.5339, 0.5288, 0.5217, 0.4153, 0.4536, 0.5602, 0.8729, 0.5256, 0.3562, 0.2683, 0.7553, 0.6923, 0.5000, 0.0000, 1.0000, 0.7500, 0.2500, 0.4000, 0.4545, NULL, NULL),
(100, 1, 100, 0.6500, 0.7748, 0.7752, 0.6818, 0.4320, 0.5154, 0.7458, 0.5769, 0.3913, 0.6780, 0.4536, 0.5602, 0.7542, 0.5256, 0.7055, 0.6341, 0.7979, 0.6923, 0.2500, 0.0000, 0.1250, 0.2500, 0.0000, 0.8000, 0.7273, NULL, NULL),
(101, 1, 101, 0.7000, 0.8559, 0.6977, 0.8636, 0.7840, 0.7538, 0.6017, 0.7115, 0.8696, 0.7288, 0.4536, 0.5602, 0.9153, 0.5256, 0.7534, 0.8943, 0.8830, 0.6923, 0.5000, 0.0000, 0.8750, 0.0000, 0.2500, 0.9000, 0.6364, NULL, NULL),
(102, 1, 102, 0.6000, 0.8108, 0.8140, 0.8636, 0.8240, 0.8000, 0.6525, 0.6731, 0.7826, 0.6356, 0.4536, 0.5602, 0.9237, 0.5256, 0.7671, 0.7805, 0.8298, 0.6923, 1.0000, 0.0000, 1.0000, 0.5000, 0.0000, 0.4000, 0.3636, NULL, NULL),
(103, 1, 103, 0.0400, 0.0270, 0.0000, 0.0000, 0.8080, 0.0769, 0.1525, 0.0000, 0.0000, 0.2034, 0.4536, 0.5602, 0.0000, 0.5256, 0.0959, 0.0000, 0.3511, 0.6923, 0.5000, 0.0000, 0.6250, 0.0000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(104, 1, 104, 0.7500, 0.5405, 0.6202, 0.6818, 0.7280, 0.5923, 0.4068, 0.5769, 0.5652, 0.6441, 0.4536, 0.5602, 0.7966, 0.5256, 0.5890, 0.5285, 0.9255, 0.6923, 1.0000, 0.0000, 0.3750, 0.5000, 0.2500, 1.0000, 0.5455, NULL, NULL),
(105, 1, 105, 0.8000, 0.8739, 0.8140, 0.7273, 0.7680, 0.6769, 0.6610, 0.6250, 0.7826, 0.7203, 0.4536, 0.5602, 0.9237, 0.5256, 0.8288, 0.8537, 0.9255, 0.6923, 0.2500, 0.0000, 0.6250, 0.2500, 0.5000, 0.4000, 0.2727, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `siswa`
--

CREATE TABLE `siswa` (
  `id` bigint NOT NULL,
  `nis` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_kelamin` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`id`, `nis`, `nama`, `jenis_kelamin`, `created_at`, `updated_at`) VALUES
(1, '4277', 'Agit Prasetya', 'L', '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(2, '4278', 'Akmal Fatur Rohman', 'L', '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(3, '4336', 'Bilal Fanansyah', 'L', '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(4, '4250', 'Damar Aryo Seto', 'L', '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(5, '4283', 'Fairuz Azizah', 'P', '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(6, '4255', 'Fanda Enggelina Ragesti Sihobing', 'P', '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(7, '4311', 'Firman Maulana Subagia', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(8, '4287', 'Hifran Narezh Fath Islamsyah', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(9, '4258', 'Iqbal Ramadhan', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(10, '4314', 'Kareena Ayudya Maheswari', 'P', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(11, '4316', 'Melva Nazwa Al Mahri', 'P', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(12, '4290', 'Meylianda Zabina Putri', 'P', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(13, '4345', 'Mohammad Iqbal Khalid Herwindo', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(14, '4291', 'Muhamad Rezka Nurdiansyah', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(15, '4292', 'Muhammad Nurul Akram Baadilla', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(16, '4293', 'Nahdil Umam', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(17, '4321', 'Nandyra Ramdhanfahrani P', 'P', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(18, '4295', 'Panca Nuari Saputra', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(19, '4270', 'Rafika Nurulaini', 'P', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(20, '4351', 'Rauza Alfarizzi', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(21, '4297', 'Rayzan Satya Nugroho', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(22, '4326', 'Rifqi Apriliano Putrawan', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(23, '4358', 'Viko Arfiansyah', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(24, '4332', 'Zefanya Ezra Saragih', 'P', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(25, '4280', 'Amanda Azmi', 'P', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(26, '4305', 'Aqilah Ross Hatammi', 'P', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(27, '4309', 'Danendra Rasya Kairu Pratama', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(28, '4254', 'Fadhil Amru Rajendro', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(29, '4284', 'Fajar Febriyansah', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(30, '4340', 'Farah Aulia', 'P', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(31, '4341', 'Galih Cahya Saputra', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(32, '4312', 'Hafiz Devano Pramadwika', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(33, '4313', 'Kaisar Ramadhan', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(34, '4342', 'Kayla Navi Eka Handaya', 'P', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(35, '4289', 'Khalisah Putriabiyyah', 'P', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(36, '4317', 'Muhamad Adrian Maulana', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(37, '4346', 'Muhamad Faris Al Zahir', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(38, '4319', 'Muhammad Daffa Izaz Binya Nuddin', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(39, '4320', 'Muhammad Fariel Febrianto Rabbani', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(40, '4261', 'Muhammad Farrel Fahrezi', 'L', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(41, '4360', 'Nadjwa Laura Adinda', 'P', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(42, '4323', 'Ok Vita Ramadhini', 'P', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(43, '4269', 'Qaisha Fitria Sabilla', 'P', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(44, '4350', 'Queen Tania Kartika', 'P', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(45, '4296', 'Rahima Rachelya Rifeko', 'P', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(46, '4325', 'Raid Fakhri Ramadhan', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(47, '4327', 'Sarah Dewi Wulandari', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(48, '4354', 'Syaqila Nur Ibtitsah', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(49, '4356', 'Tessa Amalia Zahra', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(50, '4330', 'Thoriq Abizar Ghassani', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(51, '4331', 'Yulistia Dwi Grahita', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(52, '4303', 'Abyadh Fathir Tajkah', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(53, '4249', 'Anisa Rachmani Setiaman', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(54, '4307', 'Avrilla Chelsea Rahman', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(55, '4337', 'Chesy Febrika Amaliyah', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(56, '4251', 'Daniel Maruli Tamba', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(57, '4339', 'Dea Natalia', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(58, '4359', 'Dinda Ayu Septiana', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(59, '4281', 'Eka Liviana', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(60, '4253', 'Eric Prasetya Nadi', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(61, '4259', 'Jafar Rama Rajendra', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(62, '4343', 'Maulida Apriliani', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(63, '4347', 'Muhammad Alif Faqih Zaeni', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(64, '4348', 'Muhammad Biky Niadi', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(65, '4263', 'Muhammad Nesta', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(66, '4265', 'Najwan Nur Ramadhan', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(67, '4266', 'Naufal Ahnaf Zahid Efendi', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(68, '4268', 'Philbert Chasdiel Matthew Havelar Parengkuan', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(69, '4324', 'Putri Adelia', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(70, '4458', 'Putri Rizkika Ramadhani Mulia', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(71, '4271', 'Sherina Ramadani Pulungan', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(72, '4272', 'Sri Ulina', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(73, '4355', 'Syarafina Agustin', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(74, '4274', 'Theresia Vidolia Tamalonggehe Runtulalo', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(75, '4275', 'Wildan Ihsan Wahyudi', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(76, '4276', 'Yusuf Fatih Maulana', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(77, '4302', 'Zunita Cheri Anjani', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(78, '4333', 'Ahmad Shan Nejaf', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(79, '4334', 'Alief Hizbullah', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(80, '4335', 'Alin Rhama Putri', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(81, '4279', 'Amalia Alfie Hasiana', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(82, '4362', 'Amanda Callista Aurelia', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(83, '4306', 'Aulia Neysyabilla', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(84, '4338', 'Cinta Cahaya Putri Wahyudi', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(85, '4308', 'Danendra Ramadito Athallah', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(86, '4282', 'Ezra Ramadhani Adduhayah', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(87, '4310', 'Farhad Jalal', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(88, '4286', 'Fathin Hamamah', 'P', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(89, '4256', 'Ibrahim Satrio Musyafa', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(90, '4315', 'Lyric Adwa Licky Pranata', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(91, '4344', 'Mohammad Darren Dzulhannan', 'L', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(92, '4260', 'Muhammad Aqmal Agustian', 'L', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(93, '4318', 'Muhammad Azriel', 'L', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(94, '4262', 'Muhammad Firdaus', 'L', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(95, '4461', 'Muhammad Rafii Al Asytar', 'L', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(96, '4349', 'Muhammad Yazid Rifa\'I', 'L', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(97, '4264', 'Nadya Kamila Azzahra', 'P', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(98, '4322', 'Naysilla Nazwa Aulia', 'P', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(99, '4352', 'Salwa Nurafia Azzahra', 'P', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(100, '4298', 'Sandy Setiawan', 'L', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(101, '4328', 'Shalsha Prameswari', 'P', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(102, '4329', 'Siti Desta Nurwahyuni', 'P', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(103, '4300', 'Syifa Aryanih', 'P', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(104, '4273', 'Syifa Azahra', 'P', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(105, '4301', 'Zahra Putri Noperian', 'P', '2026-11-02 21:04:02', '2026-11-02 21:04:02');

-- --------------------------------------------------------

--
-- Table structure for table `siswa_periode`
--

CREATE TABLE `siswa_periode` (
  `id` bigint NOT NULL,
  `siswa_id` bigint NOT NULL,
  `periode_id` bigint NOT NULL,
  `kelas` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `siswa_periode`
--

INSERT INTO `siswa_periode` (`id`, `siswa_id`, `periode_id`, `kelas`, `source_type`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'XII-1', 'excel_import', '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(2, 2, 1, 'XII-1', 'excel_import', '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(3, 3, 1, 'XII-1', 'excel_import', '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(4, 4, 1, 'XII-1', 'excel_import', '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(5, 5, 1, 'XII-1', 'excel_import', '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(6, 6, 1, 'XII-1', 'excel_import', '2026-11-02 21:03:59', '2026-11-02 21:03:59'),
(7, 7, 1, 'XII-1', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(8, 8, 1, 'XII-1', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(9, 9, 1, 'XII-1', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(10, 10, 1, 'XII-1', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(11, 11, 1, 'XII-1', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(12, 12, 1, 'XII-1', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(13, 13, 1, 'XII-1', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(14, 14, 1, 'XII-1', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(15, 15, 1, 'XII-1', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(16, 16, 1, 'XII-1', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(17, 17, 1, 'XII-1', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(18, 18, 1, 'XII-1', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(19, 19, 1, 'XII-1', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(20, 20, 1, 'XII-1', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(21, 21, 1, 'XII-1', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(22, 22, 1, 'XII-1', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(23, 23, 1, 'XII-1', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(24, 24, 1, 'XII-1', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(25, 25, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(26, 26, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(27, 27, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(28, 28, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(29, 29, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(30, 30, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(31, 31, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(32, 32, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(33, 33, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(34, 34, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(35, 35, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(36, 36, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(37, 37, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(38, 38, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(39, 39, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(40, 40, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(41, 41, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(42, 42, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(43, 43, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(44, 44, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(45, 45, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:00', '2026-11-02 21:04:00'),
(46, 46, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(47, 47, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(48, 48, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(49, 49, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(50, 50, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(51, 51, 1, 'XII-2', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(52, 52, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(53, 53, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(54, 54, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(55, 55, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(56, 56, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(57, 57, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(58, 58, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(59, 59, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(60, 60, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(61, 61, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(62, 62, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(63, 63, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(64, 64, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(65, 65, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(66, 66, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(67, 67, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(68, 68, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(69, 69, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(70, 70, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(71, 71, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(72, 72, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(73, 73, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(74, 74, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(75, 75, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(76, 76, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(77, 77, 1, 'XII-3', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(78, 78, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(79, 79, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(80, 80, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(81, 81, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(82, 82, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(83, 83, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(84, 84, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(85, 85, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(86, 86, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(87, 87, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(88, 88, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(89, 89, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(90, 90, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(91, 91, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:01', '2026-11-02 21:04:01'),
(92, 92, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(93, 93, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(94, 94, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(95, 95, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(96, 96, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(97, 97, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(98, 98, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(99, 99, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(100, 100, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(101, 101, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(102, 102, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(103, 103, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(104, 104, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:02', '2026-11-02 21:04:02'),
(105, 105, 1, 'XII-4', 'excel_import', '2026-11-02 21:04:02', '2026-11-02 21:04:02');

-- --------------------------------------------------------

--
-- Table structure for table `transformed_data`
--

CREATE TABLE `transformed_data` (
  `id` bigint NOT NULL,
  `preprocessing_run_id` bigint NOT NULL,
  `siswa_periode_id` bigint NOT NULL,
  `agama` decimal(8,4) DEFAULT NULL,
  `pkn` decimal(8,4) DEFAULT NULL,
  `b_indonesia` decimal(8,4) DEFAULT NULL,
  `b_inggris` decimal(8,4) DEFAULT NULL,
  `mtk_wajib` decimal(8,4) DEFAULT NULL,
  `sejarah` decimal(8,4) DEFAULT NULL,
  `pjok` decimal(8,4) DEFAULT NULL,
  `seni_rupa` decimal(8,4) DEFAULT NULL,
  `b_jepang` decimal(8,4) DEFAULT NULL,
  `biologi` decimal(8,4) DEFAULT NULL,
  `fisika` decimal(8,4) DEFAULT NULL,
  `kimia` decimal(8,4) DEFAULT NULL,
  `informatika` decimal(8,4) DEFAULT NULL,
  `mtk_lanjut` decimal(8,4) DEFAULT NULL,
  `geografi` decimal(8,4) DEFAULT NULL,
  `sosial` decimal(8,4) DEFAULT NULL,
  `pkwu` decimal(8,4) DEFAULT NULL,
  `ekonomi` decimal(8,4) DEFAULT NULL,
  `ekstrakurikuler` decimal(8,4) DEFAULT NULL,
  `prestasi` decimal(8,4) DEFAULT NULL,
  `kemampuan` decimal(8,4) DEFAULT NULL,
  `organisasi` decimal(8,4) DEFAULT NULL,
  `kursus` decimal(8,4) DEFAULT NULL,
  `jurusan_1` decimal(8,4) DEFAULT NULL,
  `jurusan_2` decimal(8,4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transformed_data`
--

INSERT INTO `transformed_data` (`id`, `preprocessing_run_id`, `siswa_periode_id`, `agama`, `pkn`, `b_indonesia`, `b_inggris`, `mtk_wajib`, `sejarah`, `pjok`, `seni_rupa`, `b_jepang`, `biologi`, `fisika`, `kimia`, `informatika`, `mtk_lanjut`, `geografi`, `sosial`, `pkwu`, `ekonomi`, `ekstrakurikuler`, `prestasi`, `kemampuan`, `organisasi`, `kursus`, `jurusan_1`, `jurusan_2`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1.0000, 1.0000, 0.9767, 0.7727, 0.8480, 0.9154, 0.9068, 0.9135, 0.6957, 1.0000, 1.0000, 0.7581, 0.8305, 0.6111, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.7500, 0.2500, 0.0000, 0.1000, 0.7273, NULL, NULL),
(2, 1, 2, 0.5000, 0.6577, 0.7907, 0.6818, 0.6000, 0.7692, 0.7373, 0.6731, 0.5043, 0.5424, 0.2734, 0.5484, 0.7542, 0.2889, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.1250, 0.5000, 0.0000, 0.3000, 0.7273, NULL, NULL),
(3, 1, 3, 0.7500, 0.8378, 0.8527, 0.8636, 0.7520, 0.7385, 0.9407, 0.6731, 0.7391, 0.9322, 0.5469, 0.7339, 0.8136, 0.3444, 0.5963, 0.6185, 0.5696, 0.6923, 0.5000, 0.0000, 0.2500, 0.7500, 0.2500, 0.4000, 0.4545, NULL, NULL),
(4, 1, 4, 0.3500, 0.5405, 0.6977, 0.6818, 0.6880, 0.9077, 0.5847, 0.2885, 0.0870, 0.5424, 0.6172, 0.0000, 0.6864, 0.3667, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.1250, 0.0000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(5, 1, 5, 0.8000, 0.9009, 0.8527, 0.6364, 0.7200, 0.9462, 0.8475, 0.8558, 0.6522, 0.9915, 0.6953, 0.7258, 0.8644, 0.5667, 0.5963, 0.6185, 0.5696, 0.6923, 0.5000, 0.0000, 0.6250, 0.5000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(6, 1, 6, 0.7500, 0.6306, 0.8527, 0.8636, 0.8560, 0.5231, 0.6949, 0.8558, 0.5217, 0.7966, 0.0703, 0.2984, 0.8644, 0.7333, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 1.0000, 0.7500, 0.5000, 0.5000, 0.3636, NULL, NULL),
(7, 1, 7, 0.5500, 0.4955, 0.7442, 0.5455, 0.6000, 0.2077, 0.6610, 0.3365, 0.6087, 0.4492, 0.4141, 0.2742, 0.6695, 0.3111, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.1250, 0.0000, 0.0000, 0.8000, 0.7273, NULL, NULL),
(8, 1, 8, 0.5300, 0.6757, 0.7364, 0.5909, 0.6080, 0.4231, 0.7797, 0.7692, 0.6957, 0.7458, 0.1953, 0.7177, 0.8220, 0.3444, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.7500, 0.5000, 0.0000, 0.1000, 0.0909, NULL, NULL),
(9, 1, 9, 0.9000, 0.8829, 1.0000, 0.8636, 0.9360, 0.9077, 0.8644, 0.9519, 0.9130, 0.9153, 0.7969, 0.9758, 0.8729, 0.5556, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.1250, 0.0000, 0.0000, 0.3000, 0.3636, NULL, NULL),
(10, 1, 10, 0.4500, 0.7477, 0.7674, 0.8636, 0.8240, 0.5538, 0.7797, 0.8173, 0.7826, 0.9746, 0.2812, 0.7097, 0.8390, 0.6667, 0.5963, 0.6185, 0.5696, 0.6923, 0.5000, 0.8000, 0.3750, 0.7500, 0.2500, 0.4000, 0.3636, NULL, NULL),
(11, 1, 11, 0.7500, 0.6757, 0.8062, 0.9091, 0.8480, 0.5923, 0.9237, 1.0000, 0.7391, 0.9153, 0.5234, 0.4758, 0.9322, 0.7000, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.3750, 0.2500, 0.2500, 1.0000, 0.5455, NULL, NULL),
(12, 1, 12, 0.6000, 0.7207, 0.7674, 0.7727, 0.9280, 0.6615, 0.7966, 0.9038, 0.6522, 0.5254, 0.3906, 0.4274, 0.9153, 0.8111, 0.5963, 0.6185, 0.5696, 0.6923, 1.0000, 0.0000, 0.5000, 0.0000, 0.2500, 0.6000, 0.2727, NULL, NULL),
(13, 1, 13, 0.8200, 0.6757, 1.0000, 0.8364, 0.7440, 0.7692, 0.9068, 0.8558, 0.3913, 0.7881, 0.5859, 0.4274, 0.7797, 0.5444, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.5000, 0.5000, 0.2500, 0.6000, 0.1818, NULL, NULL),
(14, 1, 14, 0.8500, 0.8108, 0.9302, 0.8636, 0.7120, 0.8077, 0.9915, 0.9519, 0.4783, 0.8644, 0.5625, 0.5000, 0.8644, 0.4000, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.7500, 0.5000, 0.0000, 0.1000, 0.3636, NULL, NULL),
(15, 1, 15, 0.9500, 0.7387, 0.9302, 0.9091, 0.5760, 0.8077, 0.4407, 0.9519, 0.6087, 0.8475, 0.9609, 0.7097, 0.8644, 0.4444, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.5000, 0.0000, 0.0000, 0.2000, 0.5455, NULL, NULL),
(16, 1, 16, 0.5500, 0.2973, 0.5271, 0.6364, 0.6240, 0.6692, 0.4407, 0.7596, 0.3913, 0.7034, 0.5625, 0.4194, 0.5254, 0.5333, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.6250, 0.2500, 0.0000, 0.3000, 0.2727, NULL, NULL),
(17, 1, 17, 0.2500, 0.4505, 0.6512, 0.8636, 0.9360, 0.5769, 0.6610, 0.6250, 0.2174, 0.6949, 0.1406, 0.0645, 0.8559, 1.0000, 0.5963, 0.6185, 0.5696, 0.6923, 0.7500, 0.0000, 0.7500, 0.7500, 0.2500, 0.7000, 0.1818, NULL, NULL),
(18, 1, 18, 0.8000, 0.7477, 0.9612, 0.7727, 0.6800, 0.6385, 1.0000, 0.9519, 0.5652, 0.7627, 0.5469, 0.6048, 0.8136, 0.3667, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.5000, 0.2500, 0.0000, 0.2000, 0.1818, NULL, NULL),
(19, 1, 19, 1.0000, 0.8198, 0.8140, 0.7727, 0.8720, 0.7077, 0.8983, 0.8558, 0.7826, 0.7797, 0.5000, 0.5484, 0.8390, 0.8667, 0.5963, 0.6185, 0.5696, 0.6923, 0.5000, 0.0000, 0.6250, 0.7500, 0.2500, 0.3000, 0.6364, NULL, NULL),
(20, 1, 20, 1.0000, 0.5856, 0.9302, 0.6364, 0.5920, 0.7692, 0.8220, 1.0000, 0.5652, 0.8051, 0.6328, 0.6290, 0.8220, 0.3444, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.5000, 0.0000, 0.0000, 0.6000, 0.9091, NULL, NULL),
(21, 1, 21, 0.8500, 0.7387, 0.9225, 0.7727, 0.4000, 0.7308, 0.8814, 0.9038, 0.4348, 0.5932, 0.4453, 0.4758, 0.8136, 0.1111, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.6250, 0.5000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(22, 1, 22, 0.9500, 0.9099, 0.9767, 0.8182, 0.8640, 0.6692, 0.9576, 0.9038, 0.6522, 1.0000, 0.7578, 0.7339, 0.8051, 0.6667, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.1250, 0.7500, 0.0000, 0.8000, 0.3636, NULL, NULL),
(23, 1, 23, 0.9000, 0.8559, 0.9767, 0.8636, 0.5520, 0.7923, 0.8814, 0.8654, 0.6957, 0.6949, 0.5156, 0.7661, 0.8644, 0.3111, 0.5963, 0.6185, 0.5696, 0.6923, 0.2500, 0.0000, 0.7500, 0.0000, 0.0000, 0.1000, 0.0909, NULL, NULL),
(24, 1, 24, 0.5500, 0.7928, 0.6977, 0.7273, 0.6960, 0.6308, 0.9068, 0.8654, 0.6957, 0.4068, 0.2344, 0.7500, 0.7881, 0.7556, 0.5963, 0.6185, 0.5696, 0.6923, 0.7500, 0.0000, 1.0000, 0.7500, 0.5000, 0.4000, 0.3636, NULL, NULL),
(25, 1, 25, 0.6500, 0.9279, 0.5116, 0.7273, 0.6400, 0.7077, 0.6525, 0.7692, 0.5217, 0.6453, 0.4536, 0.5602, 0.9407, 0.5256, 0.7329, 0.7724, 0.6915, 0.5352, 0.5000, 0.0000, 0.6250, 0.5000, 0.2500, 0.3000, 0.2727, NULL, NULL),
(26, 1, 26, 0.7300, 0.9189, 0.8140, 0.9091, 0.7440, 0.8462, 0.7712, 0.8077, 0.6522, 0.6453, 0.4536, 0.5602, 0.8475, 0.5256, 0.9658, 0.8374, 0.9468, 0.8873, 0.5000, 0.4000, 0.5000, 0.0000, 0.2500, 0.6000, 0.9091, NULL, NULL),
(27, 1, 27, 0.6000, 0.8108, 0.7054, 0.3636, 0.5280, 0.7538, 0.7119, 0.4808, 0.7826, 0.6453, 0.4536, 0.5602, 0.8729, 0.5256, 0.4041, 0.6179, 0.4362, 0.5775, 0.2500, 0.2000, 0.1250, 0.5000, 0.0000, 0.8000, 0.0909, NULL, NULL),
(28, 1, 28, 0.7800, 0.4324, 0.5426, 0.9091, 0.5920, 0.6077, 0.5763, 0.5288, 0.6522, 0.6453, 0.4536, 0.5602, 0.4746, 0.5256, 0.6027, 0.8943, 0.4787, 0.7746, 0.5000, 0.0000, 0.5000, 0.0000, 0.0000, 0.2000, 0.1818, NULL, NULL),
(29, 1, 29, 0.6500, 0.8559, 0.5504, 0.5455, 0.6400, 0.5385, 0.5424, 0.7212, 0.4783, 0.6453, 0.4536, 0.5602, 0.7034, 0.5256, 0.6712, 0.6748, 0.3298, 0.4930, 0.2500, 0.0000, 0.1250, 0.0000, 0.0000, 0.8000, 0.7273, NULL, NULL),
(30, 1, 30, 0.7500, 0.8829, 0.6589, 0.6818, 0.8080, 0.7462, 0.6949, 0.8558, 0.7391, 0.6453, 0.4536, 0.5602, 0.8136, 0.5256, 0.7329, 0.6585, 0.5957, 0.8310, 0.2500, 0.0000, 1.0000, 0.2500, 0.5000, 0.4000, 0.4545, NULL, NULL),
(31, 1, 31, 0.2000, 0.5856, 0.6124, 0.5000, 0.3280, 0.2615, 0.5339, 0.5288, 0.4783, 0.6453, 0.4536, 0.5602, 0.3644, 0.5256, 0.4521, 0.1707, 0.3830, 0.5070, 0.2500, 0.0000, 0.7500, 0.7500, 0.0000, 0.1000, 0.0909, NULL, NULL),
(32, 1, 32, 0.3500, 0.6757, 0.5426, 0.5909, 0.3600, 0.4538, 0.6017, 0.5288, 0.4348, 0.6453, 0.4536, 0.5602, 0.5339, 0.5256, 0.3014, 0.4553, 0.3723, 0.6479, 0.7500, 0.0000, 0.7500, 0.0000, 0.0000, 0.4000, 0.3636, NULL, NULL),
(33, 1, 33, 0.8500, 0.9459, 0.8140, 0.7727, 0.5920, 0.7538, 0.7458, 0.6250, 0.8696, 0.6453, 0.4536, 0.5602, 0.9153, 0.5256, 0.5959, 0.8943, 0.4894, 0.7887, 0.2500, 0.0000, 0.1250, 0.5000, 0.7500, 0.4000, 0.3636, NULL, NULL),
(34, 1, 34, 0.7500, 0.9009, 0.8140, 0.9545, 0.8960, 0.7846, 0.8814, 0.8077, 0.6957, 0.6453, 0.4536, 0.5602, 0.8475, 0.5256, 0.8973, 0.6585, 0.7553, 0.7465, 0.2500, 0.2000, 0.1250, 0.7500, 0.0000, 0.4000, 0.7273, NULL, NULL),
(35, 1, 35, 0.6500, 0.8559, 0.6512, 0.8182, 0.7360, 0.4923, 0.5169, 0.8558, 0.5652, 0.6453, 0.4536, 0.5602, 0.5085, 0.5256, 0.5411, 0.6911, 0.5957, 0.5634, 0.2500, 0.0000, 0.1250, 0.2500, 0.0000, 0.8000, 0.4545, NULL, NULL),
(36, 1, 36, 0.7500, 0.9730, 0.8140, 0.7727, 0.5600, 0.7923, 0.8729, 0.7212, 0.8696, 0.6453, 0.4536, 0.5602, 0.7203, 0.5256, 0.8014, 0.8293, 0.3191, 0.7887, 0.2500, 0.0000, 0.1250, 0.0000, 0.0000, 0.8000, 0.0909, NULL, NULL),
(37, 1, 37, 0.1000, 0.3423, 0.1860, 0.1364, 0.0320, 0.3615, 0.0000, 0.4327, 0.0261, 0.6453, 0.4536, 0.5602, 0.1780, 0.5256, 0.0000, 0.2439, 0.0000, 0.0000, 0.5000, 0.0000, 0.2500, 0.7500, 0.0000, 0.3000, 0.0909, NULL, NULL),
(38, 1, 38, 0.2500, 0.3153, 0.6124, 0.3636, 0.2320, 0.4154, 0.8220, 0.5288, 0.5913, 0.6453, 0.4536, 0.5602, 0.6017, 0.5256, 0.3219, 0.5285, 0.1596, 0.2113, 0.2500, 0.0000, 0.5000, 0.2500, 0.0000, 0.6000, 0.1818, NULL, NULL),
(39, 1, 39, 0.6000, 0.6577, 0.6977, 0.6818, 0.4320, 0.5462, 0.8220, 0.8558, 0.5913, 0.6453, 0.4536, 0.5602, 1.0000, 0.5256, 0.5959, 0.4959, 0.7234, 0.6479, 0.5000, 0.0000, 0.6250, 0.5000, 0.2500, 0.4000, 0.2727, NULL, NULL),
(40, 1, 40, 0.8000, 0.8559, 0.6977, 0.7727, 0.4320, 0.7308, 0.4576, 0.9038, 0.6087, 0.6453, 0.4536, 0.5602, 0.9407, 0.5256, 0.8014, 0.8211, 0.7660, 1.0000, 0.2500, 0.2000, 0.1250, 0.5000, 0.0000, 0.4000, 0.2727, NULL, NULL),
(41, 1, 41, 0.7500, 0.9009, 0.8915, 0.8182, 0.7840, 0.7077, 0.6610, 0.7212, 0.6957, 0.6453, 0.4536, 0.5602, 0.8305, 0.5256, 0.5959, 0.7805, 0.6915, 0.8451, 1.0000, 0.0000, 0.3750, 0.0000, 0.2500, 0.3000, 0.5455, NULL, NULL),
(42, 1, 42, 0.2000, 0.3153, 0.2713, 0.4545, 0.7280, 0.0692, 0.0932, 0.4327, 0.2174, 0.6453, 0.4536, 0.5602, 0.4915, 0.5256, 0.5342, 0.2683, 0.2660, 0.3662, 0.5000, 0.0000, 1.0000, 0.7500, 0.5000, 0.4000, 0.3636, NULL, NULL),
(43, 1, 43, 0.8500, 0.9459, 0.8372, 0.8636, 0.8160, 0.9538, 0.7373, 0.7692, 0.6522, 0.6453, 0.4536, 0.5602, 0.8644, 0.5256, 0.8630, 0.9431, 0.8511, 1.0000, 0.5000, 0.0000, 0.6250, 0.0000, 0.2500, 0.3000, 0.2727, NULL, NULL),
(44, 1, 44, 0.5000, 0.9009, 0.8837, 0.7273, 0.6000, 0.6615, 0.7881, 0.6250, 0.9130, 0.6453, 0.4536, 0.5602, 0.9322, 0.5256, 0.8014, 0.7805, 0.7553, 0.4366, 1.0000, 0.0000, 0.3750, 0.5000, 0.0000, 0.6000, 0.5455, NULL, NULL),
(45, 1, 45, 0.7000, 0.9189, 0.8527, 0.9091, 0.7520, 0.7308, 0.6610, 0.7596, 0.6522, 0.6453, 0.4536, 0.5602, 0.9407, 0.5256, 0.7877, 0.8374, 0.7660, 0.8310, 0.7500, 0.0000, 0.7500, 1.0000, 0.0000, 0.7000, 0.6364, NULL, NULL),
(46, 1, 46, 0.6000, 0.9279, 0.6202, 0.7727, 0.6080, 0.8692, 0.7458, 0.7212, 0.7217, 0.6453, 0.4536, 0.5602, 0.9153, 0.5256, 0.7329, 0.7398, 0.3191, 0.8028, 0.5000, 0.0000, 0.2500, 0.5000, 0.0000, 0.3000, 0.3636, NULL, NULL),
(47, 1, 47, 0.9300, 1.0000, 0.9302, 0.9091, 0.9200, 0.9615, 0.8729, 0.8558, 0.7826, 0.6453, 0.4536, 0.5602, 0.9322, 0.5256, 1.0000, 1.0000, 1.0000, 1.0000, 0.7500, 0.0000, 0.7500, 1.0000, 0.2500, 0.7000, 0.8182, NULL, NULL),
(48, 1, 48, 0.7000, 0.9910, 0.7984, 0.6818, 0.9120, 0.6692, 0.6525, 0.6731, 0.6957, 0.6453, 0.4536, 0.5602, 0.7712, 0.5256, 0.7192, 0.8374, 0.6596, 0.7887, 0.5000, 0.0000, 0.6250, 0.7500, 0.2500, 0.3000, 0.2727, NULL, NULL),
(49, 1, 49, 0.6000, 0.9009, 0.7984, 0.6818, 0.5760, 0.6923, 0.6102, 0.5769, 0.6522, 0.6453, 0.4536, 0.5602, 0.6102, 0.5256, 0.7397, 0.7886, 0.4894, 0.6761, 0.2500, 0.0000, 1.0000, 0.2500, 0.5000, 0.5000, 0.3636, NULL, NULL),
(50, 1, 50, 0.4500, 0.9009, 0.7984, 0.7273, 0.4480, 0.6923, 0.6610, 0.5769, 0.6522, 0.6453, 0.4536, 0.5602, 0.9153, 0.5256, 0.4178, 0.7967, 0.2766, 0.8592, 0.2500, 0.0000, 0.7500, 0.0000, 0.0000, 0.1000, 0.0909, NULL, NULL),
(51, 1, 51, 0.9000, 0.9550, 1.0000, 0.8182, 0.5280, 0.9538, 0.7797, 0.7692, 0.8261, 0.6453, 0.4536, 0.5602, 0.7881, 0.5256, 0.9315, 0.8699, 1.0000, 0.8592, 0.5000, 0.0000, 0.6250, 0.5000, 0.2500, 0.3000, 0.3636, NULL, NULL),
(52, 1, 52, 0.3500, 0.8829, 0.7752, 0.7727, 0.5600, 0.6923, 0.6102, 0.7212, 0.6348, 0.2458, 0.1953, 0.2742, 0.7593, 0.3667, 0.5963, 0.6185, 0.5696, 0.6479, 0.7500, 1.0000, 0.7500, 0.7500, 0.0000, 0.9000, 0.9091, NULL, NULL),
(53, 1, 53, 0.5800, 0.8378, 0.8372, 0.8636, 0.7200, 0.5231, 0.6356, 0.7596, 0.7391, 0.6356, 0.3125, 0.6048, 0.7593, 0.5667, 0.5963, 0.6185, 0.5696, 0.6479, 0.5000, 0.0000, 0.8750, 0.0000, 0.2500, 0.9000, 0.3636, NULL, NULL),
(54, 1, 54, 0.6000, 0.8108, 0.8760, 0.8636, 0.6640, 0.6769, 0.6356, 0.7596, 0.4609, 0.5339, 0.3672, 0.3306, 0.7593, 0.6444, 0.5963, 0.6185, 0.5696, 0.7887, 0.5000, 0.0000, 0.3750, 0.5000, 0.0000, 0.6000, 1.0000, NULL, NULL),
(55, 1, 55, 0.8000, 0.7207, 0.8217, 0.7727, 0.6800, 0.9923, 0.7797, 0.8558, 0.8261, 0.9068, 0.4844, 0.7339, 0.7593, 0.7778, 0.5963, 0.6185, 0.5696, 0.6479, 1.0000, 0.0000, 0.5000, 0.0000, 0.2500, 0.6000, 0.1818, NULL, NULL),
(56, 1, 56, 0.7800, 0.7027, 0.8527, 0.8364, 0.5600, 0.6231, 0.8644, 0.7212, 0.8261, 0.8051, 0.3828, 0.4194, 0.7593, 0.4111, 0.5963, 0.6185, 0.5696, 0.8732, 0.5000, 0.0000, 0.7500, 0.7500, 0.2500, 0.1000, 0.0909, NULL, NULL),
(57, 1, 57, 0.8000, 0.9009, 0.6977, 1.0000, 0.7040, 1.0000, 0.7458, 0.8558, 0.8696, 0.8136, 0.3984, 1.0000, 0.7593, 0.7222, 0.5963, 0.6185, 0.5696, 0.7183, 1.0000, 0.0000, 0.3750, 0.0000, 0.2500, 0.6000, 0.9091, NULL, NULL),
(58, 1, 58, 0.5000, 0.0000, 0.7287, 0.7273, 0.7680, 0.5154, 0.3983, 0.6731, 0.8261, 0.3475, 0.2891, 0.1129, 0.7593, 0.6444, 0.5963, 0.6185, 0.5696, 0.7324, 0.2500, 0.0000, 0.6250, 0.2500, 0.0000, 0.3000, 0.3636, NULL, NULL),
(59, 1, 59, 0.5500, 0.2973, 0.6977, 0.7273, 0.8000, 0.5462, 0.4831, 0.6731, 0.7826, 0.3136, 0.1250, 0.3145, 0.7593, 0.7333, 0.5963, 0.6185, 0.5696, 0.8451, 0.2500, 0.0000, 0.1250, 0.5000, 0.0000, 0.8000, 0.3636, NULL, NULL),
(60, 1, 60, 0.5500, 0.9009, 0.8062, 0.7273, 0.6080, 0.6000, 0.9153, 0.7212, 0.7391, 0.2542, 0.2188, 0.4355, 0.7593, 0.2333, 0.5963, 0.6185, 0.5696, 0.6479, 0.2500, 0.0000, 0.7500, 0.5000, 0.0000, 0.1000, 0.2727, NULL, NULL),
(61, 1, 61, 0.4000, 0.3153, 0.5349, 0.7273, 0.5680, 0.3000, 0.5339, 0.7212, 0.6087, 0.4068, 0.3438, 0.5323, 0.7593, 0.3889, 0.5963, 0.6185, 0.5696, 0.4366, 0.2500, 0.0000, 0.5000, 0.0000, 0.0000, 0.6000, 0.1818, NULL, NULL),
(62, 1, 62, 0.5500, 0.4955, 0.6589, 0.8182, 0.9120, 0.7462, 0.5678, 0.8077, 0.6087, 0.8051, 0.2969, 0.7984, 0.7593, 0.8667, 0.5963, 0.6185, 0.5696, 0.9014, 1.0000, 0.0000, 0.3750, 0.0000, 0.0000, 1.0000, 0.5455, NULL, NULL),
(63, 1, 63, 0.8000, 0.6937, 0.8915, 0.8636, 0.8480, 0.7538, 0.8305, 0.9038, 0.9130, 0.8644, 0.6641, 0.7500, 0.7593, 0.7222, 0.5963, 0.6185, 0.5696, 1.0000, 0.2500, 0.0000, 0.6250, 0.0000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(64, 1, 64, 0.4500, 0.6036, 0.5039, 0.6364, 0.3680, 0.6231, 0.3390, 0.7115, 0.7391, 0.5085, 0.0000, 0.4355, 0.7593, 0.0667, 0.5963, 0.6185, 0.5696, 0.3803, 0.2500, 0.6000, 0.5000, 0.0000, 0.0000, 0.2000, 0.2727, NULL, NULL),
(65, 1, 65, 0.7500, 0.9459, 0.7364, 0.7727, 0.6800, 0.7000, 0.7034, 0.7692, 0.9130, 0.8559, 0.6953, 0.5565, 0.7593, 0.2333, 0.5963, 0.6185, 0.5696, 0.8592, 0.2500, 0.6000, 0.5000, 0.7500, 0.0000, 0.2000, 0.1818, NULL, NULL),
(66, 1, 66, 0.4500, 0.7207, 0.8062, 0.4545, 0.6080, 0.7000, 0.7881, 0.7212, 0.6348, 0.3051, 0.1875, 0.5645, 0.7593, 0.0889, 0.5963, 0.6185, 0.5696, 0.4648, 0.2500, 0.0000, 1.0000, 0.5000, 0.0000, 0.4000, 0.3636, NULL, NULL),
(67, 1, 67, 0.9000, 0.7928, 0.7752, 0.8636, 0.7600, 0.9000, 0.9576, 0.8077, 0.9565, 0.9746, 0.7578, 0.8790, 0.7593, 0.3333, 0.5963, 0.6185, 0.5696, 0.7887, 0.2500, 0.6000, 0.5000, 0.2500, 0.0000, 0.2000, 0.0909, NULL, NULL),
(68, 1, 68, 0.0500, 0.5225, 0.5039, 0.6818, 0.4400, 0.2308, 0.6780, 0.4327, 0.7217, 0.3051, 0.1953, 0.1048, 0.7593, 0.0000, 0.5963, 0.6185, 0.5696, 0.3521, 0.2500, 0.0000, 0.5000, 0.5000, 0.0000, 0.6000, 0.2727, NULL, NULL),
(69, 1, 69, 0.8800, 0.6757, 0.7752, 0.4091, 0.9280, 0.6385, 0.6186, 0.6731, 0.6522, 0.8051, 0.2891, 0.5081, 0.7593, 0.6444, 0.5963, 0.6185, 0.5696, 0.5493, 0.7500, 0.0000, 1.0000, 0.0000, 0.5000, 0.4000, 0.4545, NULL, NULL),
(70, 1, 70, 0.7300, 0.6577, 0.7752, 0.6818, 0.8400, 0.6923, 0.7881, 0.6731, 0.8696, 0.6186, 0.2656, 0.6048, 0.7593, 0.4556, 0.5963, 0.6185, 0.5696, 0.6479, 0.5000, 0.4000, 0.2500, 0.7500, 0.0000, 0.4000, 0.4545, NULL, NULL),
(71, 1, 71, 0.6500, 0.4505, 0.6202, 0.6364, 0.8080, 0.5923, 0.3051, 0.8654, 0.2609, 0.8051, 0.6562, 0.5242, 0.7593, 0.7000, 0.5963, 0.6185, 0.5696, 0.3662, 1.0000, 0.0000, 0.3750, 0.0000, 1.0000, 0.6000, 0.5455, NULL, NULL),
(72, 1, 72, 0.7500, 0.8559, 0.9690, 0.7273, 1.0000, 0.6692, 0.6525, 0.7212, 0.9130, 0.7542, 0.3750, 0.6613, 0.7593, 0.9556, 0.5963, 0.6185, 0.5696, 0.8873, 0.5000, 0.0000, 0.6250, 0.5000, 0.2500, 0.3000, 0.2727, NULL, NULL),
(73, 1, 73, 0.7500, 0.7838, 0.6977, 0.5000, 0.9440, 0.7462, 0.7034, 0.7212, 0.8261, 0.7797, 0.6484, 0.8065, 0.7593, 0.6778, 0.5963, 0.6185, 0.5696, 0.7606, 0.5000, 0.0000, 0.8750, 0.0000, 0.2500, 0.7000, 0.8182, NULL, NULL),
(74, 1, 74, 0.3200, 0.5225, 0.8760, 0.7273, 0.9280, 0.3385, 0.6780, 0.7692, 1.0000, 0.7288, 0.2969, 0.7177, 0.7593, 0.8444, 0.5963, 0.6185, 0.5696, 0.7042, 0.7500, 0.0000, 0.7500, 0.0000, 0.2500, 1.0000, 0.6364, NULL, NULL),
(75, 1, 75, 0.5500, 0.5856, 0.7829, 0.6818, 0.5680, 0.6923, 0.9661, 0.7692, 0.5652, 0.5932, 0.4531, 0.6774, 0.7593, 0.4000, 0.5963, 0.6185, 0.5696, 0.9014, 0.2500, 0.6000, 0.5000, 0.5000, 0.0000, 0.3000, 0.1818, NULL, NULL),
(76, 1, 76, 0.5800, 0.8559, 0.6667, 0.7273, 0.6400, 0.8615, 0.6949, 0.7212, 0.6087, 0.6356, 0.6172, 0.6774, 0.7593, 0.3444, 0.5963, 0.6185, 0.5696, 0.8028, 0.2500, 0.6000, 0.5000, 0.0000, 0.0000, 0.2000, 0.1818, NULL, NULL),
(77, 1, 77, 0.8000, 0.8649, 0.7054, 0.7273, 0.8320, 0.5000, 0.3729, 0.3846, 0.7391, 0.7797, 0.9141, 0.7097, 0.7593, 0.8111, 0.5963, 0.6185, 0.5696, 0.8732, 0.5000, 0.0000, 0.6250, 0.5000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(78, 1, 78, 0.8000, 0.7207, 0.7364, 0.7273, 0.4320, 0.7692, 0.7966, 0.8077, 0.6087, 0.5847, 0.4536, 0.5602, 0.8136, 0.5256, 0.6233, 0.4553, 0.6277, 0.6923, 0.5000, 0.0000, 0.2500, 0.5000, 0.7500, 0.4000, 0.4545, NULL, NULL),
(79, 1, 79, 0.1500, 0.6577, 0.6977, 0.6818, 0.5200, 0.1846, 0.6102, 0.8077, 0.5913, 0.5424, 0.4536, 0.5602, 0.8051, 0.5256, 0.5616, 0.1545, 0.4255, 0.6923, 0.2500, 0.0000, 0.5000, 0.5000, 0.0000, 0.6000, 0.1818, NULL, NULL),
(80, 1, 80, 0.7500, 0.7658, 0.8062, 0.8636, 0.6800, 0.5538, 0.6525, 0.8173, 0.8261, 0.7966, 0.4536, 0.5602, 0.7797, 0.5256, 0.6849, 0.7561, 0.9043, 0.6923, 0.5000, 0.0000, 0.3750, 0.0000, 0.0000, 0.8000, 0.5455, NULL, NULL),
(81, 1, 81, 0.8000, 0.9640, 0.6977, 0.9545, 0.8000, 0.8385, 0.6525, 0.4808, 0.7391, 0.8475, 0.4536, 0.5602, 0.6780, 0.5256, 0.6644, 0.8537, 0.8830, 0.6923, 0.5000, 0.0000, 0.8750, 0.7500, 0.2500, 0.9000, 0.6364, NULL, NULL),
(82, 1, 82, 0.5500, 0.6306, 0.7364, 0.6818, 0.6880, 0.5462, 0.5932, 0.8077, 0.7391, 0.6610, 0.4536, 0.5602, 0.6441, 0.5256, 0.5890, 0.8780, 0.5638, 0.6923, 0.7500, 0.0000, 0.6250, 0.7500, 0.0000, 0.3000, 0.2727, NULL, NULL),
(83, 1, 83, 0.2500, 0.6937, 0.6589, 0.8182, 0.8320, 0.6000, 0.3983, 0.4327, 0.5652, 0.6525, 0.4536, 0.5602, 0.6780, 0.5256, 0.3082, 0.5285, 0.1383, 0.6923, 1.0000, 0.0000, 0.3750, 0.0000, 0.0000, 0.6000, 0.9091, NULL, NULL),
(84, 1, 84, 0.5000, 0.2252, 0.6202, 0.7727, 0.8880, 0.0077, 0.4746, 0.4808, 0.5652, 0.6610, 0.4536, 0.5602, 0.5593, 0.5256, 0.5342, 0.3984, 0.4043, 0.6923, 0.7500, 0.0000, 0.5000, 1.0000, 0.0000, 0.6000, 0.6364, NULL, NULL),
(85, 1, 85, 0.0000, 0.2883, 0.3798, 0.6818, 0.2720, 0.0000, 0.6780, 0.5288, 0.4348, 0.3898, 0.4536, 0.5602, 0.4492, 0.5256, 0.0959, 0.0406, 0.0106, 0.6923, 0.2500, 0.0000, 0.7500, 0.0000, 0.0000, 0.1000, 0.0909, NULL, NULL),
(86, 1, 86, 0.2500, 0.4955, 0.3798, 0.0000, 0.3920, 0.4385, 0.5254, 0.5288, 0.4609, 0.0000, 0.4536, 0.5602, 0.8644, 0.5256, 0.1986, 0.4146, 0.3830, 0.6923, 0.5000, 0.0000, 0.7500, 0.0000, 0.2500, 0.7000, 0.0909, NULL, NULL),
(87, 1, 87, 0.0000, 0.4054, 0.6124, 0.8182, 0.3920, 0.2154, 0.8644, 0.5769, 0.3739, 0.4661, 0.4536, 0.5602, 0.7797, 0.5256, 0.5000, 0.3740, 0.1596, 0.6923, 0.2500, 0.0000, 0.6250, 0.0000, 0.0000, 0.2000, 0.7273, NULL, NULL),
(88, 1, 88, 0.6500, 0.5586, 0.6589, 0.8182, 0.6240, 0.6000, 0.7797, 0.7212, 0.5217, 0.6949, 0.4536, 0.5602, 0.7966, 0.5256, 0.5548, 0.4146, 0.7234, 0.6923, 0.2500, 0.0000, 0.5000, 0.2500, 0.0000, 0.2000, 0.1818, NULL, NULL),
(89, 1, 89, 0.4500, 0.4775, 0.7364, 0.9091, 0.5680, 0.7077, 0.7966, 0.8558, 0.6348, 0.4746, 0.4536, 0.5602, 0.7203, 0.5256, 0.7192, 0.7154, 0.5957, 0.6923, 0.2500, 0.0000, 0.5000, 0.0000, 0.0000, 0.6000, 0.1818, NULL, NULL),
(90, 1, 90, 0.5000, 0.4054, 0.7752, 0.8182, 0.7600, 0.8769, 0.6525, 0.8558, 0.3739, 0.5424, 0.4536, 0.5602, 0.6186, 0.5256, 0.8014, 0.7073, 0.7553, 0.6923, 0.2500, 0.0000, 0.7500, 0.5000, 0.0000, 0.1000, 0.3636, NULL, NULL),
(91, 1, 91, 0.5000, 0.7207, 0.6899, 0.8182, 0.5680, 0.6000, 0.6610, 0.5769, 0.7391, 0.3898, 0.4536, 0.5602, 0.8475, 0.5256, 0.6986, 0.5285, 0.6383, 0.6923, 0.2500, 0.0000, 1.0000, 0.7500, 0.0000, 0.4000, 0.3636, NULL, NULL),
(92, 1, 92, 0.1500, 0.2072, 0.1550, 0.5909, 0.0800, 0.4538, 0.6441, 0.6250, 0.1739, 0.3220, 0.4536, 0.5602, 0.7203, 0.5256, 0.3356, 0.4634, 0.3723, 0.6923, 0.7500, 0.0000, 0.6250, 0.7500, 0.0000, 0.3000, 0.2727, NULL, NULL),
(93, 1, 93, 0.4500, 0.5225, 0.9225, 0.9091, 0.4800, 0.6846, 0.6441, 0.6731, 0.6783, 0.6695, 0.4536, 0.5602, 0.8814, 0.5256, 0.5685, 0.6911, 0.3723, 0.6923, 0.7500, 0.0000, 1.0000, 0.7500, 0.5000, 0.4000, 0.4545, NULL, NULL),
(94, 1, 94, 0.3500, 0.4324, 0.4574, 0.6364, 0.0000, 0.5385, 0.6949, 0.5769, 0.5478, 0.4153, 0.4536, 0.5602, 0.5763, 0.5256, 0.5411, 0.4472, 0.5000, 0.6923, 0.2500, 0.0000, 0.5000, 0.0000, 0.0000, 0.2000, 0.5455, NULL, NULL),
(95, 1, 95, 0.1500, 0.5405, 0.4806, 0.5455, 0.0480, 0.3385, 0.7458, 0.7115, 0.5217, 0.3559, 0.4536, 0.5602, 0.6610, 0.5256, 0.2671, 0.5041, 0.3404, 0.6923, 0.2500, 0.0000, 0.1250, 0.5000, 0.0000, 0.8000, 0.4545, NULL, NULL),
(96, 1, 96, 0.5000, 0.7207, 0.8915, 0.8182, 0.1120, 0.6923, 0.6102, 0.6731, 0.6087, 0.8390, 0.4536, 0.5602, 0.7627, 0.5256, 0.5685, 0.6504, 0.5957, 0.6923, 0.2500, 0.0000, 0.1250, 0.2500, 0.0000, 0.8000, 0.7273, NULL, NULL),
(97, 1, 97, 0.5500, 0.6757, 0.5426, 0.9545, 0.7280, 0.4385, 0.6949, 0.5769, 0.6087, 0.8390, 0.4536, 0.5602, 0.6949, 0.5256, 0.7534, 0.8618, 0.8617, 0.6923, 0.7500, 0.0000, 0.5000, 0.7500, 0.5000, 0.5000, 0.3636, NULL, NULL),
(98, 1, 98, 0.6000, 0.4505, 0.4264, 0.4545, 0.7280, 0.3462, 0.3559, 0.6635, 0.5217, 0.5085, 0.4536, 0.5602, 0.7119, 0.5256, 0.5890, 0.3333, 0.4894, 0.6923, 0.5000, 0.0000, 0.6250, 0.0000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(99, 1, 99, 0.5500, 0.7477, 0.4884, 0.6818, 0.7840, 0.5000, 0.5339, 0.5288, 0.5217, 0.4153, 0.4536, 0.5602, 0.8729, 0.5256, 0.3562, 0.2683, 0.7553, 0.6923, 0.5000, 0.0000, 1.0000, 0.7500, 0.2500, 0.4000, 0.4545, NULL, NULL),
(100, 1, 100, 0.6500, 0.7748, 0.7752, 0.6818, 0.4320, 0.5154, 0.7458, 0.5769, 0.3913, 0.6780, 0.4536, 0.5602, 0.7542, 0.5256, 0.7055, 0.6341, 0.7979, 0.6923, 0.2500, 0.0000, 0.1250, 0.2500, 0.0000, 0.8000, 0.7273, NULL, NULL),
(101, 1, 101, 0.7000, 0.8559, 0.6977, 0.8636, 0.7840, 0.7538, 0.6017, 0.7115, 0.8696, 0.7288, 0.4536, 0.5602, 0.9153, 0.5256, 0.7534, 0.8943, 0.8830, 0.6923, 0.5000, 0.0000, 0.8750, 0.0000, 0.2500, 0.9000, 0.6364, NULL, NULL),
(102, 1, 102, 0.6000, 0.8108, 0.8140, 0.8636, 0.8240, 0.8000, 0.6525, 0.6731, 0.7826, 0.6356, 0.4536, 0.5602, 0.9237, 0.5256, 0.7671, 0.7805, 0.8298, 0.6923, 1.0000, 0.0000, 1.0000, 0.5000, 0.0000, 0.4000, 0.3636, NULL, NULL),
(103, 1, 103, 0.0400, 0.0270, 0.0000, 0.0000, 0.8080, 0.0769, 0.1525, 0.0000, 0.0000, 0.2034, 0.4536, 0.5602, 0.0000, 0.5256, 0.0959, 0.0000, 0.3511, 0.6923, 0.5000, 0.0000, 0.6250, 0.0000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(104, 1, 104, 0.7500, 0.5405, 0.6202, 0.6818, 0.7280, 0.5923, 0.4068, 0.5769, 0.5652, 0.6441, 0.4536, 0.5602, 0.7966, 0.5256, 0.5890, 0.5285, 0.9255, 0.6923, 1.0000, 0.0000, 0.3750, 0.5000, 0.2500, 1.0000, 0.5455, NULL, NULL),
(105, 1, 105, 0.8000, 0.8739, 0.8140, 0.7273, 0.7680, 0.6769, 0.6610, 0.6250, 0.7826, 0.7203, 0.4536, 0.5602, 0.9237, 0.5256, 0.8288, 0.8537, 0.9255, 0.6923, 0.2500, 0.0000, 0.6250, 0.2500, 0.5000, 0.4000, 0.2727, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `_prisma_migrations`
--

CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logs` text COLLATE utf8mb4_unicode_ci,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `applied_steps_count` int UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `_prisma_migrations`
--

INSERT INTO `_prisma_migrations` (`id`, `checksum`, `finished_at`, `migration_name`, `logs`, `rolled_back_at`, `started_at`, `applied_steps_count`) VALUES
('15048f4d-51c3-4ab2-bee5-3b9be9d47e0c', 'e26a3afd43cb817b92d3134ba9895b5bb5e512e1bec701ebae202026eee5b0bf', '2026-10-28 15:57:02.511', '20261028000000_add_kmeans_dbi_score', NULL, NULL, '2026-10-28 15:57:02.341', 1),
('2a50f573-90cd-413a-b61a-a5b7dcfecdd4', '6d8037fbe9c15321dc29f579890a98f8f787598436b52fde07aebb8822caedc1', '2026-10-07 15:39:12.619', '20261007153912_remove_admin_email', NULL, NULL, '2026-10-07 15:39:12.379', 1),
('67c5c99b-f286-45d4-b1e8-ec008b7461d1', '7d3c79839d13da2425e0cd32c820734fac3c12599754c8a97655b637f160452d', '2026-10-15 14:18:44.505', '20261015134835_add_preprocessing_config', NULL, NULL, '2026-10-15 14:18:42.127', 1),
('6838f1a0-3ef4-46c0-bd61-360f21ecbe6e', 'a5d31fe4fd07c5c09c37229ea9eb9abd1728d6c94c16e0431553214a3308e0d5', '2026-10-02 06:38:19.410', '20261001000000_init_erd', '', NULL, '2026-10-02 06:38:19.410', 0),
('d54d7923-b89c-4246-99b9-660a68917767', 'ce6e9fb3778e03569251ea5ae0f3a040fd411f058d412611f03290dfb86d2a54', '2026-10-02 07:10:20.045', '20261002071019_add_admin_status', NULL, NULL, '2026-10-02 07:10:19.923', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `category_assignment`
--
ALTER TABLE `category_assignment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `category_assignment_index_0` (`periode_id`,`field_name`,`standard_value`),
  ADD KEY `category_assignment_option_id_idx` (`option_id`);

--
-- Indexes for table `category_mapping`
--
ALTER TABLE `category_mapping`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `category_mapping_index_run_field_raw` (`preprocessing_run_id`,`field_name`,`raw_value`);

--
-- Indexes for table `category_option`
--
ALTER TABLE `category_option`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `category_option_index_name` (`periode_id`,`field_name`,`name`),
  ADD UNIQUE KEY `category_option_index_code` (`periode_id`,`field_name`,`code`),
  ADD KEY `category_option_periode_id_idx` (`periode_id`);

--
-- Indexes for table `centroid`
--
ALTER TABLE `centroid`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kmeans_iteration_id` (`kmeans_iteration_id`);

--
-- Indexes for table `cleaned_data`
--
ALTER TABLE `cleaned_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `preprocessing_run_id` (`preprocessing_run_id`),
  ADD KEY `siswa_periode_id` (`siswa_periode_id`);

--
-- Indexes for table `cluster_assignment`
--
ALTER TABLE `cluster_assignment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kmeans_iteration_id` (`kmeans_iteration_id`),
  ADD KEY `siswa_periode_id` (`siswa_periode_id`);

--
-- Indexes for table `cluster_profile`
--
ALTER TABLE `cluster_profile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cluster_profile_index_6` (`kmeans_run_id`,`cluster_code`);

--
-- Indexes for table `cluster_result`
--
ALTER TABLE `cluster_result`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cluster_result_index_5` (`kmeans_run_id`,`siswa_periode_id`),
  ADD KEY `siswa_periode_id` (`siswa_periode_id`);

--
-- Indexes for table `integrated_data`
--
ALTER TABLE `integrated_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `integrated_data_index_4` (`preprocessing_run_id`,`siswa_periode_id`),
  ADD KEY `siswa_periode_id` (`siswa_periode_id`);

--
-- Indexes for table `kmeans_iteration`
--
ALTER TABLE `kmeans_iteration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kmeans_run_id` (`kmeans_run_id`);

--
-- Indexes for table `kmeans_run`
--
ALTER TABLE `kmeans_run`
  ADD PRIMARY KEY (`id`),
  ADD KEY `preprocessing_run_id` (`preprocessing_run_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `nilai_akademik`
--
ALTER TABLE `nilai_akademik`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nilai_akademik_index_2` (`siswa_periode_id`,`jenis_nilai`);

--
-- Indexes for table `non_akademik`
--
ALTER TABLE `non_akademik`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `non_akademik_index_3` (`siswa_periode_id`);

--
-- Indexes for table `periode`
--
ALTER TABLE `periode`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `periode_index_0` (`tahun_ajaran`,`semester`);

--
-- Indexes for table `preprocessing_run`
--
ALTER TABLE `preprocessing_run`
  ADD PRIMARY KEY (`id`),
  ADD KEY `periode_id` (`periode_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `recommendation`
--
ALTER TABLE `recommendation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `recommendation_index_7` (`kmeans_run_id`,`siswa_periode_id`),
  ADD KEY `siswa_periode_id` (`siswa_periode_id`);

--
-- Indexes for table `reduced_data`
--
ALTER TABLE `reduced_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `preprocessing_run_id` (`preprocessing_run_id`),
  ADD KEY `siswa_periode_id` (`siswa_periode_id`);

--
-- Indexes for table `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nis` (`nis`);

--
-- Indexes for table `siswa_periode`
--
ALTER TABLE `siswa_periode`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `siswa_periode_index_1` (`siswa_id`,`periode_id`),
  ADD KEY `periode_id` (`periode_id`);

--
-- Indexes for table `transformed_data`
--
ALTER TABLE `transformed_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `preprocessing_run_id` (`preprocessing_run_id`),
  ADD KEY `siswa_periode_id` (`siswa_periode_id`);

--
-- Indexes for table `_prisma_migrations`
--
ALTER TABLE `_prisma_migrations`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `category_assignment`
--
ALTER TABLE `category_assignment`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `category_mapping`
--
ALTER TABLE `category_mapping`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `category_option`
--
ALTER TABLE `category_option`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `centroid`
--
ALTER TABLE `centroid`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cleaned_data`
--
ALTER TABLE `cleaned_data`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `cluster_assignment`
--
ALTER TABLE `cluster_assignment`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cluster_profile`
--
ALTER TABLE `cluster_profile`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cluster_result`
--
ALTER TABLE `cluster_result`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `integrated_data`
--
ALTER TABLE `integrated_data`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `kmeans_iteration`
--
ALTER TABLE `kmeans_iteration`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kmeans_run`
--
ALTER TABLE `kmeans_run`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nilai_akademik`
--
ALTER TABLE `nilai_akademik`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=316;

--
-- AUTO_INCREMENT for table `non_akademik`
--
ALTER TABLE `non_akademik`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `periode`
--
ALTER TABLE `periode`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `preprocessing_run`
--
ALTER TABLE `preprocessing_run`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `recommendation`
--
ALTER TABLE `recommendation`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reduced_data`
--
ALTER TABLE `reduced_data`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `siswa_periode`
--
ALTER TABLE `siswa_periode`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `transformed_data`
--
ALTER TABLE `transformed_data`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `category_assignment`
--
ALTER TABLE `category_assignment`
  ADD CONSTRAINT `category_assignment_option_id_fkey` FOREIGN KEY (`option_id`) REFERENCES `category_option` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `category_assignment_periode_id_fkey` FOREIGN KEY (`periode_id`) REFERENCES `periode` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `category_mapping`
--
ALTER TABLE `category_mapping`
  ADD CONSTRAINT `category_mapping_ibfk_1` FOREIGN KEY (`preprocessing_run_id`) REFERENCES `preprocessing_run` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `category_option`
--
ALTER TABLE `category_option`
  ADD CONSTRAINT `category_option_periode_id_fkey` FOREIGN KEY (`periode_id`) REFERENCES `periode` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `centroid`
--
ALTER TABLE `centroid`
  ADD CONSTRAINT `centroid_ibfk_1` FOREIGN KEY (`kmeans_iteration_id`) REFERENCES `kmeans_iteration` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cleaned_data`
--
ALTER TABLE `cleaned_data`
  ADD CONSTRAINT `cleaned_data_ibfk_1` FOREIGN KEY (`preprocessing_run_id`) REFERENCES `preprocessing_run` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cleaned_data_ibfk_2` FOREIGN KEY (`siswa_periode_id`) REFERENCES `siswa_periode` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cluster_assignment`
--
ALTER TABLE `cluster_assignment`
  ADD CONSTRAINT `cluster_assignment_ibfk_1` FOREIGN KEY (`kmeans_iteration_id`) REFERENCES `kmeans_iteration` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cluster_assignment_ibfk_2` FOREIGN KEY (`siswa_periode_id`) REFERENCES `siswa_periode` (`id`) ON DELETE RESTRICT;

--
-- Constraints for table `cluster_profile`
--
ALTER TABLE `cluster_profile`
  ADD CONSTRAINT `cluster_profile_ibfk_1` FOREIGN KEY (`kmeans_run_id`) REFERENCES `kmeans_run` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cluster_result`
--
ALTER TABLE `cluster_result`
  ADD CONSTRAINT `cluster_result_ibfk_1` FOREIGN KEY (`kmeans_run_id`) REFERENCES `kmeans_run` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cluster_result_ibfk_2` FOREIGN KEY (`siswa_periode_id`) REFERENCES `siswa_periode` (`id`) ON DELETE RESTRICT;

--
-- Constraints for table `integrated_data`
--
ALTER TABLE `integrated_data`
  ADD CONSTRAINT `integrated_data_ibfk_1` FOREIGN KEY (`preprocessing_run_id`) REFERENCES `preprocessing_run` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `integrated_data_ibfk_2` FOREIGN KEY (`siswa_periode_id`) REFERENCES `siswa_periode` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `kmeans_iteration`
--
ALTER TABLE `kmeans_iteration`
  ADD CONSTRAINT `kmeans_iteration_ibfk_1` FOREIGN KEY (`kmeans_run_id`) REFERENCES `kmeans_run` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `kmeans_run`
--
ALTER TABLE `kmeans_run`
  ADD CONSTRAINT `kmeans_run_ibfk_1` FOREIGN KEY (`preprocessing_run_id`) REFERENCES `preprocessing_run` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `kmeans_run_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE RESTRICT;

--
-- Constraints for table `nilai_akademik`
--
ALTER TABLE `nilai_akademik`
  ADD CONSTRAINT `nilai_akademik_ibfk_1` FOREIGN KEY (`siswa_periode_id`) REFERENCES `siswa_periode` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `non_akademik`
--
ALTER TABLE `non_akademik`
  ADD CONSTRAINT `non_akademik_ibfk_1` FOREIGN KEY (`siswa_periode_id`) REFERENCES `siswa_periode` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `preprocessing_run`
--
ALTER TABLE `preprocessing_run`
  ADD CONSTRAINT `preprocessing_run_ibfk_1` FOREIGN KEY (`periode_id`) REFERENCES `periode` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `preprocessing_run_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE RESTRICT;

--
-- Constraints for table `recommendation`
--
ALTER TABLE `recommendation`
  ADD CONSTRAINT `recommendation_ibfk_1` FOREIGN KEY (`kmeans_run_id`) REFERENCES `kmeans_run` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `recommendation_ibfk_2` FOREIGN KEY (`siswa_periode_id`) REFERENCES `siswa_periode` (`id`) ON DELETE RESTRICT;

--
-- Constraints for table `reduced_data`
--
ALTER TABLE `reduced_data`
  ADD CONSTRAINT `reduced_data_ibfk_1` FOREIGN KEY (`preprocessing_run_id`) REFERENCES `preprocessing_run` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reduced_data_ibfk_2` FOREIGN KEY (`siswa_periode_id`) REFERENCES `siswa_periode` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `siswa_periode`
--
ALTER TABLE `siswa_periode`
  ADD CONSTRAINT `siswa_periode_ibfk_1` FOREIGN KEY (`siswa_id`) REFERENCES `siswa` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `siswa_periode_ibfk_2` FOREIGN KEY (`periode_id`) REFERENCES `periode` (`id`) ON DELETE RESTRICT;

--
-- Constraints for table `transformed_data`
--
ALTER TABLE `transformed_data`
  ADD CONSTRAINT `transformed_data_ibfk_1` FOREIGN KEY (`preprocessing_run_id`) REFERENCES `preprocessing_run` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transformed_data_ibfk_2` FOREIGN KEY (`siswa_periode_id`) REFERENCES `siswa_periode` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
