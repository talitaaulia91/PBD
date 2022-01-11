-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 11, 2022 at 06:25 PM
-- Server version: 10.4.16-MariaDB
-- PHP Version: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bengkel`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `total` (`id` VARCHAR(7)) RETURNS INT(11) BEGIN
DECLARE hitung INT;
SELECT SUM(sc.Harga_Satuan * dn.Banyak) INTO hitung
FROM detail_nota_suku_cadang dn, suku_cadang sc
WHERE sc.ID_Suku_Cadang = dn.ID_Suku_Cadang
	AND dn.No_Nota_Suku_Cadang = id;
RETURN hitung;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `billing`
-- (See below for the actual view)
--
CREATE TABLE `billing` (
`id_pkb` varchar(5)
,`nama_pemilik` varchar(30)
,`no_stnk` varchar(10)
,`tgl_beli` date
,`total_harga` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `detail_nota_suku_cadang`
--

CREATE TABLE `detail_nota_suku_cadang` (
  `No_Nota_Suku_Cadang` varchar(7) NOT NULL,
  `ID_Suku_Cadang` varchar(20) NOT NULL,
  `Banyak` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `detail_nota_suku_cadang`
--

INSERT INTO `detail_nota_suku_cadang` (`No_Nota_Suku_Cadang`, `ID_Suku_Cadang`, `Banyak`) VALUES
('NSC0001', '06430KFL001', 1),
('NSC0002', '06430KFL001', 1),
('NSC0003', '06430KFL002', 1),
('NSC0004', '06430KFL004', 1),
('NSC0005', '06430KFL007', 1),
('NSC0006', '06430KFL003', 1),
('NSC0006', '06430KFL010', 1),
('NSC0007', '06430KFL001', 2),
('NSC0008', '06430KFL008', 1),
('NSC0009', '06430KFL001', 1),
('NSC0009', '06430KFL012', 1),
('NSC0010', '06430KFL001', 1);

--
-- Triggers `detail_nota_suku_cadang`
--
DELIMITER $$
CREATE TRIGGER `after_insert_pembelian` AFTER INSERT ON `detail_nota_suku_cadang` FOR EACH ROW BEGIN 
UPDATE suku_cadang 
SET stok=stok-new.banyak 
WHERE id_suku_cadang = new.id_suku_cadang; 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `jabatan`
--

CREATE TABLE `jabatan` (
  `ID_Jabatan` char(1) NOT NULL,
  `Nama_Jabatan` varchar(20) NOT NULL,
  `Gaji_Pokok` int(11) NOT NULL,
  `Tunjangan` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `jabatan`
--

INSERT INTO `jabatan` (`ID_Jabatan`, `Nama_Jabatan`, `Gaji_Pokok`, `Tunjangan`) VALUES
('1', 'Branch Head', 6000000, 100000),
('2', 'Workshop Head', 5000000, 100000),
('3', 'Service Instructor', 4000000, NULL),
('4', 'Service Advisor', 3700000, NULL),
('5', 'Mekanik', 2000000, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `kendaraan`
--

CREATE TABLE `kendaraan` (
  `NO_STNK` varchar(10) NOT NULL,
  `ID_Pemilik` varchar(6) NOT NULL,
  `ID_Tipe` char(4) NOT NULL,
  `No_Mesin` varchar(14) NOT NULL,
  `No_Rangka` varchar(18) NOT NULL,
  `Tahun` int(11) NOT NULL,
  `Warna` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kendaraan`
--

INSERT INTO `kendaraan` (`NO_STNK`, `ID_Pemilik`, `ID_Tipe`, `No_Mesin`, `No_Rangka`, `Tahun`, `Warna`) VALUES
('AA-1352-ZL', 'CUS001', '00A1', 'BJ1234567', 'JJH123000', 2019, 'putih'),
('AG-1010-HA', 'CUS020', '00A1', 'BJ1234567', 'JJH123000', 2019, 'putih'),
('AG-3849-HW', 'CUS001', '00A1', 'BJ1234567', 'JJH123000', 2019, 'putih'),
('B-2827-A', 'CUS020', '00A2', 'BJ1234567', 'JJH123000', 2019, 'hitam'),
('J-1234-KK', '001245', '00B2', 'NJ1234568', 'JI0876545', 2005, 'Polkadot'),
('J-1234-KL', '001247', '00B3', 'NJ7775', '53543535', 2021, 'hutam'),
('L-1979-AA', '001244', '00A1', 'NJ1234567', 'JI0876543', 2021, 'Hitam');

