-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 28, 2026 at 03:52 PM
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
(358, 1, 'ekstrakurikuler', 'futsal', 223),
(359, 1, 'ekstrakurikuler', 'badminton', 223),
(360, 1, 'ekstrakurikuler', 'taekwondo', 223),
(361, 1, 'ekstrakurikuler', 'basket', 223),
(362, 1, 'ekstrakurikuler', 'tari tradisional', 224),
(363, 1, 'ekstrakurikuler', 'band', 224),
(364, 1, 'ekstrakurikuler', 'modern dance', 224),
(365, 1, 'ekstrakurikuler', 'kir', 225),
(366, 1, 'ekstrakurikuler', 'mading', 226),
(367, 1, 'prestasi', 'tidak', 227),
(368, 1, 'prestasi', 'juara 1 lomba futsal di sma penabur bintaro jaya 2024', 228),
(369, 1, 'prestasi', 'juara 1 kejuaraan taekwondo liga dki', 228),
(370, 1, 'prestasi', 'juara 2 solo vokal m25 cup sma muhammadh 25 pamulang 2024', 229),
(371, 1, 'prestasi', 'juara harapan 1 fls2n', 229),
(372, 1, 'prestasi', 'juara 3 lomba mobile legends tingkat sma', 230),
(373, 1, 'prestasi', 'runner up puteri remaja indonesia lingkungan jakarta 2024', 231),
(374, 1, 'prestasi', 'juara 2 kejuaraan pelajar nasional', 232),
(375, 1, 'kemampuan', 'bela diri', 234),
(376, 1, 'kemampuan', 'bermain futsal', 234),
(377, 1, 'kemampuan', 'main basket', 234),
(378, 1, 'kemampuan', 'atletik', 234),
(379, 1, 'kemampuan', 'main drum', 235),
(380, 1, 'kemampuan', 'main gitar', 235),
(381, 1, 'kemampuan', 'menyanyi', 235),
(382, 1, 'kemampuan', 'menari', 236),
(383, 1, 'kemampuan', 'menggambar', 236),
(384, 1, 'kemampuan', 'melukis', 236),
(385, 1, 'kemampuan', 'videografi', 237),
(386, 1, 'kemampuan', 'fotografi', 237),
(387, 1, 'kemampuan', 'editing', 237),
(388, 1, 'kemampuan', 'gaming', 237),
(389, 1, 'kemampuan', 'desain', 237),
(390, 1, 'kemampuan', 'bisnis', 238),
(391, 1, 'kemampuan', 'wirausaha', 238),
(392, 1, 'kemampuan', 'modifikasi motor', 239),
(393, 1, 'kemampuan', 'analisis', 239),
(394, 1, 'kemampuan', 'memasak', 240),
(395, 1, 'kemampuan', 'public speaking', 241),
(396, 1, 'organisasi', 'tidak', 242),
(397, 1, 'organisasi', 'badminton', 243),
(398, 1, 'organisasi', 'basket', 243),
(399, 1, 'organisasi', 'karang taruna', 244),
(400, 1, 'organisasi', 'osis', 245),
(401, 1, 'organisasi', 'pmr', 246),
(402, 1, 'kursus', 'tidak', 247),
(403, 1, 'kursus', 'bimbel', 248),
(404, 1, 'kursus', 'kursus toefl', 249),
(405, 1, 'kursus', 'pelatihan saksi partai', 250),
(406, 1, 'kursus', 'melukis', 251),
(407, 1, 'jurusan_1', 'teknik mesin', 254),
(408, 1, 'jurusan_1', 'teknik industri', 254),
(409, 1, 'jurusan_1', 'teknik informatika', 255),
(410, 1, 'jurusan_1', 'ilmu komputer', 255),
(411, 1, 'jurusan_1', 'manajemen', 256),
(412, 1, 'jurusan_1', 'akuntansi', 256),
(413, 1, 'jurusan_1', 'psikologi', 257),
(414, 1, 'jurusan_1', 'hukum', 257),
(415, 1, 'jurusan_1', 'ilmu komunikasi', 257),
(416, 1, 'jurusan_1', 'sastra inggris', 258),
(417, 1, 'jurusan_1', 'dkv', 259),
(418, 1, 'jurusan_1', 'seni rupa', 259),
(419, 1, 'jurusan_1', 'kedokteran', 260),
(420, 1, 'jurusan_1', 'ilmu keperawatan', 260),
(421, 1, 'jurusan_1', 'ilmu keolahragaan', 261),
(422, 1, 'jurusan_1', 'pendidikan jasmani', 261),
(423, 1, 'jurusan_1', 'arsitektur', 263),
(424, 1, 'jurusan_1', 'teknologi pangan', 262),
(425, 1, 'jurusan_2', 'teknik elektro', 266),
(426, 1, 'jurusan_2', 'teknik industri', 266),
(427, 1, 'jurusan_2', 'teknik mesin', 266),
(428, 1, 'jurusan_2', 'teknik informatika', 267),
(429, 1, 'jurusan_2', 'sistem informasi', 267),
(430, 1, 'jurusan_2', 'ekonomi', 268),
(431, 1, 'jurusan_2', 'akuntansi', 268),
(432, 1, 'jurusan_2', 'manajemen', 268),
(433, 1, 'jurusan_2', 'psikologi', 269),
(434, 1, 'jurusan_2', 'hukum', 269),
(435, 1, 'jurusan_2', 'ilmu komunikasi', 269),
(436, 1, 'jurusan_2', 'sastra inggris', 270),
(437, 1, 'jurusan_2', 'sastra indonesia', 270),
(438, 1, 'jurusan_2', 'dkv', 271),
(439, 1, 'jurusan_2', 'seni rupa', 271),
(440, 1, 'jurusan_2', 'farmasi', 272),
(441, 1, 'jurusan_2', 'ilmu keperawatan', 272),
(442, 1, 'jurusan_2', 'pendidikan jasmani', 273),
(443, 1, 'jurusan_2', 'ilmu keolahragaan', 273),
(444, 1, 'jurusan_2', 'teknologi pangan', 274),
(445, 1, 'jurusan_2', 'arsitektur', 275),
(446, 1, 'jurusan_2', 'pgsd', 276);

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
(1188, 11, 'ekstrakurikuler', 'badminton', 'Badminton', NULL, NULL),
(1189, 11, 'ekstrakurikuler', 'futsal', 'Futsal', NULL, NULL),
(1190, 11, 'ekstrakurikuler', 'band', 'Band', NULL, NULL),
(1191, 11, 'ekstrakurikuler', 'modern dance', 'Modern Dance', NULL, NULL),
(1192, 11, 'ekstrakurikuler', 'taekwondo', 'Taekwondo', NULL, NULL),
(1193, 11, 'ekstrakurikuler', 'basket', 'Basket', NULL, NULL),
(1194, 11, 'ekstrakurikuler', 'tari tradisional', 'Tari Tradisional', NULL, NULL),
(1195, 11, 'ekstrakurikuler', 'mading', 'Mading', NULL, NULL),
(1196, 11, 'ekstrakurikuler', 'kir', 'KIR', NULL, NULL),
(1197, 11, 'prestasi', 'tidak', 'Tidak', NULL, NULL),
(1198, 11, 'prestasi', 'runner up puteri remaja indonesia lingkungan jakarta 2024', 'Runner Up Puteri Remaja Indonesia Lingkungan Jakarta 2024', NULL, NULL),
(1199, 11, 'prestasi', 'juara harapan 1 fls2n', 'Juara harapan 1 FLS2N', NULL, NULL),
(1200, 11, 'prestasi', 'juara 1 lomba futsal di sma penabur bintaro jaya 2024', 'Juara 1 Lomba Futsal di SMA Penabur Bintaro Jaya 2024', NULL, NULL),
(1201, 11, 'prestasi', 'juara 1 kejuaraan taekwondo liga dki', 'Juara 1 kejuaraan taekwondo liga DKI', NULL, NULL),
(1202, 11, 'prestasi', 'juara 2 kejuaraan pelajar nasional', 'Juara 2 kejuaraan pelajar nasional', NULL, NULL),
(1203, 11, 'prestasi', 'juara 3 lomba mobile legends tingkat sma', 'Juara 3 lomba mobile legends tingkat SMA', NULL, NULL),
(1204, 11, 'prestasi', 'juara 2 solo vokal m25 cup sma muhammadh 25 pamulang 2024', 'Juara 2 Solo Vokal M25 Cup SMA Muhammadh 25 Pamulang 2024', NULL, NULL),
(1205, 11, 'kemampuan', 'modifikasi motor', 'Modifikasi Motor', NULL, NULL),
(1206, 11, 'kemampuan', 'bermain futsal', 'Bermain Futsal', NULL, NULL),
(1207, 11, 'kemampuan', 'main gitar', 'Main Gitar', NULL, NULL),
(1208, 11, 'kemampuan', 'bisnis', 'Bisnis', NULL, NULL),
(1209, 11, 'kemampuan', 'public speaking', 'Public Speaking', NULL, NULL),
(1210, 11, 'kemampuan', 'bela diri', 'Bela Diri', NULL, NULL),
(1211, 11, 'kemampuan', 'main basket', 'Main Basket', NULL, NULL),
(1212, 11, 'kemampuan', 'menari', 'Menari', NULL, NULL),
(1213, 11, 'kemampuan', 'menggambar', 'Menggambar', NULL, NULL),
(1214, 11, 'kemampuan', 'fotografi', 'Fotografi', NULL, NULL),
(1215, 11, 'kemampuan', 'videografi', 'Videografi', NULL, NULL),
(1216, 11, 'kemampuan', 'editing', 'Editing', NULL, NULL),
(1217, 11, 'kemampuan', 'analisis', 'Analisis', NULL, NULL),
(1218, 11, 'kemampuan', 'gaming', 'Gaming', NULL, NULL),
(1219, 11, 'kemampuan', 'wirausaha', 'Wirausaha', NULL, NULL),
(1220, 11, 'kemampuan', 'desain', 'Desain', NULL, NULL),
(1221, 11, 'kemampuan', 'atletik', 'Atletik', NULL, NULL),
(1222, 11, 'kemampuan', 'main drum', 'Main Drum', NULL, NULL),
(1223, 11, 'kemampuan', 'melukis', 'Melukis', NULL, NULL),
(1224, 11, 'kemampuan', 'memasak', 'Memasak', NULL, NULL),
(1225, 11, 'kemampuan', 'menyanyi', 'Menyanyi', NULL, NULL),
(1226, 11, 'organisasi', 'badminton', 'Badminton', NULL, NULL),
(1227, 11, 'organisasi', 'karang taruna', 'Karang Taruna', NULL, NULL),
(1228, 11, 'organisasi', 'osis', 'OSIS', NULL, NULL),
(1229, 11, 'organisasi', 'tidak', 'Tidak', NULL, NULL),
(1230, 11, 'organisasi', 'basket', 'Basket', NULL, NULL),
(1231, 11, 'organisasi', 'pmr', 'PMR', NULL, NULL),
(1232, 11, 'kursus', 'tidak', 'Tidak', NULL, NULL),
(1233, 11, 'kursus', 'bimbel', 'Bimbel', NULL, NULL),
(1234, 11, 'kursus', 'kursus toefl', 'Kursus TOEFL', NULL, NULL),
(1235, 11, 'kursus', 'pelatihan saksi partai', 'Pelatihan Saksi Partai', NULL, NULL),
(1236, 11, 'kursus', 'melukis', 'Melukis', NULL, NULL),
(1237, 11, 'jurusan_1', 'teknik mesin', 'Teknik Mesin', NULL, NULL),
(1238, 11, 'jurusan_1', 'manajemen', 'Manajemen', NULL, NULL),
(1239, 11, 'jurusan_1', 'psikologi', 'Psikologi', NULL, NULL),
(1240, 11, 'jurusan_1', 'sastra inggris', 'Sastra Inggris', NULL, NULL),
(1241, 11, 'jurusan_1', 'ilmu keolahragaan', 'Ilmu Keolahragaan', NULL, NULL),
(1242, 11, 'jurusan_1', 'teknik industri', 'Teknik Industri', NULL, NULL),
(1243, 11, 'jurusan_1', 'ilmu komunikasi', 'Ilmu Komunikasi', NULL, NULL),
(1244, 11, 'jurusan_1', 'arsitektur', 'Arsitektur', NULL, NULL),
(1245, 11, 'jurusan_1', 'dkv', 'DKV', NULL, NULL),
(1246, 11, 'jurusan_1', 'teknik informatika', 'Teknik Informatika', NULL, NULL),
(1247, 11, 'jurusan_1', 'akuntansi', 'Akuntansi', NULL, NULL),
(1248, 11, 'jurusan_1', 'kedokteran', 'Kedokteran', NULL, NULL),
(1249, 11, 'jurusan_1', 'pendidikan jasmani', 'Pendidikan Jasmani', NULL, NULL),
(1250, 11, 'jurusan_1', 'hukum', 'Hukum', NULL, NULL),
(1251, 11, 'jurusan_1', 'seni rupa', 'Seni Rupa', NULL, NULL),
(1252, 11, 'jurusan_1', 'ilmu keperawatan', 'Ilmu Keperawatan', NULL, NULL),
(1253, 11, 'jurusan_1', 'teknologi pangan', 'Teknologi Pangan', NULL, NULL),
(1254, 11, 'jurusan_1', 'ilmu komputer', 'Ilmu Komputer', NULL, NULL),
(1255, 11, 'jurusan_2', 'pendidikan jasmani', 'Pendidikan Jasmani', NULL, NULL),
(1256, 11, 'jurusan_2', 'ilmu keolahragaan', 'Ilmu Keolahragaan', NULL, NULL),
(1257, 11, 'jurusan_2', 'sastra indonesia', 'Sastra Indonesia', NULL, NULL),
(1258, 11, 'jurusan_2', 'ekonomi', 'Ekonomi', NULL, NULL),
(1259, 11, 'jurusan_2', 'akuntansi', 'Akuntansi', NULL, NULL),
(1260, 11, 'jurusan_2', 'ilmu komunikasi', 'Ilmu Komunikasi', NULL, NULL),
(1261, 11, 'jurusan_2', 'teknik elektro', 'Teknik Elektro', NULL, NULL),
(1262, 11, 'jurusan_2', 'hukum', 'Hukum', NULL, NULL),
(1263, 11, 'jurusan_2', 'psikologi', 'Psikologi', NULL, NULL),
(1264, 11, 'jurusan_2', 'dkv', 'DKV', NULL, NULL),
(1265, 11, 'jurusan_2', 'manajemen', 'Manajemen', NULL, NULL),
(1266, 11, 'jurusan_2', 'teknik informatika', 'Teknik Informatika', NULL, NULL),
(1267, 11, 'jurusan_2', 'sistem informasi', 'Sistem Informasi', NULL, NULL),
(1268, 11, 'jurusan_2', 'farmasi', 'Farmasi', NULL, NULL),
(1269, 11, 'jurusan_2', 'arsitektur', 'Arsitektur', NULL, NULL),
(1270, 11, 'jurusan_2', 'sastra inggris', 'Sastra Inggris', NULL, NULL),
(1271, 11, 'jurusan_2', 'teknik industri', 'Teknik Industri', NULL, NULL),
(1272, 11, 'jurusan_2', 'teknik mesin', 'Teknik Mesin', NULL, NULL),
(1273, 11, 'jurusan_2', 'teknologi pangan', 'Teknologi Pangan', NULL, NULL),
(1274, 11, 'jurusan_2', 'pgsd', 'PGSD', NULL, NULL),
(1275, 11, 'jurusan_2', 'seni rupa', 'Seni Rupa', NULL, NULL),
(1276, 11, 'jurusan_2', 'ilmu keperawatan', 'Ilmu Keperawatan', NULL, NULL);

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
(222, 1, 'ekstrakurikuler', 'Tidak Ada', 0),
(223, 1, 'ekstrakurikuler', 'Olahraga', 1),
(224, 1, 'ekstrakurikuler', 'Seni', 2),
(225, 1, 'ekstrakurikuler', 'Sains', 3),
(226, 1, 'ekstrakurikuler', 'Literasi', 4),
(227, 1, 'prestasi', 'Tidak Ada', 0),
(228, 1, 'prestasi', 'Olahraga', 1),
(229, 1, 'prestasi', 'Seni', 2),
(230, 1, 'prestasi', 'E-Sport', 3),
(231, 1, 'prestasi', 'Sosial', 4),
(232, 1, 'prestasi', 'Sains', 5),
(233, 1, 'kemampuan', 'Tidak Ada', 0),
(234, 1, 'kemampuan', 'Olahraga', 1),
(235, 1, 'kemampuan', 'Musik', 2),
(236, 1, 'kemampuan', 'Seni', 3),
(237, 1, 'kemampuan', 'Digital', 4),
(238, 1, 'kemampuan', 'Bisnis', 5),
(239, 1, 'kemampuan', 'Sains&Teknik', 6),
(240, 1, 'kemampuan', 'Tata boga', 7),
(241, 1, 'kemampuan', 'Komunikasi', 8),
(242, 1, 'organisasi', 'Tidak Ada', 0),
(243, 1, 'organisasi', 'Olahraga', 1),
(244, 1, 'organisasi', 'Sosial', 2),
(245, 1, 'organisasi', 'Kepemimpinan', 3),
(246, 1, 'organisasi', 'Kesehatan', 4),
(247, 1, 'kursus', 'Tidak Ada', 0),
(248, 1, 'kursus', 'Akademik', 1),
(249, 1, 'kursus', 'Bahasa Inggris', 2),
(250, 1, 'kursus', 'Hukum', 3),
(251, 1, 'kursus', 'Seni', 4),
(253, 1, 'jurusan_1', 'Tidak Ada', 0),
(254, 1, 'jurusan_1', 'Teknik', 1),
(255, 1, 'jurusan_1', 'Komputer', 2),
(256, 1, 'jurusan_1', 'Ekonomi', 3),
(257, 1, 'jurusan_1', 'Sosial', 4),
(258, 1, 'jurusan_1', 'Bahasa', 5),
(259, 1, 'jurusan_1', 'Seni', 6),
(260, 1, 'jurusan_1', 'Kesehatan', 7),
(261, 1, 'jurusan_1', 'Olahraga', 8),
(262, 1, 'jurusan_1', 'Sains Terapan', 9),
(263, 1, 'jurusan_1', 'Perancangan Bangunan', 10),
(265, 1, 'jurusan_2', 'Tidak Ada', 0),
(266, 1, 'jurusan_2', 'Teknik', 1),
(267, 1, 'jurusan_2', 'Komputer', 2),
(268, 1, 'jurusan_2', 'Ekonomi', 3),
(269, 1, 'jurusan_2', 'Sosial', 4),
(270, 1, 'jurusan_2', 'Bahasa', 5),
(271, 1, 'jurusan_2', 'Seni', 6),
(272, 1, 'jurusan_2', 'Kesehatan', 7),
(273, 1, 'jurusan_2', 'Olahraga', 8),
(274, 1, 'jurusan_2', 'Sains Terapan', 9),
(275, 1, 'jurusan_2', 'Perancangan Bangunan', 10),
(276, 1, 'jurusan_2', 'Pendidikan Guru', 11);

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
(709, 11, 16, 96.6667, 92.0000, 87.0000, 85.0000, 83.3333, 88.0000, 84.3333, 83.6667, 76.6667, 96.0000, 95.0000, 76.6667, 86.0000, 77.3333, 71.9833, 78.3333, 81.0000, 84.0000, 'Badminton', 'Tidak', 'Modifikasi Motor', 'Badminton', 'Tidak', 'Teknik Mesin', 'Pendidikan Jasmani', NULL, NULL),
(710, 11, 17, 80.0000, 79.3333, 79.0000, 81.6667, 73.0000, 81.6667, 77.6667, 75.3333, 69.3333, 78.0000, 64.0000, 68.0000, 83.0000, 67.6667, 71.9833, 78.3333, 81.0000, 84.0000, 'Futsal', 'Tidak', 'Bermain Futsal', 'Karang Taruna', 'Tidak', 'Manajemen', 'Ilmu Keolahragaan', NULL, NULL),
(711, 11, 18, 88.3333, 86.0000, 81.6667, 88.3333, 79.3333, 80.3333, 85.6667, 75.3333, 78.3333, 93.3333, 75.6667, 75.6667, 85.3333, 69.3333, 71.9833, 78.3333, 81.0000, 84.0000, 'Band', 'Tidak', 'Main Gitar', 'OSIS', 'Bimbel', 'Psikologi', 'Sastra Indonesia', NULL, NULL),
(712, 11, 19, 48.3333, 75.0000, 75.0000, 58.3333, 76.6667, 59.3333, 71.6667, 62.0000, 53.3333, 53.0000, 53.6667, 45.3333, 80.3333, 46.6667, 71.9833, 78.3333, 81.0000, 84.0000, 'Futsal', 'Tidak', 'Bermain Futsal', 'Tidak', 'Tidak', 'Manajemen', 'Ekonomi', NULL, NULL),
(713, 11, 20, 90.0000, 88.3333, 81.6667, 80.0000, 78.0000, 89.3333, 82.0000, 81.6667, 75.0000, 95.6667, 82.0000, 75.3333, 87.3333, 76.0000, 71.9833, 78.3333, 81.0000, 84.0000, 'Modern Dance', 'Tidak', 'Bisnis', 'Karang Taruna', 'Tidak', 'Manajemen', 'Akuntansi', NULL, NULL),
(714, 11, 21, 88.3333, 78.3333, 81.6667, 88.3333, 83.6667, 71.0000, 76.0000, 81.6667, 70.0000, 88.0000, 55.3333, 57.6667, 87.3333, 81.0000, 71.9833, 78.3333, 81.0000, 84.0000, 'Badminton', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Sastra Inggris', 'Ilmu Komunikasi', NULL, NULL),
(715, 11, 22, 81.6667, 73.3333, 77.0000, 76.6667, 73.0000, 57.3333, 74.6667, 63.6667, 73.3333, 74.3333, 70.0000, 56.6667, 79.6667, 68.3333, 71.9833, 78.3333, 81.0000, 84.0000, 'Taekwondo', 'Tidak', 'Bela Diri', 'Tidak', 'Tidak', 'Ilmu Keolahragaan', 'Pendidikan Jasmani', NULL, NULL),
(716, 11, 23, 81.0000, 80.0000, 50.0000, 78.3333, 73.3333, 66.6667, 54.3333, 78.6667, 76.6667, 86.0000, 60.6667, 75.0000, 85.6667, 69.3333, 71.9833, 78.3333, 81.0000, 84.0000, 'Badminton', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Industri', 'Teknik Elektro', NULL, NULL),
(717, 11, 24, 93.3333, 87.6667, 88.0000, 88.3333, 87.0000, 87.6667, 82.6667, 85.0000, 85.0000, 92.6667, 86.3333, 85.6667, 87.6667, 75.6667, 71.9833, 78.3333, 81.0000, 84.0000, 'Basket', 'Tidak', 'Main Basket', 'Tidak', 'Tidak', 'Manajemen', 'Hukum', NULL, NULL),
(718, 11, 25, 78.3333, 82.6667, 78.0000, 88.3333, 82.3333, 72.3333, 79.3333, 80.3333, 80.0000, 95.0000, 64.3333, 74.6667, 86.3333, 79.0000, 71.9833, 78.3333, 81.0000, 84.0000, 'Tari Tradisional', 'Runner Up Puteri Remaja Indonesia Lingkungan Jakarta 2024', 'Menari', 'OSIS', 'Bimbel', 'Ilmu Komunikasi', 'Psikologi', NULL, NULL),
(719, 11, 26, 88.3333, 80.0000, 79.6667, 90.0000, 83.3333, 74.0000, 85.0000, 86.6667, 78.3333, 92.6667, 74.6667, 65.0000, 90.0000, 80.0000, 71.9833, 78.3333, 81.0000, 84.0000, 'Badminton', 'Tidak', 'Menggambar', 'Badminton', 'Bimbel', 'Arsitektur', 'DKV', NULL, NULL),
(720, 11, 27, 83.3333, 81.6667, 78.0000, 85.0000, 86.6667, 77.0000, 80.0000, 83.3333, 75.0000, 77.3333, 69.0000, 63.0000, 89.3333, 83.3333, 71.9833, 78.3333, 81.0000, 84.0000, 'Mading', 'Tidak', 'Fotografi', 'Tidak', 'Bimbel', 'DKV', 'Manajemen', NULL, NULL),
(721, 11, 28, 90.6667, 80.0000, 88.0000, 87.3333, 79.0000, 81.6667, 84.3333, 81.6667, 65.0000, 87.6667, 77.3333, 63.0000, 84.0000, 75.3333, 71.9833, 78.3333, 81.0000, 84.0000, 'Futsal', 'Tidak', 'Videografi', 'Karang Taruna', 'Bimbel', 'DKV', 'Teknik Informatika', NULL, NULL),
(722, 11, 29, 91.6667, 85.0000, 85.0000, 88.3333, 77.6667, 83.3333, 87.6667, 85.0000, 68.3333, 90.6667, 76.3333, 66.0000, 87.3333, 71.0000, 71.9833, 78.3333, 81.0000, 84.0000, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Mesin', 'Hukum', NULL, NULL),
(723, 11, 30, 95.0000, 82.3333, 85.0000, 90.0000, 72.0000, 83.3333, 66.0000, 85.0000, 73.3333, 90.0000, 93.3333, 74.6667, 87.3333, 72.3333, 71.9833, 78.3333, 81.0000, 84.0000, 'Basket', 'Tidak', 'Editing', 'Tidak', 'Tidak', 'Teknik Informatika', 'DKV', NULL, NULL),
(724, 11, 31, 53.3333, 66.0000, 67.6667, 80.0000, 74.0000, 47.3333, 66.0000, 78.3333, 65.0000, 57.6667, 76.3333, 62.6667, 74.0000, 75.0000, 71.9833, 78.3333, 81.0000, 84.0000, 'Futsal', 'Tidak', 'Bisnis', 'Basket', 'Tidak', 'Akuntansi', 'Manajemen', NULL, NULL),
(725, 11, 32, 71.6667, 71.6667, 73.0000, 88.3333, 87.0000, 73.3333, 74.6667, 73.6667, 58.3333, 84.0000, 58.3333, 48.0000, 87.0000, 89.0000, 71.9833, 78.3333, 81.0000, 84.0000, 'KIR', 'Tidak', 'Analisis', 'OSIS', 'Bimbel', 'Kedokteran', 'Teknik Informatika', NULL, NULL),
(726, 11, 33, 90.0000, 82.6667, 86.3333, 85.0000, 76.3333, 76.0000, 88.0000, 85.0000, 71.6667, 86.6667, 75.6667, 70.3333, 85.3333, 70.0000, 71.9833, 78.3333, 81.0000, 84.0000, 'Basket', 'Tidak', 'Gaming', 'Basket', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', NULL, NULL),
(727, 11, 34, 96.6667, 85.3333, 80.0000, 85.0000, 84.3333, 79.0000, 84.0000, 81.6667, 80.0000, 87.3333, 73.6667, 68.0000, 86.3333, 85.0000, 71.9833, 78.3333, 81.0000, 84.0000, 'Modern Dance', 'Tidak', 'Wirausaha', 'OSIS', 'Bimbel', 'Manajemen', 'Farmasi', NULL, NULL),
(728, 11, 35, 96.6667, 76.6667, 85.0000, 80.0000, 72.6667, 81.6667, 81.0000, 86.6667, 71.6667, 88.3333, 79.3333, 71.3333, 85.6667, 69.3333, 71.9833, 78.3333, 81.0000, 84.0000, 'Futsal', 'Tidak', 'Desain', 'Tidak', 'Tidak', 'DKV', 'Arsitektur', NULL, NULL),
(729, 11, 36, 91.6667, 82.3333, 84.6667, 85.0000, 64.6667, 80.0000, 83.3333, 83.3333, 66.6667, 80.0000, 71.3333, 65.0000, 85.3333, 62.3333, 71.9833, 78.3333, 81.0000, 84.0000, 'Basket', 'Tidak', 'Bisnis', 'Karang Taruna', 'Tidak', 'Manajemen', 'Ekonomi', NULL, NULL),
(730, 11, 37, 95.0000, 88.6667, 87.0000, 86.6667, 84.0000, 77.3333, 86.3333, 83.3333, 75.0000, 96.0000, 84.6667, 75.6667, 85.0000, 79.0000, 71.9833, 78.3333, 81.0000, 84.0000, 'Taekwondo', 'Tidak', 'Bela Diri', 'OSIS', 'Tidak', 'Ilmu Keolahragaan', 'Hukum', NULL, NULL),
(731, 11, 38, 93.3333, 86.6667, 87.0000, 88.3333, 71.0000, 82.6667, 83.3333, 82.0000, 76.6667, 84.0000, 74.3333, 77.0000, 87.3333, 68.3333, 71.9833, 78.3333, 81.0000, 84.0000, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Tidak', 'Tidak', 'Teknik Industri', 'Teknik Elektro', NULL, NULL),
(732, 11, 39, 81.6667, 54.3333, 50.0000, 83.3333, 53.6667, 75.6667, 57.6667, 53.6667, 76.6667, 72.6667, 62.3333, 53.0000, 84.3333, 81.6667, 71.9833, 78.3333, 81.0000, 84.0000, 'KIR', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Psikologi', NULL, NULL),
(733, 11, 40, 85.0000, 89.3333, 67.0000, 83.3333, 74.6667, 79.0000, 74.3333, 78.6667, 70.0000, 82.6667, 69.6667, 68.5000, 90.1667, 75.5000, 78.8100, 82.3333, 84.0000, 79.0000, 'Tari Tradisional', 'Tidak', 'Wirausaha', 'Karang Taruna', 'Bimbel', 'Manajemen', 'Akuntansi', NULL, NULL),
(734, 11, 41, 87.6667, 89.0000, 80.0000, 90.0000, 79.0000, 85.0000, 79.0000, 80.0000, 75.0000, 82.6667, 69.6667, 68.5000, 86.6667, 75.5000, 90.0000, 85.0000, 92.0000, 87.3333, 'Tari Tradisional', 'Juara harapan 1 FLS2N', 'Desain', 'Tidak', 'Bimbel', 'DKV', 'Arsitektur', NULL, NULL),
(735, 11, 42, 83.3333, 85.0000, 75.3333, 70.0000, 70.0000, 81.0000, 76.6667, 68.6667, 80.0000, 82.6667, 69.6667, 68.5000, 87.5000, 75.5000, 62.6200, 76.0000, 76.0000, 80.0000, 'Futsal', 'Juara 1 Lomba Futsal di SMA Penabur Bintaro Jaya 2024', 'Bermain Futsal', 'Karang Taruna', 'Tidak', 'Ilmu Keolahragaan', 'Teknik Elektro', NULL, NULL),
(736, 11, 43, 89.3333, 71.0000, 68.3333, 90.0000, 72.6667, 74.6667, 71.3333, 70.3333, 75.0000, 82.6667, 69.6667, 68.5000, 72.0000, 75.5000, 72.3800, 87.3333, 80.6667, 84.6667, 'Band', 'Tidak', 'Gaming', 'Tidak', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', NULL, NULL),
(737, 11, 44, 85.0000, 86.6667, 68.6667, 76.6667, 74.6667, 71.6667, 70.0000, 77.0000, 68.3333, 82.6667, 69.6667, 68.5000, 81.0000, 75.5000, 75.5567, 78.3333, 74.3333, 78.0000, 'Futsal', 'Tidak', 'Atletik', 'Tidak', 'Tidak', 'Pendidikan Jasmani', 'Ilmu Keolahragaan', NULL, NULL),
(738, 11, 45, 88.3333, 87.6667, 73.3333, 81.6667, 76.6667, 80.6667, 76.0000, 81.6667, 78.3333, 82.6667, 69.6667, 68.5000, 85.3333, 75.5000, 78.7300, 77.6667, 81.0000, 86.0000, 'Basket', 'Tidak', 'Public Speaking', 'Basket', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Sastra Inggris', NULL, NULL),
(739, 11, 46, 70.0000, 76.6667, 71.3333, 75.0000, 61.6667, 59.6667, 69.6667, 70.3333, 68.3333, 82.6667, 69.6667, 68.5000, 67.5000, 75.5000, 64.9667, 57.6667, 74.3333, 78.3333, 'Futsal', 'Tidak', 'Modifikasi Motor', 'OSIS', 'Tidak', 'Teknik Mesin', 'Teknik Industri', NULL, NULL),
(740, 11, 47, 75.0000, 80.0000, 68.3333, 78.3333, 63.0000, 68.0000, 72.3333, 70.3333, 66.6667, 82.6667, 69.6667, 68.5000, 74.1667, 75.5000, 57.5400, 69.3333, 74.0000, 81.6667, 'KIR', 'Tidak', 'Analisis', 'Tidak', 'Tidak', 'Hukum', 'Psikologi', NULL, NULL),
(741, 11, 48, 91.6667, 90.0000, 80.0000, 85.0000, 72.6667, 81.0000, 78.0000, 73.6667, 83.3333, 82.6667, 69.6667, 68.5000, 89.3333, 75.5000, 71.9033, 87.3333, 77.6667, 85.0000, 'Taekwondo', 'Tidak', 'Bela Diri', 'Karang Taruna', 'Pelatihan Saksi Partai', 'Hukum', 'Ilmu Komunikasi', NULL, NULL),
(742, 11, 49, 88.3333, 88.3333, 80.0000, 91.6667, 82.0000, 82.3333, 83.3333, 80.0000, 76.6667, 82.6667, 69.6667, 68.5000, 86.6667, 75.5000, 86.7467, 77.6667, 86.0000, 84.0000, 'Taekwondo', 'Juara 1 kejuaraan taekwondo liga DKI', 'Bela Diri', 'OSIS', 'Tidak', 'Hukum', 'Pendidikan Jasmani', NULL, NULL),
(743, 11, 50, 85.0000, 86.6667, 73.0000, 60.0000, 85.3333, 69.6667, 69.0000, 81.6667, 71.6667, 82.6667, 69.6667, 68.5000, 73.3333, 75.5000, 44.2067, 79.0000, 81.0000, 79.6667, 'Badminton', 'Tidak', 'Atletik', 'Badminton', 'Tidak', 'Pendidikan Jasmani', 'Sastra Indonesia', NULL, NULL),
(744, 11, 51, 88.3333, 91.0000, 80.0000, 85.0000, 71.3333, 82.6667, 83.0000, 77.0000, 83.3333, 82.6667, 69.6667, 68.5000, 81.6667, 75.5000, 82.0633, 84.6667, 72.3333, 85.0000, 'Taekwondo', 'Tidak', 'Bela Diri', 'Tidak', 'Tidak', 'Ilmu Keolahragaan', 'Teknik Mesin', NULL, NULL),
(745, 11, 52, 66.6667, 67.6667, 53.0000, 61.6667, 49.3333, 64.0000, 48.6667, 67.0000, 51.0000, 82.6667, 69.6667, 68.5000, 60.3333, 75.5000, 42.8567, 60.6667, 67.3333, 66.3333, 'Band', 'Tidak', 'Main Drum', 'OSIS', 'Tidak', 'Manajemen', 'Teknik Industri', NULL, NULL),
(746, 11, 53, 71.6667, 66.6667, 71.3333, 70.0000, 57.6667, 66.3333, 81.0000, 70.3333, 72.6667, 82.6667, 69.6667, 68.5000, 76.8333, 75.5000, 58.8100, 72.3333, 70.6667, 71.3333, 'Badminton', 'Tidak', 'Videografi', 'Badminton', 'Tidak', 'DKV', 'Teknik Informatika', NULL, NULL),
(747, 11, 54, 83.3333, 79.3333, 75.0000, 81.6667, 66.0000, 72.0000, 81.0000, 81.6667, 72.6667, 82.6667, 69.6667, 68.5000, 92.6667, 75.5000, 71.9833, 71.0000, 85.0000, 81.6667, 'Modern Dance', 'Tidak', 'Bisnis', 'Karang Taruna', 'Bimbel', 'Hukum', 'Akuntansi', NULL, NULL),
(748, 11, 55, 90.0000, 86.6667, 75.0000, 85.0000, 66.0000, 80.0000, 66.6667, 83.3333, 73.3333, 82.6667, 69.6667, 68.5000, 90.3333, 75.5000, 81.9833, 84.3333, 86.3333, 90.0000, 'Futsal', 'Juara 1 Lomba Futsal di SMA Penabur Bintaro Jaya 2024', 'Bermain Futsal', 'Karang Taruna', 'Tidak', 'Ilmu Komunikasi', 'Manajemen', NULL, NULL),
(749, 11, 56, 88.3333, 88.3333, 83.3333, 86.6667, 75.6667, 79.0000, 74.6667, 77.0000, 76.6667, 82.6667, 69.6667, 68.5000, 85.8333, 75.5000, 71.9833, 82.6667, 84.0000, 86.3333, 'Mading', 'Tidak', 'Melukis', 'Tidak', 'Bimbel', 'Manajemen', 'DKV', NULL, NULL),
(750, 11, 57, 70.0000, 66.6667, 56.6667, 73.3333, 75.0000, 51.3333, 52.3333, 67.0000, 58.3333, 82.6667, 69.6667, 68.5000, 72.6667, 75.5000, 68.9667, 61.6667, 70.6667, 75.0000, 'Tari Tradisional', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Psikologi', NULL, NULL),
(751, 11, 58, 91.6667, 90.0000, 81.0000, 88.3333, 77.0000, 89.6667, 77.6667, 78.6667, 75.0000, 82.6667, 69.6667, 68.5000, 87.3333, 75.5000, 85.0000, 89.3333, 89.0000, 90.0000, 'Modern Dance', 'Tidak', 'Wirausaha', 'Tidak', 'Bimbel', 'Manajemen', 'Akuntansi', NULL, NULL),
(752, 11, 59, 80.0000, 88.3333, 83.0000, 83.3333, 74.6667, 77.0000, 79.6667, 73.6667, 85.0000, 82.6667, 69.6667, 68.5000, 90.0000, 75.5000, 81.9833, 82.6667, 86.0000, 76.6667, 'Mading', 'Tidak', 'Menggambar', 'Karang Taruna', 'Tidak', 'Seni Rupa', 'DKV', NULL, NULL),
(753, 11, 60, 86.6667, 89.0000, 81.6667, 90.0000, 79.3333, 80.0000, 74.6667, 78.3333, 75.0000, 82.6667, 69.6667, 68.5000, 90.3333, 75.5000, 81.3167, 85.0000, 86.3333, 86.0000, 'KIR', 'Tidak', 'Analisis', 'PMR', 'Tidak', 'Ilmu Keperawatan', 'Farmasi', NULL, NULL),
(754, 11, 61, 83.3333, 89.3333, 71.6667, 85.0000, 73.3333, 86.0000, 78.0000, 77.0000, 77.6667, 82.6667, 69.6667, 68.5000, 89.3333, 75.5000, 78.5700, 81.0000, 72.3333, 85.3333, 'Band', 'Tidak', 'Main Gitar', 'Karang Taruna', 'Tidak', 'Manajemen', 'Hukum', NULL, NULL),
(755, 11, 62, 94.3333, 92.0000, 85.0000, 90.0000, 84.6667, 90.0000, 83.0000, 81.6667, 80.0000, 82.6667, 69.6667, 68.5000, 89.8333, 75.5000, 91.6667, 91.6667, 93.6667, 90.0000, 'KIR', 'Tidak', 'Analisis', 'PMR', 'Bimbel', 'Ilmu Keperawatan', 'Teknologi Pangan', NULL, NULL),
(756, 11, 63, 86.6667, 91.6667, 79.3333, 81.6667, 86.0000, 77.3333, 74.3333, 75.3333, 76.6667, 82.6667, 69.6667, 68.5000, 83.5000, 75.5000, 77.9033, 85.0000, 83.0000, 85.0000, 'Tari Tradisional', 'Tidak', 'Bisnis', 'OSIS', 'Bimbel', 'Akuntansi', 'Ekonomi', NULL, NULL),
(757, 11, 64, 83.3333, 88.3333, 79.3333, 81.6667, 77.0000, 78.3333, 72.6667, 72.0000, 75.0000, 82.6667, 69.6667, 68.5000, 77.1667, 75.5000, 78.8900, 83.0000, 77.6667, 82.3333, 'Badminton', 'Tidak', 'Public Speaking', 'Badminton', 'Kursus TOEFL', 'Sastra Inggris', 'Ilmu Komunikasi', NULL, NULL),
(758, 11, 65, 78.3333, 88.3333, 79.3333, 83.3333, 66.6667, 78.3333, 74.6667, 72.0000, 75.0000, 82.6667, 69.6667, 68.5000, 89.1667, 75.5000, 63.2233, 83.3333, 71.0000, 86.6667, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Tidak', 'Tidak', 'Teknik Industri', 'Teknik Elektro', NULL, NULL),
(759, 11, 66, 93.3333, 90.3333, 88.0000, 86.6667, 68.3333, 89.6667, 79.3333, 78.6667, 81.6667, 82.6667, 69.6667, 68.5000, 84.3333, 75.5000, 88.4133, 86.3333, 93.6667, 86.6667, 'Tari Tradisional', 'Tidak', 'Bisnis', 'Karang Taruna', 'Bimbel', 'Akuntansi', 'Hukum', NULL, NULL),
(760, 11, 67, 75.0000, 87.6667, 78.3333, 85.0000, 71.3333, 78.3333, 72.6667, 77.0000, 74.3333, 66.3333, 60.6667, 56.6667, 85.1667, 70.0000, 71.9833, 78.3333, 81.0000, 81.6667, 'KIR', 'Juara 2 kejuaraan pelajar nasional', 'Analisis', 'OSIS', 'Tidak', 'Teknologi Pangan', 'Arsitektur', NULL, NULL),
(761, 11, 68, 82.6667, 86.0000, 81.0000, 88.3333, 78.0000, 71.0000, 73.6667, 78.3333, 78.3333, 81.6667, 65.6667, 70.3333, 85.1667, 76.0000, 71.9833, 78.3333, 81.0000, 81.6667, 'Tari Tradisional', 'Tidak', 'Memasak', 'Tidak', 'Bimbel', 'Teknologi Pangan', 'Ilmu Komunikasi', NULL, NULL),
(762, 11, 69, 83.3333, 85.0000, 82.6667, 88.3333, 75.6667, 77.6667, 73.6667, 78.3333, 67.6667, 77.6667, 68.0000, 59.0000, 85.1667, 78.3333, 71.9833, 78.3333, 81.0000, 85.0000, 'Modern Dance', 'Tidak', 'Menari', 'Karang Taruna', 'Tidak', 'Seni Rupa', 'PGSD', NULL, NULL),
(763, 11, 70, 90.0000, 81.6667, 80.3333, 85.0000, 76.3333, 91.3333, 79.3333, 81.6667, 81.6667, 92.3333, 73.0000, 75.6667, 85.1667, 82.3333, 71.9833, 78.3333, 81.0000, 81.6667, 'Mading', 'Tidak', 'Videografi', 'Tidak', 'Bimbel', 'DKV', 'Teknik Informatika', NULL, NULL),
(764, 11, 71, 58.3333, 81.0000, 81.6667, 87.3333, 71.3333, 75.3333, 82.6667, 77.0000, 81.6667, 88.3333, 68.6667, 62.6667, 85.1667, 71.3333, 71.9833, 78.3333, 81.0000, 87.0000, 'Band', 'Tidak', 'Modifikasi Motor', 'OSIS', 'Bimbel', 'Teknik Mesin', 'Teknik Elektro', NULL, NULL),
(765, 11, 72, 90.0000, 88.3333, 75.0000, 93.3333, 77.3333, 91.6667, 78.0000, 81.6667, 83.3333, 88.6667, 69.3333, 86.6667, 85.1667, 80.6667, 71.9833, 78.3333, 81.0000, 83.3333, 'Mading', 'Tidak', 'Menggambar', 'Tidak', 'Bimbel', 'DKV', 'Arsitektur', NULL, NULL),
(766, 11, 73, 80.0000, 55.0000, 76.3333, 83.3333, 80.0000, 70.6667, 64.3333, 75.3333, 81.6667, 70.3333, 64.6667, 50.0000, 85.1667, 78.3333, 71.9833, 78.3333, 81.0000, 83.6667, 'Basket', 'Tidak', 'Bisnis', 'Basket', 'Tidak', 'Manajemen', 'Psikologi', NULL, NULL),
(767, 11, 74, 81.6667, 66.0000, 75.0000, 83.3333, 81.3333, 72.0000, 67.6667, 75.3333, 80.0000, 69.0000, 57.6667, 58.3333, 85.1667, 81.0000, 71.9833, 78.3333, 81.0000, 86.3333, 'Taekwondo', 'Tidak', 'Bela Diri', 'Karang Taruna', 'Tidak', 'Pendidikan Jasmani', 'Hukum', NULL, NULL),
(768, 11, 75, 81.6667, 88.3333, 79.6667, 83.3333, 73.3333, 74.3333, 84.6667, 77.0000, 78.3333, 66.6667, 61.6667, 63.3333, 85.1667, 66.0000, 71.9833, 78.3333, 81.0000, 81.6667, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Industri', 'Manajemen', NULL, NULL),
(769, 11, 76, 76.6667, 40.0000, 68.0000, 58.3333, 71.6667, 61.3333, 69.6667, 48.6667, 73.3333, 72.6667, 43.6667, 45.6667, 85.1667, 47.3333, 71.9833, 78.3333, 81.0000, 76.6667, 'Badminton', 'Tidak', 'Editing', 'Tidak', 'Tidak', 'DKV', 'Teknik Informatika', NULL, NULL),
(770, 11, 77, 81.6667, 73.3333, 73.3333, 86.6667, 86.0000, 80.6667, 71.0000, 80.0000, 73.3333, 88.3333, 65.0000, 78.3333, 85.1667, 85.0000, 71.9833, 78.3333, 81.0000, 87.6667, 'Mading', 'Tidak', 'Menggambar', 'Tidak', 'Tidak', 'Arsitektur', 'DKV', NULL, NULL),
(771, 11, 78, 90.0000, 80.6667, 83.3333, 88.3333, 83.3333, 81.0000, 81.3333, 83.3333, 85.0000, 90.6667, 80.6667, 76.3333, 85.1667, 80.6667, 71.9833, 78.3333, 81.0000, 90.0000, 'Futsal', 'Tidak', 'Wirausaha', 'Tidak', 'Tidak', 'Manajemen', 'Ekonomi', NULL, NULL),
(772, 11, 79, 78.3333, 77.3333, 66.6667, 80.0000, 63.3333, 75.3333, 62.0000, 76.6667, 78.3333, 76.6667, 52.3333, 63.3333, 85.1667, 61.0000, 71.9833, 78.3333, 81.0000, 75.3333, 'Futsal', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Tidak', 'Tidak', 'Teknik Informatika', 'Manajemen', NULL, NULL),
(773, 11, 80, 88.3333, 90.0000, 76.6667, 85.0000, 76.3333, 78.6667, 76.3333, 78.6667, 85.0000, 90.3333, 82.0000, 68.3333, 85.1667, 66.0000, 71.9833, 78.3333, 81.0000, 86.6667, 'Basket', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'OSIS', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', NULL, NULL),
(774, 11, 81, 78.3333, 81.6667, 79.6667, 73.3333, 73.3333, 78.6667, 79.6667, 77.0000, 74.3333, 68.6667, 60.3333, 68.6667, 85.1667, 61.6667, 71.9833, 78.3333, 81.0000, 77.3333, 'Futsal', 'Tidak', 'Public Speaking', 'Karang Taruna', 'Tidak', 'Hukum', 'Ilmu Komunikasi', NULL, NULL),
(775, 11, 82, 93.3333, 84.3333, 78.3333, 88.3333, 79.6667, 87.3333, 86.3333, 80.0000, 86.6667, 95.0000, 84.6667, 81.6667, 85.1667, 69.0000, 71.9833, 78.3333, 81.0000, 85.0000, 'Badminton', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Badminton', 'Tidak', 'Teknik Informatika', 'Teknik Elektro', NULL, NULL),
(776, 11, 83, 38.3333, 74.3333, 66.6667, 55.0000, 66.3333, 58.3333, 75.3333, 67.0000, 77.6667, 68.6667, 37.3333, 49.6667, 85.1667, 39.0000, 71.9833, 78.3333, 81.0000, 74.6667, 'Basket', 'Tidak', 'Videografi', 'Karang Taruna', 'Tidak', 'DKV', 'Manajemen', NULL, NULL),
(777, 11, 84, 92.6667, 80.0000, 78.3333, 71.6667, 86.6667, 76.0000, 73.0000, 75.3333, 75.0000, 88.3333, 64.6667, 66.3333, 85.1667, 78.3333, 71.9833, 78.3333, 81.0000, 79.3333, 'KIR', 'Tidak', 'Public Speaking', 'Tidak', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Sastra Inggris', NULL, NULL),
(778, 11, 85, 87.6667, 79.3333, 78.3333, 81.6667, 83.0000, 78.3333, 79.6667, 75.3333, 83.3333, 81.0000, 63.6667, 70.3333, 85.1667, 72.6667, 71.9833, 78.3333, 81.0000, 81.6667, 'Band', 'Juara 2 Solo Vokal M25 Cup SMA Muhammadh 25 Pamulang 2024', 'Menyanyi', 'OSIS', 'Tidak', 'Ilmu Komunikasi', 'Sastra Indonesia', NULL, NULL),
(779, 11, 86, 55.0000, 48.3333, 71.6667, 80.0000, 81.6667, 42.3333, 60.6667, 52.0000, 60.0000, 60.0000, 80.3333, 42.0000, 85.1667, 80.0000, 71.9833, 78.3333, 81.0000, 75.0000, 'Mading', 'Tidak', 'Melukis', 'Tidak', 'Melukis', 'Seni Rupa', 'DKV', NULL, NULL),
(780, 11, 87, 88.3333, 86.6667, 86.6667, 83.3333, 89.6667, 77.3333, 74.3333, 77.0000, 85.0000, 86.3333, 68.3333, 72.6667, 85.1667, 87.6667, 71.9833, 78.3333, 81.0000, 87.3333, 'Tari Tradisional', 'Tidak', 'Bisnis', 'Karang Taruna', 'Bimbel', 'Akuntansi', 'Ekonomi', NULL, NULL),
(781, 11, 88, 88.3333, 84.0000, 75.0000, 75.0000, 87.3333, 80.6667, 76.3333, 77.0000, 81.6667, 87.3333, 80.0000, 78.6667, 85.1667, 79.3333, 71.9833, 78.3333, 81.0000, 84.3333, 'Tari Tradisional', 'Tidak', 'Memasak', 'Tidak', 'Bimbel', 'Ilmu Keperawatan', 'Teknologi Pangan', NULL, NULL),
(782, 11, 89, 46.6667, 74.3333, 82.6667, 83.3333, 86.6667, 63.0000, 75.3333, 78.6667, 88.3333, 85.3333, 65.0000, 75.0000, 85.1667, 84.3333, 71.9833, 78.3333, 81.0000, 83.0000, 'KIR', 'Tidak', 'Analisis', 'Tidak', 'Bimbel', 'Arsitektur', 'Farmasi', NULL, NULL),
(783, 11, 90, 81.6667, 76.6667, 78.6667, 81.6667, 71.6667, 78.3333, 86.6667, 78.6667, 71.6667, 80.0000, 71.6667, 73.3333, 85.1667, 71.0000, 71.9833, 78.3333, 81.0000, 87.6667, 'Futsal', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Karang Taruna', 'Tidak', 'Manajemen', 'Teknik Informatika', NULL, NULL),
(784, 11, 91, 82.6667, 86.6667, 73.6667, 83.3333, 74.6667, 85.6667, 76.0000, 77.0000, 73.3333, 81.6667, 78.6667, 73.3333, 85.1667, 69.3333, 71.9833, 78.3333, 81.0000, 85.3333, 'Badminton', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Tidak', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', NULL, NULL),
(785, 11, 92, 90.0000, 87.0000, 75.3333, 83.3333, 82.6667, 70.0000, 63.3333, 65.3333, 78.3333, 87.3333, 91.3333, 74.6667, 0.0000, 83.3333, 71.9833, 78.3333, 81.0000, 87.0000, 'Tari Tradisional', 'Tidak', 'Wirausaha', 'Karang Taruna', 'Tidak', 'Akuntansi', 'Manajemen', NULL, NULL),
(786, 11, 93, 90.0000, 81.6667, 76.6667, 83.3333, 66.0000, 81.6667, 80.0000, 80.0000, 73.3333, 79.6667, 69.6667, 68.5000, 85.3333, 75.5000, 73.2233, 69.3333, 82.0000, 84.0000, 'Band', 'Tidak', 'Main Gitar', 'Karang Taruna', 'Pelatihan Saksi Partai', 'Hukum', 'Sastra Indonesia', NULL, NULL),
(787, 11, 94, 68.3333, 79.3333, 75.0000, 81.6667, 69.6667, 56.3333, 72.6667, 80.0000, 72.6667, 78.0000, 69.6667, 68.5000, 85.0000, 75.5000, 70.4767, 57.0000, 75.6667, 84.0000, 'Futsal', 'Tidak', 'Editing', 'Karang Taruna', 'Tidak', 'DKV', 'Teknik Informatika', NULL, NULL),
(788, 11, 95, 88.3333, 83.3333, 79.6667, 88.3333, 76.3333, 72.3333, 74.3333, 80.3333, 81.6667, 88.0000, 69.6667, 68.5000, 83.8333, 75.5000, 76.4767, 81.6667, 90.6667, 84.0000, 'Modern Dance', 'Tidak', 'Menari', 'Tidak', 'Tidak', 'Pendidikan Jasmani', 'Seni Rupa', NULL, NULL),
(789, 11, 96, 90.0000, 90.6667, 75.0000, 91.6667, 81.3333, 84.6667, 74.3333, 68.6667, 78.3333, 90.0000, 69.6667, 68.5000, 80.0000, 75.5000, 75.4767, 85.6667, 90.0000, 84.0000, 'Modern Dance', 'Tidak', 'Memasak', 'OSIS', 'Bimbel', 'Teknologi Pangan', 'Farmasi', NULL, NULL),
(790, 11, 97, 81.6667, 78.3333, 76.6667, 81.6667, 76.6667, 72.0000, 72.0000, 80.0000, 78.3333, 82.6667, 69.6667, 68.5000, 78.6667, 75.5000, 71.5567, 86.6667, 80.0000, 84.0000, 'KIR', 'Tidak', 'Wirausaha', 'OSIS', 'Tidak', 'Manajemen', 'Ekonomi', NULL, NULL),
(791, 11, 98, 71.6667, 80.6667, 73.3333, 86.6667, 82.6667, 74.3333, 64.3333, 67.0000, 71.6667, 82.3333, 69.6667, 68.5000, 80.0000, 75.5000, 57.8567, 72.3333, 71.6667, 84.0000, 'Mading', 'Tidak', 'Menggambar', 'Tidak', 'Tidak', 'DKV', 'Arsitektur', NULL, NULL),
(792, 11, 99, 80.0000, 63.3333, 71.6667, 85.0000, 85.0000, 48.6667, 67.3333, 68.6667, 71.6667, 82.6667, 69.6667, 68.5000, 75.3333, 75.5000, 69.0467, 67.0000, 75.0000, 84.0000, 'KIR', 'Tidak', 'Fotografi', 'PMR', 'Tidak', 'DKV', 'Ilmu Keperawatan', NULL, NULL),
(793, 11, 100, 63.3333, 65.6667, 61.3333, 81.6667, 59.3333, 48.3333, 75.3333, 70.3333, 66.6667, 72.0000, 69.6667, 68.5000, 70.8333, 75.5000, 47.7767, 52.3333, 66.0000, 84.0000, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Tidak', 'Tidak', 'Teknik Industri', 'Teknik Elektro', NULL, NULL),
(794, 11, 101, 71.6667, 73.3333, 61.3333, 56.6667, 64.3333, 67.3333, 69.3333, 70.3333, 67.6667, 56.6667, 69.6667, 68.5000, 87.1667, 75.5000, 52.6200, 67.6667, 76.0000, 84.0000, 'Band', 'Tidak', 'Analisis', 'Tidak', 'Bimbel', 'Kedokteran', 'Teknik Industri', NULL, NULL),
(795, 11, 102, 63.3333, 70.0000, 71.3333, 86.6667, 64.3333, 57.6667, 82.6667, 72.0000, 64.3333, 75.0000, 69.6667, 68.5000, 83.8333, 75.5000, 67.3800, 66.0000, 72.3333, 84.0000, 'Taekwondo', 'Tidak', 'Bisnis', 'Tidak', 'Tidak', 'Teknik Informatika', 'Pendidikan Jasmani', NULL, NULL),
(796, 11, 103, 85.0000, 75.6667, 73.3333, 86.6667, 74.0000, 74.3333, 79.3333, 77.0000, 70.0000, 84.0000, 69.6667, 68.5000, 84.6667, 75.5000, 70.1267, 67.6667, 85.0000, 84.0000, 'Basket', 'Tidak', 'Gaming', 'Basket', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', NULL, NULL),
(797, 11, 104, 78.3333, 72.6667, 76.6667, 90.0000, 71.6667, 79.0000, 80.0000, 81.6667, 74.3333, 75.3333, 69.6667, 68.5000, 81.6667, 75.5000, 78.1433, 80.0000, 81.0000, 84.0000, 'Futsal', 'Tidak', 'Desain', 'Tidak', 'Tidak', 'DKV', 'Teknik Informatika', NULL, NULL),
(798, 11, 105, 80.0000, 70.0000, 78.3333, 86.6667, 79.6667, 86.3333, 74.3333, 81.6667, 64.3333, 78.0000, 69.6667, 68.5000, 77.5000, 75.5000, 81.9833, 79.6667, 86.0000, 84.0000, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Industri', 'Hukum', NULL, NULL),
(799, 11, 106, 80.0000, 81.6667, 74.6667, 86.6667, 71.6667, 74.3333, 74.6667, 72.0000, 78.3333, 72.0000, 69.6667, 68.5000, 86.6667, 75.5000, 77.0633, 72.3333, 82.3333, 84.0000, 'Badminton', 'Tidak', 'Public Speaking', 'OSIS', 'Tidak', 'Hukum', 'Psikologi', NULL, NULL),
(800, 11, 107, 68.3333, 62.6667, 51.6667, 78.3333, 51.3333, 68.0000, 74.0000, 73.6667, 56.6667, 69.3333, 69.6667, 68.5000, 81.6667, 75.5000, 59.2867, 69.6667, 77.3333, 84.0000, 'KIR', 'Tidak', 'Bisnis', 'OSIS', 'Tidak', 'Manajemen', 'Akuntansi', NULL, NULL),
(801, 11, 108, 78.3333, 74.3333, 84.6667, 90.0000, 68.0000, 78.0000, 74.0000, 75.3333, 76.0000, 83.0000, 69.6667, 68.5000, 88.0000, 75.5000, 70.5567, 79.0000, 74.0000, 84.0000, 'KIR', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Sastra Inggris', NULL, NULL),
(802, 11, 109, 75.0000, 71.0000, 64.6667, 80.0000, 48.0000, 71.6667, 76.0000, 72.0000, 71.0000, 73.0000, 69.6667, 68.5000, 76.0000, 75.5000, 69.2867, 69.0000, 78.0000, 84.0000, 'Futsal', 'Tidak', 'Desain', 'Tidak', 'Tidak', 'Ilmu Komputer', 'DKV', NULL, NULL),
(803, 11, 110, 68.3333, 75.0000, 65.6667, 76.6667, 50.0000, 63.0000, 78.0000, 76.6667, 70.0000, 70.6667, 69.6667, 68.5000, 79.1667, 75.5000, 56.0333, 71.3333, 73.0000, 84.0000, 'Taekwondo', 'Tidak', 'Bela Diri', 'Karang Taruna', 'Tidak', 'Pendidikan Jasmani', 'Sastra Indonesia', NULL, NULL),
(804, 11, 111, 80.0000, 81.6667, 83.3333, 86.6667, 52.6667, 78.3333, 72.6667, 75.3333, 73.3333, 89.6667, 69.6667, 68.5000, 83.3333, 75.5000, 70.6333, 77.3333, 81.0000, 84.0000, 'Basket', 'Tidak', 'Atletik', 'Basket', 'Tidak', 'Ilmu Keolahragaan', 'Pendidikan Jasmani', NULL, NULL),
(805, 11, 112, 81.6667, 80.0000, 68.3333, 91.6667, 78.3333, 67.3333, 76.0000, 72.0000, 73.3333, 89.6667, 69.6667, 68.5000, 80.5000, 75.5000, 79.8100, 86.0000, 89.3333, 84.0000, 'KIR', 'Tidak', 'Desain', 'OSIS', 'Kursus TOEFL', 'Sastra Inggris', 'Ilmu Komunikasi', NULL, NULL),
(806, 11, 113, 83.3333, 71.6667, 63.3333, 73.3333, 78.3333, 63.3333, 62.6667, 75.0000, 70.0000, 76.6667, 69.6667, 68.5000, 81.1667, 75.5000, 71.5567, 64.3333, 77.6667, 84.0000, 'Modern Dance', 'Tidak', 'Bisnis', 'Tidak', 'Tidak', 'Akuntansi', 'Manajemen', NULL, NULL),
(807, 11, 114, 81.6667, 82.6667, 66.0000, 81.6667, 80.6667, 70.0000, 69.6667, 70.3333, 70.0000, 73.0000, 69.6667, 68.5000, 87.5000, 75.5000, 60.3667, 61.6667, 86.0000, 84.0000, 'Modern Dance', 'Tidak', 'Public Speaking', 'OSIS', 'Bimbel', 'Ilmu Komunikasi', 'Sastra Inggris', NULL, NULL),
(808, 11, 115, 85.0000, 83.6667, 78.3333, 81.6667, 66.0000, 70.6667, 78.0000, 72.0000, 65.0000, 83.3333, 69.6667, 68.5000, 83.0000, 75.5000, 77.2233, 76.6667, 87.3333, 84.0000, 'Badminton', 'Tidak', 'Atletik', 'Badminton', 'Tidak', 'Ilmu Keolahragaan', 'Pendidikan Jasmani', NULL, NULL),
(809, 11, 116, 86.6667, 86.6667, 75.0000, 88.3333, 80.6667, 81.0000, 72.3333, 76.6667, 83.3333, 85.3333, 69.6667, 68.5000, 89.3333, 75.5000, 79.5700, 87.3333, 90.0000, 84.0000, 'Tari Tradisional', 'Tidak', 'Memasak', 'Tidak', 'Bimbel', 'Teknologi Pangan', 'Farmasi', NULL, NULL),
(810, 11, 117, 83.3333, 85.0000, 80.0000, 88.3333, 82.3333, 83.0000, 74.3333, 75.3333, 80.0000, 81.6667, 69.6667, 68.5000, 89.5000, 75.5000, 80.2367, 82.6667, 88.3333, 84.0000, 'Mading', 'Tidak', 'Public Speaking', 'Karang Taruna', 'Tidak', 'Psikologi', 'Ilmu Komunikasi', NULL, NULL),
(811, 11, 118, 64.6667, 56.0000, 45.0000, 56.6667, 81.6667, 51.6667, 54.6667, 52.0000, 50.0000, 64.6667, 69.6667, 68.5000, 53.3333, 75.5000, 47.7767, 50.6667, 78.3333, 84.0000, 'Modern Dance', 'Tidak', 'Bisnis', 'Tidak', 'Tidak', 'Manajemen', 'Ekonomi', NULL, NULL),
(812, 11, 119, 88.3333, 75.0000, 71.6667, 81.6667, 78.3333, 74.0000, 64.6667, 72.0000, 71.6667, 82.0000, 69.6667, 68.5000, 84.5000, 75.5000, 71.5567, 72.3333, 91.3333, 84.0000, 'Mading', 'Tidak', 'Menggambar', 'Karang Taruna', 'Bimbel', 'Arsitektur', 'DKV', NULL, NULL),
(813, 11, 120, 90.0000, 87.3333, 80.0000, 83.3333, 80.0000, 77.6667, 74.6667, 73.6667, 80.0000, 85.0000, 69.6667, 68.5000, 89.5000, 75.5000, 83.4933, 85.6667, 91.3333, 84.0000, 'Basket', 'Tidak', 'Bisnis', 'Basket', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Manajemen', NULL, NULL);

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
(683, 11, 16, 96.6667, 92.0000, 87.0000, 85.0000, 83.3333, 88.0000, 84.3333, 83.6667, 76.6667, 96.0000, 95.0000, 76.6667, 86.0000, 77.3333, NULL, NULL, NULL, NULL, 'Badminton', 'Tidak', 'Modifikasi Motor', 'Badminton', 'Tidak', 'Teknik Mesin', 'Pendidikan Jasmani', NULL, NULL),
(684, 11, 17, 80.0000, 79.3333, 79.0000, 81.6667, 73.0000, 81.6667, 77.6667, 75.3333, 69.3333, 78.0000, 64.0000, 68.0000, 83.0000, 67.6667, NULL, NULL, NULL, NULL, 'Futsal', 'Tidak', 'Bermain Futsal', 'Karang Taruna', 'Tidak', 'Manajemen', 'Ilmu Keolahragaan', NULL, NULL),
(685, 11, 18, 88.3333, 86.0000, 81.6667, 88.3333, 79.3333, 80.3333, 85.6667, 75.3333, 78.3333, 93.3333, 75.6667, 75.6667, 85.3333, 69.3333, NULL, NULL, NULL, NULL, 'Band', 'Tidak', 'Main Gitar', 'OSIS', 'Bimbel', 'Psikologi', 'Sastra Indonesia', NULL, NULL),
(686, 11, 19, 48.3333, 75.0000, 75.0000, 58.3333, 76.6667, 59.3333, 71.6667, 62.0000, 53.3333, 53.0000, 53.6667, 45.3333, 80.3333, 46.6667, NULL, NULL, NULL, NULL, 'Futsal', 'Tidak', 'Bermain Futsal', 'Tidak', 'Tidak', 'Manajemen', 'Ekonomi', NULL, NULL),
(687, 11, 20, 90.0000, 88.3333, 81.6667, 80.0000, 78.0000, 89.3333, 82.0000, 81.6667, 75.0000, 95.6667, 82.0000, 75.3333, 87.3333, 76.0000, NULL, NULL, NULL, NULL, 'Modern Dance', 'Tidak', 'Bisnis', 'Karang Taruna', 'Tidak', 'Manajemen', 'Akuntansi', NULL, NULL),
(688, 11, 21, 88.3333, 78.3333, 81.6667, 88.3333, 83.6667, 71.0000, 76.0000, 81.6667, 70.0000, 88.0000, 55.3333, 57.6667, 87.3333, 81.0000, NULL, NULL, NULL, NULL, 'Badminton', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Sastra Inggris', 'Ilmu Komunikasi', NULL, NULL),
(689, 11, 22, 81.6667, 73.3333, 77.0000, 76.6667, 73.0000, 57.3333, 74.6667, 63.6667, 73.3333, 74.3333, 70.0000, 56.6667, 79.6667, 68.3333, NULL, NULL, NULL, NULL, 'Taekwondo', 'Tidak', 'Bela Diri', 'Tidak', 'Tidak', 'Ilmu Keolahragaan', 'Pendidikan Jasmani', NULL, NULL),
(690, 11, 23, 81.0000, 80.0000, 50.0000, 78.3333, 73.3333, 66.6667, 54.3333, 78.6667, 76.6667, 86.0000, 60.6667, 75.0000, 85.6667, 69.3333, NULL, NULL, NULL, NULL, 'Badminton', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Industri', 'Teknik Elektro', NULL, NULL),
(691, 11, 24, 93.3333, 87.6667, 88.0000, 88.3333, 87.0000, 87.6667, 82.6667, 85.0000, 85.0000, 92.6667, 86.3333, 85.6667, 87.6667, 75.6667, NULL, NULL, NULL, NULL, 'Basket', 'Tidak', 'Main Basket', 'Tidak', 'Tidak', 'Manajemen', 'Hukum', NULL, NULL),
(692, 11, 25, 78.3333, 82.6667, 78.0000, 88.3333, 82.3333, 72.3333, 79.3333, 80.3333, 80.0000, 95.0000, 64.3333, 74.6667, 86.3333, 79.0000, NULL, NULL, NULL, NULL, 'Tari Tradisional', 'Runner Up Puteri Remaja Indonesia Lingkungan Jakarta 2024', 'Menari', 'OSIS', 'Bimbel', 'Ilmu Komunikasi', 'Psikologi', NULL, NULL),
(693, 11, 26, 88.3333, 80.0000, 79.6667, 90.0000, 83.3333, 74.0000, 85.0000, 86.6667, 78.3333, 92.6667, 74.6667, 65.0000, 90.0000, 80.0000, NULL, NULL, NULL, NULL, 'Badminton', 'Tidak', 'Menggambar', 'Badminton', 'Bimbel', 'Arsitektur', 'DKV', NULL, NULL),
(694, 11, 27, 83.3333, 81.6667, 78.0000, 85.0000, 86.6667, 77.0000, 80.0000, 83.3333, 75.0000, 77.3333, 69.0000, 63.0000, 89.3333, 83.3333, NULL, NULL, NULL, NULL, 'Mading', 'Tidak', 'Fotografi', 'Tidak', 'Bimbel', 'DKV', 'Manajemen', NULL, NULL),
(695, 11, 28, 90.6667, 80.0000, 88.0000, 87.3333, 79.0000, 81.6667, 84.3333, 81.6667, 65.0000, 87.6667, 77.3333, 63.0000, 84.0000, 75.3333, NULL, NULL, NULL, NULL, 'Futsal', 'Tidak', 'Videografi', 'Karang Taruna', 'Bimbel', 'DKV', 'Teknik Informatika', NULL, NULL),
(696, 11, 29, 91.6667, 85.0000, 85.0000, 88.3333, 77.6667, 83.3333, 87.6667, 85.0000, 68.3333, 90.6667, 76.3333, 66.0000, 87.3333, 71.0000, NULL, NULL, NULL, NULL, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Mesin', 'Hukum', NULL, NULL),
(697, 11, 30, 95.0000, 82.3333, 85.0000, 90.0000, 72.0000, 83.3333, 66.0000, 85.0000, 73.3333, 90.0000, 93.3333, 74.6667, 87.3333, 72.3333, NULL, NULL, NULL, NULL, 'Basket', 'Tidak', 'Editing', 'Tidak', 'Tidak', 'Teknik Informatika', 'DKV', NULL, NULL),
(698, 11, 31, 53.3333, 66.0000, 67.6667, 80.0000, 74.0000, 47.3333, 66.0000, 78.3333, 65.0000, 57.6667, 76.3333, 62.6667, 74.0000, 75.0000, NULL, NULL, NULL, NULL, 'Futsal', 'Tidak', 'Bisnis', 'Basket', 'Tidak', 'Akuntansi', 'Manajemen', NULL, NULL),
(699, 11, 32, 71.6667, 71.6667, 73.0000, 88.3333, 87.0000, 73.3333, 74.6667, 73.6667, 58.3333, 84.0000, 58.3333, 48.0000, 87.0000, 89.0000, NULL, NULL, NULL, NULL, 'KIR', 'Tidak', 'Analisis', 'OSIS', 'Bimbel', 'Kedokteran', 'Teknik Informatika', NULL, NULL),
(700, 11, 33, 90.0000, 82.6667, 86.3333, 85.0000, 76.3333, 76.0000, 88.0000, 85.0000, 71.6667, 86.6667, 75.6667, 70.3333, 85.3333, 70.0000, NULL, NULL, NULL, NULL, 'Basket', 'Tidak', 'Gaming', 'Basket', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', NULL, NULL),
(701, 11, 34, 96.6667, 85.3333, 80.0000, 85.0000, 84.3333, 79.0000, 84.0000, 81.6667, 80.0000, 87.3333, 73.6667, 68.0000, 86.3333, 85.0000, NULL, NULL, NULL, NULL, 'Modern Dance', 'Tidak', 'Wirausaha', 'OSIS', 'Bimbel', 'Manajemen', 'Farmasi', NULL, NULL),
(702, 11, 35, 96.6667, 76.6667, 85.0000, 80.0000, 72.6667, 81.6667, 81.0000, 86.6667, 71.6667, 88.3333, 79.3333, 71.3333, 85.6667, 69.3333, NULL, NULL, NULL, NULL, 'Futsal', 'Tidak', 'Desain', 'Tidak', 'Tidak', 'DKV', 'Arsitektur', NULL, NULL),
(703, 11, 36, 91.6667, 82.3333, 84.6667, 85.0000, 64.6667, 80.0000, 83.3333, 83.3333, 66.6667, 80.0000, 71.3333, 65.0000, 85.3333, 62.3333, NULL, NULL, NULL, NULL, 'Basket', 'Tidak', 'Bisnis', 'Karang Taruna', 'Tidak', 'Manajemen', 'Ekonomi', NULL, NULL),
(704, 11, 37, 95.0000, 88.6667, 87.0000, 86.6667, 84.0000, 77.3333, 86.3333, 83.3333, 75.0000, 96.0000, 84.6667, 75.6667, 85.0000, 79.0000, NULL, NULL, NULL, NULL, 'Taekwondo', 'Tidak', 'Bela Diri', 'OSIS', 'Tidak', 'Ilmu Keolahragaan', 'Hukum', NULL, NULL),
(705, 11, 38, 93.3333, 86.6667, 87.0000, 88.3333, 71.0000, 82.6667, 83.3333, 82.0000, 76.6667, 84.0000, 74.3333, 77.0000, 87.3333, 68.3333, NULL, NULL, NULL, NULL, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Tidak', 'Tidak', 'Teknik Industri', 'Teknik Elektro', NULL, NULL),
(706, 11, 39, 81.6667, 54.3333, 50.0000, 83.3333, 53.6667, 75.6667, 57.6667, 53.6667, 76.6667, 72.6667, 62.3333, 53.0000, 84.3333, 81.6667, NULL, NULL, NULL, NULL, 'KIR', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Psikologi', NULL, NULL),
(707, 11, 40, 85.0000, 89.3333, 67.0000, 83.3333, 74.6667, 79.0000, 74.3333, 78.6667, 70.0000, NULL, NULL, NULL, 90.1667, NULL, 78.8100, 82.3333, 84.0000, 79.0000, 'Tari Tradisional', 'Tidak', 'Wirausaha', 'Karang Taruna', 'Bimbel', 'Manajemen', 'Akuntansi', NULL, NULL),
(708, 11, 41, 87.6667, 89.0000, 80.0000, 90.0000, 79.0000, 85.0000, 79.0000, 80.0000, 75.0000, NULL, NULL, NULL, 86.6667, NULL, 90.0000, 85.0000, 92.0000, 87.3333, 'Tari Tradisional', 'Juara harapan 1 FLS2N', 'Desain', 'Tidak', 'Bimbel', 'DKV', 'Arsitektur', NULL, NULL),
(709, 11, 42, 83.3333, 85.0000, 75.3333, 70.0000, 70.0000, 81.0000, 76.6667, 68.6667, 80.0000, NULL, NULL, NULL, 87.5000, NULL, 62.6200, 76.0000, 76.0000, 80.0000, 'Futsal', 'Juara 1 Lomba Futsal di SMA Penabur Bintaro Jaya 2024', 'Bermain Futsal', 'Karang Taruna', 'Tidak', 'Ilmu Keolahragaan', 'Teknik Elektro', NULL, NULL),
(710, 11, 43, 89.3333, 71.0000, 68.3333, 90.0000, 72.6667, 74.6667, 71.3333, 70.3333, 75.0000, NULL, NULL, NULL, 72.0000, NULL, 72.3800, 87.3333, 80.6667, 84.6667, 'Band', 'Tidak', 'Gaming', 'Tidak', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', NULL, NULL),
(711, 11, 44, 85.0000, 86.6667, 68.6667, 76.6667, 74.6667, 71.6667, 70.0000, 77.0000, 68.3333, NULL, NULL, NULL, 81.0000, NULL, 75.5567, 78.3333, 74.3333, 78.0000, 'Futsal', 'Tidak', 'Atletik', 'Tidak', 'Tidak', 'Pendidikan Jasmani', 'Ilmu Keolahragaan', NULL, NULL),
(712, 11, 45, 88.3333, 87.6667, 73.3333, 81.6667, 76.6667, 80.6667, 76.0000, 81.6667, 78.3333, NULL, NULL, NULL, 85.3333, NULL, 78.7300, 77.6667, 81.0000, 86.0000, 'Basket', 'Tidak', 'Public Speaking', 'Basket', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Sastra Inggris', NULL, NULL),
(713, 11, 46, 70.0000, 76.6667, 71.3333, 75.0000, 61.6667, 59.6667, 69.6667, 70.3333, 68.3333, NULL, NULL, NULL, 67.5000, NULL, 64.9667, 57.6667, 74.3333, 78.3333, 'Futsal', 'Tidak', 'Modifikasi Motor', 'OSIS', 'Tidak', 'Teknik Mesin', 'Teknik Industri', NULL, NULL),
(714, 11, 47, 75.0000, 80.0000, 68.3333, 78.3333, 63.0000, 68.0000, 72.3333, 70.3333, 66.6667, NULL, NULL, NULL, 74.1667, NULL, 57.5400, 69.3333, 74.0000, 81.6667, 'KIR', 'Tidak', 'Analisis', 'Tidak', 'Tidak', 'Hukum', 'Psikologi', NULL, NULL),
(715, 11, 48, 91.6667, 90.0000, 80.0000, 85.0000, 72.6667, 81.0000, 78.0000, 73.6667, 83.3333, NULL, NULL, NULL, 89.3333, NULL, 71.9033, 87.3333, 77.6667, 85.0000, 'Taekwondo', 'Tidak', 'Bela Diri', 'Karang Taruna', 'Pelatihan Saksi Partai', 'Hukum', 'Ilmu Komunikasi', NULL, NULL),
(716, 11, 49, 88.3333, 88.3333, 80.0000, 91.6667, 82.0000, 82.3333, 83.3333, 80.0000, 76.6667, NULL, NULL, NULL, 86.6667, NULL, 86.7467, 77.6667, 86.0000, 84.0000, 'Taekwondo', 'Juara 1 kejuaraan taekwondo liga DKI', 'Bela Diri', 'OSIS', 'Tidak', 'Hukum', 'Pendidikan Jasmani', NULL, NULL),
(717, 11, 50, 85.0000, 86.6667, 73.0000, 60.0000, 85.3333, 69.6667, 69.0000, 81.6667, 71.6667, NULL, NULL, NULL, 73.3333, NULL, 44.2067, 79.0000, 81.0000, 79.6667, 'Badminton', 'Tidak', 'Atletik', 'Badminton', 'Tidak', 'Pendidikan Jasmani', 'Sastra Indonesia', NULL, NULL),
(718, 11, 51, 88.3333, 91.0000, 80.0000, 85.0000, 71.3333, 82.6667, 83.0000, 77.0000, 83.3333, NULL, NULL, NULL, 81.6667, NULL, 82.0633, 84.6667, 72.3333, 85.0000, 'Taekwondo', 'Tidak', 'Bela Diri', 'Tidak', 'Tidak', 'Ilmu Keolahragaan', 'Teknik Mesin', NULL, NULL),
(719, 11, 52, 66.6667, 67.6667, 53.0000, 61.6667, 49.3333, 64.0000, 48.6667, 67.0000, 51.0000, NULL, NULL, NULL, 60.3333, NULL, 42.8567, 60.6667, 67.3333, 66.3333, 'Band', 'Tidak', 'Main Drum', 'OSIS', 'Tidak', 'Manajemen', 'Teknik Industri', NULL, NULL),
(720, 11, 53, 71.6667, 66.6667, 71.3333, 70.0000, 57.6667, 66.3333, 81.0000, 70.3333, 72.6667, NULL, NULL, NULL, 76.8333, NULL, 58.8100, 72.3333, 70.6667, 71.3333, 'Badminton', 'Tidak', 'Videografi', 'Badminton', 'Tidak', 'DKV', 'Teknik Informatika', NULL, NULL),
(721, 11, 54, 83.3333, 79.3333, 75.0000, 81.6667, 66.0000, 72.0000, 81.0000, 81.6667, 72.6667, NULL, NULL, NULL, 92.6667, NULL, 71.9833, 71.0000, 85.0000, 81.6667, 'Modern Dance', 'Tidak', 'Bisnis', 'Karang Taruna', 'Bimbel', 'Hukum', 'Akuntansi', NULL, NULL),
(722, 11, 55, 90.0000, 86.6667, 75.0000, 85.0000, 66.0000, 80.0000, 66.6667, 83.3333, 73.3333, NULL, NULL, NULL, 90.3333, NULL, 81.9833, 84.3333, 86.3333, 90.0000, 'Futsal', 'Juara 1 Lomba Futsal di SMA Penabur Bintaro Jaya 2024', 'Bermain Futsal', 'Karang Taruna', 'Tidak', 'Ilmu Komunikasi', 'Manajemen', NULL, NULL),
(723, 11, 56, 88.3333, 88.3333, 83.3333, 86.6667, 75.6667, 79.0000, 74.6667, 77.0000, 76.6667, NULL, NULL, NULL, 85.8333, NULL, 71.9833, 82.6667, 84.0000, 86.3333, 'Mading', 'Tidak', 'Melukis', 'Tidak', 'Bimbel', 'Manajemen', 'DKV', NULL, NULL),
(724, 11, 57, 70.0000, 66.6667, 56.6667, 73.3333, 75.0000, 51.3333, 52.3333, 67.0000, 58.3333, NULL, NULL, NULL, 72.6667, NULL, 68.9667, 61.6667, 70.6667, 75.0000, 'Tari Tradisional', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Psikologi', NULL, NULL),
(725, 11, 58, 91.6667, 90.0000, 81.0000, 88.3333, 77.0000, 89.6667, 77.6667, 78.6667, 75.0000, NULL, NULL, NULL, 87.3333, NULL, 85.0000, 89.3333, 89.0000, 90.0000, 'Modern Dance', 'Tidak', 'Wirausaha', 'Tidak', 'Bimbel', 'Manajemen', 'Akuntansi', NULL, NULL),
(726, 11, 59, 80.0000, 88.3333, 83.0000, 83.3333, 74.6667, 77.0000, 79.6667, 73.6667, 85.0000, NULL, NULL, NULL, 90.0000, NULL, 81.9833, 82.6667, 86.0000, 76.6667, 'Mading', 'Tidak', 'Menggambar', 'Karang Taruna', 'Tidak', 'Seni Rupa', 'DKV', NULL, NULL),
(727, 11, 60, 86.6667, 89.0000, 81.6667, 90.0000, 79.3333, 80.0000, 74.6667, 78.3333, 75.0000, NULL, NULL, NULL, 90.3333, NULL, 81.3167, 85.0000, 86.3333, 86.0000, 'KIR', 'Tidak', 'Analisis', 'PMR', 'Tidak', 'Ilmu Keperawatan', 'Farmasi', NULL, NULL),
(728, 11, 61, 83.3333, 89.3333, 71.6667, 85.0000, 73.3333, 86.0000, 78.0000, 77.0000, 77.6667, NULL, NULL, NULL, 89.3333, NULL, 78.5700, 81.0000, 72.3333, 85.3333, 'Band', 'Tidak', 'Main Gitar', 'Karang Taruna', 'Tidak', 'Manajemen', 'Hukum', NULL, NULL),
(729, 11, 62, 94.3333, 92.0000, 85.0000, 90.0000, 84.6667, 90.0000, 83.0000, 81.6667, 80.0000, NULL, NULL, NULL, 89.8333, NULL, 91.6667, 91.6667, 93.6667, 90.0000, 'KIR', 'Tidak', 'Analisis', 'PMR', 'Bimbel', 'Ilmu Keperawatan', 'Teknologi Pangan', NULL, NULL),
(730, 11, 63, 86.6667, 91.6667, 79.3333, 81.6667, 86.0000, 77.3333, 74.3333, 75.3333, 76.6667, NULL, NULL, NULL, 83.5000, NULL, 77.9033, 85.0000, 83.0000, 85.0000, 'Tari Tradisional', 'Tidak', 'Bisnis', 'OSIS', 'Bimbel', 'Akuntansi', 'Ekonomi', NULL, NULL),
(731, 11, 64, 83.3333, 88.3333, 79.3333, 81.6667, 77.0000, 78.3333, 72.6667, 72.0000, 75.0000, NULL, NULL, NULL, 77.1667, NULL, 78.8900, 83.0000, 77.6667, 82.3333, 'Badminton', 'Tidak', 'Public Speaking', 'Badminton', 'Kursus TOEFL', 'Sastra Inggris', 'Ilmu Komunikasi', NULL, NULL),
(732, 11, 65, 78.3333, 88.3333, 79.3333, 83.3333, 66.6667, 78.3333, 74.6667, 72.0000, 75.0000, NULL, NULL, NULL, 89.1667, NULL, 63.2233, 83.3333, 71.0000, 86.6667, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Tidak', 'Tidak', 'Teknik Industri', 'Teknik Elektro', NULL, NULL),
(733, 11, 66, 93.3333, 90.3333, 88.0000, 86.6667, 68.3333, 89.6667, 79.3333, 78.6667, 81.6667, NULL, NULL, NULL, 84.3333, NULL, 88.4133, 86.3333, 93.6667, 86.6667, 'Tari Tradisional', 'Tidak', 'Bisnis', 'Karang Taruna', 'Bimbel', 'Akuntansi', 'Hukum', NULL, NULL),
(734, 11, 67, 75.0000, 87.6667, 78.3333, 85.0000, 71.3333, 78.3333, 72.6667, 77.0000, 74.3333, 66.3333, 60.6667, 56.6667, NULL, 70.0000, NULL, NULL, NULL, 81.6667, 'KIR', 'Juara 2 kejuaraan pelajar nasional', 'Analisis', 'OSIS', 'Tidak', 'Teknologi Pangan', 'Arsitektur', NULL, NULL),
(735, 11, 68, 82.6667, 86.0000, 81.0000, 88.3333, 78.0000, 71.0000, 73.6667, 78.3333, 78.3333, 81.6667, 65.6667, 70.3333, NULL, 76.0000, NULL, NULL, NULL, 81.6667, 'Tari Tradisional', 'Tidak', 'Memasak', 'Tidak', 'Bimbel', 'Teknologi Pangan', 'Ilmu Komunikasi', NULL, NULL),
(736, 11, 69, 83.3333, 85.0000, 82.6667, 88.3333, 75.6667, 77.6667, 73.6667, 78.3333, 67.6667, 77.6667, 68.0000, 59.0000, NULL, 78.3333, NULL, NULL, NULL, 85.0000, 'Modern Dance', 'Tidak', 'Menari', 'Karang Taruna', 'Tidak', 'Seni Rupa', 'PGSD', NULL, NULL),
(737, 11, 70, 90.0000, 81.6667, 80.3333, 85.0000, 76.3333, 91.3333, 79.3333, 81.6667, 81.6667, 92.3333, 73.0000, 75.6667, NULL, 82.3333, NULL, NULL, NULL, 81.6667, 'Mading', 'Tidak', 'Videografi', 'Tidak', 'Bimbel', 'DKV', 'Teknik Informatika', NULL, NULL),
(738, 11, 71, 58.3333, 81.0000, 81.6667, 87.3333, 71.3333, 75.3333, 82.6667, 77.0000, 81.6667, 88.3333, 68.6667, 62.6667, NULL, 71.3333, NULL, NULL, NULL, 87.0000, 'Band', 'Tidak', 'Modifikasi Motor', 'OSIS', 'Bimbel', 'Teknik Mesin', 'Teknik Elektro', NULL, NULL),
(739, 11, 72, 90.0000, 88.3333, 75.0000, 93.3333, 77.3333, 91.6667, 78.0000, 81.6667, 83.3333, 88.6667, 69.3333, 86.6667, NULL, 80.6667, NULL, NULL, NULL, 83.3333, 'Mading', 'Tidak', 'Menggambar', 'Tidak', 'Bimbel', 'DKV', 'Arsitektur', NULL, NULL),
(740, 11, 73, 80.0000, 55.0000, 76.3333, 83.3333, 80.0000, 70.6667, 64.3333, 75.3333, 81.6667, 70.3333, 64.6667, 50.0000, NULL, 78.3333, NULL, NULL, NULL, 83.6667, 'Basket', 'Tidak', 'Bisnis', 'Basket', 'Tidak', 'Manajemen', 'Psikologi', NULL, NULL),
(741, 11, 74, 81.6667, 66.0000, 75.0000, 83.3333, 81.3333, 72.0000, 67.6667, 75.3333, 80.0000, 69.0000, 57.6667, 58.3333, NULL, 81.0000, NULL, NULL, NULL, 86.3333, 'Taekwondo', 'Tidak', 'Bela Diri', 'Karang Taruna', 'Tidak', 'Pendidikan Jasmani', 'Hukum', NULL, NULL),
(742, 11, 75, 81.6667, 88.3333, 79.6667, 83.3333, 73.3333, 74.3333, 84.6667, 77.0000, 78.3333, 66.6667, 61.6667, 63.3333, NULL, 66.0000, NULL, NULL, NULL, 81.6667, 'futsal', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Industri', 'Manajemen', NULL, NULL),
(743, 11, 76, 76.6667, 40.0000, 68.0000, 58.3333, 71.6667, 61.3333, 69.6667, 48.6667, 73.3333, 72.6667, 43.6667, 45.6667, NULL, 47.3333, NULL, NULL, NULL, 76.6667, 'Badminton', 'Tidak', 'Editing', 'Tidak', 'Tidak', 'DKV', 'Teknik Informatika', NULL, NULL),
(744, 11, 77, 81.6667, 73.3333, 73.3333, 86.6667, 86.0000, 80.6667, 71.0000, 80.0000, 73.3333, 88.3333, 65.0000, 78.3333, NULL, 85.0000, NULL, NULL, NULL, 87.6667, 'Mading', 'Tidak', 'Menggambar', 'Tidak', 'Tidak', 'Arsitektur', 'DKV', NULL, NULL),
(745, 11, 78, 90.0000, 80.6667, 83.3333, 88.3333, 83.3333, 81.0000, 81.3333, 83.3333, 85.0000, 90.6667, 80.6667, 76.3333, NULL, 80.6667, NULL, NULL, NULL, 90.0000, 'futsal', 'Tidak', 'Wirausaha', 'Tidak', 'Tidak', 'Manajemen', 'Ekonomi', NULL, NULL),
(746, 11, 79, 78.3333, 77.3333, 66.6667, 80.0000, 63.3333, 75.3333, 62.0000, 76.6667, 78.3333, 76.6667, 52.3333, 63.3333, NULL, 61.0000, NULL, NULL, NULL, 75.3333, 'Futsal', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Tidak', 'Tidak', 'Teknik Informatika', 'Manajemen', NULL, NULL),
(747, 11, 80, 88.3333, 90.0000, 76.6667, 85.0000, 76.3333, 78.6667, 76.3333, 78.6667, 85.0000, 90.3333, 82.0000, 68.3333, NULL, 66.0000, NULL, NULL, NULL, 86.6667, 'basket', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'OSIS', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', NULL, NULL),
(748, 11, 81, 78.3333, 81.6667, 79.6667, 73.3333, 73.3333, 78.6667, 79.6667, 77.0000, 74.3333, 68.6667, 60.3333, 68.6667, NULL, 61.6667, NULL, NULL, NULL, 77.3333, 'Futsal', 'Tidak', 'Public Speaking', 'Karang Taruna', 'Tidak', 'Hukum', 'Ilmu Komunikasi', NULL, NULL),
(749, 11, 82, 93.3333, 84.3333, 78.3333, 88.3333, 79.6667, 87.3333, 86.3333, 80.0000, 86.6667, 95.0000, 84.6667, 81.6667, NULL, 69.0000, NULL, NULL, NULL, 85.0000, 'Badminton', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Badminton', 'Tidak', 'Teknik Informatika', 'Teknik Elektro', NULL, NULL),
(750, 11, 83, 38.3333, 74.3333, 66.6667, 55.0000, 66.3333, 58.3333, 75.3333, 67.0000, 77.6667, 68.6667, 37.3333, 49.6667, NULL, 39.0000, NULL, NULL, NULL, 74.6667, 'Basket', 'Tidak', 'Videografi', 'Karang Taruna', 'Tidak', 'DKV', 'Manajemen', NULL, NULL),
(751, 11, 84, 92.6667, 80.0000, 78.3333, 71.6667, 86.6667, 76.0000, 73.0000, 75.3333, 75.0000, 88.3333, 64.6667, 66.3333, NULL, 78.3333, NULL, NULL, NULL, 79.3333, 'KIR', 'Tidak', 'Public Speaking', 'Tidak', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Sastra Inggris', NULL, NULL),
(752, 11, 85, 87.6667, 79.3333, 78.3333, 81.6667, 83.0000, 78.3333, 79.6667, 75.3333, 83.3333, 81.0000, 63.6667, 70.3333, NULL, 72.6667, NULL, NULL, NULL, 81.6667, 'Band', 'Juara 2 Solo Vokal M25 Cup SMA Muhammadh 25 Pamulang 2024', 'Menyanyi', 'OSIS', 'Tidak', 'Ilmu Komunikasi', 'Sastra Indonesia', NULL, NULL),
(753, 11, 86, 55.0000, 48.3333, 71.6667, 80.0000, 81.6667, 42.3333, 60.6667, 52.0000, 60.0000, 60.0000, 80.3333, 42.0000, NULL, 80.0000, NULL, NULL, NULL, 75.0000, 'Mading', 'Tidak', 'Melukis', 'Tidak', 'Melukis', 'Seni Rupa', 'DKV', NULL, NULL),
(754, 11, 87, 88.3333, 86.6667, 86.6667, 83.3333, 89.6667, 77.3333, 74.3333, 77.0000, 85.0000, 86.3333, 68.3333, 72.6667, NULL, 87.6667, NULL, NULL, NULL, 87.3333, 'Tari Tradisional', 'Tidak', 'Bisnis', 'Karang Taruna', 'Bimbel', 'Akuntansi', 'Ekonomi', NULL, NULL),
(755, 11, 88, 88.3333, 84.0000, 75.0000, 75.0000, 87.3333, 80.6667, 76.3333, 77.0000, 81.6667, 87.3333, 80.0000, 78.6667, NULL, 79.3333, NULL, NULL, NULL, 84.3333, 'Tari Tradisional', 'Tidak', 'Memasak', 'Tidak', 'Bimbel', 'Ilmu Keperawatan', 'Teknologi Pangan', NULL, NULL),
(756, 11, 89, 46.6667, 74.3333, 82.6667, 83.3333, 86.6667, 63.0000, 75.3333, 78.6667, 88.3333, 85.3333, 65.0000, 75.0000, NULL, 84.3333, NULL, NULL, NULL, 83.0000, 'KIR', 'Tidak', 'Analisis', 'Tidak', 'Bimbel', 'Arsitektur', 'Farmasi', NULL, NULL),
(757, 11, 90, 81.6667, 76.6667, 78.6667, 81.6667, 71.6667, 78.3333, 86.6667, 78.6667, 71.6667, 80.0000, 71.6667, 73.3333, NULL, 71.0000, NULL, NULL, NULL, 87.6667, 'Futsal', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Karang Taruna', 'Tidak', 'Manajemen', 'Teknik Informatika', NULL, NULL),
(758, 11, 91, 82.6667, 86.6667, 73.6667, 83.3333, 74.6667, 85.6667, 76.0000, 77.0000, 73.3333, 81.6667, 78.6667, 73.3333, NULL, 69.3333, NULL, NULL, NULL, 85.3333, 'Badminton', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Tidak', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', NULL, NULL),
(759, 11, 92, 90.0000, 87.0000, 75.3333, 83.3333, 82.6667, 70.0000, 63.3333, 65.3333, 78.3333, 87.3333, 91.3333, 74.6667, 0.0000, 83.3333, NULL, NULL, NULL, 87.0000, 'Tari Tradisional', 'Tidak', 'Wirausaha', 'Karang Taruna', 'Tidak', 'Akuntansi', 'Manajemen', NULL, NULL),
(760, 11, 93, 90.0000, 81.6667, 76.6667, 83.3333, 66.0000, 81.6667, 80.0000, 80.0000, 73.3333, 79.6667, NULL, NULL, 85.3333, NULL, 73.2233, 69.3333, 82.0000, NULL, 'Band', 'Tidak', 'Main Gitar', 'Karang Taruna', 'Pelatihan Saksi Partai', 'Hukum', 'Sastra Indonesia', NULL, NULL),
(761, 11, 94, 68.3333, 79.3333, 75.0000, 81.6667, 69.6667, 56.3333, 72.6667, 80.0000, 72.6667, 78.0000, NULL, NULL, 85.0000, NULL, 70.4767, 57.0000, 75.6667, NULL, 'Futsal', 'Tidak', 'Editing', 'Karang Taruna', 'Tidak', 'DKV', 'Teknik Informatika', NULL, NULL),
(762, 11, 95, 88.3333, 83.3333, 79.6667, 88.3333, 76.3333, 72.3333, 74.3333, 80.3333, 81.6667, 88.0000, NULL, NULL, 83.8333, NULL, 76.4767, 81.6667, 90.6667, NULL, 'Modern Dance', 'Tidak', 'Menari', 'Tidak', 'Tidak', 'Pendidikan Jasmani', 'Seni Rupa', NULL, NULL),
(763, 11, 96, 90.0000, 90.6667, 75.0000, 91.6667, 81.3333, 84.6667, 74.3333, 68.6667, 78.3333, 90.0000, NULL, NULL, 80.0000, NULL, 75.4767, 85.6667, 90.0000, NULL, 'Modern Dance', 'Tidak', 'Memasak', 'OSIS', 'Bimbel', 'Teknologi Pangan', 'Farmasi', NULL, NULL),
(764, 11, 97, 81.6667, 78.3333, 76.6667, 81.6667, 76.6667, 72.0000, 72.0000, 80.0000, 78.3333, 82.6667, NULL, NULL, 78.6667, NULL, 71.5567, 86.6667, 80.0000, NULL, 'KIR', 'Tidak', 'Wirausaha', 'OSIS', 'Tidak', 'Manajemen', 'Ekonomi', NULL, NULL),
(765, 11, 98, 71.6667, 80.6667, 73.3333, 86.6667, 82.6667, 74.3333, 64.3333, 67.0000, 71.6667, 82.3333, NULL, NULL, 80.0000, NULL, 57.8567, 72.3333, 71.6667, NULL, 'Mading', 'Tidak', 'Menggambar', 'Tidak', 'Tidak', 'DKV', 'Arsitektur', NULL, NULL),
(766, 11, 99, 80.0000, 63.3333, 71.6667, 85.0000, 85.0000, 48.6667, 67.3333, 68.6667, 71.6667, 82.6667, NULL, NULL, 75.3333, NULL, 69.0467, 67.0000, 75.0000, NULL, 'KIR', 'Tidak', 'Fotografi', 'PMR', 'Tidak', 'DKV', 'Ilmu Keperawatan', NULL, NULL),
(767, 11, 100, 63.3333, 65.6667, 61.3333, 81.6667, 59.3333, 48.3333, 75.3333, 70.3333, 66.6667, 72.0000, NULL, NULL, 70.8333, NULL, 47.7767, 52.3333, 66.0000, NULL, 'futsal', 'Tidak', 'Modifikasi Motor', 'Tidak', 'Tidak', 'Teknik Industri', 'Teknik Elektro', NULL, NULL),
(768, 11, 101, 71.6667, 73.3333, 61.3333, 56.6667, 64.3333, 67.3333, 69.3333, 70.3333, 67.6667, 56.6667, NULL, NULL, 87.1667, NULL, 52.6200, 67.6667, 76.0000, NULL, 'Band', 'Tidak', 'Analisis', 'Tidak', 'Bimbel', 'Kedokteran', 'Teknik Industri', NULL, NULL),
(769, 11, 102, 63.3333, 70.0000, 71.3333, 86.6667, 64.3333, 57.6667, 82.6667, 72.0000, 64.3333, 75.0000, NULL, NULL, 83.8333, NULL, 67.3800, 66.0000, 72.3333, NULL, 'Taekwondo', 'Tidak', 'Bisnis', 'Tidak', 'Tidak', 'Teknik Informatika', 'Pendidikan Jasmani', NULL, NULL),
(770, 11, 103, 85.0000, 75.6667, 73.3333, 86.6667, 74.0000, 74.3333, 79.3333, 77.0000, 70.0000, 84.0000, NULL, NULL, 84.6667, NULL, 70.1267, 67.6667, 85.0000, NULL, 'Basket', 'Tidak', 'Gaming', 'Basket', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', NULL, NULL),
(771, 11, 104, 78.3333, 72.6667, 76.6667, 90.0000, 71.6667, 79.0000, 80.0000, 81.6667, 74.3333, 75.3333, NULL, NULL, 81.6667, NULL, 78.1433, 80.0000, 81.0000, NULL, 'Futsal', 'Tidak', 'Desain', 'Tidak', 'Tidak', 'DKV', 'Teknik Informatika', NULL, NULL),
(772, 11, 105, 80.0000, 70.0000, 78.3333, 86.6667, 79.6667, 86.3333, 74.3333, 81.6667, 64.3333, 78.0000, NULL, NULL, 77.5000, NULL, 81.9833, 79.6667, 86.0000, NULL, 'futsal', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Industri', 'Hukum', NULL, NULL),
(773, 11, 106, 80.0000, 81.6667, 74.6667, 86.6667, 71.6667, 74.3333, 74.6667, 72.0000, 78.3333, 72.0000, NULL, NULL, 86.6667, NULL, 77.0633, 72.3333, 82.3333, NULL, 'Badminton', 'Tidak', 'Public Speaking', 'OSIS', 'Tidak', 'Hukum', 'Psikologi', NULL, NULL),
(774, 11, 107, 68.3333, 62.6667, 51.6667, 78.3333, 51.3333, 68.0000, 74.0000, 73.6667, 56.6667, 69.3333, NULL, NULL, 81.6667, NULL, 59.2867, 69.6667, 77.3333, NULL, 'KIR', 'Tidak', 'Bisnis', 'OSIS', 'Tidak', 'Manajemen', 'Akuntansi', NULL, NULL),
(775, 11, 108, 78.3333, 74.3333, 84.6667, 90.0000, 68.0000, 78.0000, 74.0000, 75.3333, 76.0000, 83.0000, NULL, NULL, 88.0000, NULL, 70.5567, 79.0000, 74.0000, NULL, 'KIR', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Sastra Inggris', NULL, NULL),
(776, 11, 109, 75.0000, 71.0000, 64.6667, 80.0000, 48.0000, 71.6667, 76.0000, 72.0000, 71.0000, 73.0000, NULL, NULL, 76.0000, NULL, 69.2867, 69.0000, 78.0000, NULL, 'Futsal', 'Tidak', 'Desain', 'Tidak', 'Tidak', 'Ilmu Komputer', 'DKV', NULL, NULL),
(777, 11, 110, 68.3333, 75.0000, 65.6667, 76.6667, 50.0000, 63.0000, 78.0000, 76.6667, 70.0000, 70.6667, NULL, NULL, 79.1667, NULL, 56.0333, 71.3333, 73.0000, NULL, 'Taekwondo', 'Tidak', 'Bela Diri', 'Karang Taruna', 'Tidak', 'Pendidikan Jasmani', 'Sastra Indonesia', NULL, NULL),
(778, 11, 111, 80.0000, 81.6667, 83.3333, 86.6667, 52.6667, 78.3333, 72.6667, 75.3333, 73.3333, 89.6667, NULL, NULL, 83.3333, NULL, 70.6333, 77.3333, 81.0000, NULL, 'Basket', 'Tidak', 'Atletik', 'Basket', 'Tidak', 'Ilmu Keolahragaan', 'Pendidikan Jasmani', NULL, NULL),
(779, 11, 112, 81.6667, 80.0000, 68.3333, 91.6667, 78.3333, 67.3333, 76.0000, 72.0000, 73.3333, 89.6667, NULL, NULL, 80.5000, NULL, 79.8100, 86.0000, 89.3333, NULL, 'KIR', 'Tidak', 'Desain', 'OSIS', 'Kursus TOEFL', 'Sastra Inggris', 'Ilmu Komunikasi', NULL, NULL),
(780, 11, 113, 83.3333, 71.6667, 63.3333, 73.3333, 78.3333, 63.3333, 62.6667, 75.0000, 70.0000, 76.6667, NULL, NULL, 81.1667, NULL, 71.5567, 64.3333, 77.6667, NULL, 'Modern Dance', 'Tidak', 'Bisnis', 'Tidak', 'Tidak', 'Akuntansi', 'Manajemen', NULL, NULL),
(781, 11, 114, 81.6667, 82.6667, 66.0000, 81.6667, 80.6667, 70.0000, 69.6667, 70.3333, 70.0000, 73.0000, NULL, NULL, 87.5000, NULL, 60.3667, 61.6667, 86.0000, NULL, 'Modern Dance', 'Tidak', 'Public Speaking', 'OSIS', 'Bimbel', 'Ilmu Komunikasi', 'Sastra Inggris', NULL, NULL),
(782, 11, 115, 85.0000, 83.6667, 78.3333, 81.6667, 66.0000, 70.6667, 78.0000, 72.0000, 65.0000, 83.3333, NULL, NULL, 83.0000, NULL, 77.2233, 76.6667, 87.3333, NULL, 'Badminton', 'Tidak', 'Atletik', 'Badminton', 'Tidak', 'Ilmu Keolahragaan', 'Pendidikan Jasmani', NULL, NULL),
(783, 11, 116, 86.6667, 86.6667, 75.0000, 88.3333, 80.6667, 81.0000, 72.3333, 76.6667, 83.3333, 85.3333, NULL, NULL, 89.3333, NULL, 79.5700, 87.3333, 90.0000, NULL, 'Tari Tradisional', 'Tidak', 'Memasak', 'Tidak', 'Bimbel', 'Teknologi Pangan', 'Farmasi', NULL, NULL),
(784, 11, 117, 83.3333, 85.0000, 80.0000, 88.3333, 82.3333, 83.0000, 74.3333, 75.3333, 80.0000, 81.6667, NULL, NULL, 89.5000, NULL, 80.2367, 82.6667, 88.3333, NULL, 'Mading', 'Tidak', 'Public Speaking', 'Karang Taruna', 'Tidak', 'Psikologi', 'Ilmu Komunikasi', NULL, NULL),
(785, 11, 118, 64.6667, 56.0000, 45.0000, 56.6667, 81.6667, 51.6667, 54.6667, 52.0000, 50.0000, 64.6667, NULL, NULL, 53.3333, NULL, 47.7767, 50.6667, 78.3333, NULL, 'Modern Dance', 'Tidak', 'Bisnis', 'Tidak', 'Tidak', 'Manajemen', 'Ekonomi', NULL, NULL),
(786, 11, 119, 88.3333, 75.0000, 71.6667, 81.6667, 78.3333, 74.0000, 64.6667, 72.0000, 71.6667, 82.0000, NULL, NULL, 84.5000, NULL, 71.5567, 72.3333, 91.3333, NULL, 'Mading', 'Tidak', 'Menggambar', 'Karang Taruna', 'Bimbel', 'Arsitektur', 'DKV', NULL, NULL),
(787, 11, 120, 90.0000, 87.3333, 80.0000, 83.3333, 80.0000, 77.6667, 74.6667, 73.6667, 80.0000, 85.0000, NULL, NULL, 89.5000, NULL, 83.4933, 85.6667, 91.3333, NULL, 'Basket', 'Tidak', 'Bisnis', 'Basket', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Manajemen', NULL, NULL);

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
  `updated_at` timestamp NULL DEFAULT NULL
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
(46, 16, 'rapor', 95.00, 91.00, 96.00, 90.00, 90.00, 94.00, 88.00, 76.00, 90.00, 93.00, 90.00, 90.00, 93.00, 92.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:43', '2026-10-21 13:29:43'),
(47, 16, 'pts', 100.00, 85.00, 75.00, 85.00, 85.00, 90.00, 75.00, 90.00, 80.00, 95.00, 100.00, 80.00, 75.00, 70.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:43', '2026-10-21 13:29:43'),
(48, 16, 'pas', 95.00, 100.00, 90.00, 80.00, 75.00, 80.00, 90.00, 85.00, 60.00, 100.00, 95.00, 60.00, 90.00, 70.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:43', '2026-10-21 13:29:43'),
(49, 17, 'rapor', 80.00, 83.00, 87.00, 85.00, 79.00, 85.00, 88.00, 76.00, 83.00, 84.00, 77.00, 79.00, 89.00, 78.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(50, 17, 'pts', 85.00, 55.00, 65.00, 75.00, 70.00, 70.00, 65.00, 80.00, 60.00, 50.00, 80.00, 60.00, 75.00, 60.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(51, 17, 'pas', 75.00, 100.00, 85.00, 85.00, 70.00, 90.00, 80.00, 70.00, 65.00, 100.00, 35.00, 65.00, 85.00, 65.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(52, 18, 'rapor', 85.00, 88.00, 90.00, 85.00, 88.00, 86.00, 87.00, 76.00, 90.00, 90.00, 87.00, 82.00, 91.00, 83.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(53, 18, 'pts', 95.00, 70.00, 75.00, 85.00, 75.00, 65.00, 80.00, 85.00, 85.00, 90.00, 85.00, 85.00, 75.00, 60.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(54, 18, 'pas', 85.00, 100.00, 80.00, 95.00, 75.00, 90.00, 90.00, 65.00, 60.00, 100.00, 55.00, 60.00, 90.00, 65.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(55, 19, 'rapor', 70.00, 75.00, 75.00, 80.00, 75.00, 83.00, 85.00, 76.00, 80.00, 79.00, 76.00, 76.00, 86.00, 75.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(56, 19, 'pts', 0.00, 55.00, 65.00, 95.00, 85.00, 0.00, 70.00, 55.00, 40.00, 0.00, 85.00, 20.00, 75.00, 65.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(57, 19, 'pas', 75.00, 95.00, 85.00, 0.00, 70.00, 95.00, 60.00, 55.00, 40.00, 80.00, 0.00, 40.00, 80.00, 0.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(58, 20, 'rapor', 90.00, 90.00, 95.00, 90.00, 84.00, 88.00, 86.00, 80.00, 85.00, 92.00, 86.00, 86.00, 92.00, 83.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(59, 20, 'pts', 95.00, 75.00, 65.00, 80.00, 70.00, 85.00, 75.00, 85.00, 75.00, 95.00, 95.00, 75.00, 80.00, 70.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(60, 20, 'pas', 85.00, 100.00, 85.00, 70.00, 80.00, 95.00, 85.00, 80.00, 65.00, 100.00, 65.00, 65.00, 90.00, 75.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(61, 21, 'rapor', 90.00, 90.00, 95.00, 90.00, 86.00, 88.00, 88.00, 80.00, 90.00, 89.00, 86.00, 83.00, 92.00, 83.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(62, 21, 'pts', 90.00, 60.00, 70.00, 85.00, 85.00, 45.00, 65.00, 85.00, 40.00, 85.00, 40.00, 40.00, 80.00, 80.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(63, 21, 'pas', 85.00, 85.00, 80.00, 90.00, 80.00, 80.00, 75.00, 80.00, 80.00, 90.00, 40.00, 50.00, 90.00, 80.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(64, 22, 'rapor', 85.00, 90.00, 91.00, 85.00, 84.00, 87.00, 89.00, 76.00, 90.00, 88.00, 85.00, 80.00, 89.00, 85.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(65, 22, 'pts', 80.00, 55.00, 60.00, 75.00, 70.00, 50.00, 60.00, 70.00, 55.00, 45.00, 85.00, 55.00, 65.00, 65.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(66, 22, 'pas', 80.00, 75.00, 80.00, 70.00, 65.00, 35.00, 75.00, 45.00, 75.00, 90.00, 40.00, 35.00, 85.00, 55.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(67, 23, 'rapor', 78.00, 85.00, 90.00, 85.00, 80.00, 85.00, 88.00, 76.00, 85.00, 88.00, 77.00, 80.00, 92.00, 78.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(68, 23, 'pts', 90.00, 60.00, 60.00, 80.00, 70.00, 40.00, 75.00, 85.00, 70.00, 70.00, 70.00, 70.00, 75.00, 70.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(69, 23, 'pas', 75.00, 95.00, 0.00, 70.00, 70.00, 75.00, 0.00, 75.00, 75.00, 100.00, 35.00, 75.00, 90.00, 60.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(70, 24, 'rapor', 95.00, 88.00, 94.00, 90.00, 91.00, 93.00, 88.00, 80.00, 90.00, 93.00, 89.00, 92.00, 93.00, 92.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(71, 24, 'pts', 85.00, 75.00, 85.00, 85.00, 90.00, 80.00, 80.00, 95.00, 85.00, 85.00, 90.00, 85.00, 80.00, 60.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(72, 24, 'pas', 100.00, 100.00, 85.00, 90.00, 80.00, 90.00, 80.00, 80.00, 80.00, 100.00, 80.00, 80.00, 90.00, 75.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(73, 25, 'rapor', 80.00, 88.00, 94.00, 95.00, 82.00, 87.00, 88.00, 76.00, 85.00, 90.00, 83.00, 84.00, 94.00, 82.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(74, 25, 'pts', 80.00, 70.00, 55.00, 90.00, 80.00, 60.00, 80.00, 90.00, 65.00, 95.00, 75.00, 65.00, 70.00, 80.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(75, 25, 'pas', 75.00, 90.00, 85.00, 80.00, 85.00, 70.00, 70.00, 75.00, 90.00, 100.00, 35.00, 75.00, 95.00, 75.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(76, 26, 'rapor', 95.00, 90.00, 94.00, 90.00, 85.00, 92.00, 85.00, 85.00, 85.00, 88.00, 84.00, 85.00, 95.00, 85.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(77, 26, 'pts', 85.00, 60.00, 60.00, 90.00, 75.00, 60.00, 80.00, 90.00, 60.00, 90.00, 70.00, 60.00, 80.00, 75.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(78, 26, 'pas', 85.00, 90.00, 85.00, 90.00, 90.00, 70.00, 90.00, 85.00, 90.00, 100.00, 70.00, 50.00, 95.00, 80.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(79, 27, 'rapor', 90.00, 90.00, 94.00, 90.00, 80.00, 91.00, 85.00, 80.00, 85.00, 92.00, 87.00, 84.00, 93.00, 80.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(80, 27, 'pts', 85.00, 60.00, 50.00, 80.00, 90.00, 65.00, 70.00, 90.00, 60.00, 55.00, 60.00, 60.00, 80.00, 85.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(81, 27, 'pas', 75.00, 95.00, 90.00, 85.00, 90.00, 75.00, 85.00, 80.00, 80.00, 85.00, 60.00, 45.00, 95.00, 85.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(82, 28, 'rapor', 92.00, 90.00, 94.00, 87.00, 82.00, 90.00, 88.00, 80.00, 90.00, 93.00, 87.00, 84.00, 92.00, 86.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(83, 28, 'pts', 90.00, 60.00, 80.00, 85.00, 85.00, 65.00, 80.00, 85.00, 65.00, 80.00, 95.00, 65.00, 70.00, 75.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(84, 28, 'pas', 90.00, 90.00, 90.00, 90.00, 70.00, 90.00, 85.00, 80.00, 40.00, 90.00, 50.00, 40.00, 90.00, 65.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(85, 29, 'rapor', 95.00, 90.00, 95.00, 90.00, 83.00, 90.00, 88.00, 80.00, 90.00, 92.00, 84.00, 83.00, 92.00, 83.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(86, 29, 'pts', 90.00, 70.00, 70.00, 85.00, 75.00, 70.00, 85.00, 95.00, 70.00, 80.00, 90.00, 70.00, 80.00, 70.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(87, 29, 'pas', 90.00, 95.00, 90.00, 90.00, 75.00, 90.00, 90.00, 80.00, 45.00, 100.00, 55.00, 45.00, 90.00, 60.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(88, 30, 'rapor', 95.00, 92.00, 95.00, 85.00, 86.00, 90.00, 88.00, 85.00, 90.00, 90.00, 90.00, 94.00, 92.00, 87.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(89, 30, 'pts', 95.00, 75.00, 75.00, 90.00, 75.00, 75.00, 70.00, 85.00, 80.00, 90.00, 100.00, 80.00, 80.00, 80.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(90, 30, 'pas', 95.00, 80.00, 85.00, 95.00, 55.00, 85.00, 40.00, 85.00, 50.00, 90.00, 90.00, 50.00, 90.00, 50.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(91, 31, 'rapor', 80.00, 88.00, 93.00, 85.00, 82.00, 87.00, 88.00, 80.00, 90.00, 88.00, 84.00, 83.00, 82.00, 85.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(92, 31, 'pts', 80.00, 50.00, 30.00, 80.00, 70.00, 55.00, 55.00, 75.00, 65.00, 85.00, 80.00, 65.00, 70.00, 75.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(93, 31, 'pas', 0.00, 60.00, 80.00, 75.00, 70.00, 0.00, 55.00, 80.00, 40.00, 0.00, 65.00, 40.00, 70.00, 65.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(94, 32, 'rapor', 80.00, 90.00, 94.00, 90.00, 81.00, 90.00, 89.00, 76.00, 85.00, 87.00, 85.00, 84.00, 91.00, 82.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(95, 32, 'pts', 60.00, 55.00, 60.00, 90.00, 85.00, 40.00, 55.00, 75.00, 55.00, 75.00, 30.00, 25.00, 80.00, 90.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(96, 32, 'pas', 75.00, 70.00, 65.00, 85.00, 95.00, 90.00, 80.00, 70.00, 35.00, 90.00, 60.00, 35.00, 90.00, 95.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(97, 33, 'rapor', 90.00, 88.00, 94.00, 85.00, 84.00, 88.00, 89.00, 80.00, 90.00, 90.00, 87.00, 86.00, 91.00, 80.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(98, 33, 'pts', 90.00, 65.00, 75.00, 85.00, 70.00, 60.00, 85.00, 95.00, 75.00, 75.00, 85.00, 75.00, 75.00, 70.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(99, 33, 'pas', 90.00, 95.00, 90.00, 85.00, 75.00, 80.00, 90.00, 80.00, 50.00, 95.00, 55.00, 50.00, 90.00, 60.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(100, 34, 'rapor', 95.00, 91.00, 95.00, 90.00, 88.00, 87.00, 87.00, 80.00, 85.00, 92.00, 86.00, 89.00, 89.00, 90.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(101, 34, 'pts', 95.00, 70.00, 60.00, 90.00, 75.00, 65.00, 85.00, 85.00, 75.00, 80.00, 80.00, 75.00, 85.00, 80.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(102, 34, 'pas', 100.00, 95.00, 85.00, 75.00, 90.00, 85.00, 80.00, 80.00, 80.00, 90.00, 55.00, 40.00, 85.00, 85.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(103, 35, 'rapor', 90.00, 90.00, 95.00, 85.00, 83.00, 90.00, 88.00, 85.00, 85.00, 90.00, 88.00, 84.00, 92.00, 83.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(104, 35, 'pts', 100.00, 55.00, 70.00, 85.00, 70.00, 70.00, 65.00, 90.00, 65.00, 80.00, 80.00, 65.00, 75.00, 65.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(105, 35, 'pas', 100.00, 85.00, 90.00, 70.00, 65.00, 85.00, 90.00, 85.00, 65.00, 95.00, 70.00, 65.00, 90.00, 60.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(106, 36, 'rapor', 90.00, 87.00, 94.00, 90.00, 79.00, 85.00, 90.00, 80.00, 85.00, 90.00, 79.00, 80.00, 91.00, 77.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(107, 36, 'pts', 90.00, 70.00, 65.00, 80.00, 45.00, 70.00, 70.00, 90.00, 75.00, 55.00, 80.00, 75.00, 75.00, 50.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(108, 36, 'pas', 95.00, 90.00, 95.00, 85.00, 70.00, 85.00, 90.00, 80.00, 40.00, 95.00, 55.00, 40.00, 90.00, 60.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(109, 37, 'rapor', 95.00, 91.00, 96.00, 90.00, 92.00, 92.00, 89.00, 80.00, 90.00, 93.00, 89.00, 92.00, 90.00, 92.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(110, 37, 'pts', 95.00, 80.00, 70.00, 85.00, 85.00, 65.00, 80.00, 95.00, 80.00, 100.00, 95.00, 80.00, 80.00, 80.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(111, 37, 'pas', 95.00, 95.00, 95.00, 85.00, 75.00, 75.00, 90.00, 75.00, 55.00, 95.00, 70.00, 55.00, 85.00, 65.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(112, 38, 'rapor', 95.00, 90.00, 91.00, 85.00, 83.00, 88.00, 90.00, 76.00, 85.00, 92.00, 88.00, 86.00, 92.00, 80.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(113, 38, 'pts', 90.00, 75.00, 75.00, 95.00, 65.00, 75.00, 75.00, 95.00, 90.00, 65.00, 80.00, 90.00, 80.00, 70.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(114, 38, 'pas', 95.00, 95.00, 95.00, 85.00, 65.00, 85.00, 85.00, 75.00, 55.00, 95.00, 55.00, 55.00, 90.00, 55.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(115, 39, 'rapor', 80.00, 88.00, 95.00, 90.00, 81.00, 87.00, 88.00, 76.00, 85.00, 88.00, 82.00, 84.00, 88.00, 80.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(116, 39, 'pts', 80.00, 75.00, 55.00, 80.00, 80.00, 75.00, 85.00, 85.00, 75.00, 70.00, 75.00, 75.00, 80.00, 85.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(117, 39, 'pas', 85.00, 0.00, 0.00, 80.00, 0.00, 65.00, 0.00, 0.00, 70.00, 60.00, 30.00, 0.00, 85.00, 80.00, NULL, NULL, NULL, NULL, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(118, 40, 'rapor', 85.00, 88.00, 91.00, 90.00, 79.00, 87.00, 88.00, 76.00, 85.00, NULL, NULL, NULL, 90.50, NULL, 85.00, 87.00, 92.00, 82.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(119, 40, 'pts', 90.00, 80.00, 45.00, 75.00, 75.00, 80.00, 55.00, 85.00, 55.00, NULL, NULL, NULL, 90.00, NULL, 71.43, 70.00, 80.00, 70.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(120, 40, 'pas', 80.00, 100.00, 65.00, 85.00, 70.00, 70.00, 80.00, 75.00, 70.00, NULL, NULL, NULL, 90.00, NULL, 80.00, 90.00, 80.00, 85.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(121, 41, 'rapor', 93.00, 92.00, 95.00, 95.00, 82.00, 90.00, 87.00, 80.00, 90.00, NULL, NULL, NULL, 90.00, NULL, 90.00, 90.00, 96.00, 92.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(122, 41, 'pts', 80.00, 75.00, 65.00, 90.00, 80.00, 80.00, 75.00, 85.00, 75.00, NULL, NULL, NULL, 80.00, NULL, 100.00, 80.00, 85.00, 85.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(123, 41, 'pas', 90.00, 100.00, 80.00, 85.00, 75.00, 85.00, 75.00, 75.00, 60.00, NULL, NULL, NULL, 90.00, NULL, 80.00, 85.00, 95.00, 85.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(124, 42, 'rapor', 90.00, 90.00, 91.00, 80.00, 80.00, 88.00, 90.00, 76.00, 85.00, NULL, NULL, NULL, 92.50, NULL, 85.00, 88.00, 88.00, 90.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(125, 42, 'pts', 75.00, 65.00, 45.00, 50.00, 75.00, 70.00, 80.00, 65.00, 80.00, NULL, NULL, NULL, 75.00, NULL, 42.86, 50.00, 65.00, 70.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(126, 42, 'pas', 85.00, 100.00, 90.00, 80.00, 55.00, 85.00, 60.00, 65.00, 75.00, NULL, NULL, NULL, 95.00, NULL, 60.00, 90.00, 75.00, 80.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(127, 43, 'rapor', 88.00, 88.00, 95.00, 90.00, 83.00, 89.00, 89.00, 76.00, 90.00, NULL, NULL, NULL, 86.00, NULL, 90.00, 92.00, 92.00, 89.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(128, 43, 'pts', 95.00, 45.00, 50.00, 90.00, 70.00, 55.00, 60.00, 70.00, 60.00, NULL, NULL, NULL, 50.00, NULL, 57.14, 80.00, 65.00, 75.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(129, 43, 'pas', 85.00, 80.00, 60.00, 90.00, 65.00, 80.00, 65.00, 65.00, 75.00, NULL, NULL, NULL, 80.00, NULL, 70.00, 90.00, 85.00, 90.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(130, 44, 'rapor', 80.00, 85.00, 91.00, 85.00, 79.00, 85.00, 90.00, 76.00, 85.00, NULL, NULL, NULL, 83.00, NULL, 85.00, 80.00, 88.00, 84.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(131, 44, 'pts', 90.00, 80.00, 40.00, 60.00, 75.00, 50.00, 50.00, 80.00, 50.00, NULL, NULL, NULL, 85.00, NULL, 66.67, 70.00, 55.00, 65.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(132, 44, 'pas', 85.00, 95.00, 75.00, 85.00, 70.00, 80.00, 70.00, 75.00, 70.00, NULL, NULL, NULL, 75.00, NULL, 75.00, 85.00, 80.00, 85.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(133, 45, 'rapor', 90.00, 93.00, 90.00, 90.00, 80.00, 87.00, 88.00, 80.00, 85.00, NULL, NULL, NULL, 91.00, NULL, 85.00, 88.00, 88.00, 88.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(134, 45, 'pts', 90.00, 70.00, 50.00, 75.00, 80.00, 75.00, 65.00, 85.00, 65.00, NULL, NULL, NULL, 75.00, NULL, 76.19, 60.00, 80.00, 90.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(135, 45, 'pas', 85.00, 100.00, 80.00, 80.00, 70.00, 80.00, 75.00, 80.00, 85.00, NULL, NULL, NULL, 90.00, NULL, 75.00, 85.00, 75.00, 80.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(136, 46, 'rapor', 85.00, 90.00, 89.00, 85.00, 80.00, 84.00, 89.00, 76.00, 85.00, NULL, NULL, NULL, 82.50, NULL, 88.00, 78.00, 88.00, 80.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(137, 46, 'pts', 55.00, 45.00, 45.00, 65.00, 55.00, 45.00, 45.00, 65.00, 45.00, NULL, NULL, NULL, 45.00, NULL, 61.90, 55.00, 50.00, 80.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(138, 46, 'pas', 70.00, 95.00, 80.00, 75.00, 50.00, 50.00, 75.00, 70.00, 75.00, NULL, NULL, NULL, 75.00, NULL, 45.00, 40.00, 85.00, 75.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(139, 47, 'rapor', 80.00, 90.00, 80.00, 80.00, 79.00, 84.00, 92.00, 76.00, 85.00, NULL, NULL, NULL, 87.50, NULL, 80.00, 78.00, 82.00, 80.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(140, 47, 'pts', 65.00, 60.00, 60.00, 75.00, 65.00, 35.00, 55.00, 70.00, 55.00, NULL, NULL, NULL, 50.00, NULL, 47.62, 55.00, 65.00, 85.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(141, 47, 'pas', 80.00, 90.00, 65.00, 80.00, 45.00, 85.00, 70.00, 65.00, 60.00, NULL, NULL, NULL, 85.00, NULL, 45.00, 75.00, 75.00, 80.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(142, 48, 'rapor', 95.00, 90.00, 95.00, 85.00, 83.00, 88.00, 89.00, 76.00, 90.00, NULL, NULL, NULL, 93.00, NULL, 90.00, 92.00, 88.00, 90.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(143, 48, 'pts', 90.00, 80.00, 55.00, 90.00, 80.00, 70.00, 70.00, 80.00, 70.00, NULL, NULL, NULL, 80.00, NULL, 85.71, 80.00, 60.00, 85.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(144, 48, 'pas', 90.00, 100.00, 90.00, 80.00, 55.00, 85.00, 75.00, 65.00, 90.00, NULL, NULL, NULL, 95.00, NULL, 40.00, 90.00, 85.00, 80.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(145, 49, 'rapor', 90.00, 90.00, 95.00, 95.00, 86.00, 87.00, 90.00, 80.00, 90.00, NULL, NULL, NULL, 90.00, NULL, 80.00, 88.00, 88.00, 92.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(146, 49, 'pts', 85.00, 75.00, 60.00, 90.00, 80.00, 80.00, 70.00, 80.00, 70.00, NULL, NULL, NULL, 80.00, NULL, 95.24, 50.00, 85.00, 70.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(147, 49, 'pas', 90.00, 100.00, 85.00, 90.00, 80.00, 80.00, 90.00, 80.00, 70.00, NULL, NULL, NULL, 90.00, NULL, 85.00, 95.00, 85.00, 90.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(148, 50, 'rapor', 90.00, 90.00, 94.00, 95.00, 81.00, 89.00, 87.00, 80.00, 85.00, NULL, NULL, NULL, 85.00, NULL, 85.00, 87.00, 88.00, 89.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(149, 50, 'pts', 85.00, 80.00, 65.00, 85.00, 90.00, 80.00, 50.00, 85.00, 50.00, NULL, NULL, NULL, 60.00, NULL, 47.62, 75.00, 75.00, 80.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(150, 50, 'pas', 80.00, 90.00, 60.00, 0.00, 85.00, 40.00, 70.00, 80.00, 80.00, NULL, NULL, NULL, 75.00, NULL, 0.00, 75.00, 80.00, 70.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(151, 51, 'rapor', 90.00, 88.00, 90.00, 85.00, 79.00, 88.00, 89.00, 76.00, 90.00, NULL, NULL, NULL, 85.00, NULL, 85.00, 89.00, 82.00, 90.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(152, 51, 'pts', 90.00, 85.00, 60.00, 90.00, 80.00, 70.00, 85.00, 80.00, 85.00, NULL, NULL, NULL, 80.00, NULL, 76.19, 70.00, 55.00, 85.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(153, 51, 'pas', 85.00, 100.00, 90.00, 80.00, 55.00, 90.00, 75.00, 75.00, 75.00, NULL, NULL, NULL, 80.00, NULL, 85.00, 95.00, 80.00, 80.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(154, 52, 'rapor', 75.00, 83.00, 79.00, 80.00, 78.00, 82.00, 86.00, 76.00, 83.00, NULL, NULL, NULL, 76.00, NULL, 80.00, 77.00, 82.00, 79.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(155, 52, 'pts', 60.00, 50.00, 30.00, 50.00, 30.00, 40.00, 35.00, 70.00, 35.00, NULL, NULL, NULL, 55.00, NULL, 28.57, 45.00, 50.00, 65.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(156, 52, 'pas', 65.00, 70.00, 50.00, 55.00, 40.00, 70.00, 25.00, 55.00, 35.00, NULL, NULL, NULL, 50.00, NULL, 20.00, 60.00, 70.00, 55.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(157, 53, 'rapor', 75.00, 85.00, 79.00, 80.00, 78.00, 84.00, 88.00, 76.00, 83.00, NULL, NULL, NULL, 80.50, NULL, 80.00, 77.00, 82.00, 79.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(158, 53, 'pts', 60.00, 65.00, 75.00, 75.00, 45.00, 55.00, 75.00, 75.00, 75.00, NULL, NULL, NULL, 80.00, NULL, 71.43, 80.00, 55.00, 70.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(159, 53, 'pas', 80.00, 50.00, 60.00, 55.00, 50.00, 60.00, 80.00, 60.00, 60.00, NULL, NULL, NULL, 70.00, NULL, 25.00, 60.00, 75.00, 65.00, '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(160, 54, 'rapor', 85.00, 88.00, 90.00, 85.00, 78.00, 86.00, 88.00, 80.00, 83.00, NULL, NULL, NULL, 93.00, NULL, 85.00, 78.00, 85.00, 85.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(161, 54, 'pts', 85.00, 70.00, 70.00, 75.00, 55.00, 65.00, 80.00, 80.00, 80.00, NULL, NULL, NULL, 90.00, NULL, 80.95, 75.00, 80.00, 75.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(162, 54, 'pas', 80.00, 80.00, 65.00, 85.00, 65.00, 65.00, 75.00, 85.00, 55.00, NULL, NULL, NULL, 95.00, NULL, 50.00, 60.00, 90.00, 85.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(163, 55, 'rapor', 95.00, 90.00, 95.00, 90.00, 88.00, 90.00, 90.00, 80.00, 90.00, NULL, NULL, NULL, 91.00, NULL, 90.00, 88.00, 94.00, 95.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(164, 55, 'pts', 90.00, 70.00, 50.00, 80.00, 40.00, 80.00, 70.00, 90.00, 70.00, NULL, NULL, NULL, 90.00, NULL, 80.95, 80.00, 80.00, 90.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(165, 55, 'pas', 85.00, 100.00, 80.00, 85.00, 70.00, 70.00, 40.00, 80.00, 60.00, NULL, NULL, NULL, 90.00, NULL, 75.00, 85.00, 85.00, 85.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(166, 56, 'rapor', 90.00, 90.00, 95.00, 90.00, 82.00, 87.00, 89.00, 76.00, 90.00, NULL, NULL, NULL, 87.50, NULL, 85.00, 88.00, 92.00, 94.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(167, 56, 'pts', 85.00, 75.00, 70.00, 80.00, 70.00, 70.00, 60.00, 80.00, 60.00, NULL, NULL, NULL, 85.00, NULL, 80.95, 65.00, 75.00, 75.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(168, 56, 'pas', 90.00, 100.00, 85.00, 90.00, 75.00, 80.00, 75.00, 75.00, 80.00, NULL, NULL, NULL, 85.00, NULL, 50.00, 95.00, 85.00, 90.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(169, 57, 'rapor', 80.00, 90.00, 90.00, 90.00, 80.00, 84.00, 87.00, 76.00, 85.00, NULL, NULL, NULL, 83.00, NULL, 80.00, 80.00, 92.00, 80.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(170, 57, 'pts', 60.00, 35.00, 35.00, 55.00, 75.00, 35.00, 30.00, 60.00, 30.00, NULL, NULL, NULL, 60.00, NULL, 61.90, 50.00, 50.00, 70.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(171, 57, 'pas', 70.00, 75.00, 45.00, 75.00, 70.00, 35.00, 40.00, 65.00, 60.00, NULL, NULL, NULL, 75.00, NULL, 65.00, 55.00, 70.00, 75.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(172, 58, 'rapor', 90.00, 90.00, 93.00, 95.00, 81.00, 94.00, 88.00, 76.00, 90.00, NULL, NULL, NULL, 92.00, NULL, 90.00, 93.00, 92.00, 95.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(173, 58, 'pts', 100.00, 80.00, 65.00, 85.00, 80.00, 80.00, 70.00, 85.00, 70.00, NULL, NULL, NULL, 80.00, NULL, 100.00, 85.00, 85.00, 90.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(174, 58, 'pas', 85.00, 100.00, 85.00, 85.00, 70.00, 95.00, 75.00, 75.00, 65.00, NULL, NULL, NULL, 90.00, NULL, 65.00, 90.00, 90.00, 85.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(175, 59, 'rapor', 80.00, 90.00, 94.00, 90.00, 79.00, 86.00, 89.00, 76.00, 85.00, NULL, NULL, NULL, 90.00, NULL, 80.00, 83.00, 88.00, 80.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(176, 59, 'pts', 90.00, 75.00, 75.00, 80.00, 65.00, 70.00, 75.00, 80.00, 75.00, NULL, NULL, NULL, 90.00, NULL, 80.95, 75.00, 80.00, 70.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(177, 59, 'pas', 70.00, 100.00, 80.00, 80.00, 80.00, 75.00, 75.00, 65.00, 95.00, NULL, NULL, NULL, 90.00, NULL, 85.00, 90.00, 90.00, 80.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(178, 60, 'rapor', 90.00, 92.00, 95.00, 95.00, 83.00, 90.00, 89.00, 80.00, 90.00, NULL, NULL, NULL, 91.00, NULL, 88.00, 90.00, 94.00, 93.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(179, 60, 'pts', 85.00, 75.00, 70.00, 90.00, 70.00, 70.00, 75.00, 75.00, 75.00, NULL, NULL, NULL, 90.00, NULL, 80.95, 75.00, 70.00, 80.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(180, 60, 'pas', 85.00, 100.00, 80.00, 85.00, 85.00, 80.00, 60.00, 80.00, 60.00, NULL, NULL, NULL, 90.00, NULL, 75.00, 90.00, 95.00, 85.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(181, 61, 'rapor', 85.00, 88.00, 90.00, 80.00, 80.00, 88.00, 89.00, 76.00, 83.00, NULL, NULL, NULL, 93.00, NULL, 80.00, 83.00, 82.00, 86.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(182, 61, 'pts', 85.00, 80.00, 55.00, 80.00, 70.00, 70.00, 70.00, 80.00, 70.00, NULL, NULL, NULL, 80.00, NULL, 85.71, 80.00, 50.00, 75.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(183, 61, 'pas', 80.00, 100.00, 70.00, 95.00, 70.00, 100.00, 75.00, 75.00, 80.00, NULL, NULL, NULL, 95.00, NULL, 70.00, 80.00, 85.00, 95.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(184, 62, 'rapor', 93.00, 91.00, 95.00, 95.00, 89.00, 95.00, 89.00, 80.00, 90.00, NULL, NULL, NULL, 94.50, NULL, 90.00, 95.00, 96.00, 95.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(185, 62, 'pts', 100.00, 85.00, 75.00, 90.00, 80.00, 80.00, 80.00, 85.00, 80.00, NULL, NULL, NULL, 80.00, NULL, 100.00, 85.00, 85.00, 90.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(186, 62, 'pas', 90.00, 100.00, 85.00, 85.00, 85.00, 95.00, 80.00, 80.00, 70.00, NULL, NULL, NULL, 95.00, NULL, 85.00, 95.00, 100.00, 85.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(187, 63, 'rapor', 90.00, 90.00, 93.00, 90.00, 83.00, 87.00, 88.00, 76.00, 90.00, NULL, NULL, NULL, 90.50, NULL, 88.00, 90.00, 94.00, 95.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(188, 63, 'pts', 90.00, 85.00, 65.00, 75.00, 90.00, 70.00, 65.00, 75.00, 65.00, NULL, NULL, NULL, 70.00, NULL, 85.71, 75.00, 80.00, 80.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(189, 63, 'pas', 80.00, 100.00, 80.00, 80.00, 85.00, 75.00, 70.00, 75.00, 75.00, NULL, NULL, NULL, 90.00, NULL, 60.00, 90.00, 75.00, 80.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(190, 64, 'rapor', 85.00, 90.00, 93.00, 90.00, 81.00, 85.00, 88.00, 76.00, 85.00, NULL, NULL, NULL, 86.50, NULL, 85.00, 89.00, 88.00, 87.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(191, 64, 'pts', 90.00, 75.00, 65.00, 70.00, 65.00, 75.00, 60.00, 65.00, 60.00, NULL, NULL, NULL, 60.00, NULL, 66.67, 70.00, 60.00, 75.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(192, 64, 'pas', 75.00, 100.00, 80.00, 85.00, 85.00, 75.00, 70.00, 75.00, 80.00, NULL, NULL, NULL, 85.00, NULL, 85.00, 90.00, 85.00, 85.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(193, 65, 'rapor', 85.00, 90.00, 93.00, 85.00, 80.00, 85.00, 89.00, 76.00, 85.00, NULL, NULL, NULL, 92.50, NULL, 88.00, 85.00, 88.00, 85.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(194, 65, 'pts', 70.00, 75.00, 55.00, 80.00, 65.00, 65.00, 75.00, 75.00, 75.00, NULL, NULL, NULL, 80.00, NULL, 66.67, 75.00, 45.00, 90.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(195, 65, 'pas', 80.00, 100.00, 90.00, 85.00, 55.00, 85.00, 60.00, 65.00, 65.00, NULL, NULL, NULL, 95.00, NULL, 35.00, 90.00, 80.00, 85.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(196, 66, 'rapor', 95.00, 91.00, 94.00, 90.00, 85.00, 94.00, 88.00, 76.00, 85.00, NULL, NULL, NULL, 88.00, NULL, 90.00, 94.00, 96.00, 95.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(197, 66, 'pts', 95.00, 80.00, 85.00, 90.00, 50.00, 80.00, 75.00, 85.00, 75.00, NULL, NULL, NULL, 80.00, NULL, 95.24, 75.00, 85.00, 85.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(198, 66, 'pas', 90.00, 100.00, 85.00, 80.00, 70.00, 95.00, 75.00, 75.00, 85.00, NULL, NULL, NULL, 85.00, NULL, 80.00, 90.00, 100.00, 80.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(199, 67, 'rapor', 75.00, 88.00, 90.00, 85.00, 79.00, 85.00, 93.00, 76.00, 83.00, 84.00, 77.00, 80.00, NULL, 75.00, NULL, NULL, NULL, 80.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(200, 67, 'pts', 70.00, 75.00, 55.00, 90.00, 70.00, 65.00, 55.00, 80.00, 80.00, 50.00, 65.00, 55.00, NULL, 75.00, NULL, NULL, NULL, 90.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(201, 67, 'pas', 80.00, 100.00, 90.00, 80.00, 65.00, 85.00, 70.00, 75.00, 60.00, 65.00, 40.00, 35.00, NULL, 60.00, NULL, NULL, NULL, 75.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(202, 68, 'rapor', 83.00, 88.00, 93.00, 90.00, 84.00, 88.00, 86.00, 80.00, 90.00, 90.00, 82.00, 86.00, NULL, 83.00, NULL, NULL, NULL, 95.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(203, 68, 'pts', 85.00, 70.00, 70.00, 90.00, 80.00, 40.00, 50.00, 75.00, 75.00, 75.00, 70.00, 65.00, NULL, 80.00, NULL, NULL, NULL, 70.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(204, 68, 'pas', 80.00, 100.00, 80.00, 85.00, 70.00, 85.00, 85.00, 80.00, 70.00, 80.00, 45.00, 60.00, NULL, 65.00, NULL, NULL, NULL, 80.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(205, 69, 'rapor', 85.00, 90.00, 93.00, 90.00, 82.00, 88.00, 86.00, 80.00, 83.00, 88.00, 84.00, 82.00, NULL, 80.00, NULL, NULL, NULL, 90.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(206, 69, 'pts', 85.00, 75.00, 75.00, 90.00, 75.00, 65.00, 50.00, 75.00, 75.00, 70.00, 70.00, 45.00, NULL, 85.00, NULL, NULL, NULL, 80.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(207, 69, 'pas', 80.00, 90.00, 80.00, 85.00, 70.00, 80.00, 85.00, 80.00, 45.00, 75.00, 50.00, 50.00, NULL, 70.00, NULL, NULL, NULL, 85.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(208, 70, 'rapor', 90.00, 90.00, 91.00, 90.00, 84.00, 89.00, 88.00, 80.00, 90.00, 92.00, 84.00, 92.00, NULL, 82.00, NULL, NULL, NULL, 95.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(209, 70, 'pts', 100.00, 65.00, 70.00, 80.00, 70.00, 90.00, 65.00, 85.00, 85.00, 90.00, 80.00, 70.00, NULL, 90.00, NULL, NULL, NULL, 70.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(210, 70, 'pas', 80.00, 90.00, 80.00, 85.00, 75.00, 95.00, 85.00, 80.00, 70.00, 95.00, 55.00, 65.00, NULL, 75.00, NULL, NULL, NULL, 80.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(211, 71, 'rapor', 0.00, 88.00, 90.00, 87.00, 84.00, 86.00, 88.00, 76.00, 85.00, 90.00, 86.00, 83.00, NULL, 89.00, NULL, NULL, NULL, 96.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(212, 71, 'pts', 80.00, 60.00, 65.00, 85.00, 65.00, 65.00, 75.00, 80.00, 80.00, 80.00, 75.00, 60.00, NULL, 80.00, NULL, NULL, NULL, 90.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(213, 71, 'pas', 95.00, 95.00, 90.00, 90.00, 65.00, 75.00, 85.00, 75.00, 80.00, 95.00, 45.00, 45.00, NULL, 45.00, NULL, NULL, NULL, 75.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(214, 72, 'rapor', 95.00, 90.00, 95.00, 90.00, 87.00, 90.00, 89.00, 80.00, 90.00, 91.00, 83.00, 90.00, NULL, 87.00, NULL, NULL, NULL, 90.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(215, 72, 'pts', 90.00, 75.00, 55.00, 95.00, 75.00, 85.00, 60.00, 85.00, 85.00, 90.00, 70.00, 75.00, NULL, 70.00, NULL, NULL, NULL, 80.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(216, 72, 'pas', 85.00, 100.00, 75.00, 95.00, 70.00, 100.00, 85.00, 80.00, 75.00, 85.00, 55.00, 95.00, NULL, 85.00, NULL, NULL, NULL, 80.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(217, 73, 'rapor', 85.00, 85.00, 94.00, 90.00, 80.00, 87.00, 88.00, 76.00, 85.00, 86.00, 79.00, 80.00, NULL, 80.00, NULL, NULL, NULL, 86.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(218, 73, 'pts', 75.00, 40.00, 55.00, 80.00, 80.00, 40.00, 45.00, 75.00, 75.00, 75.00, 65.00, 35.00, NULL, 80.00, NULL, NULL, NULL, 75.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(219, 73, 'pas', 80.00, 40.00, 80.00, 80.00, 80.00, 85.00, 60.00, 75.00, 85.00, 50.00, 50.00, 35.00, NULL, 75.00, NULL, NULL, NULL, 90.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(220, 74, 'rapor', 80.00, 88.00, 90.00, 85.00, 79.00, 86.00, 88.00, 76.00, 85.00, 82.00, 78.00, 80.00, NULL, 78.00, NULL, NULL, NULL, 84.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(221, 74, 'pts', 85.00, 55.00, 55.00, 90.00, 80.00, 45.00, 55.00, 75.00, 75.00, 70.00, 55.00, 40.00, NULL, 90.00, NULL, NULL, NULL, 90.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(222, 74, 'pas', 80.00, 55.00, 80.00, 75.00, 85.00, 85.00, 60.00, 75.00, 80.00, 55.00, 40.00, 55.00, NULL, 75.00, NULL, NULL, NULL, 85.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(223, 75, 'rapor', 80.00, 90.00, 89.00, 85.00, 80.00, 88.00, 89.00, 76.00, 85.00, 80.00, 80.00, 80.00, NULL, 78.00, NULL, NULL, NULL, 80.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(224, 75, 'pts', 90.00, 80.00, 55.00, 80.00, 70.00, 65.00, 85.00, 80.00, 80.00, 55.00, 70.00, 65.00, NULL, 70.00, NULL, NULL, NULL, 90.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(225, 75, 'pas', 75.00, 95.00, 95.00, 85.00, 70.00, 70.00, 80.00, 75.00, 70.00, 65.00, 35.00, 45.00, NULL, 50.00, NULL, NULL, NULL, 75.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(226, 76, 'rapor', 80.00, 75.00, 89.00, 95.00, 80.00, 84.00, 89.00, 76.00, 85.00, 88.00, 81.00, 82.00, NULL, 77.00, NULL, NULL, NULL, 80.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(227, 76, 'pts', 85.00, 45.00, 50.00, 80.00, 60.00, 55.00, 65.00, 70.00, 70.00, 65.00, 50.00, 55.00, NULL, 65.00, NULL, NULL, NULL, 85.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(228, 76, 'pas', 65.00, 0.00, 65.00, 0.00, 75.00, 45.00, 55.00, 0.00, 65.00, 65.00, 0.00, 0.00, NULL, 0.00, NULL, NULL, NULL, 65.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(229, 77, 'rapor', 90.00, 90.00, 90.00, 90.00, 83.00, 87.00, 88.00, 85.00, 90.00, 90.00, 85.00, 85.00, NULL, 85.00, NULL, NULL, NULL, 88.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(230, 77, 'pts', 70.00, 60.00, 55.00, 80.00, 85.00, 70.00, 50.00, 70.00, 70.00, 80.00, 80.00, 75.00, NULL, 85.00, NULL, NULL, NULL, 85.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(231, 77, 'pas', 85.00, 70.00, 75.00, 90.00, 90.00, 85.00, 75.00, 85.00, 60.00, 95.00, 30.00, 75.00, NULL, 85.00, NULL, NULL, NULL, 90.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(232, 78, 'rapor', 95.00, 92.00, 90.00, 85.00, 90.00, 93.00, 89.00, 85.00, 90.00, 92.00, 87.00, 89.00, NULL, 92.00, NULL, NULL, NULL, 95.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(233, 78, 'pts', 90.00, 70.00, 75.00, 95.00, 75.00, 75.00, 70.00, 80.00, 80.00, 90.00, 90.00, 80.00, NULL, 80.00, NULL, NULL, NULL, 80.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(234, 78, 'pas', 85.00, 80.00, 85.00, 85.00, 85.00, 75.00, 85.00, 85.00, 85.00, 90.00, 65.00, 60.00, NULL, 70.00, NULL, NULL, NULL, 95.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(235, 79, 'rapor', 80.00, 87.00, 90.00, 85.00, 80.00, 86.00, 86.00, 80.00, 85.00, 85.00, 82.00, 80.00, NULL, 78.00, NULL, NULL, NULL, 81.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(236, 79, 'pts', 80.00, 50.00, 55.00, 80.00, 70.00, 75.00, 50.00, 70.00, 70.00, 55.00, 40.00, 55.00, NULL, 70.00, NULL, NULL, NULL, 70.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(237, 79, 'pas', 75.00, 95.00, 55.00, 75.00, 40.00, 65.00, 50.00, 80.00, 80.00, 90.00, 35.00, 55.00, NULL, 35.00, NULL, NULL, NULL, 75.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(238, 80, 'rapor', 90.00, 90.00, 95.00, 85.00, 89.00, 86.00, 89.00, 76.00, 90.00, 91.00, 86.00, 85.00, NULL, 88.00, NULL, NULL, NULL, 95.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(239, 80, 'pts', 85.00, 80.00, 50.00, 80.00, 70.00, 65.00, 75.00, 85.00, 85.00, 80.00, 90.00, 70.00, NULL, 50.00, NULL, NULL, NULL, 85.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(240, 80, 'pas', 90.00, 100.00, 85.00, 90.00, 70.00, 85.00, 65.00, 75.00, 80.00, 100.00, 70.00, 50.00, NULL, 60.00, NULL, NULL, NULL, 80.00, '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(241, 81, 'rapor', 80.00, 90.00, 89.00, 80.00, 80.00, 86.00, 89.00, 76.00, 83.00, 86.00, 86.00, 81.00, NULL, 80.00, NULL, NULL, NULL, 82.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(242, 81, 'pts', 70.00, 60.00, 65.00, 65.00, 65.00, 60.00, 70.00, 80.00, 80.00, 50.00, 50.00, 70.00, NULL, 40.00, NULL, NULL, NULL, 80.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(243, 81, 'pas', 85.00, 95.00, 85.00, 75.00, 75.00, 90.00, 80.00, 75.00, 60.00, 70.00, 45.00, 55.00, NULL, 65.00, NULL, NULL, NULL, 70.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(244, 82, 'rapor', 95.00, 88.00, 90.00, 85.00, 89.00, 87.00, 89.00, 80.00, 90.00, 90.00, 89.00, 90.00, NULL, 92.00, NULL, NULL, NULL, 95.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(245, 82, 'pts', 90.00, 80.00, 65.00, 95.00, 70.00, 85.00, 85.00, 80.00, 80.00, 100.00, 95.00, 80.00, NULL, 45.00, NULL, NULL, NULL, 90.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(246, 82, 'pas', 95.00, 85.00, 80.00, 85.00, 80.00, 90.00, 85.00, 80.00, 90.00, 95.00, 70.00, 75.00, NULL, 70.00, NULL, NULL, NULL, 70.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(247, 83, 'rapor', 0.00, 78.00, 85.00, 85.00, 79.00, 80.00, 86.00, 76.00, 83.00, 81.00, 77.00, 79.00, NULL, 77.00, NULL, NULL, NULL, 79.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(248, 83, 'pts', 35.00, 60.00, 40.00, 80.00, 55.00, 30.00, 60.00, 55.00, 55.00, 45.00, 35.00, 15.00, NULL, 40.00, NULL, NULL, NULL, 65.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(249, 83, 'pas', 80.00, 85.00, 75.00, 0.00, 65.00, 65.00, 80.00, 70.00, 95.00, 80.00, 0.00, 55.00, NULL, 0.00, NULL, NULL, NULL, 80.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(250, 84, 'rapor', 93.00, 90.00, 90.00, 90.00, 80.00, 88.00, 89.00, 76.00, 85.00, 90.00, 84.00, 84.00, NULL, 80.00, NULL, NULL, NULL, 83.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(251, 84, 'pts', 90.00, 55.00, 60.00, 65.00, 90.00, 55.00, 55.00, 80.00, 80.00, 80.00, 50.00, 60.00, NULL, 70.00, NULL, NULL, NULL, 80.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(252, 84, 'pas', 95.00, 95.00, 85.00, 60.00, 90.00, 85.00, 75.00, 70.00, 60.00, 95.00, 60.00, 55.00, NULL, 85.00, NULL, NULL, NULL, 75.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(253, 85, 'rapor', 93.00, 88.00, 90.00, 90.00, 79.00, 85.00, 89.00, 76.00, 85.00, 88.00, 81.00, 81.00, NULL, 78.00, NULL, NULL, NULL, 80.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(254, 85, 'pts', 75.00, 50.00, 65.00, 80.00, 85.00, 70.00, 65.00, 75.00, 75.00, 70.00, 55.00, 65.00, NULL, 65.00, NULL, NULL, NULL, 90.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(255, 85, 'pas', 95.00, 100.00, 80.00, 75.00, 85.00, 80.00, 85.00, 75.00, 90.00, 85.00, 55.00, 65.00, NULL, 75.00, NULL, NULL, NULL, 75.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(256, 86, 'rapor', 90.00, 90.00, 90.00, 90.00, 80.00, 87.00, 87.00, 76.00, 85.00, 90.00, 86.00, 81.00, NULL, 80.00, NULL, NULL, NULL, 95.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(257, 86, 'pts', 75.00, 55.00, 65.00, 75.00, 80.00, 40.00, 50.00, 80.00, 80.00, 90.00, 70.00, 45.00, NULL, 80.00, NULL, NULL, NULL, 60.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(258, 86, 'pas', 0.00, 0.00, 60.00, 75.00, 85.00, 0.00, 45.00, 0.00, 15.00, 0.00, 85.00, 0.00, NULL, 80.00, NULL, NULL, NULL, 70.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(259, 87, 'rapor', 90.00, 90.00, 95.00, 90.00, 89.00, 92.00, 88.00, 76.00, 85.00, 89.00, 85.00, 83.00, NULL, 88.00, NULL, NULL, NULL, 92.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(260, 87, 'pts', 95.00, 80.00, 70.00, 90.00, 90.00, 65.00, 55.00, 80.00, 80.00, 85.00, 60.00, 55.00, NULL, 90.00, NULL, NULL, NULL, 75.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(261, 87, 'pas', 80.00, 90.00, 95.00, 70.00, 90.00, 75.00, 80.00, 75.00, 90.00, 85.00, 60.00, 80.00, NULL, 85.00, NULL, NULL, NULL, 95.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(262, 88, 'rapor', 90.00, 92.00, 95.00, 90.00, 82.00, 92.00, 89.00, 76.00, 85.00, 92.00, 85.00, 86.00, NULL, 88.00, NULL, NULL, NULL, 88.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(263, 88, 'pts', 95.00, 60.00, 55.00, 70.00, 90.00, 70.00, 60.00, 85.00, 85.00, 75.00, 75.00, 75.00, NULL, 70.00, NULL, NULL, NULL, 85.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(264, 88, 'pas', 80.00, 100.00, 75.00, 65.00, 90.00, 80.00, 80.00, 70.00, 75.00, 95.00, 80.00, 75.00, NULL, 80.00, NULL, NULL, NULL, 80.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(265, 89, 'rapor', 0.00, 88.00, 93.00, 90.00, 80.00, 84.00, 86.00, 76.00, 85.00, 86.00, 80.00, 80.00, NULL, 78.00, NULL, NULL, NULL, 84.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(266, 89, 'pts', 65.00, 40.00, 65.00, 85.00, 85.00, 45.00, 75.00, 85.00, 85.00, 80.00, 70.00, 70.00, NULL, 85.00, NULL, NULL, NULL, 85.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(267, 89, 'pas', 75.00, 95.00, 90.00, 75.00, 95.00, 60.00, 65.00, 75.00, 95.00, 90.00, 45.00, 75.00, NULL, 90.00, NULL, NULL, NULL, 80.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(268, 90, 'rapor', 85.00, 85.00, 91.00, 85.00, 85.00, 85.00, 90.00, 76.00, 85.00, 90.00, 80.00, 80.00, NULL, 83.00, NULL, NULL, NULL, 88.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(269, 90, 'pts', 75.00, 55.00, 60.00, 85.00, 75.00, 65.00, 85.00, 85.00, 85.00, 50.00, 70.00, 70.00, NULL, 80.00, NULL, NULL, NULL, 90.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(270, 90, 'pas', 85.00, 90.00, 85.00, 75.00, 55.00, 85.00, 85.00, 75.00, 45.00, 100.00, 65.00, 70.00, NULL, 50.00, NULL, NULL, NULL, 85.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(271, 91, 'rapor', 83.00, 85.00, 91.00, 85.00, 89.00, 87.00, 88.00, 76.00, 85.00, 90.00, 86.00, 85.00, NULL, 88.00, NULL, NULL, NULL, 86.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(272, 91, 'pts', 85.00, 75.00, 55.00, 90.00, 75.00, 75.00, 60.00, 80.00, 80.00, 65.00, 80.00, 75.00, NULL, 75.00, NULL, NULL, NULL, 90.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(273, 91, 'pas', 80.00, 100.00, 75.00, 75.00, 60.00, 95.00, 80.00, 75.00, 55.00, 90.00, 70.00, 60.00, NULL, 45.00, NULL, NULL, NULL, 80.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(274, 92, 'rapor', 90.00, 91.00, 96.00, 90.00, 88.00, 90.00, 90.00, 76.00, 85.00, 92.00, 89.00, 89.00, NULL, 90.00, NULL, NULL, NULL, 96.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(275, 92, 'pts', 95.00, 90.00, 55.00, 80.00, 85.00, 60.00, 50.00, 65.00, 65.00, 80.00, 85.00, 70.00, NULL, 90.00, NULL, NULL, NULL, 75.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(276, 92, 'pas', 85.00, 80.00, 75.00, 80.00, 75.00, 60.00, 50.00, 55.00, 85.00, 90.00, 100.00, 65.00, 0.00, 70.00, NULL, NULL, NULL, 90.00, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(277, 93, 'rapor', 90.00, 90.00, 95.00, 90.00, 83.00, 90.00, 90.00, 80.00, 90.00, 89.00, NULL, NULL, 91.00, NULL, 88.00, 88.00, 96.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(278, 93, 'pts', 90.00, 65.00, 55.00, 75.00, 45.00, 70.00, 70.00, 80.00, 65.00, 75.00, NULL, NULL, 80.00, NULL, 66.67, 60.00, 75.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(279, 93, 'pas', 90.00, 90.00, 80.00, 85.00, 70.00, 85.00, 80.00, 80.00, 65.00, 75.00, NULL, NULL, 85.00, NULL, 65.00, 60.00, 75.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(280, 94, 'rapor', 80.00, 88.00, 90.00, 85.00, 79.00, 84.00, 88.00, 80.00, 83.00, 84.00, NULL, NULL, 90.00, NULL, 85.00, 76.00, 82.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(281, 94, 'pts', 70.00, 60.00, 65.00, 80.00, 65.00, 25.00, 55.00, 80.00, 60.00, 80.00, NULL, NULL, 75.00, NULL, 71.43, 30.00, 70.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(282, 94, 'pas', 55.00, 90.00, 70.00, 80.00, 65.00, 60.00, 75.00, 80.00, 75.00, 70.00, NULL, NULL, 90.00, NULL, 55.00, 65.00, 75.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(283, 95, 'rapor', 90.00, 90.00, 94.00, 95.00, 84.00, 87.00, 88.00, 76.00, 90.00, 89.00, NULL, NULL, 91.50, NULL, 88.00, 90.00, 92.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(284, 95, 'pts', 90.00, 70.00, 70.00, 85.00, 70.00, 60.00, 65.00, 90.00, 70.00, 85.00, NULL, NULL, 70.00, NULL, 71.43, 75.00, 85.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(285, 95, 'pas', 85.00, 90.00, 75.00, 85.00, 75.00, 70.00, 70.00, 75.00, 85.00, 90.00, NULL, NULL, 90.00, NULL, 70.00, 80.00, 95.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(286, 96, 'rapor', 90.00, 92.00, 95.00, 95.00, 89.00, 89.00, 88.00, 76.00, 85.00, 90.00, NULL, NULL, 85.00, NULL, 90.00, 92.00, 90.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(287, 96, 'pts', 100.00, 80.00, 60.00, 95.00, 75.00, 90.00, 60.00, 80.00, 80.00, 95.00, NULL, NULL, 75.00, NULL, 71.43, 70.00, 80.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(288, 96, 'pas', 80.00, 100.00, 70.00, 85.00, 80.00, 75.00, 75.00, 50.00, 70.00, 85.00, NULL, NULL, 80.00, NULL, 65.00, 95.00, 100.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(289, 97, 'rapor', 85.00, 90.00, 90.00, 90.00, 80.00, 86.00, 86.00, 80.00, 90.00, 88.00, NULL, NULL, 86.00, NULL, 88.00, 90.00, 90.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(290, 97, 'pts', 75.00, 65.00, 70.00, 75.00, 80.00, 70.00, 60.00, 80.00, 65.00, 75.00, NULL, NULL, 70.00, NULL, 66.67, 80.00, 65.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(291, 97, 'pas', 85.00, 80.00, 70.00, 80.00, 70.00, 60.00, 70.00, 80.00, 80.00, 85.00, NULL, NULL, 80.00, NULL, 60.00, 90.00, 85.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(292, 98, 'rapor', 80.00, 92.00, 95.00, 90.00, 83.00, 88.00, 88.00, 76.00, 90.00, 87.00, NULL, NULL, 85.00, NULL, 90.00, 87.00, 90.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(293, 98, 'pts', 65.00, 55.00, 45.00, 80.00, 85.00, 45.00, 40.00, 75.00, 55.00, 80.00, NULL, NULL, 75.00, NULL, 28.57, 50.00, 55.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(294, 98, 'pas', 70.00, 95.00, 80.00, 90.00, 80.00, 90.00, 65.00, 50.00, 70.00, 80.00, NULL, NULL, 80.00, NULL, 55.00, 80.00, 70.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(295, 99, 'rapor', 85.00, 90.00, 95.00, 90.00, 80.00, 86.00, 87.00, 76.00, 90.00, 88.00, NULL, NULL, 81.00, NULL, 85.00, 86.00, 90.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(296, 99, 'pts', 80.00, 35.00, 50.00, 90.00, 80.00, 20.00, 60.00, 70.00, 35.00, 90.00, NULL, NULL, 75.00, NULL, 57.14, 60.00, 60.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(297, 99, 'pas', 75.00, 65.00, 70.00, 75.00, 95.00, 40.00, 55.00, 60.00, 90.00, 70.00, NULL, NULL, 70.00, NULL, 65.00, 55.00, 75.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(298, 100, 'rapor', 75.00, 82.00, 89.00, 90.00, 78.00, 85.00, 86.00, 76.00, 90.00, 86.00, NULL, NULL, 82.50, NULL, 80.00, 77.00, 88.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(299, 100, 'pts', 50.00, 45.00, 40.00, 75.00, 55.00, 30.00, 60.00, 70.00, 45.00, 75.00, NULL, NULL, 55.00, NULL, 33.33, 35.00, 45.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(300, 100, 'pas', 65.00, 70.00, 55.00, 80.00, 45.00, 30.00, 80.00, 65.00, 65.00, 55.00, NULL, NULL, 75.00, NULL, 30.00, 45.00, 65.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(301, 101, 'rapor', 75.00, 80.00, 79.00, 85.00, 78.00, 82.00, 88.00, 76.00, 83.00, 80.00, NULL, NULL, 91.50, NULL, 80.00, 78.00, 88.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(302, 101, 'pts', 60.00, 45.00, 45.00, 30.00, 60.00, 30.00, 35.00, 65.00, 45.00, 30.00, NULL, NULL, 75.00, NULL, 42.86, 35.00, 70.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(303, 101, 'pas', 80.00, 95.00, 60.00, 55.00, 55.00, 90.00, 85.00, 70.00, 75.00, 60.00, NULL, NULL, 95.00, NULL, 35.00, 90.00, 70.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(304, 102, 'rapor', 75.00, 80.00, 89.00, 85.00, 78.00, 83.00, 88.00, 76.00, 83.00, 80.00, NULL, NULL, 86.50, NULL, 85.00, 78.00, 82.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(305, 102, 'pts', 65.00, 50.00, 60.00, 85.00, 55.00, 35.00, 80.00, 75.00, 50.00, 85.00, NULL, NULL, 80.00, NULL, 57.14, 55.00, 70.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(306, 102, 'pas', 50.00, 80.00, 65.00, 90.00, 60.00, 55.00, 80.00, 65.00, 60.00, 60.00, NULL, NULL, 85.00, NULL, 60.00, 65.00, 65.00, NULL, '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(307, 103, 'rapor', 90.00, 92.00, 95.00, 90.00, 82.00, 88.00, 88.00, 76.00, 85.00, 87.00, NULL, NULL, 89.00, NULL, 88.00, 88.00, 90.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(308, 103, 'pts', 80.00, 50.00, 55.00, 80.00, 70.00, 50.00, 70.00, 80.00, 50.00, 80.00, NULL, NULL, 80.00, NULL, 52.38, 55.00, 90.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(309, 103, 'pas', 85.00, 85.00, 70.00, 90.00, 70.00, 85.00, 80.00, 75.00, 75.00, 85.00, NULL, NULL, 85.00, NULL, 70.00, 60.00, 75.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(310, 104, 'rapor', 80.00, 88.00, 90.00, 90.00, 80.00, 87.00, 90.00, 80.00, 83.00, 81.00, NULL, NULL, 85.00, NULL, 88.00, 75.00, 88.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(311, 104, 'pts', 80.00, 60.00, 60.00, 85.00, 65.00, 75.00, 70.00, 85.00, 60.00, 85.00, NULL, NULL, 80.00, NULL, 71.43, 75.00, 75.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(312, 104, 'pas', 75.00, 70.00, 80.00, 95.00, 70.00, 75.00, 80.00, 80.00, 80.00, 60.00, NULL, NULL, 80.00, NULL, 75.00, 90.00, 80.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(313, 105, 'rapor', 80.00, 80.00, 90.00, 85.00, 89.00, 94.00, 88.00, 80.00, 83.00, 89.00, NULL, NULL, 82.50, NULL, 90.00, 84.00, 88.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(314, 105, 'pts', 80.00, 55.00, 65.00, 85.00, 70.00, 75.00, 65.00, 85.00, 55.00, 85.00, NULL, NULL, 75.00, NULL, 80.95, 75.00, 80.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47');
INSERT INTO `nilai_akademik` (`id`, `siswa_periode_id`, `jenis_nilai`, `agama`, `pkn`, `b_indonesia`, `b_inggris`, `mtk_wajib`, `sejarah`, `pjok`, `seni_rupa`, `b_jepang`, `biologi`, `fisika`, `kimia`, `informatika`, `mtk_lanjut`, `geografi`, `sosial`, `pkwu`, `ekonomi`, `created_at`, `updated_at`) VALUES
(315, 105, 'pas', 80.00, 75.00, 80.00, 90.00, 80.00, 90.00, 70.00, 80.00, 55.00, 60.00, NULL, NULL, 75.00, NULL, 75.00, 80.00, 90.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(316, 106, 'rapor', 80.00, 85.00, 89.00, 85.00, 80.00, 88.00, 89.00, 76.00, 85.00, 81.00, NULL, NULL, 90.00, NULL, 85.00, 77.00, 92.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(317, 106, 'pts', 80.00, 65.00, 60.00, 80.00, 75.00, 55.00, 70.00, 75.00, 65.00, 80.00, NULL, NULL, 80.00, NULL, 76.19, 50.00, 75.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(318, 106, 'pas', 80.00, 95.00, 75.00, 95.00, 60.00, 80.00, 65.00, 65.00, 85.00, 55.00, NULL, NULL, 90.00, NULL, 70.00, 90.00, 80.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(319, 107, 'rapor', 75.00, 78.00, 80.00, 85.00, 79.00, 84.00, 92.00, 76.00, 85.00, 83.00, NULL, NULL, 85.00, NULL, 85.00, 79.00, 82.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(320, 107, 'pts', 65.00, 45.00, 30.00, 65.00, 25.00, 35.00, 60.00, 75.00, 45.00, 65.00, NULL, NULL, 80.00, NULL, 42.86, 50.00, 80.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(321, 107, 'pas', 65.00, 65.00, 45.00, 85.00, 50.00, 85.00, 70.00, 70.00, 40.00, 60.00, NULL, NULL, 80.00, NULL, 50.00, 80.00, 70.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(322, 108, 'rapor', 75.00, 78.00, 94.00, 90.00, 79.00, 84.00, 87.00, 76.00, 83.00, 79.00, NULL, NULL, 94.00, NULL, 80.00, 82.00, 82.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(323, 108, 'pts', 80.00, 50.00, 70.00, 90.00, 65.00, 60.00, 60.00, 80.00, 50.00, 90.00, NULL, NULL, 75.00, NULL, 66.67, 60.00, 55.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(324, 108, 'pas', 80.00, 95.00, 90.00, 90.00, 60.00, 90.00, 75.00, 70.00, 95.00, 80.00, NULL, NULL, 95.00, NULL, 65.00, 95.00, 85.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(325, 109, 'rapor', 75.00, 78.00, 89.00, 85.00, 79.00, 85.00, 88.00, 76.00, 83.00, 79.00, NULL, NULL, 93.00, NULL, 80.00, 77.00, 84.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(326, 109, 'pts', 70.00, 45.00, 20.00, 65.00, 20.00, 40.00, 60.00, 65.00, 45.00, 65.00, NULL, NULL, 40.00, NULL, 42.86, 50.00, 65.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(327, 109, 'pas', 80.00, 90.00, 85.00, 90.00, 45.00, 90.00, 80.00, 75.00, 85.00, 75.00, NULL, NULL, 95.00, NULL, 85.00, 80.00, 85.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(328, 110, 'rapor', 75.00, 80.00, 82.00, 85.00, 80.00, 84.00, 89.00, 80.00, 85.00, 82.00, NULL, NULL, 82.50, NULL, 85.00, 79.00, 84.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(329, 110, 'pts', 60.00, 55.00, 45.00, 70.00, 30.00, 25.00, 60.00, 70.00, 55.00, 70.00, NULL, NULL, 80.00, NULL, 38.10, 55.00, 70.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(330, 110, 'pas', 70.00, 90.00, 70.00, 75.00, 40.00, 80.00, 85.00, 80.00, 70.00, 60.00, NULL, NULL, 75.00, NULL, 45.00, 80.00, 65.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(331, 111, 'rapor', 85.00, 90.00, 80.00, 85.00, 78.00, 85.00, 88.00, 76.00, 90.00, 89.00, NULL, NULL, 85.00, NULL, 80.00, 87.00, 88.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(332, 111, 'pts', 85.00, 65.00, 85.00, 90.00, 30.00, 70.00, 60.00, 80.00, 65.00, 90.00, NULL, NULL, 85.00, NULL, 61.90, 55.00, 65.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(333, 111, 'pas', 70.00, 90.00, 85.00, 85.00, 50.00, 80.00, 70.00, 70.00, 65.00, 90.00, NULL, NULL, 80.00, NULL, 70.00, 90.00, 90.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(334, 112, 'rapor', 75.00, 90.00, 90.00, 95.00, 80.00, 87.00, 88.00, 76.00, 90.00, 89.00, NULL, NULL, 86.50, NULL, 88.00, 88.00, 88.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(335, 112, 'pts', 95.00, 55.00, 50.00, 95.00, 75.00, 35.00, 55.00, 75.00, 55.00, 95.00, NULL, NULL, 70.00, NULL, 71.43, 90.00, 90.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(336, 112, 'pas', 75.00, 95.00, 65.00, 85.00, 80.00, 80.00, 85.00, 65.00, 75.00, 85.00, NULL, NULL, 85.00, NULL, 80.00, 80.00, 90.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(337, 113, 'rapor', 80.00, 85.00, 90.00, 85.00, 80.00, 85.00, 88.00, 80.00, 85.00, 85.00, NULL, NULL, 83.50, NULL, 88.00, 83.00, 88.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(338, 113, 'pts', 90.00, 60.00, 40.00, 60.00, 80.00, 45.00, 40.00, 65.00, 60.00, 70.00, NULL, NULL, 85.00, NULL, 66.67, 60.00, 80.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(339, 113, 'pas', 80.00, 70.00, 60.00, 75.00, 75.00, 60.00, 60.00, 80.00, 65.00, 75.00, NULL, NULL, 75.00, NULL, 60.00, 50.00, 65.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(340, 114, 'rapor', 85.00, 88.00, 93.00, 90.00, 82.00, 90.00, 89.00, 76.00, 85.00, 84.00, NULL, NULL, 92.50, NULL, 88.00, 85.00, 88.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(341, 114, 'pts', 75.00, 65.00, 30.00, 75.00, 75.00, 30.00, 50.00, 70.00, 65.00, 75.00, NULL, NULL, 75.00, NULL, 38.10, 35.00, 85.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(342, 114, 'pas', 85.00, 95.00, 75.00, 80.00, 85.00, 90.00, 70.00, 65.00, 60.00, 60.00, NULL, NULL, 95.00, NULL, 55.00, 65.00, 85.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(343, 115, 'rapor', 90.00, 91.00, 95.00, 90.00, 83.00, 92.00, 89.00, 76.00, 90.00, 90.00, NULL, NULL, 89.00, NULL, 90.00, 90.00, 92.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(344, 115, 'pts', 85.00, 60.00, 60.00, 75.00, 40.00, 75.00, 75.00, 85.00, 60.00, 65.00, NULL, NULL, 75.00, NULL, 66.67, 70.00, 75.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(345, 115, 'pas', 80.00, 100.00, 80.00, 80.00, 75.00, 45.00, 70.00, 55.00, 45.00, 95.00, NULL, NULL, 85.00, NULL, 75.00, 70.00, 95.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(346, 116, 'rapor', 90.00, 90.00, 90.00, 90.00, 82.00, 88.00, 87.00, 80.00, 85.00, 86.00, NULL, NULL, 93.00, NULL, 88.00, 92.00, 90.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(347, 116, 'pts', 85.00, 80.00, 55.00, 95.00, 85.00, 70.00, 60.00, 80.00, 80.00, 80.00, NULL, NULL, 80.00, NULL, 85.71, 80.00, 85.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(348, 116, 'pas', 85.00, 90.00, 80.00, 80.00, 75.00, 85.00, 70.00, 70.00, 85.00, 90.00, NULL, NULL, 95.00, NULL, 65.00, 90.00, 95.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(349, 117, 'rapor', 85.00, 90.00, 90.00, 90.00, 82.00, 89.00, 88.00, 76.00, 85.00, 85.00, NULL, NULL, 93.50, NULL, 85.00, 88.00, 90.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(350, 117, 'pts', 80.00, 70.00, 70.00, 85.00, 85.00, 70.00, 65.00, 85.00, 70.00, 80.00, NULL, NULL, 80.00, NULL, 85.71, 80.00, 90.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(351, 117, 'pas', 85.00, 95.00, 80.00, 90.00, 80.00, 90.00, 70.00, 65.00, 85.00, 80.00, NULL, NULL, 95.00, NULL, 70.00, 80.00, 85.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(352, 118, 'rapor', 74.00, 88.00, 80.00, 85.00, 80.00, 85.00, 89.00, 76.00, 85.00, 84.00, NULL, NULL, 85.00, NULL, 80.00, 77.00, 90.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(353, 118, 'pts', 55.00, 30.00, 15.00, 30.00, 80.00, 20.00, 20.00, 25.00, 30.00, 70.00, NULL, NULL, 30.00, NULL, 33.33, 35.00, 85.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(354, 118, 'pas', 65.00, 50.00, 40.00, 55.00, 85.00, 50.00, 55.00, 55.00, 35.00, 40.00, NULL, NULL, 45.00, NULL, 30.00, 40.00, 60.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(355, 119, 'rapor', 90.00, 90.00, 90.00, 90.00, 80.00, 87.00, 89.00, 76.00, 85.00, 86.00, NULL, NULL, 88.50, NULL, 88.00, 92.00, 94.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(356, 119, 'pts', 90.00, 60.00, 50.00, 80.00, 80.00, 55.00, 45.00, 60.00, 60.00, 75.00, NULL, NULL, 80.00, NULL, 66.67, 55.00, 90.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(357, 119, 'pas', 85.00, 75.00, 75.00, 75.00, 75.00, 80.00, 60.00, 80.00, 70.00, 85.00, NULL, NULL, 85.00, NULL, 60.00, 70.00, 90.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(358, 120, 'rapor', 90.00, 92.00, 95.00, 90.00, 85.00, 88.00, 89.00, 76.00, 90.00, 90.00, NULL, NULL, 93.50, NULL, 90.00, 92.00, 94.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(359, 120, 'pts', 90.00, 75.00, 70.00, 90.00, 85.00, 55.00, 65.00, 75.00, 75.00, 80.00, NULL, NULL, 80.00, NULL, 90.48, 80.00, 85.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(360, 120, 'pas', 90.00, 95.00, 75.00, 70.00, 70.00, 90.00, 70.00, 70.00, 75.00, 85.00, NULL, NULL, 95.00, NULL, 70.00, 85.00, 95.00, NULL, '2026-10-21 13:29:47', '2026-10-21 13:29:47');

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
(16, 16, 'Badminton', 'Tidak', 'Modifikasi Motor', 'Badminton', 'Tidak', 'Teknik Mesin', 'Pendidikan Jasmani', '2026-10-21 13:29:43', '2026-10-21 13:29:43'),
(17, 17, 'Futsal', 'Tidak', 'Bermain Futsal', 'Karang Taruna', 'Tidak', 'Manajemen', 'Ilmu Keolahragaan', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(18, 18, 'Band', 'Tidak', 'Main Gitar', 'OSIS', 'Bimbel', 'Psikologi', 'Sastra Indonesia', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(19, 19, 'Futsal', 'Tidak', 'Bermain Futsal', 'Tidak', 'Tidak', 'Manajemen', 'Ekonomi', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(20, 20, 'Modern Dance', 'Tidak', 'Bisnis', 'Karang Taruna', 'Tidak', 'Manajemen', 'Akuntansi', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(21, 21, 'Badminton', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Sastra Inggris', 'Ilmu Komunikasi', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(22, 22, 'Taekwondo', 'Tidak', 'Bela Diri', 'Tidak', 'Tidak', 'Ilmu Keolahragaan', 'Pendidikan Jasmani', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(23, 23, 'Badminton', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Industri', 'Teknik Elektro', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(24, 24, 'Basket', 'Tidak', 'Main Basket', 'Tidak', 'Tidak', 'Manajemen', 'Hukum', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(25, 25, 'Tari Tradisional', 'Runner Up Puteri Remaja Indonesia Lingkungan Jakarta 2024', 'Menari', 'OSIS', 'Bimbel', 'Ilmu Komunikasi', 'Psikologi', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(26, 26, 'Badminton', 'Tidak', 'Menggambar', 'Badminton', 'Bimbel', 'Arsitektur', 'DKV', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(27, 27, 'Mading', 'Tidak', 'Fotografi', 'Tidak', 'Bimbel', 'DKV', 'Manajemen', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(28, 28, 'Futsal', 'Tidak', 'Videografi', 'Karang Taruna', 'Bimbel', 'DKV', 'Teknik Informatika', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(29, 29, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Mesin', 'Hukum', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(30, 30, 'Basket', 'Tidak', 'Editing', 'Tidak', 'Tidak', 'Teknik Informatika', 'DKV', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(31, 31, 'Futsal', 'Tidak', 'Bisnis', 'Basket', 'Tidak', 'Akuntansi', 'Manajemen', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(32, 32, 'KIR', 'Tidak', 'Analisis', 'OSIS', 'Bimbel', 'Kedokteran', 'Teknik Informatika', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(33, 33, 'Basket', 'Tidak', 'Gaming', 'Basket', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(34, 34, 'Modern Dance', 'Tidak', 'Wirausaha', 'OSIS', 'Bimbel', 'Manajemen', 'Farmasi', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(35, 35, 'Futsal', 'Tidak', 'Desain', 'Tidak', 'Tidak', 'DKV', 'Arsitektur', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(36, 36, 'Basket', 'Tidak', 'Bisnis', 'Karang Taruna', 'Tidak', 'Manajemen', 'Ekonomi', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(37, 37, 'Taekwondo', 'Tidak', 'Bela Diri', 'OSIS', 'Tidak', 'Ilmu Keolahragaan', 'Hukum', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(38, 38, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Tidak', 'Tidak', 'Teknik Industri', 'Teknik Elektro', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(39, 39, 'KIR', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Psikologi', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(40, 40, 'Tari Tradisional', 'Tidak', 'Wirausaha', 'Karang Taruna', 'Bimbel', 'Manajemen', 'Akuntansi', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(41, 41, 'Tari Tradisional', 'Juara harapan 1 FLS2N', 'Desain', 'Tidak', 'Bimbel', 'DKV', 'Arsitektur', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(42, 42, 'Futsal', 'Juara 1 Lomba Futsal di SMA Penabur Bintaro Jaya 2024', 'Bermain Futsal', 'Karang Taruna', 'Tidak', 'Ilmu Keolahragaan', 'Teknik Elektro', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(43, 43, 'Band', 'Tidak', 'Gaming', 'Tidak', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(44, 44, 'Futsal', 'Tidak', 'Atletik', 'Tidak', 'Tidak', 'Pendidikan Jasmani', 'Ilmu Keolahragaan', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(45, 45, 'Basket', 'Tidak', 'Public Speaking', 'Basket', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Sastra Inggris', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(46, 46, 'Futsal', 'Tidak', 'Modifikasi Motor', 'OSIS', 'Tidak', 'Teknik Mesin', 'Teknik Industri', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(47, 47, 'KIR', 'Tidak', 'Analisis', 'Tidak', 'Tidak', 'Hukum', 'Psikologi', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(48, 48, 'Taekwondo', 'Tidak', 'Bela Diri', 'Karang Taruna', 'Pelatihan Saksi Partai', 'Hukum', 'Ilmu Komunikasi', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(49, 49, 'Taekwondo', 'Juara 1 kejuaraan taekwondo liga DKI', 'Bela Diri', 'OSIS', 'Tidak', 'Hukum', 'Pendidikan Jasmani', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(50, 50, 'Badminton', 'Tidak', 'Atletik', 'Badminton', 'Tidak', 'Pendidikan Jasmani', 'Sastra Indonesia', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(51, 51, 'Taekwondo', 'Tidak', 'Bela Diri', 'Tidak', 'Tidak', 'Ilmu Keolahragaan', 'Teknik Mesin', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(52, 52, 'Band', 'Tidak', 'Main Drum', 'OSIS', 'Tidak', 'Manajemen', 'Teknik Industri', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(53, 53, 'Badminton', 'Tidak', 'Videografi', 'Badminton', 'Tidak', 'DKV', 'Teknik Informatika', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(54, 54, 'Modern Dance', 'Tidak', 'Bisnis', 'Karang Taruna', 'Bimbel', 'Hukum', 'Akuntansi', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(55, 55, 'Futsal', 'Juara 1 Lomba Futsal di SMA Penabur Bintaro Jaya 2024', 'Bermain Futsal', 'Karang Taruna', 'Tidak', 'Ilmu Komunikasi', 'Manajemen', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(56, 56, 'Mading', 'Tidak', 'Melukis', 'Tidak', 'Bimbel', 'Manajemen', 'DKV', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(57, 57, 'Tari Tradisional', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Psikologi', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(58, 58, 'Modern Dance', 'Tidak', 'Wirausaha', 'Tidak', 'Bimbel', 'Manajemen', 'Akuntansi', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(59, 59, 'Mading', 'Tidak', 'Menggambar', 'Karang Taruna', 'Tidak', 'Seni Rupa', 'DKV', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(60, 60, 'KIR', 'Tidak', 'Analisis', 'PMR', 'Tidak', 'Ilmu Keperawatan', 'Farmasi', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(61, 61, 'Band', 'Tidak', 'Main Gitar', 'Karang Taruna', 'Tidak', 'Manajemen', 'Hukum', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(62, 62, 'KIR', 'Tidak', 'Analisis', 'PMR', 'Bimbel', 'Ilmu Keperawatan', 'Teknologi Pangan', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(63, 63, 'Tari Tradisional', 'Tidak', 'Bisnis', 'OSIS', 'Bimbel', 'Akuntansi', 'Ekonomi', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(64, 64, 'Badminton', 'Tidak', 'Public Speaking', 'Badminton', 'Kursus TOEFL', 'Sastra Inggris', 'Ilmu Komunikasi', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(65, 65, 'Futsal', 'Tidak', 'Modifikasi Motor', 'Tidak', 'Tidak', 'Teknik Industri', 'Teknik Elektro', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(66, 66, 'Tari Tradisional', 'Tidak', 'Bisnis', 'Karang Taruna', 'Bimbel', 'Akuntansi', 'Hukum', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(67, 67, 'KIR', 'Juara 2 kejuaraan pelajar nasional', 'Analisis', 'OSIS', 'Tidak', 'Teknologi Pangan', 'Arsitektur', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(68, 68, 'Tari Tradisional', 'Tidak', 'Memasak', 'Tidak', 'Bimbel', 'Teknologi Pangan', 'Ilmu Komunikasi', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(69, 69, 'Modern Dance', 'Tidak', 'Menari', 'Karang Taruna', 'Tidak', 'Seni Rupa', 'PGSD', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(70, 70, 'Mading', 'Tidak', 'Videografi', 'Tidak', 'Bimbel', 'DKV', 'Teknik Informatika', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(71, 71, 'Band', 'Tidak', 'Modifikasi Motor', 'OSIS', 'Bimbel', 'Teknik Mesin', 'Teknik Elektro', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(72, 72, 'Mading', 'Tidak', 'Menggambar', 'Tidak', 'Bimbel', 'DKV', 'Arsitektur', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(73, 73, 'Basket', 'Tidak', 'Bisnis', 'Basket', 'Tidak', 'Manajemen', 'Psikologi', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(74, 74, 'Taekwondo', 'Tidak', 'Bela Diri', 'Karang Taruna', 'Tidak', 'Pendidikan Jasmani', 'Hukum', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(75, 75, 'futsal', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Industri', 'Manajemen', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(76, 76, 'Badminton', 'Tidak', 'Editing', 'Tidak', 'Tidak', 'DKV', 'Teknik Informatika', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(77, 77, 'Mading', 'Tidak', 'Menggambar', 'Tidak', 'Tidak', 'Arsitektur', 'DKV', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(78, 78, 'futsal', 'Tidak', 'Wirausaha', 'Tidak', 'Tidak', 'Manajemen', 'Ekonomi', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(79, 79, 'Futsal', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Tidak', 'Tidak', 'Teknik Informatika', 'Manajemen', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(80, 80, 'basket', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'OSIS', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(81, 81, 'Futsal', 'Tidak', 'Public Speaking', 'Karang Taruna', 'Tidak', 'Hukum', 'Ilmu Komunikasi', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(82, 82, 'Badminton', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Badminton', 'Tidak', 'Teknik Informatika', 'Teknik Elektro', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(83, 83, 'Basket', 'Tidak', 'Videografi', 'Karang Taruna', 'Tidak', 'DKV', 'Manajemen', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(84, 84, 'KIR', 'Tidak', 'Public Speaking', 'Tidak', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Sastra Inggris', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(85, 85, 'Band', 'Juara 2 Solo Vokal M25 Cup SMA Muhammadh 25 Pamulang 2024', 'Menyanyi', 'OSIS', 'Tidak', 'Ilmu Komunikasi', 'Sastra Indonesia', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(86, 86, 'Mading', 'Tidak', 'Melukis', 'Tidak', 'Melukis', 'Seni Rupa', 'DKV', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(87, 87, 'Tari Tradisional', 'Tidak', 'Bisnis', 'Karang Taruna', 'Bimbel', 'Akuntansi', 'Ekonomi', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(88, 88, 'Tari Tradisional', 'Tidak', 'Memasak', 'Tidak', 'Bimbel', 'Ilmu Keperawatan', 'Teknologi Pangan', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(89, 89, 'KIR', 'Tidak', 'Analisis', 'Tidak', 'Bimbel', 'Arsitektur', 'Farmasi', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(90, 90, 'Futsal', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Karang Taruna', 'Tidak', 'Manajemen', 'Teknik Informatika', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(91, 91, 'Badminton', 'Juara 3 lomba mobile legends tingkat SMA', 'Gaming', 'Tidak', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(92, 92, 'Tari Tradisional', 'Tidak', 'Wirausaha', 'Karang Taruna', 'Tidak', 'Akuntansi', 'Manajemen', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(93, 93, 'Band', 'Tidak', 'Main Gitar', 'Karang Taruna', 'Pelatihan Saksi Partai', 'Hukum', 'Sastra Indonesia', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(94, 94, 'Futsal', 'Tidak', 'Editing', 'Karang Taruna', 'Tidak', 'DKV', 'Teknik Informatika', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(95, 95, 'Modern Dance', 'Tidak', 'Menari', 'Tidak', 'Tidak', 'Pendidikan Jasmani', 'Seni Rupa', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(96, 96, 'Modern Dance', 'Tidak', 'Memasak', 'OSIS', 'Bimbel', 'Teknologi Pangan', 'Farmasi', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(97, 97, 'KIR', 'Tidak', 'Wirausaha', 'OSIS', 'Tidak', 'Manajemen', 'Ekonomi', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(98, 98, 'Mading', 'Tidak', 'Menggambar', 'Tidak', 'Tidak', 'DKV', 'Arsitektur', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(99, 99, 'KIR', 'Tidak', 'Fotografi', 'PMR', 'Tidak', 'DKV', 'Ilmu Keperawatan', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(100, 100, 'futsal', 'Tidak', 'Modifikasi Motor', 'Tidak', 'Tidak', 'Teknik Industri', 'Teknik Elektro', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(101, 101, 'Band', 'Tidak', 'Analisis', 'Tidak', 'Bimbel', 'Kedokteran', 'Teknik Industri', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(102, 102, 'Taekwondo', 'Tidak', 'Bisnis', 'Tidak', 'Tidak', 'Teknik Informatika', 'Pendidikan Jasmani', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(103, 103, 'Basket', 'Tidak', 'Gaming', 'Basket', 'Tidak', 'Teknik Informatika', 'Sistem Informasi', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(104, 104, 'Futsal', 'Tidak', 'Desain', 'Tidak', 'Tidak', 'DKV', 'Teknik Informatika', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(105, 105, 'futsal', 'Tidak', 'Modifikasi Motor', 'Karang Taruna', 'Tidak', 'Teknik Industri', 'Hukum', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(106, 106, 'Badminton', 'Tidak', 'Public Speaking', 'OSIS', 'Tidak', 'Hukum', 'Psikologi', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(107, 107, 'KIR', 'Tidak', 'Bisnis', 'OSIS', 'Tidak', 'Manajemen', 'Akuntansi', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(108, 108, 'KIR', 'Tidak', 'Public Speaking', 'OSIS', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Sastra Inggris', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(109, 109, 'Futsal', 'Tidak', 'Desain', 'Tidak', 'Tidak', 'Ilmu Komputer', 'DKV', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(110, 110, 'Taekwondo', 'Tidak', 'Bela Diri', 'Karang Taruna', 'Tidak', 'Pendidikan Jasmani', 'Sastra Indonesia', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(111, 111, 'Basket', 'Tidak', 'Atletik', 'Basket', 'Tidak', 'Ilmu Keolahragaan', 'Pendidikan Jasmani', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(112, 112, 'KIR', 'Tidak', 'Desain', 'OSIS', 'Kursus TOEFL', 'Sastra Inggris', 'Ilmu Komunikasi', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(113, 113, 'Modern Dance', 'Tidak', 'Bisnis', 'Tidak', 'Tidak', 'Akuntansi', 'Manajemen', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(114, 114, 'Modern Dance', 'Tidak', 'Public Speaking', 'OSIS', 'Bimbel', 'Ilmu Komunikasi', 'Sastra Inggris', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(115, 115, 'Badminton', 'Tidak', 'Atletik', 'Badminton', 'Tidak', 'Ilmu Keolahragaan', 'Pendidikan Jasmani', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(116, 116, 'Tari Tradisional', 'Tidak', 'Memasak', 'Tidak', 'Bimbel', 'Teknologi Pangan', 'Farmasi', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(117, 117, 'Mading', 'Tidak', 'Public Speaking', 'Karang Taruna', 'Tidak', 'Psikologi', 'Ilmu Komunikasi', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(118, 118, 'Modern Dance', 'Tidak', 'Bisnis', 'Tidak', 'Tidak', 'Manajemen', 'Ekonomi', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(119, 119, 'Mading', 'Tidak', 'Menggambar', 'Karang Taruna', 'Bimbel', 'Arsitektur', 'DKV', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(120, 120, 'Basket', 'Tidak', 'Bisnis', 'Basket', 'Kursus TOEFL', 'Ilmu Komunikasi', 'Manajemen', '2026-10-21 13:29:47', '2026-10-21 13:29:47');

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
(1, '2025/2026', 'GANJIL', '2025/2026 Ganjil', 'AKTIF', NULL, '2026-10-13 08:01:42'),
(2, '2026/2027', 'GANJIL', '2026/2027 Ganjil', 'SELESAI', NULL, '2026-10-13 08:01:42'),
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
(11, 1, 1, 'median', 'COMPLETED', '2026-10-28 13:34:31', NULL, NULL, NULL, '2026-10-28 13:35:21', 256, '2026-10-28 13:34:32', 459, '2026-10-28 13:45:15', 12, NULL, '2026-10-28 13:45:10', 30, NULL);

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
(526, 11, 16, 1.0000, 1.0000, 0.9767, 0.7826, 0.8480, 0.9257, 0.9068, 0.9211, 0.6957, 1.0000, 1.0000, 0.7761, 0.9281, 0.7667, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.7500, 0.2500, 0.0000, 0.1000, 0.7273, NULL, NULL),
(527, 11, 17, 0.7143, 0.7564, 0.7907, 0.6957, 0.6000, 0.7973, 0.7373, 0.7018, 0.5043, 0.5814, 0.4624, 0.5821, 0.8957, 0.5733, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.1250, 0.5000, 0.0000, 0.3000, 0.7273, NULL, NULL),
(528, 11, 18, 0.8571, 0.8846, 0.8527, 0.8696, 0.7520, 0.7703, 0.9407, 0.7018, 0.7391, 0.9380, 0.6647, 0.7537, 0.9209, 0.6067, 0.5967, 0.6748, 0.5422, 0.7465, 0.5000, 0.0000, 0.2500, 0.7500, 0.2500, 0.4000, 0.4545, NULL, NULL),
(529, 11, 19, 0.1714, 0.6731, 0.6977, 0.0870, 0.6880, 0.3446, 0.5847, 0.3509, 0.0870, 0.0000, 0.2832, 0.0746, 0.8669, 0.1533, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.1250, 0.0000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(530, 11, 20, 0.8857, 0.9295, 0.8527, 0.6522, 0.7200, 0.9527, 0.8475, 0.8684, 0.6522, 0.9922, 0.7746, 0.7463, 0.9424, 0.7400, 0.5967, 0.6748, 0.5422, 0.7465, 0.5000, 0.0000, 0.6250, 0.5000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(531, 11, 21, 0.8571, 0.7372, 0.8527, 0.8696, 0.8560, 0.5811, 0.6949, 0.8684, 0.5217, 0.8140, 0.3121, 0.3507, 0.9424, 0.8400, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 1.0000, 0.7500, 0.5000, 0.5000, 0.3636, NULL, NULL),
(532, 11, 22, 0.7429, 0.6410, 0.7442, 0.5652, 0.6000, 0.3041, 0.6610, 0.3947, 0.6087, 0.4961, 0.5665, 0.3284, 0.8597, 0.5867, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.1250, 0.0000, 0.0000, 0.8000, 0.7273, NULL, NULL),
(533, 11, 23, 0.7314, 0.7692, 0.1163, 0.6087, 0.6080, 0.4932, 0.1441, 0.7895, 0.6957, 0.7674, 0.4046, 0.7388, 0.9245, 0.6067, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.7500, 0.5000, 0.0000, 0.1000, 0.0909, NULL, NULL),
(534, 11, 24, 0.9429, 0.9167, 1.0000, 0.8696, 0.9360, 0.9189, 0.8644, 0.9561, 0.9130, 0.9225, 0.8497, 0.9776, 0.9460, 0.7333, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.1250, 0.0000, 0.0000, 0.3000, 0.3636, NULL, NULL),
(535, 11, 25, 0.6857, 0.8205, 0.7674, 0.8696, 0.8240, 0.6081, 0.7797, 0.8333, 0.7826, 0.9767, 0.4682, 0.7313, 0.9317, 0.8000, 0.5967, 0.6748, 0.5422, 0.7465, 0.5000, 0.8000, 0.3750, 0.7500, 0.2500, 0.4000, 0.3636, NULL, NULL),
(536, 11, 26, 0.8571, 0.7692, 0.8062, 0.9130, 0.8480, 0.6419, 0.9237, 1.0000, 0.7391, 0.9225, 0.6474, 0.5149, 0.9712, 0.8200, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.3750, 0.2500, 0.2500, 1.0000, 0.5455, NULL, NULL),
(537, 11, 27, 0.7714, 0.8013, 0.7674, 0.7826, 0.9280, 0.7027, 0.7966, 0.9123, 0.6522, 0.5659, 0.5491, 0.4701, 0.9640, 0.8867, 0.5967, 0.6748, 0.5422, 0.7465, 1.0000, 0.0000, 0.5000, 0.0000, 0.2500, 0.6000, 0.2727, NULL, NULL),
(538, 11, 28, 0.8971, 0.7692, 1.0000, 0.8435, 0.7440, 0.7973, 0.9068, 0.8684, 0.3913, 0.8062, 0.6936, 0.4701, 0.9065, 0.7267, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.5000, 0.5000, 0.2500, 0.6000, 0.1818, NULL, NULL),
(539, 11, 29, 0.9143, 0.8654, 0.9302, 0.8696, 0.7120, 0.8311, 0.9915, 0.9561, 0.4783, 0.8760, 0.6763, 0.5373, 0.9424, 0.6400, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.7500, 0.5000, 0.0000, 0.1000, 0.3636, NULL, NULL),
(540, 11, 30, 0.9714, 0.8141, 0.9302, 0.9130, 0.5760, 0.8311, 0.4407, 0.9561, 0.6087, 0.8605, 0.9711, 0.7313, 0.9424, 0.6667, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.5000, 0.0000, 0.0000, 0.2000, 0.5455, NULL, NULL),
(541, 11, 31, 0.2571, 0.5000, 0.5271, 0.6522, 0.6240, 0.1014, 0.4407, 0.7807, 0.3913, 0.1085, 0.6763, 0.4627, 0.7986, 0.7200, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.6250, 0.2500, 0.0000, 0.3000, 0.2727, NULL, NULL),
(542, 11, 32, 0.5714, 0.6090, 0.6512, 0.8696, 0.9360, 0.6284, 0.6610, 0.6579, 0.2174, 0.7209, 0.3642, 0.1343, 0.9388, 1.0000, 0.5967, 0.6748, 0.5422, 0.7465, 0.7500, 0.0000, 0.7500, 0.7500, 0.2500, 0.7000, 0.1818, NULL, NULL),
(543, 11, 33, 0.8857, 0.8205, 0.9612, 0.7826, 0.6800, 0.6824, 1.0000, 0.9561, 0.5652, 0.7829, 0.6647, 0.6343, 0.9209, 0.6200, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.5000, 0.2500, 0.0000, 0.2000, 0.1818, NULL, NULL),
(544, 11, 34, 1.0000, 0.8718, 0.8140, 0.7826, 0.8720, 0.7432, 0.8983, 0.8684, 0.7826, 0.7984, 0.6301, 0.5821, 0.9317, 0.9200, 0.5967, 0.6748, 0.5422, 0.7465, 0.5000, 0.0000, 0.6250, 0.7500, 0.2500, 0.3000, 0.6364, NULL, NULL),
(545, 11, 35, 1.0000, 0.7051, 0.9302, 0.6522, 0.5920, 0.7973, 0.8220, 1.0000, 0.5652, 0.8217, 0.7283, 0.6567, 0.9245, 0.6067, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.5000, 0.0000, 0.0000, 0.6000, 0.9091, NULL, NULL),
(546, 11, 36, 0.9143, 0.8141, 0.9225, 0.7826, 0.4000, 0.7635, 0.8814, 0.9123, 0.4348, 0.6279, 0.5896, 0.5149, 0.9209, 0.4667, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.6250, 0.5000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(547, 11, 37, 0.9714, 0.9359, 0.9767, 0.8261, 0.8640, 0.7095, 0.9576, 0.9123, 0.6522, 1.0000, 0.8208, 0.7537, 0.9173, 0.8000, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.1250, 0.7500, 0.0000, 0.8000, 0.3636, NULL, NULL),
(548, 11, 38, 0.9429, 0.8974, 0.9767, 0.8696, 0.5520, 0.8176, 0.8814, 0.8772, 0.6957, 0.7209, 0.6416, 0.7836, 0.9424, 0.5867, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.7500, 0.0000, 0.0000, 0.1000, 0.0909, NULL, NULL),
(549, 11, 39, 0.7429, 0.2756, 0.1163, 0.7391, 0.1360, 0.6757, 0.2288, 0.1316, 0.6957, 0.4574, 0.4335, 0.2463, 0.9101, 0.8533, 0.5967, 0.6748, 0.5422, 0.7465, 0.7500, 0.0000, 1.0000, 0.7500, 0.5000, 0.4000, 0.3636, NULL, NULL),
(550, 11, 40, 0.8000, 0.9487, 0.5116, 0.7391, 0.6400, 0.7432, 0.6525, 0.7895, 0.5217, 0.6899, 0.5607, 0.5933, 0.9730, 0.7300, 0.7366, 0.7724, 0.6506, 0.5352, 0.5000, 0.0000, 0.6250, 0.5000, 0.2500, 0.3000, 0.2727, NULL, NULL),
(551, 11, 41, 0.8457, 0.9423, 0.8140, 0.9130, 0.7440, 0.8649, 0.7712, 0.8246, 0.6522, 0.6899, 0.5607, 0.5933, 0.9353, 0.7300, 0.9659, 0.8374, 0.9398, 0.8873, 0.5000, 0.4000, 0.5000, 0.0000, 0.2500, 0.6000, 0.9091, NULL, NULL),
(552, 11, 42, 0.7714, 0.8654, 0.7054, 0.3913, 0.5280, 0.7838, 0.7119, 0.5263, 0.7826, 0.6899, 0.5607, 0.5933, 0.9442, 0.7300, 0.4049, 0.6179, 0.3614, 0.5775, 0.2500, 0.2000, 0.1250, 0.5000, 0.0000, 0.8000, 0.0909, NULL, NULL),
(553, 11, 43, 0.8743, 0.5962, 0.5426, 0.9130, 0.5920, 0.6554, 0.5763, 0.5702, 0.6522, 0.6899, 0.5607, 0.5933, 0.7770, 0.7300, 0.6049, 0.8943, 0.5301, 0.7746, 0.5000, 0.0000, 0.5000, 0.0000, 0.0000, 0.2000, 0.1818, NULL, NULL),
(554, 11, 44, 0.8000, 0.8974, 0.5504, 0.5652, 0.6400, 0.5946, 0.5424, 0.7456, 0.4783, 0.6899, 0.5607, 0.5933, 0.8741, 0.7300, 0.6699, 0.6748, 0.3012, 0.4930, 0.2500, 0.0000, 0.1250, 0.0000, 0.0000, 0.8000, 0.7273, NULL, NULL),
(555, 11, 45, 0.8571, 0.9167, 0.6589, 0.6957, 0.6880, 0.7770, 0.6949, 0.8684, 0.7391, 0.6899, 0.5607, 0.5933, 0.9209, 0.7300, 0.7350, 0.6585, 0.5422, 0.8310, 0.2500, 0.0000, 1.0000, 0.2500, 0.5000, 0.4000, 0.4545, NULL, NULL),
(556, 11, 46, 0.5429, 0.7051, 0.6124, 0.5217, 0.3280, 0.3514, 0.5339, 0.5702, 0.4783, 0.6899, 0.5607, 0.5933, 0.7284, 0.7300, 0.4530, 0.1707, 0.3012, 0.5070, 0.2500, 0.0000, 0.7500, 0.7500, 0.0000, 0.1000, 0.0909, NULL, NULL),
(557, 11, 47, 0.6286, 0.7692, 0.5426, 0.6087, 0.3600, 0.5203, 0.6017, 0.5702, 0.4348, 0.6899, 0.5607, 0.5933, 0.8004, 0.7300, 0.3008, 0.4553, 0.2892, 0.6479, 0.7500, 0.0000, 0.7500, 0.0000, 0.0000, 0.4000, 0.3636, NULL, NULL),
(558, 11, 48, 0.9143, 0.9615, 0.8140, 0.7826, 0.5920, 0.7838, 0.7458, 0.6579, 0.8696, 0.6899, 0.5607, 0.5933, 0.9640, 0.7300, 0.5951, 0.8943, 0.4217, 0.7887, 0.2500, 0.0000, 0.1250, 0.5000, 0.7500, 0.4000, 0.3636, NULL, NULL),
(559, 11, 49, 0.8571, 0.9295, 0.8140, 0.9565, 0.8160, 0.8108, 0.8814, 0.8246, 0.6957, 0.6899, 0.5607, 0.5933, 0.9353, 0.7300, 0.8992, 0.6585, 0.7229, 0.7465, 0.2500, 0.2000, 0.1250, 0.7500, 0.0000, 0.4000, 0.7273, NULL, NULL),
(560, 11, 50, 0.8000, 0.8974, 0.6512, 0.1304, 0.8960, 0.5541, 0.5169, 0.8684, 0.5652, 0.6899, 0.5607, 0.5933, 0.7914, 0.7300, 0.0277, 0.6911, 0.5422, 0.5634, 0.2500, 0.0000, 0.1250, 0.2500, 0.0000, 0.8000, 0.4545, NULL, NULL),
(561, 11, 51, 0.8571, 0.9808, 0.8140, 0.7826, 0.5600, 0.8176, 0.8729, 0.7456, 0.8696, 0.6899, 0.5607, 0.5933, 0.8813, 0.7300, 0.8032, 0.8293, 0.2289, 0.7887, 0.2500, 0.0000, 0.1250, 0.0000, 0.0000, 0.8000, 0.0909, NULL, NULL),
(562, 11, 52, 0.4857, 0.5321, 0.1860, 0.1739, 0.0320, 0.4392, 0.0000, 0.4825, 0.0261, 0.6899, 0.5607, 0.5933, 0.6511, 0.7300, 0.0000, 0.2439, 0.0482, 0.0000, 0.5000, 0.0000, 0.2500, 0.7500, 0.0000, 0.3000, 0.0909, NULL, NULL),
(563, 11, 53, 0.5714, 0.5128, 0.6124, 0.3913, 0.2320, 0.4865, 0.8220, 0.5702, 0.5913, 0.6899, 0.5607, 0.5933, 0.8291, 0.7300, 0.3268, 0.5285, 0.1687, 0.2113, 0.2500, 0.0000, 0.5000, 0.2500, 0.0000, 0.6000, 0.1818, NULL, NULL),
(564, 11, 54, 0.7714, 0.7564, 0.6977, 0.6957, 0.4320, 0.6014, 0.8220, 0.8684, 0.5913, 0.6899, 0.5607, 0.5933, 1.0000, 0.7300, 0.5967, 0.4959, 0.6867, 0.6479, 0.5000, 0.0000, 0.6250, 0.5000, 0.2500, 0.4000, 0.2727, NULL, NULL),
(565, 11, 55, 0.8857, 0.8974, 0.6977, 0.7826, 0.4320, 0.7635, 0.4576, 0.9123, 0.6087, 0.6899, 0.5607, 0.5933, 0.9748, 0.7300, 0.8016, 0.8211, 0.7349, 1.0000, 0.2500, 0.2000, 0.1250, 0.5000, 0.0000, 0.4000, 0.2727, NULL, NULL),
(566, 11, 56, 0.8571, 0.9295, 0.8915, 0.8261, 0.6640, 0.7432, 0.6610, 0.7456, 0.6957, 0.6899, 0.5607, 0.5933, 0.9263, 0.7300, 0.5967, 0.7805, 0.6506, 0.8451, 1.0000, 0.0000, 0.3750, 0.0000, 0.2500, 0.3000, 0.5455, NULL, NULL),
(567, 11, 57, 0.5429, 0.5128, 0.2713, 0.4783, 0.6480, 0.1824, 0.0932, 0.4825, 0.2174, 0.6899, 0.5607, 0.5933, 0.7842, 0.7300, 0.5349, 0.2683, 0.1687, 0.3662, 0.5000, 0.0000, 1.0000, 0.7500, 0.5000, 0.4000, 0.3636, NULL, NULL),
(568, 11, 58, 0.9143, 0.9615, 0.8372, 0.8696, 0.6960, 0.9595, 0.7373, 0.7895, 0.6522, 0.6899, 0.5607, 0.5933, 0.9424, 0.7300, 0.8634, 0.9431, 0.8313, 1.0000, 0.5000, 0.0000, 0.6250, 0.0000, 0.2500, 0.3000, 0.2727, NULL, NULL),
(569, 11, 59, 0.7143, 0.9295, 0.8837, 0.7391, 0.6400, 0.7027, 0.7881, 0.6579, 0.9130, 0.6899, 0.5607, 0.5933, 0.9712, 0.7300, 0.8016, 0.7805, 0.7229, 0.4366, 1.0000, 0.0000, 0.3750, 0.5000, 0.0000, 0.6000, 0.5455, NULL, NULL),
(570, 11, 60, 0.8286, 0.9423, 0.8527, 0.9130, 0.7520, 0.7635, 0.6610, 0.7807, 0.6522, 0.6899, 0.5607, 0.5933, 0.9748, 0.7300, 0.7880, 0.8374, 0.7349, 0.8310, 0.7500, 0.0000, 0.7500, 1.0000, 0.0000, 0.7000, 0.6364, NULL, NULL),
(571, 11, 61, 0.7714, 0.9487, 0.6202, 0.7826, 0.6080, 0.8851, 0.7458, 0.7456, 0.7217, 0.6899, 0.5607, 0.5933, 0.9640, 0.7300, 0.7317, 0.7398, 0.2289, 0.8028, 0.5000, 0.0000, 0.2500, 0.5000, 0.0000, 0.3000, 0.3636, NULL, NULL),
(572, 11, 62, 0.9600, 1.0000, 0.9302, 0.9130, 0.8800, 0.9662, 0.8729, 0.8684, 0.7826, 0.6899, 0.5607, 0.5933, 0.9694, 0.7300, 1.0000, 1.0000, 1.0000, 1.0000, 0.7500, 0.0000, 0.7500, 1.0000, 0.2500, 0.7000, 0.8182, NULL, NULL),
(573, 11, 63, 0.8286, 0.9936, 0.7984, 0.6957, 0.9120, 0.7095, 0.6525, 0.7018, 0.6957, 0.6899, 0.5607, 0.5933, 0.9011, 0.7300, 0.7180, 0.8374, 0.6145, 0.7887, 0.5000, 0.0000, 0.6250, 0.7500, 0.2500, 0.3000, 0.2727, NULL, NULL),
(574, 11, 64, 0.7714, 0.9295, 0.7984, 0.6957, 0.6960, 0.7297, 0.6102, 0.6140, 0.6522, 0.6899, 0.5607, 0.5933, 0.8327, 0.7300, 0.7382, 0.7886, 0.4217, 0.6761, 0.2500, 0.0000, 1.0000, 0.2500, 0.5000, 0.5000, 0.3636, NULL, NULL),
(575, 11, 65, 0.6857, 0.9295, 0.7984, 0.7391, 0.4480, 0.7297, 0.6610, 0.6140, 0.6522, 0.6899, 0.5607, 0.5933, 0.9622, 0.7300, 0.4173, 0.7967, 0.1807, 0.8592, 0.2500, 0.0000, 0.7500, 0.0000, 0.0000, 0.1000, 0.0909, NULL, NULL),
(576, 11, 66, 0.9429, 0.9679, 1.0000, 0.8261, 0.4880, 0.9595, 0.7797, 0.7895, 0.8261, 0.6899, 0.5607, 0.5933, 0.9101, 0.7300, 0.9333, 0.8699, 1.0000, 0.8592, 0.5000, 0.0000, 0.6250, 0.5000, 0.2500, 0.3000, 0.3636, NULL, NULL),
(577, 11, 67, 0.6286, 0.9167, 0.7752, 0.7826, 0.5600, 0.7297, 0.6102, 0.7456, 0.6348, 0.3101, 0.4046, 0.3284, 0.9191, 0.6200, 0.5967, 0.6748, 0.5422, 0.6479, 0.7500, 1.0000, 0.7500, 0.7500, 0.0000, 0.9000, 0.9091, NULL, NULL),
(578, 11, 68, 0.7600, 0.8846, 0.8372, 0.8696, 0.7200, 0.5811, 0.6356, 0.7807, 0.7391, 0.6667, 0.4913, 0.6343, 0.9191, 0.7400, 0.5967, 0.6748, 0.5422, 0.6479, 0.5000, 0.0000, 0.8750, 0.0000, 0.2500, 0.9000, 0.3636, NULL, NULL),
(579, 11, 69, 0.7714, 0.8654, 0.8760, 0.8696, 0.6640, 0.7162, 0.6356, 0.7807, 0.4609, 0.5736, 0.5318, 0.3806, 0.9191, 0.7867, 0.5967, 0.6748, 0.5422, 0.7887, 0.5000, 0.0000, 0.3750, 0.5000, 0.0000, 0.6000, 1.0000, NULL, NULL),
(580, 11, 70, 0.8857, 0.8013, 0.8217, 0.7826, 0.6800, 0.9932, 0.7797, 0.8684, 0.8261, 0.9147, 0.6185, 0.7537, 0.9191, 0.8667, 0.5967, 0.6748, 0.5422, 0.6479, 1.0000, 0.0000, 0.5000, 0.0000, 0.2500, 0.6000, 0.1818, NULL, NULL),
(581, 11, 71, 0.3429, 0.7885, 0.8527, 0.8435, 0.5600, 0.6689, 0.8644, 0.7456, 0.8261, 0.8217, 0.5434, 0.4627, 0.9191, 0.6467, 0.5967, 0.6748, 0.5422, 0.8732, 0.5000, 0.0000, 0.7500, 0.7500, 0.2500, 0.1000, 0.0909, NULL, NULL),
(582, 11, 72, 0.8857, 0.9295, 0.6977, 1.0000, 0.7040, 1.0000, 0.7458, 0.8684, 0.8696, 0.8295, 0.5549, 1.0000, 0.9191, 0.8333, 0.5967, 0.6748, 0.5422, 0.7183, 1.0000, 0.0000, 0.3750, 0.0000, 0.2500, 0.6000, 0.9091, NULL, NULL),
(583, 11, 73, 0.7143, 0.2885, 0.7287, 0.7391, 0.7680, 0.5743, 0.3983, 0.7018, 0.8261, 0.4031, 0.4740, 0.1791, 0.9191, 0.7867, 0.5967, 0.6748, 0.5422, 0.7324, 0.2500, 0.0000, 0.6250, 0.2500, 0.0000, 0.3000, 0.3636, NULL, NULL),
(584, 11, 74, 0.7429, 0.5000, 0.6977, 0.7391, 0.8000, 0.6014, 0.4831, 0.7018, 0.7826, 0.3721, 0.3526, 0.3657, 0.9191, 0.8400, 0.5967, 0.6748, 0.5422, 0.8451, 0.2500, 0.0000, 0.1250, 0.5000, 0.0000, 0.8000, 0.3636, NULL, NULL),
(585, 11, 75, 0.7429, 0.9295, 0.8062, 0.7391, 0.6080, 0.6486, 0.9153, 0.7456, 0.7391, 0.3178, 0.4220, 0.4776, 0.9191, 0.5400, 0.5967, 0.6748, 0.5422, 0.6479, 0.2500, 0.0000, 0.7500, 0.5000, 0.0000, 0.1000, 0.2727, NULL, NULL),
(586, 11, 76, 0.6571, 0.0000, 0.5349, 0.0870, 0.5680, 0.3851, 0.5339, 0.0000, 0.6087, 0.4574, 0.1098, 0.0821, 0.9191, 0.1667, 0.5967, 0.6748, 0.5422, 0.4366, 0.2500, 0.0000, 0.5000, 0.0000, 0.0000, 0.6000, 0.1818, NULL, NULL),
(587, 11, 77, 0.7429, 0.6410, 0.6589, 0.8261, 0.9120, 0.7770, 0.5678, 0.8246, 0.6087, 0.8217, 0.4798, 0.8134, 0.9191, 0.9200, 0.5967, 0.6748, 0.5422, 0.9014, 1.0000, 0.0000, 0.3750, 0.0000, 0.0000, 1.0000, 0.5455, NULL, NULL),
(588, 11, 78, 0.8857, 0.7821, 0.8915, 0.8696, 0.8480, 0.7838, 0.8305, 0.9123, 0.9130, 0.8760, 0.7514, 0.7687, 0.9191, 0.8333, 0.5967, 0.6748, 0.5422, 1.0000, 0.2500, 0.0000, 0.6250, 0.0000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(589, 11, 79, 0.6857, 0.7179, 0.5039, 0.6522, 0.3680, 0.6689, 0.3390, 0.7368, 0.7391, 0.5504, 0.2601, 0.4776, 0.9191, 0.4400, 0.5967, 0.6748, 0.5422, 0.3803, 0.2500, 0.6000, 0.5000, 0.0000, 0.0000, 0.2000, 0.2727, NULL, NULL),
(590, 11, 80, 0.8571, 0.9615, 0.7364, 0.7826, 0.6800, 0.7365, 0.7034, 0.7895, 0.9130, 0.8682, 0.7746, 0.5896, 0.9191, 0.5400, 0.5967, 0.6748, 0.5422, 0.8592, 0.2500, 0.6000, 0.5000, 0.7500, 0.0000, 0.2000, 0.1818, NULL, NULL),
(591, 11, 81, 0.6857, 0.8013, 0.8062, 0.4783, 0.6080, 0.7365, 0.7881, 0.7456, 0.6348, 0.3643, 0.3988, 0.5970, 0.9191, 0.4533, 0.5967, 0.6748, 0.5422, 0.4648, 0.2500, 0.0000, 1.0000, 0.5000, 0.0000, 0.4000, 0.3636, NULL, NULL),
(592, 11, 82, 0.9429, 0.8526, 0.7752, 0.8696, 0.7600, 0.9122, 0.9576, 0.8246, 0.9565, 0.9767, 0.8208, 0.8881, 0.9191, 0.6000, 0.5967, 0.6748, 0.5422, 0.7887, 0.2500, 0.6000, 0.5000, 0.2500, 0.0000, 0.2000, 0.0909, NULL, NULL),
(593, 11, 83, 0.0000, 0.6603, 0.5039, 0.0000, 0.4400, 0.3243, 0.6780, 0.4825, 0.7217, 0.3643, 0.0000, 0.1716, 0.9191, 0.0000, 0.5967, 0.6748, 0.5422, 0.3521, 0.2500, 0.0000, 0.5000, 0.5000, 0.0000, 0.6000, 0.2727, NULL, NULL),
(594, 11, 84, 0.9314, 0.7692, 0.7752, 0.4348, 0.9280, 0.6824, 0.6186, 0.7018, 0.6522, 0.8217, 0.4740, 0.5448, 0.9191, 0.7867, 0.5967, 0.6748, 0.5422, 0.5493, 0.7500, 0.0000, 1.0000, 0.0000, 0.5000, 0.4000, 0.4545, NULL, NULL),
(595, 11, 85, 0.8457, 0.7564, 0.7752, 0.6957, 0.8400, 0.7297, 0.7881, 0.7018, 0.8696, 0.6512, 0.4566, 0.6343, 0.9191, 0.6733, 0.5967, 0.6748, 0.5422, 0.6479, 0.5000, 0.4000, 0.2500, 0.7500, 0.0000, 0.4000, 0.4545, NULL, NULL),
(596, 11, 86, 0.2857, 0.1603, 0.6202, 0.6522, 0.8080, 0.0000, 0.3051, 0.0877, 0.2609, 0.1628, 0.7457, 0.0000, 0.9191, 0.8200, 0.5967, 0.6748, 0.5422, 0.3662, 1.0000, 0.0000, 0.3750, 0.0000, 1.0000, 0.6000, 0.5455, NULL, NULL),
(597, 11, 87, 0.8571, 0.8974, 0.9690, 0.7391, 1.0000, 0.7095, 0.6525, 0.7456, 0.9130, 0.7752, 0.5376, 0.6866, 0.9191, 0.9733, 0.5967, 0.6748, 0.5422, 0.8873, 0.5000, 0.0000, 0.6250, 0.5000, 0.2500, 0.3000, 0.2727, NULL, NULL),
(598, 11, 88, 0.8571, 0.8462, 0.6977, 0.5217, 0.9440, 0.7770, 0.7034, 0.7456, 0.8261, 0.7984, 0.7399, 0.8209, 0.9191, 0.8067, 0.5967, 0.6748, 0.5422, 0.7606, 0.5000, 0.0000, 0.8750, 0.0000, 0.2500, 0.7000, 0.8182, NULL, NULL),
(599, 11, 89, 0.1429, 0.6603, 0.8760, 0.7391, 0.9280, 0.4189, 0.6780, 0.7895, 1.0000, 0.7519, 0.4798, 0.7388, 0.9191, 0.9067, 0.5967, 0.6748, 0.5422, 0.7042, 0.7500, 0.0000, 0.7500, 0.0000, 0.2500, 1.0000, 0.6364, NULL, NULL),
(600, 11, 90, 0.7429, 0.7051, 0.7829, 0.6957, 0.5680, 0.7297, 0.9661, 0.7895, 0.5652, 0.6279, 0.5954, 0.7015, 0.9191, 0.6400, 0.5967, 0.6748, 0.5422, 0.9014, 0.2500, 0.6000, 0.5000, 0.5000, 0.0000, 0.3000, 0.1818, NULL, NULL),
(601, 11, 91, 0.7600, 0.8974, 0.6667, 0.7391, 0.6400, 0.8784, 0.6949, 0.7456, 0.6087, 0.6667, 0.7168, 0.7015, 0.9191, 0.6067, 0.5967, 0.6748, 0.5422, 0.8028, 0.2500, 0.6000, 0.5000, 0.0000, 0.0000, 0.2000, 0.1818, NULL, NULL),
(602, 11, 92, 0.8857, 0.9038, 0.7054, 0.7391, 0.8320, 0.5608, 0.3729, 0.4386, 0.7391, 0.7984, 0.9364, 0.7313, 0.0000, 0.8867, 0.5967, 0.6748, 0.5422, 0.8732, 0.5000, 0.0000, 0.6250, 0.5000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(603, 11, 93, 0.8857, 0.8013, 0.7364, 0.7391, 0.4320, 0.7973, 0.7966, 0.8246, 0.6087, 0.6202, 0.5607, 0.5933, 0.9209, 0.7300, 0.6221, 0.4553, 0.5783, 0.7465, 0.5000, 0.0000, 0.2500, 0.5000, 0.7500, 0.4000, 0.4545, NULL, NULL),
(604, 11, 94, 0.5143, 0.7564, 0.6977, 0.6957, 0.5200, 0.2838, 0.6102, 0.8246, 0.5913, 0.5814, 0.5607, 0.5933, 0.9173, 0.7300, 0.5659, 0.1545, 0.3494, 0.7465, 0.2500, 0.0000, 0.5000, 0.5000, 0.0000, 0.6000, 0.1818, NULL, NULL),
(605, 11, 95, 0.8571, 0.8333, 0.8062, 0.8696, 0.6800, 0.6081, 0.6525, 0.8333, 0.8261, 0.8140, 0.5607, 0.5933, 0.9047, 0.7300, 0.6888, 0.7561, 0.8916, 0.7465, 0.5000, 0.0000, 0.3750, 0.0000, 0.0000, 0.8000, 0.5455, NULL, NULL),
(606, 11, 96, 0.8857, 0.9744, 0.6977, 0.9565, 0.8000, 0.8581, 0.6525, 0.5263, 0.7391, 0.8605, 0.5607, 0.5933, 0.8633, 0.7300, 0.6683, 0.8537, 0.8675, 0.7465, 0.5000, 0.0000, 0.8750, 0.7500, 0.2500, 0.9000, 0.6364, NULL, NULL),
(607, 11, 97, 0.7429, 0.7372, 0.7364, 0.6957, 0.6880, 0.6014, 0.5932, 0.8246, 0.7391, 0.6899, 0.5607, 0.5933, 0.8489, 0.7300, 0.5880, 0.8780, 0.5060, 0.7465, 0.7500, 0.0000, 0.6250, 0.7500, 0.0000, 0.3000, 0.2727, NULL, NULL),
(608, 11, 98, 0.5714, 0.7821, 0.6589, 0.8261, 0.8320, 0.6486, 0.3983, 0.4825, 0.5652, 0.6822, 0.5607, 0.5933, 0.8633, 0.7300, 0.3073, 0.5285, 0.2048, 0.7465, 1.0000, 0.0000, 0.3750, 0.0000, 0.0000, 0.6000, 0.9091, NULL, NULL),
(609, 11, 99, 0.7143, 0.4487, 0.6202, 0.7826, 0.8880, 0.1284, 0.4746, 0.5263, 0.5652, 0.6899, 0.5607, 0.5933, 0.8129, 0.7300, 0.5366, 0.3984, 0.3253, 0.7465, 0.7500, 0.0000, 0.5000, 1.0000, 0.0000, 0.6000, 0.6364, NULL, NULL),
(610, 11, 100, 0.4286, 0.4936, 0.3798, 0.6957, 0.2720, 0.1216, 0.6780, 0.5702, 0.4348, 0.4419, 0.5607, 0.5933, 0.7644, 0.7300, 0.1008, 0.0406, 0.0000, 0.7465, 0.2500, 0.0000, 0.7500, 0.0000, 0.0000, 0.1000, 0.0909, NULL, NULL),
(611, 11, 101, 0.5714, 0.6410, 0.3798, 0.0435, 0.3920, 0.5068, 0.5254, 0.5702, 0.4609, 0.0853, 0.5607, 0.5933, 0.9406, 0.7300, 0.2000, 0.4146, 0.3614, 0.7465, 0.5000, 0.0000, 0.7500, 0.0000, 0.2500, 0.7000, 0.0909, NULL, NULL),
(612, 11, 102, 0.4286, 0.5769, 0.6124, 0.8261, 0.3920, 0.3108, 0.8644, 0.6140, 0.3739, 0.5116, 0.5607, 0.5933, 0.9047, 0.7300, 0.5024, 0.3740, 0.2289, 0.7465, 0.2500, 0.0000, 0.6250, 0.0000, 0.0000, 0.2000, 0.7273, NULL, NULL),
(613, 11, 103, 0.8000, 0.6859, 0.6589, 0.8261, 0.6240, 0.6486, 0.7797, 0.7456, 0.5217, 0.7209, 0.5607, 0.5933, 0.9137, 0.7300, 0.5587, 0.4146, 0.6867, 0.7465, 0.2500, 0.0000, 0.5000, 0.2500, 0.0000, 0.2000, 0.1818, NULL, NULL),
(614, 11, 104, 0.6857, 0.6282, 0.7364, 0.9130, 0.5680, 0.7432, 0.7966, 0.8684, 0.6348, 0.5194, 0.5607, 0.5933, 0.8813, 0.7300, 0.7229, 0.7154, 0.5422, 0.7465, 0.2500, 0.0000, 0.5000, 0.0000, 0.0000, 0.6000, 0.1818, NULL, NULL),
(615, 11, 105, 0.7143, 0.5769, 0.7752, 0.8261, 0.7600, 0.8919, 0.6525, 0.8684, 0.3739, 0.5814, 0.5607, 0.5933, 0.8363, 0.7300, 0.8016, 0.7073, 0.7229, 0.7465, 0.2500, 0.0000, 0.7500, 0.5000, 0.0000, 0.1000, 0.3636, NULL, NULL),
(616, 11, 106, 0.7143, 0.8013, 0.6899, 0.8261, 0.5680, 0.6486, 0.6610, 0.6140, 0.7391, 0.4419, 0.5607, 0.5933, 0.9353, 0.7300, 0.7008, 0.5285, 0.5904, 0.7465, 0.2500, 0.0000, 1.0000, 0.7500, 0.0000, 0.4000, 0.3636, NULL, NULL),
(617, 11, 107, 0.5143, 0.4359, 0.1550, 0.6087, 0.0800, 0.5203, 0.6441, 0.6579, 0.1739, 0.3798, 0.5607, 0.5933, 0.8813, 0.7300, 0.3366, 0.4634, 0.4096, 0.7465, 0.7500, 0.0000, 0.6250, 0.7500, 0.0000, 0.3000, 0.2727, NULL, NULL),
(618, 11, 108, 0.6857, 0.6603, 0.9225, 0.9130, 0.4800, 0.7230, 0.6441, 0.7018, 0.6783, 0.6977, 0.5607, 0.5933, 0.9496, 0.7300, 0.5675, 0.6911, 0.2892, 0.7465, 0.7500, 0.0000, 1.0000, 0.7500, 0.5000, 0.4000, 0.4545, NULL, NULL),
(619, 11, 109, 0.6286, 0.5962, 0.4574, 0.6522, 0.0000, 0.5946, 0.6949, 0.6140, 0.5478, 0.4651, 0.5607, 0.5933, 0.8201, 0.7300, 0.5415, 0.4472, 0.4337, 0.7465, 0.2500, 0.0000, 0.5000, 0.0000, 0.0000, 0.2000, 0.5455, NULL, NULL),
(620, 11, 110, 0.5143, 0.6731, 0.4806, 0.5652, 0.0480, 0.4189, 0.7458, 0.7368, 0.5217, 0.4109, 0.5607, 0.5933, 0.8543, 0.7300, 0.2700, 0.5041, 0.2530, 0.7465, 0.2500, 0.0000, 0.1250, 0.5000, 0.0000, 0.8000, 0.4545, NULL, NULL),
(621, 11, 111, 0.7143, 0.8013, 0.8915, 0.8261, 0.1120, 0.7297, 0.6102, 0.7018, 0.6087, 0.8527, 0.5607, 0.5933, 0.8993, 0.7300, 0.5691, 0.6504, 0.5422, 0.7465, 0.2500, 0.0000, 0.1250, 0.2500, 0.0000, 0.8000, 0.7273, NULL, NULL),
(622, 11, 112, 0.7429, 0.7692, 0.5426, 0.9565, 0.7280, 0.5068, 0.6949, 0.6140, 0.6087, 0.8527, 0.5607, 0.5933, 0.8687, 0.7300, 0.7571, 0.8618, 0.8434, 0.7465, 0.7500, 0.0000, 0.5000, 0.7500, 0.5000, 0.5000, 0.3636, NULL, NULL),
(623, 11, 113, 0.7714, 0.6090, 0.4264, 0.4783, 0.7280, 0.4257, 0.3559, 0.6930, 0.5217, 0.5504, 0.5607, 0.5933, 0.8759, 0.7300, 0.5880, 0.3333, 0.4217, 0.7465, 0.5000, 0.0000, 0.6250, 0.0000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(624, 11, 114, 0.7429, 0.8205, 0.4884, 0.6957, 0.7840, 0.5608, 0.5339, 0.5702, 0.5217, 0.4651, 0.5607, 0.5933, 0.9442, 0.7300, 0.3587, 0.2683, 0.7229, 0.7465, 0.5000, 0.0000, 1.0000, 0.7500, 0.2500, 0.4000, 0.4545, NULL, NULL),
(625, 11, 115, 0.8000, 0.8397, 0.7752, 0.6957, 0.4320, 0.5743, 0.7458, 0.6140, 0.3913, 0.7054, 0.5607, 0.5933, 0.8957, 0.7300, 0.7041, 0.6341, 0.7711, 0.7465, 0.2500, 0.0000, 0.1250, 0.2500, 0.0000, 0.8000, 0.7273, NULL, NULL),
(626, 11, 116, 0.8286, 0.8974, 0.6977, 0.8696, 0.7840, 0.7838, 0.6017, 0.7368, 0.8696, 0.7519, 0.5607, 0.5933, 0.9640, 0.7300, 0.7522, 0.8943, 0.8675, 0.7465, 0.5000, 0.0000, 0.8750, 0.0000, 0.2500, 0.9000, 0.6364, NULL, NULL),
(627, 11, 117, 0.7714, 0.8654, 0.8140, 0.8696, 0.8240, 0.8243, 0.6525, 0.7018, 0.7826, 0.6667, 0.5607, 0.5933, 0.9658, 0.7300, 0.7658, 0.7805, 0.8072, 0.7465, 1.0000, 0.0000, 1.0000, 0.5000, 0.0000, 0.4000, 0.3636, NULL, NULL),
(628, 11, 118, 0.4514, 0.3077, 0.0000, 0.0435, 0.8080, 0.1892, 0.1525, 0.0877, 0.0000, 0.2713, 0.5607, 0.5933, 0.5755, 0.7300, 0.1008, 0.0000, 0.4458, 0.7465, 0.5000, 0.0000, 0.6250, 0.0000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(629, 11, 119, 0.8571, 0.6731, 0.6202, 0.6957, 0.7280, 0.6419, 0.4068, 0.6140, 0.5652, 0.6744, 0.5607, 0.5933, 0.9119, 0.7300, 0.5880, 0.5285, 0.9157, 0.7465, 1.0000, 0.0000, 0.3750, 0.5000, 0.2500, 1.0000, 0.5455, NULL, NULL),
(630, 11, 120, 0.8857, 0.9103, 0.8140, 0.7391, 0.7680, 0.7162, 0.6610, 0.6579, 0.7826, 0.7442, 0.5607, 0.5933, 0.9658, 0.7300, 0.8325, 0.8537, 0.9157, 0.7465, 0.2500, 0.0000, 0.6250, 0.2500, 0.5000, 0.4000, 0.2727, NULL, NULL);

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
(17, '4277', 'Agit Prasetya', 'L', '2026-10-21 13:29:43', '2026-10-21 13:29:43'),
(18, '4278', 'Akmal Fatur Rohman', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(19, '4336', 'Bilal Fanansyah', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(20, '4250', 'Damar Aryo Seto', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(21, '4283', 'Fairuz Azizah', 'P', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(22, '4255', 'Fanda Enggelina Ragesti Sihobing', 'P', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(23, '4311', 'Firman Maulana Subagia', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(24, '4287', 'Hifran Narezh Fath Islamsyah', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(25, '4258', 'Iqbal Ramadhan', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(26, '4314', 'Kareena Ayudya Maheswari', 'P', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(27, '4316', 'Melva Nazwa Al Mahri', 'P', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(28, '4290', 'Meylianda Zabina Putri', 'P', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(29, '4345', 'Mohammad Iqbal Khalid Herwindo', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(30, '4291', 'Muhamad Rezka Nurdiansyah', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(31, '4292', 'Muhammad Nurul Akram Baadilla', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(32, '4293', 'Nahdil Umam', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(33, '4321', 'Nandyra Ramdhanfahrani P', 'P', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(34, '4295', 'Panca Nuari Saputra', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(35, '4270', 'Rafika Nurulaini', 'P', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(36, '4351', 'Rauza Alfarizzi', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(37, '4297', 'Rayzan Satya Nugroho', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(38, '4326', 'Rifqi Apriliano Putrawan', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(39, '4358', 'Viko Arfiansyah', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(40, '4332', 'Zefanya Ezra Saragih', 'P', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(41, '4280', 'Amanda Azmi', 'P', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(42, '4305', 'Aqilah Ross Hatammi', 'P', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(43, '4309', 'Danendra Rasya Kairu Pratama', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(44, '4254', 'Fadhil Amru Rajendro', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(45, '4284', 'Fajar Febriyansah', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(46, '4340', 'Farah Aulia', 'P', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(47, '4341', 'Galih Cahya Saputra', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(48, '4312', 'Hafiz Devano Pramadwika', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(49, '4313', 'Kaisar Ramadhan', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(50, '4342', 'Kayla Navi Eka Handaya', 'P', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(51, '4289', 'Khalisah Putriabiyyah', 'P', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(52, '4317', 'Muhamad Adrian Maulana', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(53, '4346', 'Muhamad Faris Al Zahir', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(54, '4319', 'Muhammad Daffa Izaz Binya Nuddin', 'L', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(55, '4320', 'Muhammad Fariel Febrianto Rabbani', 'L', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(56, '4261', 'Muhammad Farrel Fahrezi', 'L', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(57, '4360', 'Nadjwa Laura Adinda', 'P', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(58, '4323', 'Ok Vita Ramadhini', 'P', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(59, '4269', 'Qaisha Fitria Sabilla', 'P', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(60, '4350', 'Queen Tania Kartika', 'P', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(61, '4296', 'Rahima Rachelya Rifeko', 'P', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(62, '4325', 'Raid Fakhri Ramadhan', 'L', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(63, '4327', 'Sarah Dewi Wulandari', 'P', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(64, '4354', 'Syaqila Nur Ibtitsah', 'P', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(65, '4356', 'Tessa Amalia Zahra', 'P', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(66, '4330', 'Thoriq Abizar Ghassani', 'L', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(67, '4331', 'Yulistia Dwi Grahita', 'P', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(68, '4303', 'Abyadh Fathir Tajkah', 'L', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(69, '4249', 'Anisa Rachmani Setiaman', 'P', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(70, '4307', 'Avrilla Chelsea Rahman', 'P', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(71, '4337', 'Chesy Febrika Amaliyah', 'P', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(72, '4251', 'Daniel Maruli Tamba', 'L', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(73, '4339', 'Dea Natalia', 'P', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(74, '4359', 'Dinda Ayu Septiana', 'P', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(75, '4281', 'Eka Liviana', 'P', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(76, '4253', 'Eric Prasetya Nadi', 'L', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(77, '4259', 'Jafar Rama Rajendra', 'L', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(78, '4343', 'Maulida Apriliani', 'P', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(79, '4347', 'Muhammad Alif Faqih Zaeni', 'L', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(80, '4348', 'Muhammad Biky Niadi', 'L', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(81, '4263', 'Muhammad Nesta', 'L', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(82, '4265', 'Najwan Nur Ramadhan', 'L', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(83, '4266', 'Naufal Ahnaf Zahid Efendi', 'L', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(84, '4268', 'Philbert Chasdiel Matthew Havelar Parengkuan', 'L', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(85, '4324', 'Putri Adelia', 'P', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(86, '4458', 'Putri Rizkika Ramadhani Mulia', 'P', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(87, '4271', 'Sherina Ramadani Pulungan', 'P', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(88, '4272', 'Sri Ulina', 'P', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(89, '4355', 'Syarafina Agustin', 'P', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(90, '4274', 'Theresia Vidolia Tamalonggehe Runtulalo', 'P', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(91, '4275', 'Wildan Ihsan Wahyudi', 'L', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(92, '4276', 'Yusuf Fatih Maulana', 'L', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(93, '4302', 'Zunita Cheri Anjani', 'P', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(94, '4333', 'Ahmad Shan Nejaf', 'L', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(95, '4334', 'Alief Hizbullah', 'L', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(96, '4335', 'Alin Rhama Putri', 'P', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(97, '4279', 'Amalia Alfie Hasiana', 'P', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(98, '4362', 'Amanda Callista Aurelia', 'P', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(99, '4306', 'Aulia Neysyabilla', 'P', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(100, '4338', 'Cinta Cahaya Putri Wahyudi', 'P', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(101, '4308', 'Danendra Ramadito Athallah', 'L', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(102, '4282', 'Ezra Ramadhani Adduhayah', 'L', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(103, '4310', 'Farhad Jalal', 'L', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(104, '4286', 'Fathin Hamamah', 'P', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(105, '4256', 'Ibrahim Satrio Musyafa', 'L', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(106, '4315', 'Lyric Adwa Licky Pranata', 'L', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(107, '4344', 'Mohammad Darren Dzulhannan', 'L', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(108, '4260', 'Muhammad Aqmal Agustian', 'L', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(109, '4318', 'Muhammad Azriel', 'L', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(110, '4262', 'Muhammad Firdaus', 'L', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(111, '4461', 'Muhammad Rafii Al Asytar', 'L', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(112, '4349', 'Muhammad Yazid Rifa\'I', 'L', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(113, '4264', 'Nadya Kamila Azzahra', 'P', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(114, '4322', 'Naysilla Nazwa Aulia', 'P', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(115, '4352', 'Salwa Nurafia Azzahra', 'P', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(116, '4298', 'Sandy Setiawan', 'L', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(117, '4328', 'Shalsha Prameswari', 'P', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(118, '4329', 'Siti Desta Nurwahyuni', 'P', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(119, '4300', 'Syifa Aryanih', 'P', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(120, '4273', 'Syifa Azahra', 'P', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(121, '4301', 'Zahra Putri Noperian', 'P', '2026-10-21 13:29:47', '2026-10-21 13:29:47');

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
(16, 17, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:43', '2026-10-21 13:29:43'),
(17, 18, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(18, 19, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(19, 20, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(20, 21, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(21, 22, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(22, 23, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(23, 24, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(24, 25, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(25, 26, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(26, 27, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(27, 28, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(28, 29, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(29, 30, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(30, 31, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(31, 32, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(32, 33, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(33, 34, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(34, 35, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(35, 36, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(36, 37, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(37, 38, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(38, 39, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(39, 40, 1, 'XII-1', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(40, 41, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(41, 42, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(42, 43, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(43, 44, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(44, 45, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(45, 46, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(46, 47, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(47, 48, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(48, 49, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(49, 50, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(50, 51, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(51, 52, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(52, 53, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(53, 54, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:44', '2026-10-21 13:29:44'),
(54, 55, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(55, 56, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(56, 57, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(57, 58, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(58, 59, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(59, 60, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(60, 61, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(61, 62, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(62, 63, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(63, 64, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(64, 65, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(65, 66, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(66, 67, 1, 'XII-2', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(67, 68, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(68, 69, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(69, 70, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(70, 71, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(71, 72, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(72, 73, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(73, 74, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(74, 75, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(75, 76, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(76, 77, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(77, 78, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(78, 79, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(79, 80, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(80, 81, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:45', '2026-10-21 13:29:45'),
(81, 82, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(82, 83, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(83, 84, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(84, 85, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(85, 86, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(86, 87, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(87, 88, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(88, 89, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(89, 90, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(90, 91, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(91, 92, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(92, 93, 1, 'XII-3', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(93, 94, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(94, 95, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(95, 96, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(96, 97, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(97, 98, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(98, 99, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(99, 100, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(100, 101, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(101, 102, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(102, 103, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:46', '2026-10-21 13:29:46'),
(103, 104, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(104, 105, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(105, 106, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(106, 107, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(107, 108, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(108, 109, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(109, 110, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(110, 111, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(111, 112, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(112, 113, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(113, 114, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(114, 115, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(115, 116, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(116, 117, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(117, 118, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(118, 119, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(119, 120, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:47', '2026-10-21 13:29:47'),
(120, 121, 1, 'XII-4', 'excel_import', '2026-10-21 13:29:47', '2026-10-21 13:29:47');

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
(421, 11, 16, 1.0000, 1.0000, 0.9767, 0.7826, 0.8480, 0.9257, 0.9068, 0.9211, 0.6957, 1.0000, 1.0000, 0.7761, 0.9281, 0.7667, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.7500, 0.2500, 0.0000, 0.1000, 0.7273, NULL, NULL),
(422, 11, 17, 0.7143, 0.7564, 0.7907, 0.6957, 0.6000, 0.7973, 0.7373, 0.7018, 0.5043, 0.5814, 0.4624, 0.5821, 0.8957, 0.5733, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.1250, 0.5000, 0.0000, 0.3000, 0.7273, NULL, NULL),
(423, 11, 18, 0.8571, 0.8846, 0.8527, 0.8696, 0.7520, 0.7703, 0.9407, 0.7018, 0.7391, 0.9380, 0.6647, 0.7537, 0.9209, 0.6067, 0.5967, 0.6748, 0.5422, 0.7465, 0.5000, 0.0000, 0.2500, 0.7500, 0.2500, 0.4000, 0.4545, NULL, NULL),
(424, 11, 19, 0.1714, 0.6731, 0.6977, 0.0870, 0.6880, 0.3446, 0.5847, 0.3509, 0.0870, 0.0000, 0.2832, 0.0746, 0.8669, 0.1533, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.1250, 0.0000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(425, 11, 20, 0.8857, 0.9295, 0.8527, 0.6522, 0.7200, 0.9527, 0.8475, 0.8684, 0.6522, 0.9922, 0.7746, 0.7463, 0.9424, 0.7400, 0.5967, 0.6748, 0.5422, 0.7465, 0.5000, 0.0000, 0.6250, 0.5000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(426, 11, 21, 0.8571, 0.7372, 0.8527, 0.8696, 0.8560, 0.5811, 0.6949, 0.8684, 0.5217, 0.8140, 0.3121, 0.3507, 0.9424, 0.8400, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 1.0000, 0.7500, 0.5000, 0.5000, 0.3636, NULL, NULL),
(427, 11, 22, 0.7429, 0.6410, 0.7442, 0.5652, 0.6000, 0.3041, 0.6610, 0.3947, 0.6087, 0.4961, 0.5665, 0.3284, 0.8597, 0.5867, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.1250, 0.0000, 0.0000, 0.8000, 0.7273, NULL, NULL),
(428, 11, 23, 0.7314, 0.7692, 0.1163, 0.6087, 0.6080, 0.4932, 0.1441, 0.7895, 0.6957, 0.7674, 0.4046, 0.7388, 0.9245, 0.6067, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.7500, 0.5000, 0.0000, 0.1000, 0.0909, NULL, NULL),
(429, 11, 24, 0.9429, 0.9167, 1.0000, 0.8696, 0.9360, 0.9189, 0.8644, 0.9561, 0.9130, 0.9225, 0.8497, 0.9776, 0.9460, 0.7333, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.1250, 0.0000, 0.0000, 0.3000, 0.3636, NULL, NULL),
(430, 11, 25, 0.6857, 0.8205, 0.7674, 0.8696, 0.8240, 0.6081, 0.7797, 0.8333, 0.7826, 0.9767, 0.4682, 0.7313, 0.9317, 0.8000, 0.5967, 0.6748, 0.5422, 0.7465, 0.5000, 0.8000, 0.3750, 0.7500, 0.2500, 0.4000, 0.3636, NULL, NULL),
(431, 11, 26, 0.8571, 0.7692, 0.8062, 0.9130, 0.8480, 0.6419, 0.9237, 1.0000, 0.7391, 0.9225, 0.6474, 0.5149, 0.9712, 0.8200, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.3750, 0.2500, 0.2500, 1.0000, 0.5455, NULL, NULL),
(432, 11, 27, 0.7714, 0.8013, 0.7674, 0.7826, 0.9280, 0.7027, 0.7966, 0.9123, 0.6522, 0.5659, 0.5491, 0.4701, 0.9640, 0.8867, 0.5967, 0.6748, 0.5422, 0.7465, 1.0000, 0.0000, 0.5000, 0.0000, 0.2500, 0.6000, 0.2727, NULL, NULL),
(433, 11, 28, 0.8971, 0.7692, 1.0000, 0.8435, 0.7440, 0.7973, 0.9068, 0.8684, 0.3913, 0.8062, 0.6936, 0.4701, 0.9065, 0.7267, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.5000, 0.5000, 0.2500, 0.6000, 0.1818, NULL, NULL),
(434, 11, 29, 0.9143, 0.8654, 0.9302, 0.8696, 0.7120, 0.8311, 0.9915, 0.9561, 0.4783, 0.8760, 0.6763, 0.5373, 0.9424, 0.6400, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.7500, 0.5000, 0.0000, 0.1000, 0.3636, NULL, NULL),
(435, 11, 30, 0.9714, 0.8141, 0.9302, 0.9130, 0.5760, 0.8311, 0.4407, 0.9561, 0.6087, 0.8605, 0.9711, 0.7313, 0.9424, 0.6667, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.5000, 0.0000, 0.0000, 0.2000, 0.5455, NULL, NULL),
(436, 11, 31, 0.2571, 0.5000, 0.5271, 0.6522, 0.6240, 0.1014, 0.4407, 0.7807, 0.3913, 0.1085, 0.6763, 0.4627, 0.7986, 0.7200, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.6250, 0.2500, 0.0000, 0.3000, 0.2727, NULL, NULL),
(437, 11, 32, 0.5714, 0.6090, 0.6512, 0.8696, 0.9360, 0.6284, 0.6610, 0.6579, 0.2174, 0.7209, 0.3642, 0.1343, 0.9388, 1.0000, 0.5967, 0.6748, 0.5422, 0.7465, 0.7500, 0.0000, 0.7500, 0.7500, 0.2500, 0.7000, 0.1818, NULL, NULL),
(438, 11, 33, 0.8857, 0.8205, 0.9612, 0.7826, 0.6800, 0.6824, 1.0000, 0.9561, 0.5652, 0.7829, 0.6647, 0.6343, 0.9209, 0.6200, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.5000, 0.2500, 0.0000, 0.2000, 0.1818, NULL, NULL),
(439, 11, 34, 1.0000, 0.8718, 0.8140, 0.7826, 0.8720, 0.7432, 0.8983, 0.8684, 0.7826, 0.7984, 0.6301, 0.5821, 0.9317, 0.9200, 0.5967, 0.6748, 0.5422, 0.7465, 0.5000, 0.0000, 0.6250, 0.7500, 0.2500, 0.3000, 0.6364, NULL, NULL),
(440, 11, 35, 1.0000, 0.7051, 0.9302, 0.6522, 0.5920, 0.7973, 0.8220, 1.0000, 0.5652, 0.8217, 0.7283, 0.6567, 0.9245, 0.6067, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.5000, 0.0000, 0.0000, 0.6000, 0.9091, NULL, NULL),
(441, 11, 36, 0.9143, 0.8141, 0.9225, 0.7826, 0.4000, 0.7635, 0.8814, 0.9123, 0.4348, 0.6279, 0.5896, 0.5149, 0.9209, 0.4667, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.6250, 0.5000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(442, 11, 37, 0.9714, 0.9359, 0.9767, 0.8261, 0.8640, 0.7095, 0.9576, 0.9123, 0.6522, 1.0000, 0.8208, 0.7537, 0.9173, 0.8000, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.1250, 0.7500, 0.0000, 0.8000, 0.3636, NULL, NULL),
(443, 11, 38, 0.9429, 0.8974, 0.9767, 0.8696, 0.5520, 0.8176, 0.8814, 0.8772, 0.6957, 0.7209, 0.6416, 0.7836, 0.9424, 0.5867, 0.5967, 0.6748, 0.5422, 0.7465, 0.2500, 0.0000, 0.7500, 0.0000, 0.0000, 0.1000, 0.0909, NULL, NULL),
(444, 11, 39, 0.7429, 0.2756, 0.1163, 0.7391, 0.1360, 0.6757, 0.2288, 0.1316, 0.6957, 0.4574, 0.4335, 0.2463, 0.9101, 0.8533, 0.5967, 0.6748, 0.5422, 0.7465, 0.7500, 0.0000, 1.0000, 0.7500, 0.5000, 0.4000, 0.3636, NULL, NULL),
(445, 11, 40, 0.8000, 0.9487, 0.5116, 0.7391, 0.6400, 0.7432, 0.6525, 0.7895, 0.5217, 0.6899, 0.5607, 0.5933, 0.9730, 0.7300, 0.7366, 0.7724, 0.6506, 0.5352, 0.5000, 0.0000, 0.6250, 0.5000, 0.2500, 0.3000, 0.2727, NULL, NULL),
(446, 11, 41, 0.8457, 0.9423, 0.8140, 0.9130, 0.7440, 0.8649, 0.7712, 0.8246, 0.6522, 0.6899, 0.5607, 0.5933, 0.9353, 0.7300, 0.9659, 0.8374, 0.9398, 0.8873, 0.5000, 0.4000, 0.5000, 0.0000, 0.2500, 0.6000, 0.9091, NULL, NULL),
(447, 11, 42, 0.7714, 0.8654, 0.7054, 0.3913, 0.5280, 0.7838, 0.7119, 0.5263, 0.7826, 0.6899, 0.5607, 0.5933, 0.9442, 0.7300, 0.4049, 0.6179, 0.3614, 0.5775, 0.2500, 0.2000, 0.1250, 0.5000, 0.0000, 0.8000, 0.0909, NULL, NULL),
(448, 11, 43, 0.8743, 0.5962, 0.5426, 0.9130, 0.5920, 0.6554, 0.5763, 0.5702, 0.6522, 0.6899, 0.5607, 0.5933, 0.7770, 0.7300, 0.6049, 0.8943, 0.5301, 0.7746, 0.5000, 0.0000, 0.5000, 0.0000, 0.0000, 0.2000, 0.1818, NULL, NULL),
(449, 11, 44, 0.8000, 0.8974, 0.5504, 0.5652, 0.6400, 0.5946, 0.5424, 0.7456, 0.4783, 0.6899, 0.5607, 0.5933, 0.8741, 0.7300, 0.6699, 0.6748, 0.3012, 0.4930, 0.2500, 0.0000, 0.1250, 0.0000, 0.0000, 0.8000, 0.7273, NULL, NULL),
(450, 11, 45, 0.8571, 0.9167, 0.6589, 0.6957, 0.6880, 0.7770, 0.6949, 0.8684, 0.7391, 0.6899, 0.5607, 0.5933, 0.9209, 0.7300, 0.7350, 0.6585, 0.5422, 0.8310, 0.2500, 0.0000, 1.0000, 0.2500, 0.5000, 0.4000, 0.4545, NULL, NULL),
(451, 11, 46, 0.5429, 0.7051, 0.6124, 0.5217, 0.3280, 0.3514, 0.5339, 0.5702, 0.4783, 0.6899, 0.5607, 0.5933, 0.7284, 0.7300, 0.4530, 0.1707, 0.3012, 0.5070, 0.2500, 0.0000, 0.7500, 0.7500, 0.0000, 0.1000, 0.0909, NULL, NULL),
(452, 11, 47, 0.6286, 0.7692, 0.5426, 0.6087, 0.3600, 0.5203, 0.6017, 0.5702, 0.4348, 0.6899, 0.5607, 0.5933, 0.8004, 0.7300, 0.3008, 0.4553, 0.2892, 0.6479, 0.7500, 0.0000, 0.7500, 0.0000, 0.0000, 0.4000, 0.3636, NULL, NULL),
(453, 11, 48, 0.9143, 0.9615, 0.8140, 0.7826, 0.5920, 0.7838, 0.7458, 0.6579, 0.8696, 0.6899, 0.5607, 0.5933, 0.9640, 0.7300, 0.5951, 0.8943, 0.4217, 0.7887, 0.2500, 0.0000, 0.1250, 0.5000, 0.7500, 0.4000, 0.3636, NULL, NULL),
(454, 11, 49, 0.8571, 0.9295, 0.8140, 0.9565, 0.8160, 0.8108, 0.8814, 0.8246, 0.6957, 0.6899, 0.5607, 0.5933, 0.9353, 0.7300, 0.8992, 0.6585, 0.7229, 0.7465, 0.2500, 0.2000, 0.1250, 0.7500, 0.0000, 0.4000, 0.7273, NULL, NULL),
(455, 11, 50, 0.8000, 0.8974, 0.6512, 0.1304, 0.8960, 0.5541, 0.5169, 0.8684, 0.5652, 0.6899, 0.5607, 0.5933, 0.7914, 0.7300, 0.0277, 0.6911, 0.5422, 0.5634, 0.2500, 0.0000, 0.1250, 0.2500, 0.0000, 0.8000, 0.4545, NULL, NULL),
(456, 11, 51, 0.8571, 0.9808, 0.8140, 0.7826, 0.5600, 0.8176, 0.8729, 0.7456, 0.8696, 0.6899, 0.5607, 0.5933, 0.8813, 0.7300, 0.8032, 0.8293, 0.2289, 0.7887, 0.2500, 0.0000, 0.1250, 0.0000, 0.0000, 0.8000, 0.0909, NULL, NULL),
(457, 11, 52, 0.4857, 0.5321, 0.1860, 0.1739, 0.0320, 0.4392, 0.0000, 0.4825, 0.0261, 0.6899, 0.5607, 0.5933, 0.6511, 0.7300, 0.0000, 0.2439, 0.0482, 0.0000, 0.5000, 0.0000, 0.2500, 0.7500, 0.0000, 0.3000, 0.0909, NULL, NULL),
(458, 11, 53, 0.5714, 0.5128, 0.6124, 0.3913, 0.2320, 0.4865, 0.8220, 0.5702, 0.5913, 0.6899, 0.5607, 0.5933, 0.8291, 0.7300, 0.3268, 0.5285, 0.1687, 0.2113, 0.2500, 0.0000, 0.5000, 0.2500, 0.0000, 0.6000, 0.1818, NULL, NULL),
(459, 11, 54, 0.7714, 0.7564, 0.6977, 0.6957, 0.4320, 0.6014, 0.8220, 0.8684, 0.5913, 0.6899, 0.5607, 0.5933, 1.0000, 0.7300, 0.5967, 0.4959, 0.6867, 0.6479, 0.5000, 0.0000, 0.6250, 0.5000, 0.2500, 0.4000, 0.2727, NULL, NULL),
(460, 11, 55, 0.8857, 0.8974, 0.6977, 0.7826, 0.4320, 0.7635, 0.4576, 0.9123, 0.6087, 0.6899, 0.5607, 0.5933, 0.9748, 0.7300, 0.8016, 0.8211, 0.7349, 1.0000, 0.2500, 0.2000, 0.1250, 0.5000, 0.0000, 0.4000, 0.2727, NULL, NULL),
(461, 11, 56, 0.8571, 0.9295, 0.8915, 0.8261, 0.6640, 0.7432, 0.6610, 0.7456, 0.6957, 0.6899, 0.5607, 0.5933, 0.9263, 0.7300, 0.5967, 0.7805, 0.6506, 0.8451, 1.0000, 0.0000, 0.3750, 0.0000, 0.2500, 0.3000, 0.5455, NULL, NULL),
(462, 11, 57, 0.5429, 0.5128, 0.2713, 0.4783, 0.6480, 0.1824, 0.0932, 0.4825, 0.2174, 0.6899, 0.5607, 0.5933, 0.7842, 0.7300, 0.5349, 0.2683, 0.1687, 0.3662, 0.5000, 0.0000, 1.0000, 0.7500, 0.5000, 0.4000, 0.3636, NULL, NULL),
(463, 11, 58, 0.9143, 0.9615, 0.8372, 0.8696, 0.6960, 0.9595, 0.7373, 0.7895, 0.6522, 0.6899, 0.5607, 0.5933, 0.9424, 0.7300, 0.8634, 0.9431, 0.8313, 1.0000, 0.5000, 0.0000, 0.6250, 0.0000, 0.2500, 0.3000, 0.2727, NULL, NULL),
(464, 11, 59, 0.7143, 0.9295, 0.8837, 0.7391, 0.6400, 0.7027, 0.7881, 0.6579, 0.9130, 0.6899, 0.5607, 0.5933, 0.9712, 0.7300, 0.8016, 0.7805, 0.7229, 0.4366, 1.0000, 0.0000, 0.3750, 0.5000, 0.0000, 0.6000, 0.5455, NULL, NULL),
(465, 11, 60, 0.8286, 0.9423, 0.8527, 0.9130, 0.7520, 0.7635, 0.6610, 0.7807, 0.6522, 0.6899, 0.5607, 0.5933, 0.9748, 0.7300, 0.7880, 0.8374, 0.7349, 0.8310, 0.7500, 0.0000, 0.7500, 1.0000, 0.0000, 0.7000, 0.6364, NULL, NULL),
(466, 11, 61, 0.7714, 0.9487, 0.6202, 0.7826, 0.6080, 0.8851, 0.7458, 0.7456, 0.7217, 0.6899, 0.5607, 0.5933, 0.9640, 0.7300, 0.7317, 0.7398, 0.2289, 0.8028, 0.5000, 0.0000, 0.2500, 0.5000, 0.0000, 0.3000, 0.3636, NULL, NULL),
(467, 11, 62, 0.9600, 1.0000, 0.9302, 0.9130, 0.8800, 0.9662, 0.8729, 0.8684, 0.7826, 0.6899, 0.5607, 0.5933, 0.9694, 0.7300, 1.0000, 1.0000, 1.0000, 1.0000, 0.7500, 0.0000, 0.7500, 1.0000, 0.2500, 0.7000, 0.8182, NULL, NULL),
(468, 11, 63, 0.8286, 0.9936, 0.7984, 0.6957, 0.9120, 0.7095, 0.6525, 0.7018, 0.6957, 0.6899, 0.5607, 0.5933, 0.9011, 0.7300, 0.7180, 0.8374, 0.6145, 0.7887, 0.5000, 0.0000, 0.6250, 0.7500, 0.2500, 0.3000, 0.2727, NULL, NULL),
(469, 11, 64, 0.7714, 0.9295, 0.7984, 0.6957, 0.6960, 0.7297, 0.6102, 0.6140, 0.6522, 0.6899, 0.5607, 0.5933, 0.8327, 0.7300, 0.7382, 0.7886, 0.4217, 0.6761, 0.2500, 0.0000, 1.0000, 0.2500, 0.5000, 0.5000, 0.3636, NULL, NULL),
(470, 11, 65, 0.6857, 0.9295, 0.7984, 0.7391, 0.4480, 0.7297, 0.6610, 0.6140, 0.6522, 0.6899, 0.5607, 0.5933, 0.9622, 0.7300, 0.4173, 0.7967, 0.1807, 0.8592, 0.2500, 0.0000, 0.7500, 0.0000, 0.0000, 0.1000, 0.0909, NULL, NULL),
(471, 11, 66, 0.9429, 0.9679, 1.0000, 0.8261, 0.4880, 0.9595, 0.7797, 0.7895, 0.8261, 0.6899, 0.5607, 0.5933, 0.9101, 0.7300, 0.9333, 0.8699, 1.0000, 0.8592, 0.5000, 0.0000, 0.6250, 0.5000, 0.2500, 0.3000, 0.3636, NULL, NULL),
(472, 11, 67, 0.6286, 0.9167, 0.7752, 0.7826, 0.5600, 0.7297, 0.6102, 0.7456, 0.6348, 0.3101, 0.4046, 0.3284, 0.9191, 0.6200, 0.5967, 0.6748, 0.5422, 0.6479, 0.7500, 1.0000, 0.7500, 0.7500, 0.0000, 0.9000, 0.9091, NULL, NULL),
(473, 11, 68, 0.7600, 0.8846, 0.8372, 0.8696, 0.7200, 0.5811, 0.6356, 0.7807, 0.7391, 0.6667, 0.4913, 0.6343, 0.9191, 0.7400, 0.5967, 0.6748, 0.5422, 0.6479, 0.5000, 0.0000, 0.8750, 0.0000, 0.2500, 0.9000, 0.3636, NULL, NULL),
(474, 11, 69, 0.7714, 0.8654, 0.8760, 0.8696, 0.6640, 0.7162, 0.6356, 0.7807, 0.4609, 0.5736, 0.5318, 0.3806, 0.9191, 0.7867, 0.5967, 0.6748, 0.5422, 0.7887, 0.5000, 0.0000, 0.3750, 0.5000, 0.0000, 0.6000, 1.0000, NULL, NULL),
(475, 11, 70, 0.8857, 0.8013, 0.8217, 0.7826, 0.6800, 0.9932, 0.7797, 0.8684, 0.8261, 0.9147, 0.6185, 0.7537, 0.9191, 0.8667, 0.5967, 0.6748, 0.5422, 0.6479, 1.0000, 0.0000, 0.5000, 0.0000, 0.2500, 0.6000, 0.1818, NULL, NULL),
(476, 11, 71, 0.3429, 0.7885, 0.8527, 0.8435, 0.5600, 0.6689, 0.8644, 0.7456, 0.8261, 0.8217, 0.5434, 0.4627, 0.9191, 0.6467, 0.5967, 0.6748, 0.5422, 0.8732, 0.5000, 0.0000, 0.7500, 0.7500, 0.2500, 0.1000, 0.0909, NULL, NULL),
(477, 11, 72, 0.8857, 0.9295, 0.6977, 1.0000, 0.7040, 1.0000, 0.7458, 0.8684, 0.8696, 0.8295, 0.5549, 1.0000, 0.9191, 0.8333, 0.5967, 0.6748, 0.5422, 0.7183, 1.0000, 0.0000, 0.3750, 0.0000, 0.2500, 0.6000, 0.9091, NULL, NULL),
(478, 11, 73, 0.7143, 0.2885, 0.7287, 0.7391, 0.7680, 0.5743, 0.3983, 0.7018, 0.8261, 0.4031, 0.4740, 0.1791, 0.9191, 0.7867, 0.5967, 0.6748, 0.5422, 0.7324, 0.2500, 0.0000, 0.6250, 0.2500, 0.0000, 0.3000, 0.3636, NULL, NULL),
(479, 11, 74, 0.7429, 0.5000, 0.6977, 0.7391, 0.8000, 0.6014, 0.4831, 0.7018, 0.7826, 0.3721, 0.3526, 0.3657, 0.9191, 0.8400, 0.5967, 0.6748, 0.5422, 0.8451, 0.2500, 0.0000, 0.1250, 0.5000, 0.0000, 0.8000, 0.3636, NULL, NULL),
(480, 11, 75, 0.7429, 0.9295, 0.8062, 0.7391, 0.6080, 0.6486, 0.9153, 0.7456, 0.7391, 0.3178, 0.4220, 0.4776, 0.9191, 0.5400, 0.5967, 0.6748, 0.5422, 0.6479, 0.2500, 0.0000, 0.7500, 0.5000, 0.0000, 0.1000, 0.2727, NULL, NULL),
(481, 11, 76, 0.6571, 0.0000, 0.5349, 0.0870, 0.5680, 0.3851, 0.5339, 0.0000, 0.6087, 0.4574, 0.1098, 0.0821, 0.9191, 0.1667, 0.5967, 0.6748, 0.5422, 0.4366, 0.2500, 0.0000, 0.5000, 0.0000, 0.0000, 0.6000, 0.1818, NULL, NULL),
(482, 11, 77, 0.7429, 0.6410, 0.6589, 0.8261, 0.9120, 0.7770, 0.5678, 0.8246, 0.6087, 0.8217, 0.4798, 0.8134, 0.9191, 0.9200, 0.5967, 0.6748, 0.5422, 0.9014, 1.0000, 0.0000, 0.3750, 0.0000, 0.0000, 1.0000, 0.5455, NULL, NULL),
(483, 11, 78, 0.8857, 0.7821, 0.8915, 0.8696, 0.8480, 0.7838, 0.8305, 0.9123, 0.9130, 0.8760, 0.7514, 0.7687, 0.9191, 0.8333, 0.5967, 0.6748, 0.5422, 1.0000, 0.2500, 0.0000, 0.6250, 0.0000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(484, 11, 79, 0.6857, 0.7179, 0.5039, 0.6522, 0.3680, 0.6689, 0.3390, 0.7368, 0.7391, 0.5504, 0.2601, 0.4776, 0.9191, 0.4400, 0.5967, 0.6748, 0.5422, 0.3803, 0.2500, 0.6000, 0.5000, 0.0000, 0.0000, 0.2000, 0.2727, NULL, NULL),
(485, 11, 80, 0.8571, 0.9615, 0.7364, 0.7826, 0.6800, 0.7365, 0.7034, 0.7895, 0.9130, 0.8682, 0.7746, 0.5896, 0.9191, 0.5400, 0.5967, 0.6748, 0.5422, 0.8592, 0.2500, 0.6000, 0.5000, 0.7500, 0.0000, 0.2000, 0.1818, NULL, NULL),
(486, 11, 81, 0.6857, 0.8013, 0.8062, 0.4783, 0.6080, 0.7365, 0.7881, 0.7456, 0.6348, 0.3643, 0.3988, 0.5970, 0.9191, 0.4533, 0.5967, 0.6748, 0.5422, 0.4648, 0.2500, 0.0000, 1.0000, 0.5000, 0.0000, 0.4000, 0.3636, NULL, NULL),
(487, 11, 82, 0.9429, 0.8526, 0.7752, 0.8696, 0.7600, 0.9122, 0.9576, 0.8246, 0.9565, 0.9767, 0.8208, 0.8881, 0.9191, 0.6000, 0.5967, 0.6748, 0.5422, 0.7887, 0.2500, 0.6000, 0.5000, 0.2500, 0.0000, 0.2000, 0.0909, NULL, NULL),
(488, 11, 83, 0.0000, 0.6603, 0.5039, 0.0000, 0.4400, 0.3243, 0.6780, 0.4825, 0.7217, 0.3643, 0.0000, 0.1716, 0.9191, 0.0000, 0.5967, 0.6748, 0.5422, 0.3521, 0.2500, 0.0000, 0.5000, 0.5000, 0.0000, 0.6000, 0.2727, NULL, NULL),
(489, 11, 84, 0.9314, 0.7692, 0.7752, 0.4348, 0.9280, 0.6824, 0.6186, 0.7018, 0.6522, 0.8217, 0.4740, 0.5448, 0.9191, 0.7867, 0.5967, 0.6748, 0.5422, 0.5493, 0.7500, 0.0000, 1.0000, 0.0000, 0.5000, 0.4000, 0.4545, NULL, NULL),
(490, 11, 85, 0.8457, 0.7564, 0.7752, 0.6957, 0.8400, 0.7297, 0.7881, 0.7018, 0.8696, 0.6512, 0.4566, 0.6343, 0.9191, 0.6733, 0.5967, 0.6748, 0.5422, 0.6479, 0.5000, 0.4000, 0.2500, 0.7500, 0.0000, 0.4000, 0.4545, NULL, NULL),
(491, 11, 86, 0.2857, 0.1603, 0.6202, 0.6522, 0.8080, 0.0000, 0.3051, 0.0877, 0.2609, 0.1628, 0.7457, 0.0000, 0.9191, 0.8200, 0.5967, 0.6748, 0.5422, 0.3662, 1.0000, 0.0000, 0.3750, 0.0000, 1.0000, 0.6000, 0.5455, NULL, NULL),
(492, 11, 87, 0.8571, 0.8974, 0.9690, 0.7391, 1.0000, 0.7095, 0.6525, 0.7456, 0.9130, 0.7752, 0.5376, 0.6866, 0.9191, 0.9733, 0.5967, 0.6748, 0.5422, 0.8873, 0.5000, 0.0000, 0.6250, 0.5000, 0.2500, 0.3000, 0.2727, NULL, NULL),
(493, 11, 88, 0.8571, 0.8462, 0.6977, 0.5217, 0.9440, 0.7770, 0.7034, 0.7456, 0.8261, 0.7984, 0.7399, 0.8209, 0.9191, 0.8067, 0.5967, 0.6748, 0.5422, 0.7606, 0.5000, 0.0000, 0.8750, 0.0000, 0.2500, 0.7000, 0.8182, NULL, NULL),
(494, 11, 89, 0.1429, 0.6603, 0.8760, 0.7391, 0.9280, 0.4189, 0.6780, 0.7895, 1.0000, 0.7519, 0.4798, 0.7388, 0.9191, 0.9067, 0.5967, 0.6748, 0.5422, 0.7042, 0.7500, 0.0000, 0.7500, 0.0000, 0.2500, 1.0000, 0.6364, NULL, NULL),
(495, 11, 90, 0.7429, 0.7051, 0.7829, 0.6957, 0.5680, 0.7297, 0.9661, 0.7895, 0.5652, 0.6279, 0.5954, 0.7015, 0.9191, 0.6400, 0.5967, 0.6748, 0.5422, 0.9014, 0.2500, 0.6000, 0.5000, 0.5000, 0.0000, 0.3000, 0.1818, NULL, NULL),
(496, 11, 91, 0.7600, 0.8974, 0.6667, 0.7391, 0.6400, 0.8784, 0.6949, 0.7456, 0.6087, 0.6667, 0.7168, 0.7015, 0.9191, 0.6067, 0.5967, 0.6748, 0.5422, 0.8028, 0.2500, 0.6000, 0.5000, 0.0000, 0.0000, 0.2000, 0.1818, NULL, NULL),
(497, 11, 92, 0.8857, 0.9038, 0.7054, 0.7391, 0.8320, 0.5608, 0.3729, 0.4386, 0.7391, 0.7984, 0.9364, 0.7313, 0.0000, 0.8867, 0.5967, 0.6748, 0.5422, 0.8732, 0.5000, 0.0000, 0.6250, 0.5000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(498, 11, 93, 0.8857, 0.8013, 0.7364, 0.7391, 0.4320, 0.7973, 0.7966, 0.8246, 0.6087, 0.6202, 0.5607, 0.5933, 0.9209, 0.7300, 0.6221, 0.4553, 0.5783, 0.7465, 0.5000, 0.0000, 0.2500, 0.5000, 0.7500, 0.4000, 0.4545, NULL, NULL),
(499, 11, 94, 0.5143, 0.7564, 0.6977, 0.6957, 0.5200, 0.2838, 0.6102, 0.8246, 0.5913, 0.5814, 0.5607, 0.5933, 0.9173, 0.7300, 0.5659, 0.1545, 0.3494, 0.7465, 0.2500, 0.0000, 0.5000, 0.5000, 0.0000, 0.6000, 0.1818, NULL, NULL),
(500, 11, 95, 0.8571, 0.8333, 0.8062, 0.8696, 0.6800, 0.6081, 0.6525, 0.8333, 0.8261, 0.8140, 0.5607, 0.5933, 0.9047, 0.7300, 0.6888, 0.7561, 0.8916, 0.7465, 0.5000, 0.0000, 0.3750, 0.0000, 0.0000, 0.8000, 0.5455, NULL, NULL),
(501, 11, 96, 0.8857, 0.9744, 0.6977, 0.9565, 0.8000, 0.8581, 0.6525, 0.5263, 0.7391, 0.8605, 0.5607, 0.5933, 0.8633, 0.7300, 0.6683, 0.8537, 0.8675, 0.7465, 0.5000, 0.0000, 0.8750, 0.7500, 0.2500, 0.9000, 0.6364, NULL, NULL),
(502, 11, 97, 0.7429, 0.7372, 0.7364, 0.6957, 0.6880, 0.6014, 0.5932, 0.8246, 0.7391, 0.6899, 0.5607, 0.5933, 0.8489, 0.7300, 0.5880, 0.8780, 0.5060, 0.7465, 0.7500, 0.0000, 0.6250, 0.7500, 0.0000, 0.3000, 0.2727, NULL, NULL),
(503, 11, 98, 0.5714, 0.7821, 0.6589, 0.8261, 0.8320, 0.6486, 0.3983, 0.4825, 0.5652, 0.6822, 0.5607, 0.5933, 0.8633, 0.7300, 0.3073, 0.5285, 0.2048, 0.7465, 1.0000, 0.0000, 0.3750, 0.0000, 0.0000, 0.6000, 0.9091, NULL, NULL),
(504, 11, 99, 0.7143, 0.4487, 0.6202, 0.7826, 0.8880, 0.1284, 0.4746, 0.5263, 0.5652, 0.6899, 0.5607, 0.5933, 0.8129, 0.7300, 0.5366, 0.3984, 0.3253, 0.7465, 0.7500, 0.0000, 0.5000, 1.0000, 0.0000, 0.6000, 0.6364, NULL, NULL),
(505, 11, 100, 0.4286, 0.4936, 0.3798, 0.6957, 0.2720, 0.1216, 0.6780, 0.5702, 0.4348, 0.4419, 0.5607, 0.5933, 0.7644, 0.7300, 0.1008, 0.0406, 0.0000, 0.7465, 0.2500, 0.0000, 0.7500, 0.0000, 0.0000, 0.1000, 0.0909, NULL, NULL),
(506, 11, 101, 0.5714, 0.6410, 0.3798, 0.0435, 0.3920, 0.5068, 0.5254, 0.5702, 0.4609, 0.0853, 0.5607, 0.5933, 0.9406, 0.7300, 0.2000, 0.4146, 0.3614, 0.7465, 0.5000, 0.0000, 0.7500, 0.0000, 0.2500, 0.7000, 0.0909, NULL, NULL),
(507, 11, 102, 0.4286, 0.5769, 0.6124, 0.8261, 0.3920, 0.3108, 0.8644, 0.6140, 0.3739, 0.5116, 0.5607, 0.5933, 0.9047, 0.7300, 0.5024, 0.3740, 0.2289, 0.7465, 0.2500, 0.0000, 0.6250, 0.0000, 0.0000, 0.2000, 0.7273, NULL, NULL),
(508, 11, 103, 0.8000, 0.6859, 0.6589, 0.8261, 0.6240, 0.6486, 0.7797, 0.7456, 0.5217, 0.7209, 0.5607, 0.5933, 0.9137, 0.7300, 0.5587, 0.4146, 0.6867, 0.7465, 0.2500, 0.0000, 0.5000, 0.2500, 0.0000, 0.2000, 0.1818, NULL, NULL),
(509, 11, 104, 0.6857, 0.6282, 0.7364, 0.9130, 0.5680, 0.7432, 0.7966, 0.8684, 0.6348, 0.5194, 0.5607, 0.5933, 0.8813, 0.7300, 0.7229, 0.7154, 0.5422, 0.7465, 0.2500, 0.0000, 0.5000, 0.0000, 0.0000, 0.6000, 0.1818, NULL, NULL),
(510, 11, 105, 0.7143, 0.5769, 0.7752, 0.8261, 0.7600, 0.8919, 0.6525, 0.8684, 0.3739, 0.5814, 0.5607, 0.5933, 0.8363, 0.7300, 0.8016, 0.7073, 0.7229, 0.7465, 0.2500, 0.0000, 0.7500, 0.5000, 0.0000, 0.1000, 0.3636, NULL, NULL),
(511, 11, 106, 0.7143, 0.8013, 0.6899, 0.8261, 0.5680, 0.6486, 0.6610, 0.6140, 0.7391, 0.4419, 0.5607, 0.5933, 0.9353, 0.7300, 0.7008, 0.5285, 0.5904, 0.7465, 0.2500, 0.0000, 1.0000, 0.7500, 0.0000, 0.4000, 0.3636, NULL, NULL),
(512, 11, 107, 0.5143, 0.4359, 0.1550, 0.6087, 0.0800, 0.5203, 0.6441, 0.6579, 0.1739, 0.3798, 0.5607, 0.5933, 0.8813, 0.7300, 0.3366, 0.4634, 0.4096, 0.7465, 0.7500, 0.0000, 0.6250, 0.7500, 0.0000, 0.3000, 0.2727, NULL, NULL),
(513, 11, 108, 0.6857, 0.6603, 0.9225, 0.9130, 0.4800, 0.7230, 0.6441, 0.7018, 0.6783, 0.6977, 0.5607, 0.5933, 0.9496, 0.7300, 0.5675, 0.6911, 0.2892, 0.7465, 0.7500, 0.0000, 1.0000, 0.7500, 0.5000, 0.4000, 0.4545, NULL, NULL),
(514, 11, 109, 0.6286, 0.5962, 0.4574, 0.6522, 0.0000, 0.5946, 0.6949, 0.6140, 0.5478, 0.4651, 0.5607, 0.5933, 0.8201, 0.7300, 0.5415, 0.4472, 0.4337, 0.7465, 0.2500, 0.0000, 0.5000, 0.0000, 0.0000, 0.2000, 0.5455, NULL, NULL),
(515, 11, 110, 0.5143, 0.6731, 0.4806, 0.5652, 0.0480, 0.4189, 0.7458, 0.7368, 0.5217, 0.4109, 0.5607, 0.5933, 0.8543, 0.7300, 0.2700, 0.5041, 0.2530, 0.7465, 0.2500, 0.0000, 0.1250, 0.5000, 0.0000, 0.8000, 0.4545, NULL, NULL),
(516, 11, 111, 0.7143, 0.8013, 0.8915, 0.8261, 0.1120, 0.7297, 0.6102, 0.7018, 0.6087, 0.8527, 0.5607, 0.5933, 0.8993, 0.7300, 0.5691, 0.6504, 0.5422, 0.7465, 0.2500, 0.0000, 0.1250, 0.2500, 0.0000, 0.8000, 0.7273, NULL, NULL),
(517, 11, 112, 0.7429, 0.7692, 0.5426, 0.9565, 0.7280, 0.5068, 0.6949, 0.6140, 0.6087, 0.8527, 0.5607, 0.5933, 0.8687, 0.7300, 0.7571, 0.8618, 0.8434, 0.7465, 0.7500, 0.0000, 0.5000, 0.7500, 0.5000, 0.5000, 0.3636, NULL, NULL),
(518, 11, 113, 0.7714, 0.6090, 0.4264, 0.4783, 0.7280, 0.4257, 0.3559, 0.6930, 0.5217, 0.5504, 0.5607, 0.5933, 0.8759, 0.7300, 0.5880, 0.3333, 0.4217, 0.7465, 0.5000, 0.0000, 0.6250, 0.0000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(519, 11, 114, 0.7429, 0.8205, 0.4884, 0.6957, 0.7840, 0.5608, 0.5339, 0.5702, 0.5217, 0.4651, 0.5607, 0.5933, 0.9442, 0.7300, 0.3587, 0.2683, 0.7229, 0.7465, 0.5000, 0.0000, 1.0000, 0.7500, 0.2500, 0.4000, 0.4545, NULL, NULL),
(520, 11, 115, 0.8000, 0.8397, 0.7752, 0.6957, 0.4320, 0.5743, 0.7458, 0.6140, 0.3913, 0.7054, 0.5607, 0.5933, 0.8957, 0.7300, 0.7041, 0.6341, 0.7711, 0.7465, 0.2500, 0.0000, 0.1250, 0.2500, 0.0000, 0.8000, 0.7273, NULL, NULL),
(521, 11, 116, 0.8286, 0.8974, 0.6977, 0.8696, 0.7840, 0.7838, 0.6017, 0.7368, 0.8696, 0.7519, 0.5607, 0.5933, 0.9640, 0.7300, 0.7522, 0.8943, 0.8675, 0.7465, 0.5000, 0.0000, 0.8750, 0.0000, 0.2500, 0.9000, 0.6364, NULL, NULL),
(522, 11, 117, 0.7714, 0.8654, 0.8140, 0.8696, 0.8240, 0.8243, 0.6525, 0.7018, 0.7826, 0.6667, 0.5607, 0.5933, 0.9658, 0.7300, 0.7658, 0.7805, 0.8072, 0.7465, 1.0000, 0.0000, 1.0000, 0.5000, 0.0000, 0.4000, 0.3636, NULL, NULL),
(523, 11, 118, 0.4514, 0.3077, 0.0000, 0.0435, 0.8080, 0.1892, 0.1525, 0.0877, 0.0000, 0.2713, 0.5607, 0.5933, 0.5755, 0.7300, 0.1008, 0.0000, 0.4458, 0.7465, 0.5000, 0.0000, 0.6250, 0.0000, 0.0000, 0.3000, 0.2727, NULL, NULL),
(524, 11, 119, 0.8571, 0.6731, 0.6202, 0.6957, 0.7280, 0.6419, 0.4068, 0.6140, 0.5652, 0.6744, 0.5607, 0.5933, 0.9119, 0.7300, 0.5880, 0.5285, 0.9157, 0.7465, 1.0000, 0.0000, 0.3750, 0.5000, 0.2500, 1.0000, 0.5455, NULL, NULL),
(525, 11, 120, 0.8857, 0.9103, 0.8140, 0.7391, 0.7680, 0.7162, 0.6610, 0.6579, 0.7826, 0.7442, 0.5607, 0.5933, 0.9658, 0.7300, 0.8325, 0.8537, 0.9157, 0.7465, 0.2500, 0.0000, 0.6250, 0.2500, 0.5000, 0.4000, 0.2727, NULL, NULL);

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
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=447;

--
-- AUTO_INCREMENT for table `category_mapping`
--
ALTER TABLE `category_mapping`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1277;

--
-- AUTO_INCREMENT for table `category_option`
--
ALTER TABLE `category_option`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=277;

--
-- AUTO_INCREMENT for table `centroid`
--
ALTER TABLE `centroid`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cleaned_data`
--
ALTER TABLE `cleaned_data`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=814;

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
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=788;

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
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=361;

--
-- AUTO_INCREMENT for table `non_akademik`
--
ALTER TABLE `non_akademik`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `periode`
--
ALTER TABLE `periode`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `preprocessing_run`
--
ALTER TABLE `preprocessing_run`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `recommendation`
--
ALTER TABLE `recommendation`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reduced_data`
--
ALTER TABLE `reduced_data`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=631;

--
-- AUTO_INCREMENT for table `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=122;

--
-- AUTO_INCREMENT for table `siswa_periode`
--
ALTER TABLE `siswa_periode`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `transformed_data`
--
ALTER TABLE `transformed_data`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=526;

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
