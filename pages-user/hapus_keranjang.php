<?php
session_start();

$id_suku_cadang = $_GET['id'];
unset($_SESSION['cart'][$id_suku_cadang]);

echo "<script>alert('produk dihapus dari keranjang'); </script>";
echo "<script>location='keranjang.php'; </script>";

?>