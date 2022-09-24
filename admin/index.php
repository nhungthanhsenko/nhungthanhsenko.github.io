<?php
	session_start();
	include('../db/connect.php'); 
?>
<?php
	if(isset($_POST['dangnhap'])) {
		$taikhoan = $_POST['taikhoan'];
		$matkhau = md5($_POST['matkhau']);
		if($taikhoan=='' || $matkhau ==''){
			echo '<p>Xin nhập đầy đủ</p>';
		}else{
			$sql_select_admin = mysqli_query($con,"SELECT * FROM tbl_admin WHERE email='$taikhoan' AND password='$matkhau' LIMIT 1");
			$count = mysqli_num_rows($sql_select_admin);
			$row_dangnhap = mysqli_fetch_array($sql_select_admin);
			if($count>0){
				$_SESSION['dangnhap'] = $row_dangnhap['admin_name'];
				$_SESSION['admin_id'] = $row_dangnhap['admin_id'];
				header('Location: dashboard.php');
			}else{
				echo '<p>Tài khoản hoặc mật khẩu sai</p>';
			}
		}
	}
?>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<title>Login Admin</title>
		<link href="admin.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
		<div class="login">
			<h1 class="login-heading">Login Admin</h1>
			<div class="form-group">
				<form action="" method="POST" autocomplete="off">
					<label for="username" class="login-label">Tài Khoản</label>
					<input class="login-input" type="text" id="username" name="taikhoan" placeholder="username" class="form-control"><br>
					<label for="password" class="login-label">Mật Khẩu</label>
					<input class="login-input" type="password" id="password" name="matkhau" placeholder="password" class="form-control"><br>
					<button type="submit" name="dangnhap" class="login-submit">Login</button>
				</form>
			</div>
		</div>
	</body>
</html>