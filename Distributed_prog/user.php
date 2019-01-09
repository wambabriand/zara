<!DOCTYPE html>

<?php   
	include 'sessions.php' ;
	include 'wapper.php';
	
	if(!HTTPSCheck()){
		exit();
	}
	
	$conn=connect_db();
	come_from_a_user();
	$user=$_SESSION['user'];
	if ($res = mysqli_query($conn, "SELECT email FROM booking WHERE email='$user'")) { 
		if(mysqli_num_rows($res)==1 ){
			$_SESSION['book']=1;
		}
	}
	else unset($_SESSION['book']); 
	t_title($user);
	mysqli_free_result($res);
?>

<html>
<head>

 <link rel="stylesheet" href="style.css" /> 

</head>
<body>  

<?php
	cookies_java();
	$conn=connect_db();
	create_menu('logout.php','logout','index.php','home');
?>
<div class='main'>

<?php
        $var='welcome to your home page : '.$_SESSION['user'];
		create_header($var);
        echo '<h2>segments:</h2>';
?>
</div>
<div class='user'>
<?php		
		$cmd=1;  
		liste_of_segment($conn,$cmd) ;
?>
</div>
<div class='main'>
<?php 
	echo '<h2>locations:</h2>';
        	$cmd=1; 
		liste_of_destiantion($conn,$cmd);

		booking_or_cancel_booking($conn);
					
?>
<br><br><br>
<p > s251095  </p>

</div>


</body>
</html>
