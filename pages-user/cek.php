<?php
include_once('../config/database.php');

$no_nota     = mysqli_query($mysqli,"SELECT No_Nota_Suku_Cadang FROM nota_suku_cadang
                                     ORDER BY No_Nota_Suku_Cadang DESC LIMIT 1");
$row_nota    = $no_nota->fetch_array();
$no_nota_sc  = $row_nota['No_Nota_Suku_Cadang'];

echo $no_nota_sc;

$tes = mysqli_query($mysqli, "SELECT total($no_nota_sc)");

echo $tes;


?>