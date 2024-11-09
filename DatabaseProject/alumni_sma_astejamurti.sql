-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 03, 2023 at 10:39 AM
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
-- Database: `alumni_sma_astejamurti`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `hapus_data_alumni_di_semua_tabel` (`input_nisk` VARCHAR(255))   BEGIN
    DELETE FROM data_diri_alumni WHERE nomor_induk_siswa_sekolah = input_nisk;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lihat_alumni_lulus_di_tahun_xxxx` (`input_year` YEAR)   BEGIN
    	SELECT nama_lengkap AS 'Nama Lengkap',
        	alamat AS 'Alamat',
            tempat_lahir AS 'Tempat Lahir',
            jenis_kelamin AS 'Jenis Kelamin',
            jurusan AS 'Jurusan',
            nomor_induk_siswa_sekolah AS 'NISK',
            nomor_induk_siswa_nasional AS 'NISN',
            tahun_lulus AS 'Tahun Lulus'
FROM data_diri_alumni
        WHERE YEAR(tahun_lulus) = input_year;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lihat_data_diri_alumni_yang_ikut_reuni_di_tahun_xxxx` (`input_year` YEAR)   BEGIN
    	SELECT ra.id_reuni as 'ID Reuni',
ra.tanggal_reuni as 'Tanggal Reuni',
    		ra.lokasi_reuni as 'Lokasi Reuni',
    		ra.nomor_induk_siswa_sekolah_alumni_yang_ikut as 'NISK yang Ikut',
    		dda.nama_lengkap as 'Nama Lengkap'
FROM reuni_alumni as ra JOIN 
data_diri_alumni as dda 
ON ra.nomor_induk_siswa_sekolah_alumni_yang_ikut = dda.nomor_induk_siswa_sekolah
WHERE YEAR(ra.tanggal_reuni) = input_year;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `ambil_alamat_dari_nomor_induk_sekolah` (`nomor_induk` VARCHAR(10)) RETURNS VARCHAR(100) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
    DECLARE alamat_alumni VARCHAR(100);
    SELECT alamat INTO alamat_alumni FROM data_diri_alumni WHERE nomor_induk_siswa_sekolah = nomor_induk;
    RETURN alamat_alumni;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `data_diri_alumni`
--