-- --------------------------------------------------------

--
-- Table structure for table `nota_suku_cadang`
--

CREATE TABLE `nota_suku_cadang` (
  `No_Nota_Suku_Cadang` varchar(7) NOT NULL,
  `Tgl_Nota_Suku_Cadang` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `nota_suku_cadang`
--

INSERT INTO `nota_suku_cadang` (`No_Nota_Suku_Cadang`, `Tgl_Nota_Suku_Cadang`) VALUES
('NSC0001', '2022-01-09'),
('NSC0002', '2022-01-09'),
('NSC0003', '2022-01-09'),
('NSC0004', '2022-01-09'),
('NSC0005', '2022-01-10'),
('NSC0006', '2022-01-10'),
('NSC0007', '2022-01-11'),
('NSC0008', '2022-01-11'),
('NSC0009', '2022-01-11'),
('NSC0010', '2022-01-11');

--
-- Triggers `nota_suku_cadang`
--
DELIMITER $$
CREATE TRIGGER `before_insert_nsc` BEFORE INSERT ON `nota_suku_cadang` FOR EACH ROW BEGIN
	SET NEW.no_nota_suku_cadang = CONCAT('NSC',LPAD((
	IFNULL((SELECT CAST(SUBSTR(no_nota_suku_cadang,4,4)AS INT) 
	FROM nota_suku_cadang
	ORDER BY no_nota_suku_cadang DESC 
	LIMIT 1),0)+1),4,"0"));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pegawai`
--

CREATE TABLE `pegawai` (
  `ID_Pegawai` varchar(6) NOT NULL,
  `ID_Jabatan` char(1) NOT NULL,
  `Nama_Pegawai` varchar(30) NOT NULL,
  `Email` varchar(30) NOT NULL,
  `Kata_Sandi` varchar(32) NOT NULL,
  `Alamat_Pegawai` varchar(30) NOT NULL,
  `Tlp_Pegawai` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pegawai`
--

INSERT INTO `pegawai` (`ID_Pegawai`, `ID_Jabatan`, `Nama_Pegawai`, `Email`, `Kata_Sandi`, `Alamat_Pegawai`, `Tlp_Pegawai`) VALUES
('1221', '3', 'Nadya Lovita Sari', 'nadya@gmail.com', '12345678', 'Jl. Pattimura No.77, Kediri', '085678966544'),
('1222', '2', 'Afifah Aghnia Mumtaz', 'tasya@gmail.com', '12345678', 'Jl. Flores Raya No.34, Gresik', '085789987888'),
('1223', '5', 'Muhammad Raihan Pradana', 'raihan@gmail.com', '12345678', 'Jl. Sukolilo No.05, Surabaya', '085234432111'),
('1224', '1', 'Hamimma Talita Aulia', 'lia@gmail.com', '12345678', 'Jl. PK Bangsa No.22, Kediri', '085567765456'),
('1225', '4', 'Pascallis Henoch Herutomo', 'pascal@gmail.com', '12345678', 'Jl. Manyar No.12, Surabaya', '085098876678'),
('1226', '4', 'Aryo Pandu Dwi Anggoro', 'pandu@gmail.com', '12345678', 'Jl. PK Bangsa No.08, Kediri', '085098897006'),
('1227', '3', 'Savilla Tifania Mahadewi', 'fania@gmail.com', '12345678', 'Jl. Pattimura No.01, Kediri', '085098890998'),
('1228', '5', 'Fariz Rahman', 'fariz@gmail.com', '12345678', 'Jl. Sukolilo No.89, Surabaya', '085456654006'),
('1229', '5', 'Made Baihaqi Aji Kumuda', 'baihaqi@gmail.com', '12345678', 'Jl. Pattimura No.161, Kediri', '085345369664'),
('1230', '5', 'Hasbi Zulfan Abrori', 'hassbi@gmail.com', '12345678', 'Jl. Flores Raya No.28, Gresik', '085478876997');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_pembayaran` varchar(5) NOT NULL,
  `id_pkb` varchar(5) NOT NULL,
  `tgl_pembayaran` date NOT NULL,
  `total_harga` int(11) NOT NULL,
  `bukti` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`id_pembayaran`, `id_pkb`, `tgl_pembayaran`, `total_harga`, `bukti`, `status`) VALUES
('B0001', 'PK001', '2022-01-09', 62000, '152011513045.jfif', 0),
('B0002', 'PK002', '2022-01-09', 54000, '152011513050.jfif', 0),
('B0003', 'PK003', '2022-01-09', 41000, 'WhatsApp Image 2021-12-22 at 5.35.10 PM.jpeg', 0),
('B0004', 'PK004', '2022-01-10', 425000, 'wkwk-01.png', 0),
('B0005', 'PK005', '2022-01-10', 247000, '22.jpg', 0),
('B0006', 'PK006', '2022-01-11', 124000, '22.jpg', 0),
('B0007', 'PK007', '2022-01-11', 48000, '3.jpg', 0),
('B0008', 'PK008', '2022-01-11', 692000, '33.jpg', 0);

--
-- Triggers `pembayaran`
--
DELIMITER $$
CREATE TRIGGER `before_insert_pembayaran` BEFORE INSERT ON `pembayaran` FOR EACH ROW BEGIN
	SET NEW.id_pembayaran = CONCAT('B',LPAD((
	IFNULL((SELECT CAST(SUBSTR(id_pembayaran,2,4)AS INT) 
	FROM pembayaran
	ORDER BY id_pembayaran DESC 
	LIMIT 1),0)+1),4,"0"));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `pembelian`
-- (See below for the actual view)
--
CREATE TABLE `pembelian` (
`id_pkb` varchar(5)
,`no_nota_suku_cadang` varchar(7)
,`nama_pemilik` varchar(30)
,`Email` varchar(30)
,`no_stnk` varchar(10)
,`tgl_beli` date
);

-- --------------------------------------------------------

--
-- Table structure for table `pemilik`
--

CREATE TABLE `pemilik` (
  `ID_Pemilik` varchar(6) NOT NULL,
  `Nama_Pemilik` varchar(30) NOT NULL,
  `Email` varchar(30) NOT NULL,
  `Alamat_Pemilik` varchar(30) NOT NULL,
  `Telp_Pemilik` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pemilik`
--

INSERT INTO `pemilik` (`ID_Pemilik`, `Nama_Pemilik`, `Email`, `Alamat_Pemilik`, `Telp_Pemilik`) VALUES
('CUS001', 'Bintang Achmad Mudzakie', 'bintang@gmail.com', 'Jl. Joyoboyo No.89, Kediri', '085706568677'),
('CUS002', 'Zulfa Lutfiah', 'zulfa@gmail.com', 'Perum Wisma Asri No.12 B', '085098890777'),
('CUS003', 'Finndy Noverita Syafitri', 'finndy@gmail.com', 'Perum Doko Sragi No.31 F', '085123654332'),
('CUS004', 'Putri Anindyah Azis', 'anin@gmail.com', 'Jl. PK Bangsa No.28', '085321234665'),
('CUS005', 'Arviolla Rohman Fatikhah', 'arviolla@gmail.com', 'Jl. Dharmawangsa No.11', '08532467890'),
('CUS006', 'Muhammad Nabil Alif', 'nabil@gmail.com', 'Jl. PK Bangsa No.03', '085543212344'),
('CUS007', 'Farah Salsabila Mumtaz', 'farah@gmail.com', 'Jl. Pattimura No.20', '085098004231'),
('CUS008', 'Muhammad Iqbal Krisna', 'iqbal@gmail.com', 'Jl. Karang Menjangan No.30 A', '085123456765'),
('CUS009', 'Herrys Aghista Rachman', 'herrys@gmail.com', 'Jl. Perum Doko Sragi No.20 F', '085234432345'),
('CUS010', 'Agiftsany Azhar', 'agif@gmail.com', 'Jl. Sumatra Jaya No.20', '085234432112'),
('CUS011', 'Luthfiyah Nur Arofah', 'luthfiyah@gmail.com', 'Jl. Sumatra Jaya No.20', '085678987677'),
('CUS012', 'Muhammad Faishal Hafizh', 'ishal@gmail.com', 'Jl. Kalimantan Indah No.10', '085898789009'),
('CUS013', 'Novira Damayanti Rahma', 'novira@gmail.com', 'Jl. Sumatra Jaya No.20', '085797677688'),
('CUS014', 'Adhiba Alya Firdaus', 'adhiba@gmail.com', 'Jl. Joyoboyo No.01', '0851567847'),
('CUS015', 'Ilham Dwi Kurniawan', 'ilham@gmail.com', 'Jl. Sumatra Jaya No.34', '085987789900'),
('CUS016', 'Khodijah Aulia Rahma', 'khodijah@gmail.com', 'Jl. Joyoboyo Timur No.22', '085123321334'),
('CUS017', 'Bayu Kharismulloh', 'bayu@gmail.com', 'Jl. Riau Asri No.13', '085234456780'),
('CUS018', 'Dea Oktavia', 'dea@gmail.com', 'Jl. Karang Menjangan No.28', '085789098764'),
('CUS019', 'Muhammad Faisal Maulana', 'faisal@gmail.com', 'Jl. Airlangga No.40', '085234654456'),
('CUS020', 'Annisa Aristawati', 'annisa@gmail.com', 'Jl. Kalimantan Indah No.28', '08523465444');

--
-- Triggers `pemilik`
--
DELIMITER $$
CREATE TRIGGER `before_insert_pemilik` BEFORE INSERT ON `pemilik` FOR EACH ROW BEGIN
	SET NEW.id_pemilik = CONCAT('CUS',LPAD((
	IFNULL((SELECT CAST(SUBSTR(id_pemilik,4,3)AS INT) 
	FROM pemilik 
	ORDER BY id_pemilik DESC 
	LIMIT 1),0)+1),3,"0"));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pkb`
--

CREATE TABLE `pkb` (
  `ID_PKB` varchar(5) NOT NULL,
  `NO_STNK` varchar(10) NOT NULL,
  `No_Nota_Suku_Cadang` varchar(7) NOT NULL,
  `Tgl_beli` date NOT NULL,
  `Jam_beli` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pkb`
--

INSERT INTO `pkb` (`ID_PKB`, `NO_STNK`, `No_Nota_Suku_Cadang`, `Tgl_beli`, `Jam_beli`) VALUES
('PK001', 'AA-1352-ZL', 'NSC0002', '2022-01-09', '21:14:45'),
('PK002', 'AG-3849-HW', 'NSC0003', '2022-01-09', '21:15:15'),
('PK003', 'AA-1352-ZL', 'NSC0004', '2022-01-09', '21:47:27'),
('PK004', 'AA-1352-ZL', 'NSC0005', '2022-01-10', '14:40:23'),
('PK005', 'AA-1352-ZL', 'NSC0006', '2022-01-10', '14:47:37'),
('PK006', 'AG-1010-HA', 'NSC0007', '2022-01-11', '10:45:26'),
('PK007', 'B-2827-A', 'NSC0008', '2022-01-11', '10:55:35'),
('PK008', 'AA-1352-ZL', 'NSC0009', '2022-01-11', '22:17:02'),
('PK009', 'AA-1352-ZL', 'NSC0010', '2022-01-11', '23:16:49');

--
-- Triggers `pkb`
--
DELIMITER $$
CREATE TRIGGER `before_insert_pkb` BEFORE INSERT ON `pkb` FOR EACH ROW BEGIN
	SET NEW.id_pkb = CONCAT('PK',LPAD((
	IFNULL((SELECT CAST(SUBSTR(id_pkb,3,3)AS INT) 
	FROM pkb
	ORDER BY id_pkb DESC 
	LIMIT 1),0)+1),3,"0"));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `suku_cadang`
--

CREATE TABLE `suku_cadang` (
  `ID_Suku_Cadang` varchar(20) NOT NULL,
  `Nama_Suku_cadang` varchar(30) NOT NULL,
  `Harga_Satuan` int(11) NOT NULL,
  `stok` int(11) NOT NULL,
  `gambar` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `suku_cadang`
--

INSERT INTO `suku_cadang` (`ID_Suku_Cadang`, `Nama_Suku_cadang`, `Harga_Satuan`, `stok`, `gambar`) VALUES
('06430KFL001', 'GASKET KIT A', 62000, 96, 'GASKET KIT A.jpg'),
('06430KFL002', 'GASKET KIT B', 54000, 99, 'GASKET KIT B.jpg'),
('06430KFL003', 'DAMPER SET, WHEEL', 22000, 99, 'DAMPER SET,WHEEL.jpg'),
('06430KFL004', 'SPOKE SET REAR C', 41000, 98, 'SPOKE SET REAR C.jpg'),
('06430KFL005', 'SHOE SET, BRAKE', 54300, 100, 'SHOE SET, BRAKE.jpg'),
('06430KFL006', 'FILTER OLI', 27000, 100, 'FILTER OLI.jpg'),
('06430KFL007', 'KOPLING SET DISC', 425000, 99, 'KOPLING SET DISC.jpg'),
('06430KFL008', 'BELT FAN AC', 48000, 96, 'BELT FAN AC.jpg'),
('06430KFL009', 'VTEC BUSI', 16000, 96, 'VTEC BUSI.jpg'),
('06430KFL010', 'FILTER BENSIN', 225000, 99, 'FILTER BENSIN.jpg'),
('06430KFL011', 'PACKING DRAIN ', 4000, 93, 'PACKING DRAIN.jpg'),
('06430KFL012', 'KAMPAS REM DEPAN', 630000, 100, 'KAMPAS REM DEPAN.jpg');

--
-- Triggers `suku_cadang`
--
DELIMITER $$
CREATE TRIGGER `before_insert_sc` BEFORE INSERT ON `suku_cadang` FOR EACH ROW BEGIN
	SET NEW.id_suku_cadang = CONCAT('06430KFL',LPAD((
	IFNULL((SELECT CAST(SUBSTR(id_suku_cadang,9,3)AS INT) 
	FROM suku_cadang
	ORDER BY id_suku_cadang DESC 
	LIMIT 1),0)+1),3,"0"));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tipe_kendaraan`
--

CREATE TABLE `tipe_kendaraan` (
  `ID_tipe` char(4) NOT NULL,
  `nama_tipe` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tipe_kendaraan`
--

INSERT INTO `tipe_kendaraan` (`ID_tipe`, `nama_tipe`) VALUES
('00A1', 'Suv'),
('00A2', 'Convertible'),
('00A3', 'Coupe'),
('00A4', 'Sedan'),
('00B1', 'Sportbike'),
('00B2', 'Cruiser'),
('00B3', 'Cub'),
('00B4', 'skuter'),
('00B5', 'Matic');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `Id` int(6) NOT NULL,
  `username` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(32) NOT NULL,
  `role` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`Id`, `username`, `email`, `password`, `role`) VALUES
(1, 'lia', 'lia@gmail.com', '123', 'admin'),
(32, 'Bintang', 'bintang@gmail.com', '123', 'User'),
(33, 'anin', 'anin@gmail.com', '123', 'User'),
(34, 'tasya', 'tasya@gmail.com', '123', 'User'),
(35, 'pandu', 'pandu@gmail.com', '123', 'User'),
(36, 'annisa', 'annisa@gmail.com', '12345', 'User');

-- --------------------------------------------------------

--
-- Structure for view `billing`
--
DROP TABLE IF EXISTS `billing`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `billing`  AS SELECT `pkb`.`ID_PKB` AS `id_pkb`, `pem`.`Nama_Pemilik` AS `nama_pemilik`, `ken`.`NO_STNK` AS `no_stnk`, `pkb`.`Tgl_beli` AS `tgl_beli`, `byr`.`total_harga` AS `total_harga` FROM (((`pkb` join `kendaraan` `ken` on(`pkb`.`NO_STNK` = `ken`.`NO_STNK`)) join `pemilik` `pem` on(`pem`.`ID_Pemilik` = `ken`.`ID_Pemilik`)) join `pembayaran` `byr` on(`byr`.`id_pkb` = `pkb`.`ID_PKB`)) ;

-- --------------------------------------------------------

--
-- Structure for view `pembelian`
--
DROP TABLE IF EXISTS `pembelian`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pembelian`  AS SELECT `pkb`.`ID_PKB` AS `id_pkb`, `nsc`.`No_Nota_Suku_Cadang` AS `no_nota_suku_cadang`, `pem`.`Nama_Pemilik` AS `nama_pemilik`, `pem`.`Email` AS `Email`, `ken`.`NO_STNK` AS `no_stnk`, `pkb`.`Tgl_beli` AS `tgl_beli` FROM (((`pkb` join `nota_suku_cadang` `nsc` on(`pkb`.`No_Nota_Suku_Cadang` = `nsc`.`No_Nota_Suku_Cadang`)) join `kendaraan` `ken` on(`pkb`.`NO_STNK` = `ken`.`NO_STNK`)) join `pemilik` `pem` on(`pem`.`ID_Pemilik` = `ken`.`ID_Pemilik`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail_nota_suku_cadang`
--
ALTER TABLE `detail_nota_suku_cadang`
  ADD PRIMARY KEY (`No_Nota_Suku_Cadang`,`ID_Suku_Cadang`),
  ADD KEY `dnsc_IDSC_fk` (`ID_Suku_Cadang`);

--
-- Indexes for table `jabatan`
--
ALTER TABLE `jabatan`
  ADD PRIMARY KEY (`ID_Jabatan`);

--
-- Indexes for table `kendaraan`
--
ALTER TABLE `kendaraan`
  ADD PRIMARY KEY (`NO_STNK`),
  ADD KEY `kndr_IDPemilik_fk` (`ID_Pemilik`),
  ADD KEY `kndr_IDTipe_fk` (`ID_Tipe`);

--
-- Indexes for table `nota_suku_cadang`
--
ALTER TABLE `nota_suku_cadang`
  ADD PRIMARY KEY (`No_Nota_Suku_Cadang`);

--
-- Indexes for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD PRIMARY KEY (`ID_Pegawai`),
  ADD KEY `pgw_ID_fk` (`ID_Jabatan`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id_pembayaran`),
  ADD KEY `pembayaran_pkb_fk` (`id_pkb`);

--
-- Indexes for table `pemilik`
--
ALTER TABLE `pemilik`
  ADD PRIMARY KEY (`ID_Pemilik`);

--
-- Indexes for table `pkb`
--
ALTER TABLE `pkb`
  ADD PRIMARY KEY (`ID_PKB`),
  ADD KEY `pkb_NOSTNK_fk` (`NO_STNK`),
  ADD KEY `pkb_NoNotaSukuCadang_fk` (`No_Nota_Suku_Cadang`);

--
-- Indexes for table `suku_cadang`
--
ALTER TABLE `suku_cadang`
  ADD PRIMARY KEY (`ID_Suku_Cadang`);

--
-- Indexes for table `tipe_kendaraan`
--
ALTER TABLE `tipe_kendaraan`
  ADD PRIMARY KEY (`ID_tipe`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`Id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `Id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_nota_suku_cadang`
--
ALTER TABLE `detail_nota_suku_cadang`
  ADD CONSTRAINT `nsc_fk` FOREIGN KEY (`No_Nota_Suku_Cadang`) REFERENCES `nota_suku_cadang` (`No_Nota_Suku_Cadang`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sc_fk` FOREIGN KEY (`ID_Suku_Cadang`) REFERENCES `suku_cadang` (`ID_Suku_Cadang`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kendaraan`
--
ALTER TABLE `kendaraan`
  ADD CONSTRAINT `kndr_IDPemilik_fk` FOREIGN KEY (`ID_Pemilik`) REFERENCES `pemilik` (`ID_Pemilik`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kndr_IDTipe_fk` FOREIGN KEY (`ID_Tipe`) REFERENCES `tipe_kendaraan` (`ID_tipe`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD CONSTRAINT `pgw_ID_fk` FOREIGN KEY (`ID_Jabatan`) REFERENCES `jabatan` (`ID_Jabatan`);

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_pkb_fk` FOREIGN KEY (`id_pkb`) REFERENCES `pkb` (`ID_PKB`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pkb`
--
ALTER TABLE `pkb`
  ADD CONSTRAINT `pkb_NOSTNK_fk` FOREIGN KEY (`NO_STNK`) REFERENCES `kendaraan` (`NO_STNK`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pkb_NoNotaSukuCadang_fk` FOREIGN KEY (`No_Nota_Suku_Cadang`) REFERENCES `nota_suku_cadang` (`No_Nota_Suku_Cadang`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
