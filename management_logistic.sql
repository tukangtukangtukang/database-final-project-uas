-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 10, 2024 at 01:26 PM
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
-- Database: `management_logistic`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `hitung_total_barang` () RETURNS INT(11)  BEGIN
    DECLARE total_barang INT;

    SELECT SUM(stok) INTO total_barang
    FROM barang;

    RETURN total_barang;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `hitung_total_stok_kategori_dan_harga` (`p_kategori` VARCHAR(50), `p_harga` DECIMAL(10,2)) RETURNS INT(11)  BEGIN
    DECLARE total_stok INT;

    SELECT SUM(stok) INTO total_stok
    FROM barang
    WHERE kategori = p_kategori AND harga <= p_harga;

    RETURN total_stok;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id_barang` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `kategori` varchar(50) NOT NULL,
  `harga` decimal(10,2) NOT NULL,
  `stok` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`id_barang`, `nama`, `kategori`, `harga`, `stok`) VALUES
(1, 'Laptop Gaming', 'Elektronik', 8500000.00, 10),
(2, 'Sepatu Nike Air Jordan', 'Fashion', 1200000.00, 20),
(3, 'HP Poco F6', 'Elektronik', 15000000.00, 5),
(4, 'Buku Sejarah', 'Buku', 150000.00, 50),
(5, 'Pemanggang Otomatis', 'Elektronik', 12000000.00, 15);

-- --------------------------------------------------------

--
-- Table structure for table `gudang`
--

CREATE TABLE `gudang` (
  `no_gudang` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `lokasi` varchar(255) NOT NULL,
  `kapasitas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gudang`
--

INSERT INTO `gudang` (`no_gudang`, `nama`, `lokasi`, `kapasitas`) VALUES
(1, 'Gudang Pusat', 'Jakarta', 5000),
(2, 'Gudang Barat', 'Bandung', 3000),
(3, 'Gudang Timur', 'Surabaya', 4000),
(4, 'Gudang Utara', 'Semarang', 3500),
(5, 'Gudang Selatan', 'Yogyakarta', 4500);

-- --------------------------------------------------------

--
-- Table structure for table `kostumer`
--

CREATE TABLE `kostumer` (
  `id_kostumer` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `telepon` varchar(15) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `alamat` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kostumer`
--

INSERT INTO `kostumer` (`id_kostumer`, `nama`, `telepon`, `email`, `alamat`) VALUES
(1, 'Yono', '081234567890', 'yono@gmail.com', 'Jl. Affandi No. 1, Yogyakarta'),
(2, 'Yanti', '081234567891', 'yantigemez@gmail.com', 'Jl. Malioboro No. 5, Yogyakarta'),
(3, 'Subekti', '081234567892', 'subekti@gmail.com', 'Jl. Solo No. 7, Yogyakarta'),
(4, 'Afgan', '081234567893', 'afgan@gmail.com', 'Jl. Ki Hadjar Dewantara No. 9, Yogyakarta'),
(5, 'Eko', '081234567894', 'eko@gmail.com', 'Jl. Babarsari No. 3, Yogyakarta');

-- --------------------------------------------------------

--
-- Table structure for table `kurir`
--

