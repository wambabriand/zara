<!DOCTYPE html>
<?php


  	session_start();
	if(!isset($_SESSION['time'])){
		$_SESSION['time']=time();       // set or create 
	}
	else if(isset($_SESSION['user'])){
	$t=time();
	$diff=0;
	$new=false;
	if (isset($_SESSION['time'])){
	    $t0=$_SESSION['time'];
	    $diff=($t-$t0);  // inactivity period
	} else {
	    $new=true;
	}

	if ($new || ($diff > 120)) { // new or with inactivity period too long 
   
	    $_SESSION=array();  // is better void array to session_unset();  Deprecated

    // If it's desired to kill the session, also delete the session cookie.
    // Note: This will destroy the session, and not just the session data!
	if (ini_get("session.use_cookies")) {
	            $params = session_get_cookie_params();
	            setcookie(session_name(), '', time() - 3600*24,
	            $params["path"], $params["domain"],
	            $params["secure"], $params["httponly"]
          );
    	}
    	session_destroy();  // destroy session
    	
    	header('HTTP/1.1 307 temporary redirect');
    	header('Location: login.php?msg=SessionTimeOut');
    		exit; // IMPORTANT to avoid further output from the script
	}
	 else {
	    	$_SESSION['time']=time(); /* update time */	   
		header('Location: user.php');
	}
}

?>




<html>
<head>
	
 <link rel="stylesheet" href="style.css" /> 

</head>
<body>  

<?php  
	include 'wapper.php'; 
	cookies_java();
	if(!HTTPSCheck()){
		exit();
	}
	t_title("login");
	create_menu('index.php','home','registration.php','registration');
	$conn=connect_db();
?>


<div class='main' > 

<?php

$passwordErr = $emailErr=$msgErr= "";
$password = $email= "";
$flag=1;


if ($_SERVER["REQUEST_METHOD"] == "POST") {
	if( empty($_POST["password"])) {
		$passwordErr = "password is required";
		$flag=0;
	}
	 else {
    		$password = test_input($_POST["password"]);
  	}
  
  	if( empty($_POST["email"])) {
		$emailErr = "Email is required";
		$flag=0;
	} 
	else {
    		$email = test_input($_POST["email"]);
    	}
  
	if($flag==1){
		
		if ($res = mysqli_query($conn, "SELECT email,password FROM user WHERE email='$email' and password='$password'")) { 
			
			if(mysqli_num_rows($res)==1){
				$flag=2;
			}
			else {
				$msgErr="wrong data inserted";
			}
			mysqli_free_result($res); // free buffer 
		}

		if($flag==2){
			$_SESSION['user']=$email; 
			header('Location: user.php');
		}
  	}
}
  

 	$var=' login page';
	create_header($var);
?>

	<form id="connection" method="post" action="login.php">  
		<span class="error"> <?php echo $msgErr;?></span><br>
		E-mail: <input type="text" name="email" placeholder="u0@p.it" >
		<span class="error"> <?php echo $emailErr;?></span>
		<br><br>
		password: <input type="password" name="password" placeholder="p1 or pA" >
		<span class="error"> <?php echo $passwordErr;?></span>
		<br><br>
		<input class="sub" type="submit" name="submit" value="Submit">  
	</form>


<p >   your email should be like USER@DOMAIN and password must containt at least 1 ( digit o UPPERCASE LETTER) and 1 LOWERCASE LETTER</p>
<p > s251095  </p>

  </div>


</body>
