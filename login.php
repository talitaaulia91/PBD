<?php 
session_start();
 
include ('./config/database.php');

 
if (isset($_POST['login'])) {
	$username = $_POST['username'];
	$password = (($_POST['password']));

	$cek = mysqli_query($mysqli, "SELECT * FROM user WHERE 
								  username = '" . $username . "' 
								  AND password = '" . $password . "'");
	if (mysqli_num_rows($cek) > 0) {
		$user = mysqli_fetch_assoc($cek);

		$_SESSION['user_logged'] = true;
		$_SESSION['user_id'] = $user['Id'];
		$_SESSION['user_name'] = $user['username'];
		$_SESSION['user_email'] = $user['email'];
		$_SESSION['user_role'] = $user['role'];

		if ($user['role'] == 'User') {
			header('location:./pages-user/suku_cadang.php');
		} elseif ($user['role'] == 'admin') {
			header('location:./pages-admin/dashboard.php');
		}		
	} else {
		echo "<script> alert('Username atau password salah!'); </script>";
		echo "<script> location='sign-in.php'; </script>";
	}
}
?>