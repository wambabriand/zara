<!DOCTYPE html>

<html>
<head>

 <link rel="stylesheet" href="style.css" /> 

</head>
<body>  

<?php
	include 'sessions.php' ;
	include 'wapper.php' ;

	cookies_java();
	if(!HTTPSCheck()){
		exit();
	}
	t_title("booking");
	come_from_a_user();
	create_menu('user.php','user home page','index.php','home');	
	$conn=connect_db(); 
?>
<div class='main' >

<?php

 	$var=' booking  page : '.$_SESSION['user'];
	create_header($var);
	reload_booking();

	if(  $_SERVER["REQUEST_METHOD"] == "POST" && isset($_SESSION["nocheck"])  && !isset($_SESSION['book'])  ){
		unset($_SESSION["nocheck"]);
	 	form_for_booking($conn);
		$_SESSION["check"]=1;
		
	}
	else if($_SERVER["REQUEST_METHOD"] == "POST"  && isset($_SESSION["check"] ) && !isset($_SESSION['book'])  ){		  
		booking($conn);
		if(!isset($_SESSION['book'])){ 
			form_for_booking($conn);
		}
		else{
		 	unset($_SESSION["check"]);
		}
	}
	else if( isset($_SESSION['book'])) {
		header('Location: user.php'); // je pouvais decider de fermer la session et le renvoyer sur une autre page
	}
	else if( !isset($_SESSION['book'])) {
		header('Location: login.php'); // je pouvais decider de fermer la session et le renvoyer sur une autre page
	}
	

?>

</div>

</body>
</html>
