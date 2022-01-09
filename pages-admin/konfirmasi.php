<?php

session_start();
include_once ('../config/database.php');

$confirm = mysqli_query($mysqli, "UPDATE pembayaran SET status='1' WHERE id_pembayaran='".$_GET['id']."'");

if($confirm){
    echo "<script> alert('konfirmasi berhasil!'); </script>";
    echo "<script> location='pembayaran.php'; </script>";
}else{
    echo "<script> alert('konfirmasi gagal!'); </script>";
    echo "<script> location='pembayaran.php'; </script>";
}
?>