CREATE TABLE `kurir` (
  `id_kurir` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `telepon` varchar(15) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kurir`
--

INSERT INTO `kurir` (`id_kurir`, `nama`, `telepon`, `alamat`, `email`) VALUES
(1, 'Ali Multazam', '081234567890', 'Jl. Merdeka No. 1, Jakarta', 'alimultazam@gmail.com'),
(2, 'Bonaventura Isaac', '081234567891', 'Jl. Sudirman No. 5, Bandung', 'bonaventuraisaac@gmail.com'),
(3, 'Fannes Wahyu Aji', '081234567892', 'Jl. Diponegoro No. 7, Surabaya', 'fannesaji@gmail.com'),
(4, 'Tukang Tukang', '081234567893', 'Jl. Gajah Mada No. 9, Semarang', 'tukangtukang@gmail.com'),
(5, 'Eko Budiman', '081234567894', 'Jl. Malioboro No. 3, Yogyakarta', 'ekobudiman@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `pemesanan`
--

CREATE TABLE `pemesanan` (
  `id_pemesanan` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `tanggal` date NOT NULL,
  `id_kostumer` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pemesanan`
--

INSERT INTO `pemesanan` (`id_pemesanan`, `status`, `tanggal`, `id_kostumer`) VALUES
(1, 'Menunggu Pembayaran', '2024-07-10', 1),
(2, 'Dalam Proses Pengiriman', '2024-07-09', 2),
(3, 'Selesai', '2024-07-08', 3),
(4, 'Menunggu Konfirmasi', '2024-07-07', 4),
(5, 'Dalam Proses', '2024-07-06', 5);

-- --------------------------------------------------------

--
-- Table structure for table `pengiriman`
--

CREATE TABLE `pengiriman` (
  `id_pengiriman` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `tanggal` date NOT NULL,
  `no_gudang` int(11) DEFAULT NULL,
  `id_barang` int(11) DEFAULT NULL,
  `id_kurir` int(11) DEFAULT NULL,
  `id_kostumer` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pengiriman`
--

INSERT INTO `pengiriman` (`id_pengiriman`, `status`, `tanggal`, `no_gudang`, `id_barang`, `id_kurir`, `id_kostumer`) VALUES
(1, 'Sedang Dikirim', '2024-07-10', 1, 1, 1, 1),
(2, 'Selesai', '2024-07-09', 2, 2, 2, 2),
(3, 'Dalam Proses', '2024-07-08', 3, 3, 3, 3),
(4, 'Sedang Dikirim', '2024-07-07', 4, 4, 4, 4),
(5, 'Selesai', '2024-07-06', 5, 5, 5, 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`);

--
-- Indexes for table `gudang`
--
ALTER TABLE `gudang`
  ADD PRIMARY KEY (`no_gudang`);

--
-- Indexes for table `kostumer`
--
ALTER TABLE `kostumer`
  ADD PRIMARY KEY (`id_kostumer`);

--
-- Indexes for table `kurir`
--
ALTER TABLE `kurir`
  ADD PRIMARY KEY (`id_kurir`);

--
-- Indexes for table `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD PRIMARY KEY (`id_pemesanan`),
  ADD KEY `id_kostumer` (`id_kostumer`);

--
-- Indexes for table `pengiriman`
--
ALTER TABLE `pengiriman`
  ADD PRIMARY KEY (`id_pengiriman`),
  ADD KEY `no_gudang` (`no_gudang`),
  ADD KEY `id_barang` (`id_barang`),
  ADD KEY `id_kurir` (`id_kurir`),
  ADD KEY `id_kostumer` (`id_kostumer`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `barang`
--
ALTER TABLE `barang`
  MODIFY `id_barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `gudang`
--
ALTER TABLE `gudang`
  MODIFY `no_gudang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `kostumer`
--
ALTER TABLE `kostumer`
  MODIFY `id_kostumer` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `kurir`
--
ALTER TABLE `kurir`
  MODIFY `id_kurir` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pemesanan`
--
ALTER TABLE `pemesanan`
  MODIFY `id_pemesanan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pengiriman`
--
ALTER TABLE `pengiriman`
  MODIFY `id_pengiriman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD CONSTRAINT `pemesanan_ibfk_1` FOREIGN KEY (`id_kostumer`) REFERENCES `kostumer` (`id_kostumer`);

--
-- Constraints for table `pengiriman`
--
ALTER TABLE `pengiriman`
  ADD CONSTRAINT `pengiriman_ibfk_1` FOREIGN KEY (`no_gudang`) REFERENCES `gudang` (`no_gudang`),
  ADD CONSTRAINT `pengiriman_ibfk_2` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`),
  ADD CONSTRAINT `pengiriman_ibfk_3` FOREIGN KEY (`id_kurir`) REFERENCES `kurir` (`id_kurir`),
  ADD CONSTRAINT `pengiriman_ibfk_4` FOREIGN KEY (`id_kostumer`) REFERENCES `kostumer` (`id_kostumer`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
