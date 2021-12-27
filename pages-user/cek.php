<?php
session_start();
include_once('../config/database.php');


    $pemilik = mysqli_query($mysqli, "SELECT * FROM pemilik WHERE Email = '".$_SESSION['user_email']."'");
	$cek = mysqli_num_rows($pemilik);

	if($cek > 0){
			header('location:form_kendaraan.php');
	}else{
		    header('location: form_pemilik.php');
	}






?>