CREATE TABLE `data_diri_alumni` (
  `nama_lengkap` varchar(100) NOT NULL,
  `alamat` varchar(100) NOT NULL DEFAULT 'Jalan',
  `tempat_lahir` varchar(75) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `jenis_kelamin` enum('laki-laki','perempuan') NOT NULL,
  `jurusan` enum('IPA','IPS','BAHASA') NOT NULL,
  `nomor_induk_siswa_sekolah` varchar(10) NOT NULL,
  `nomor_induk_siswa_nasional` varchar(10) NOT NULL,
  `tahun_lulus` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `data_diri_alumni`
--

INSERT INTO `data_diri_alumni` (`nama_lengkap`, `alamat`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `jurusan`, `nomor_induk_siswa_sekolah`, `nomor_induk_siswa_nasional`, `tahun_lulus`) VALUES
('Siti Nurjanah', '777 Jalan Berseri', 'Semarang', '1993-07-05', 'perempuan', 'BAHASA', '11111', 'ID11111', '2011'),
('John Doe', '123 Jalan Merdeka', 'Jakarta', '1995-05-15', 'laki-laki', 'IPA', '12345', 'ID12345', '2013'),
('David Johnson', '789 Jalan Utama', 'Bandung', '1994-02-10', 'laki-laki', 'BAHASA', '13579', 'ID13579', '2012'),
('Lina Susanto', '888 Jalan Sentosa', 'Palembang', '1992-04-18', 'perempuan', 'BAHASA', '22222', 'ID22222', '2010'),
('Maria Garcia', '321 Jalan Baru', 'Yogyakarta', '1996-11-25', 'perempuan', 'IPA', '24680', 'ID24680', '2014'),
('Andi Wijaya', '999 Jalan Ceria', 'Makassar', '1999-12-12', 'laki-laki', 'IPS', '54321', 'ID54321', '2017'),
('Jane Smith', '456 Jalan Raya', 'Surabaya', '1997-09-20', 'perempuan', 'IPS', '67890', 'ID67890', '2015'),
('Rina Cahaya', '444 Jalan Bahagia', 'Balikpapan', '1990-03-28', 'perempuan', 'IPS', '77777', 'ID77777', '2008'),
('Ahmad Abdullah', '555 Jalan Indah', 'Medan', '1998-08-30', 'laki-laki', 'IPS', '98765', 'ID98765', '2016'),
('Eko Prabowo', '666 Jalan Makmur', 'Solo', '1991-10-08', 'laki-laki', 'IPA', '99999', 'ID99999', '2009');

-- --------------------------------------------------------

--
-- Table structure for table `jenis_pekerjaan`
--

CREATE TABLE `jenis_pekerjaan` (
  `id` int(11) NOT NULL,
  `nama_pekerjaan` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jenis_pekerjaan`
--

INSERT INTO `jenis_pekerjaan` (`id`, `nama_pekerjaan`) VALUES
(1, 'Guru'),
(2, 'Dokter'),
(3, 'Insinyur'),
(4, 'Akuntan'),
(5, 'Desainer'),
(6, 'Pengusaha'),
(7, 'Programmer'),
(8, 'Arsitek'),
(9, 'Penulis'),
(10, 'Pilot');

-- --------------------------------------------------------

--
-- Stand-in structure for view `lihat_alumni_yang_sedang_bekerja`
-- (See below for the actual view)
--
CREATE TABLE `lihat_alumni_yang_sedang_bekerja` (
`NISK` varchar(10)
,`Nama Lengkap` varchar(100)
,`Nama Pekerjaan` varchar(50)
,`Jenis Pekerjaan` varchar(20)
,`Jabatan Pekerjaan` varchar(50)
,`Tempat Bekerja` varchar(100)
,`Tanggal Mulai Kerja` date
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `lihat_alumni_yang_sedang_kuliah`
-- (See below for the actual view)
--
CREATE TABLE `lihat_alumni_yang_sedang_kuliah` (
`NISK` varchar(10)
,`Nama Lengkap` varchar(100)
,`Jenjang Pendidikan` enum('D3','D4','S1','S2','S3')
,`Program Studi` varchar(50)
,`Tahun Masuk` year(4)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `lihat_data_diri_alumni_yang_berprestasi_internasional`
-- (See below for the actual view)
--
CREATE TABLE `lihat_data_diri_alumni_yang_berprestasi_internasional` (
`NISK` varchar(10)
,`Nama Lengkap` varchar(100)
,`Nama Lomba` varchar(30)
,`Predikat Prestasi` enum('peserta','juara harapan','juara 3','juara 2','juara 1')
,`Tanggal Mulai` date
,`Tanggal Selesai` date
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `lihat_data_diri_alumni_yang_berprestasi_kabupaten`
-- (See below for the actual view)
--
CREATE TABLE `lihat_data_diri_alumni_yang_berprestasi_kabupaten` (
`NISK` varchar(10)
,`Nama Lengkap` varchar(100)
,`Nama Lomba` varchar(30)
,`Predikat Prestasi` enum('peserta','juara harapan','juara 3','juara 2','juara 1')
,`Tanggal Mulai` date
,`Tanggal Selesai` date
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `lihat_data_diri_alumni_yang_berprestasi_nasional`
-- (See below for the actual view)
--
CREATE TABLE `lihat_data_diri_alumni_yang_berprestasi_nasional` (
`NISK` varchar(10)
,`Nama Lengkap` varchar(100)
,`Nama Lomba` varchar(30)
,`Predikat Prestasi` enum('peserta','juara harapan','juara 3','juara 2','juara 1')
,`Tanggal Mulai` date
,`Tanggal Selesai` date
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `lihat_data_diri_alumni_yang_berprestasi_provinsi`
-- (See below for the actual view)
--
CREATE TABLE `lihat_data_diri_alumni_yang_berprestasi_provinsi` (
`NISK` varchar(10)
,`Nama Lengkap` varchar(100)
,`Nama Lomba` varchar(30)
,`Predikat Prestasi` enum('peserta','juara harapan','juara 3','juara 2','juara 1')
,`Tanggal Mulai` date
,`Tanggal Selesai` date
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `lihat_data_diri_alumni_yang_ikut_reuni_terakhir_kali`
-- (See below for the actual view)
--
CREATE TABLE `lihat_data_diri_alumni_yang_ikut_reuni_terakhir_kali` (
`ID Reuni` int(11)
,`Tanggal Reuni` date
,`Lokasi Reuni` varchar(50)
,`NISK yang Ikut` varchar(10)
,`Nama Lengkap` varchar(100)
);

-- --------------------------------------------------------

--
-- Table structure for table `pekerjaan_alumni`
--

CREATE TABLE `pekerjaan_alumni` (
  `nomor_induk_siswa_sekolah` varchar(10) NOT NULL,
  `nama_pekerjaan` varchar(50) DEFAULT NULL,
  `id_jenis_pekerjaan` int(11) NOT NULL,
  `jabatan_pekerjaan` varchar(50) DEFAULT NULL,
  `tempat_bekerja` varchar(100) DEFAULT NULL,
  `tanggal_mulai_bekerja` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pekerjaan_alumni`
--

INSERT INTO `pekerjaan_alumni` (`nomor_induk_siswa_sekolah`, `nama_pekerjaan`, `id_jenis_pekerjaan`, `jabatan_pekerjaan`, `tempat_bekerja`, `tanggal_mulai_bekerja`) VALUES
('12345', 'Guru', 1, 'Kepala Sekolah', 'SMA Negeri 1', '2023-01-02'),
('67890', 'Dokter', 2, 'Spesialis Bedah', 'RS Pusat', '2022-04-15'),
('13579', 'Insinyur', 3, 'Project Manager', 'PT Maju Mundur', '2021-10-28'),
('24680', 'Akuntan', 4, 'Pembukuan', 'Kantor Akuntan Bersama', '2020-03-10'),
('98765', 'Desainer', 5, 'Art Director', 'Studio Kreatif', '2019-07-20'),
('11111', 'Pengusaha', 6, 'Owner', 'Warung Makmur', '2018-12-05'),
('54321', 'Programmer', 7, 'Software Engineer', 'Tech Solutions', '2017-06-18'),
('22222', 'Arsitek', 8, 'Proyek Manager', 'Arsitek Bersatu', '2016-01-30'),
('99999', 'Penulis', 9, 'Editor', 'Penerbit Cerdas', '2015-05-12'),
('77777', 'Pilot', 10, 'Pilot Garuda', 'Garuda Indonesia', '2014-09-25');

-- --------------------------------------------------------

--
-- Table structure for table `reuni_alumni`
--

CREATE TABLE `reuni_alumni` (
  `id_reuni` int(11) NOT NULL,
  `tanggal_reuni` date NOT NULL,
  `lokasi_reuni` varchar(50) NOT NULL,
  `nomor_induk_siswa_sekolah_alumni_yang_ikut` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reuni_alumni`
--

INSERT INTO `reuni_alumni` (`id_reuni`, `tanggal_reuni`, `lokasi_reuni`, `nomor_induk_siswa_sekolah_alumni_yang_ikut`) VALUES
(1, '2023-06-20', 'Gedung Serbaguna', '12345'),
(2, '2023-08-15', 'Taman Kota', '67890'),
(3, '2022-12-25', 'Hotel Megah', '13579'),
(4, '2022-09-10', 'Pantai Indah', '24680'),
(5, '2021-11-05', 'Aula Universitas', '98765'),
(6, '2021-04-30', 'Pasar Malam', '11111'),
(7, '2020-08-18', 'Kantor Pos', '54321'),
(8, '2020-02-14', 'Cafe Ceria', '22222'),
(9, '2019-07-01', 'Kolam Renang', '99999'),
(10, '2018-10-22', 'Bioskop Tertawa', '77777');

-- --------------------------------------------------------

--
-- Table structure for table `riwayat_kegiatan_organisasi`
--

CREATE TABLE `riwayat_kegiatan_organisasi` (
  `id` int(11) NOT NULL,
  `nama_kegiatan` varchar(30) NOT NULL,
  `tanggal_mulai_kegiatan` date NOT NULL,
  `tanggal_berakhir_kegiatan` date NOT NULL,
  `nama_organisasi` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `riwayat_kegiatan_organisasi`
--

INSERT INTO `riwayat_kegiatan_organisasi` (`id`, `nama_kegiatan`, `tanggal_mulai_kegiatan`, `tanggal_berakhir_kegiatan`, `nama_organisasi`) VALUES
(1, 'OSIS SMA', '2012-08-15', '2014-05-20', 'SMA Negeri 1'),
(2, 'PMR', '2013-04-10', '2015-02-28', 'SMA Negeri 2'),
(3, 'MPK', '2011-10-05', '2013-09-15', 'SMA Negeri 3'),
(4, 'UKS', '2014-12-25', '2016-08-30', 'SMA Negeri 4'),
(5, 'Pramuka', '2010-07-30', '2012-04-18', 'SMA Negeri 5'),
(6, 'KIR', '2015-03-12', '2017-10-22', 'SMA Negeri 6'),
(7, 'Rohis', '2016-09-18', '2019-12-05', 'SMA Negeri 7'),
(8, 'PKS', '2009-05-01', '2011-11-30', 'SMA Negeri 8'),
(9, 'Paskibra', '2017-11-10', '2020-06-15', 'SMA Negeri 9'),
(10, 'MPM', '2008-01-20', '2010-10-08', 'SMA Negeri 10');

-- --------------------------------------------------------

--
-- Table structure for table `riwayat_organisasi_alumni`
--

CREATE TABLE `riwayat_organisasi_alumni` (
  `nomor_induk_siswa_sekolah` varchar(10) NOT NULL,
  `id_kegiatan_organisasi` int(11) NOT NULL,
  `peran_di_kegiatan` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `riwayat_organisasi_alumni`
--

INSERT INTO `riwayat_organisasi_alumni` (`nomor_induk_siswa_sekolah`, `id_kegiatan_organisasi`, `peran_di_kegiatan`) VALUES
('11111', 6, 'Anggota'),
('12345', 1, 'Ketua Pelaksana'),
('13579', 3, 'Bendahara'),
('22222', 8, 'Bendahara'),
('24680', 4, 'Anggota'),
('54321', 7, 'Ketua Umum'),
('67890', 2, 'Sekretaris'),
('77777', 10, 'Anggota'),
('98765', 5, 'Ketua Bidang'),
('99999', 9, 'Sekretaris');

-- --------------------------------------------------------

--
-- Table structure for table `riwayat_prestasi_alumni`
--

CREATE TABLE `riwayat_prestasi_alumni` (
  `nomor_induk_siswa_sekolah` varchar(10) NOT NULL,
  `tingkat_prestasi` enum('kecamatan','kabupaten','provinsi','nasional','internasional') NOT NULL,
  `predikat_prestasi` enum('peserta','juara harapan','juara 3','juara 2','juara 1') NOT NULL,
  `nama_lomba` varchar(30) NOT NULL,
  `tanggal_lomba_mulai` date NOT NULL,
  `tanggal_lomba_selesai` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `riwayat_prestasi_alumni`
--

INSERT INTO `riwayat_prestasi_alumni` (`nomor_induk_siswa_sekolah`, `tingkat_prestasi`, `predikat_prestasi`, `nama_lomba`, `tanggal_lomba_mulai`, `tanggal_lomba_selesai`) VALUES
('12345', 'kecamatan', 'juara 1', 'Lomba Matematika', '2023-01-10', '2023-01-15'),
('67890', 'kabupaten', 'juara 2', 'Lomba Bahasa Indonesia', '2022-05-20', '2022-05-25'),
('13579', 'provinsi', 'juara 3', 'Olimpiade Fisika', '2021-11-12', '2021-11-17'),
('24680', 'nasional', 'juara harapan', 'Lomba Seni Lukis', '2020-07-05', '2020-07-10'),
('98765', 'internasional', 'peserta', 'Olimpiade Biologi', '2019-12-28', '2020-01-02'),
('11111', 'kecamatan', 'juara 1', 'Lomba Debat', '2018-04-15', '2018-04-20'),
('54321', 'kabupaten', 'juara 2', 'Lomba Tari Tradisional', '2017-10-30', '2017-11-04'),
('22222', 'provinsi', 'juara 3', 'Olimpiade Kimia', '2016-03-12', '2016-03-17'),
('99999', 'nasional', 'juara harapan', 'Lomba Fotografi', '2015-09-25', '2015-09-30'),
('77777', 'internasional', 'peserta', 'Olimpiade Astronomi', '2014-01-08', '2014-01-13');

-- --------------------------------------------------------

--
-- Table structure for table `sekolah_tinggi_alumni`
--

CREATE TABLE `sekolah_tinggi_alumni` (
  `nomor_induk_siswa_sekolah` varchar(10) NOT NULL,
  `jenjang_pendidikan` enum('D3','D4','S1','S2','S3') NOT NULL,
  `nama_sekolah_tinggi` varchar(100) NOT NULL,
  `dalam_atau_luar_negeri` enum('dalam negeri','luar negeri') NOT NULL,
  `nama_program_studi` varchar(50) NOT NULL,
  `tahun_masuk` year(4) DEFAULT NULL,
  `tahun_ekspektasi_lulus` year(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sekolah_tinggi_alumni`
--

INSERT INTO `sekolah_tinggi_alumni` (`nomor_induk_siswa_sekolah`, `jenjang_pendidikan`, `nama_sekolah_tinggi`, `dalam_atau_luar_negeri`, `nama_program_studi`, `tahun_masuk`, `tahun_ekspektasi_lulus`) VALUES
('12345', 'S1', 'Universitas ABC', 'dalam negeri', 'Teknik Informatika', '2015', '2019'),
('67890', 'S2', 'Universitas XYZ', 'luar negeri', 'Computer Science', '2017', '2020'),
('24680', 'D4', 'Institut 123', 'dalam negeri', 'Manajemen Bisnis', '2018', '2022'),
('54321', 'D3', 'Politeknik 456', 'dalam negeri', 'Teknik Elektro', '2016', '2019'),
('13579', 'S1', 'Universitas DEF', 'luar negeri', 'Economics', '2019', '2023'),
('98765', 'S3', 'Institut 789', 'dalam negeri', 'Biotechnology', '2014', '2021'),
('11111', 'S1', 'Universitas GHI', 'luar negeri', 'Psychology', '2017', '2021'),
('22222', 'S2', 'Universitas JKL', 'dalam negeri', 'Architecture', '2015', '2018'),
('99999', 'S1', 'Universitas MNO', 'luar negeri', 'Medicine', '2016', '2022'),
('77777', 'S3', 'Institut PQR', 'dalam negeri', 'Information Systems', '2018', '2024');

-- --------------------------------------------------------

--
-- Structure for view `lihat_alumni_yang_sedang_bekerja`
--
DROP TABLE IF EXISTS `lihat_alumni_yang_sedang_bekerja`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lihat_alumni_yang_sedang_bekerja`  AS SELECT `dda`.`nomor_induk_siswa_sekolah` AS `NISK`, `dda`.`nama_lengkap` AS `Nama Lengkap`, `pa`.`nama_pekerjaan` AS `Nama Pekerjaan`, `jp`.`nama_pekerjaan` AS `Jenis Pekerjaan`, `pa`.`jabatan_pekerjaan` AS `Jabatan Pekerjaan`, `pa`.`tempat_bekerja` AS `Tempat Bekerja`, `pa`.`tanggal_mulai_bekerja` AS `Tanggal Mulai Kerja` FROM ((`data_diri_alumni` `dda` join `pekerjaan_alumni` `pa` on(`dda`.`nomor_induk_siswa_sekolah` = `pa`.`nomor_induk_siswa_sekolah`)) join `jenis_pekerjaan` `jp` on(`pa`.`id_jenis_pekerjaan` = `jp`.`id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `lihat_alumni_yang_sedang_kuliah`
--
DROP TABLE IF EXISTS `lihat_alumni_yang_sedang_kuliah`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lihat_alumni_yang_sedang_kuliah`  AS SELECT `dda`.`nomor_induk_siswa_sekolah` AS `NISK`, `dda`.`nama_lengkap` AS `Nama Lengkap`, `sta`.`jenjang_pendidikan` AS `Jenjang Pendidikan`, `sta`.`nama_program_studi` AS `Program Studi`, `sta`.`tahun_masuk` AS `Tahun Masuk` FROM (`data_diri_alumni` `dda` join `sekolah_tinggi_alumni` `sta` on(`dda`.`nomor_induk_siswa_sekolah` = `sta`.`nomor_induk_siswa_sekolah`)) ;

-- --------------------------------------------------------

--
-- Structure for view `lihat_data_diri_alumni_yang_berprestasi_internasional`
--
DROP TABLE IF EXISTS `lihat_data_diri_alumni_yang_berprestasi_internasional`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lihat_data_diri_alumni_yang_berprestasi_internasional`  AS SELECT `dda`.`nomor_induk_siswa_sekolah` AS `NISK`, `dda`.`nama_lengkap` AS `Nama Lengkap`, `rpa`.`nama_lomba` AS `Nama Lomba`, `rpa`.`predikat_prestasi` AS `Predikat Prestasi`, `rpa`.`tanggal_lomba_mulai` AS `Tanggal Mulai`, `rpa`.`tanggal_lomba_selesai` AS `Tanggal Selesai` FROM (`data_diri_alumni` `dda` join `riwayat_prestasi_alumni` `rpa` on(`dda`.`nomor_induk_siswa_sekolah` = `rpa`.`nomor_induk_siswa_sekolah`)) WHERE lcase(`rpa`.`tingkat_prestasi`) = 'internasional' ;

-- --------------------------------------------------------

--
-- Structure for view `lihat_data_diri_alumni_yang_berprestasi_kabupaten`
--
DROP TABLE IF EXISTS `lihat_data_diri_alumni_yang_berprestasi_kabupaten`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lihat_data_diri_alumni_yang_berprestasi_kabupaten`  AS SELECT `dda`.`nomor_induk_siswa_sekolah` AS `NISK`, `dda`.`nama_lengkap` AS `Nama Lengkap`, `rpa`.`nama_lomba` AS `Nama Lomba`, `rpa`.`predikat_prestasi` AS `Predikat Prestasi`, `rpa`.`tanggal_lomba_mulai` AS `Tanggal Mulai`, `rpa`.`tanggal_lomba_selesai` AS `Tanggal Selesai` FROM (`data_diri_alumni` `dda` join `riwayat_prestasi_alumni` `rpa` on(`dda`.`nomor_induk_siswa_sekolah` = `rpa`.`nomor_induk_siswa_sekolah`)) WHERE lcase(`rpa`.`tingkat_prestasi`) = 'kabupaten' ;

-- --------------------------------------------------------

--
-- Structure for view `lihat_data_diri_alumni_yang_berprestasi_nasional`
--
DROP TABLE IF EXISTS `lihat_data_diri_alumni_yang_berprestasi_nasional`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lihat_data_diri_alumni_yang_berprestasi_nasional`  AS SELECT `dda`.`nomor_induk_siswa_sekolah` AS `NISK`, `dda`.`nama_lengkap` AS `Nama Lengkap`, `rpa`.`nama_lomba` AS `Nama Lomba`, `rpa`.`predikat_prestasi` AS `Predikat Prestasi`, `rpa`.`tanggal_lomba_mulai` AS `Tanggal Mulai`, `rpa`.`tanggal_lomba_selesai` AS `Tanggal Selesai` FROM (`data_diri_alumni` `dda` join `riwayat_prestasi_alumni` `rpa` on(`dda`.`nomor_induk_siswa_sekolah` = `rpa`.`nomor_induk_siswa_sekolah`)) WHERE lcase(`rpa`.`tingkat_prestasi`) = 'nasional' ;

-- --------------------------------------------------------

--
-- Structure for view `lihat_data_diri_alumni_yang_berprestasi_provinsi`
--
DROP TABLE IF EXISTS `lihat_data_diri_alumni_yang_berprestasi_provinsi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lihat_data_diri_alumni_yang_berprestasi_provinsi`  AS SELECT `dda`.`nomor_induk_siswa_sekolah` AS `NISK`, `dda`.`nama_lengkap` AS `Nama Lengkap`, `rpa`.`nama_lomba` AS `Nama Lomba`, `rpa`.`predikat_prestasi` AS `Predikat Prestasi`, `rpa`.`tanggal_lomba_mulai` AS `Tanggal Mulai`, `rpa`.`tanggal_lomba_selesai` AS `Tanggal Selesai` FROM (`data_diri_alumni` `dda` join `riwayat_prestasi_alumni` `rpa` on(`dda`.`nomor_induk_siswa_sekolah` = `rpa`.`nomor_induk_siswa_sekolah`)) WHERE lcase(`rpa`.`tingkat_prestasi`) = 'provinsi' ;

-- --------------------------------------------------------

--
-- Structure for view `lihat_data_diri_alumni_yang_ikut_reuni_terakhir_kali`
--
DROP TABLE IF EXISTS `lihat_data_diri_alumni_yang_ikut_reuni_terakhir_kali`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lihat_data_diri_alumni_yang_ikut_reuni_terakhir_kali`  AS SELECT `ra`.`id_reuni` AS `ID Reuni`, `ra`.`tanggal_reuni` AS `Tanggal Reuni`, `ra`.`lokasi_reuni` AS `Lokasi Reuni`, `ra`.`nomor_induk_siswa_sekolah_alumni_yang_ikut` AS `NISK yang Ikut`, `dda`.`nama_lengkap` AS `Nama Lengkap` FROM (`reuni_alumni` `ra` join `data_diri_alumni` `dda` on(`ra`.`nomor_induk_siswa_sekolah_alumni_yang_ikut` = `dda`.`nomor_induk_siswa_sekolah`)) WHERE `ra`.`tanggal_reuni` = (select max(`reuni_alumni`.`tanggal_reuni`) from `reuni_alumni`) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `data_diri_alumni`
--
ALTER TABLE `data_diri_alumni`
  ADD PRIMARY KEY (`nomor_induk_siswa_sekolah`,`nomor_induk_siswa_nasional`);

--
-- Indexes for table `jenis_pekerjaan`
--
ALTER TABLE `jenis_pekerjaan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pekerjaan_alumni`
--
ALTER TABLE `pekerjaan_alumni`
  ADD KEY `id_jenis_pekerjaan` (`id_jenis_pekerjaan`),
  ADD KEY `nomor_induk_siswa_sekolah` (`nomor_induk_siswa_sekolah`);

--
-- Indexes for table `reuni_alumni`
--
ALTER TABLE `reuni_alumni`
  ADD KEY `nomor_induk_siswa_sekolah_alumni_yang_ikut` (`nomor_induk_siswa_sekolah_alumni_yang_ikut`);

--
-- Indexes for table `riwayat_kegiatan_organisasi`
--
ALTER TABLE `riwayat_kegiatan_organisasi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `riwayat_organisasi_alumni`
--
ALTER TABLE `riwayat_organisasi_alumni`
  ADD PRIMARY KEY (`nomor_induk_siswa_sekolah`,`id_kegiatan_organisasi`),
  ADD KEY `id_kegiatan_organisasi` (`id_kegiatan_organisasi`);

--
-- Indexes for table `riwayat_prestasi_alumni`
--
ALTER TABLE `riwayat_prestasi_alumni`
  ADD KEY `nomor_induk_siswa_sekolah` (`nomor_induk_siswa_sekolah`);

--
-- Indexes for table `sekolah_tinggi_alumni`
--
ALTER TABLE `sekolah_tinggi_alumni`
  ADD KEY `nomor_induk_siswa_sekolah` (`nomor_induk_siswa_sekolah`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `riwayat_kegiatan_organisasi`
--
ALTER TABLE `riwayat_kegiatan_organisasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pekerjaan_alumni`
--
ALTER TABLE `pekerjaan_alumni`
  ADD CONSTRAINT `pekerjaan_alumni_ibfk_1` FOREIGN KEY (`id_jenis_pekerjaan`) REFERENCES `jenis_pekerjaan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pekerjaan_alumni_ibfk_2` FOREIGN KEY (`nomor_induk_siswa_sekolah`) REFERENCES `data_diri_alumni` (`nomor_induk_siswa_sekolah`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `reuni_alumni`
--
ALTER TABLE `reuni_alumni`
  ADD CONSTRAINT `reuni_alumni_ibfk_1` FOREIGN KEY (`nomor_induk_siswa_sekolah_alumni_yang_ikut`) REFERENCES `data_diri_alumni` (`nomor_induk_siswa_sekolah`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `riwayat_organisasi_alumni`
--
ALTER TABLE `riwayat_organisasi_alumni`
  ADD CONSTRAINT `riwayat_organisasi_alumni_ibfk_1` FOREIGN KEY (`nomor_induk_siswa_sekolah`) REFERENCES `data_diri_alumni` (`nomor_induk_siswa_sekolah`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `riwayat_organisasi_alumni_ibfk_2` FOREIGN KEY (`id_kegiatan_organisasi`) REFERENCES `riwayat_kegiatan_organisasi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `riwayat_prestasi_alumni`
--
ALTER TABLE `riwayat_prestasi_alumni`
  ADD CONSTRAINT `riwayat_prestasi_alumni_ibfk_1` FOREIGN KEY (`nomor_induk_siswa_sekolah`) REFERENCES `data_diri_alumni` (`nomor_induk_siswa_sekolah`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sekolah_tinggi_alumni`
--
ALTER TABLE `sekolah_tinggi_alumni`
  ADD CONSTRAINT `sekolah_tinggi_alumni_ibfk_1` FOREIGN KEY (`nomor_induk_siswa_sekolah`) REFERENCES `data_diri_alumni` (`nomor_induk_siswa_sekolah`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
