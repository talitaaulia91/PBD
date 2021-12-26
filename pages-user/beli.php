<?php
session_start();

if(isset($_GET['id'])){
    if(isset($_SESSION['cart'][$_GET['id']])){
       $id_suku_cadang = $_SESSION['cart'][$_GET['id']]++;
    }else{
       $id_suku_cadang = $_SESSION['cart'][$_GET['id']] = 1;
    }
}



echo "<script>alert('Produk dimasukkan ke keranjang!');</script>";
echo "<script>location='keranjang.php';</script>";

?>