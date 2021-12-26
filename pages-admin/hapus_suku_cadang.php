<?php
include_once('../config/database.php');
if(isset($_GET['id'])){
    $hapus = mysqli_query($mysqli, "DELETE FROM suku_cadang WHERE ID_Suku_Cadang = '".$_GET['id']."'");
}


echo " <script>alert('Data berhasil dihapus!');</script>";
echo " <script>location='suku_cadang.php';</script>";

?>