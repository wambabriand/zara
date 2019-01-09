
<!DOCTYPE html>
<html>
<head>

 <link rel="stylesheet" href="style.css" /> 

</head>
<body > 

	if(!HTTPSCheck()){
		exit();
	}
<?php   
include 'sessions.php' ;
include 'wapper.php';

cookies_java();
if(!HTTPSCheck()){
     exit();
}
t_title("cancel");

create_menu('user.php','user home page','index.php','home');
?>

<div class='main'>

<?php 
	$var='cancel page ';
 	create_header($var);
	
if($_SERVER["REQUEST_METHOD"] == "POST"  &&  isset($_SESSION['book'])){ 

	$conn=connect_db(); 	
	$user=$_SESSION['user'];

	if ($res = mysqli_query($conn, "SELECT * FROM booking WHERE email='$user'")) { 
	 
		$line = mysqli_fetch_array($res, MYSQLI_ASSOC);
		if(empty($line['email'])){ // IF SOMEANE RELOAD THE PAGE AFTER CANCEL 
			$msgErr="<br><br><br><br><br>YOUR BOOKING IS ALREADY CANCEL";
			unset($_SESSION['book']);
		}
		else{			
			if( cancel_booking($line['departure'],$line['arrival'],$user,$conn) ){
				unset($_SESSION['book']); 
				$msgErr="<br><br><br><br><br>CANCEL IS OK";				
			}
			else{
				$msgErr="<br><br><br><br><br>ERROR TRY AFTER";
			}
		}
	}
	mysqli_free_result($res);
	echo $msgErr;
}
else if( !isset($_SESSION['user'])){
	header('Location: login.php');
}
else {
	header('Location: user.php');
}

?>

</div>

</body>
</html>


