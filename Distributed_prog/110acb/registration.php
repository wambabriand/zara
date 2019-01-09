<!DOCTYPE html>
<html>
<head>

 <link rel="stylesheet" href="style.css" /> 

</head>
<body>  

<?php   //include 'sessions.php' ;
	include 'wapper.php'; 
	cookies_java();
	if(!HTTPSCheck()){
		exit();
	}
	t_title("registration");
	create_menu('login.php','login','index.php','home');
?>


<div class='container' >


<div class='main'>


<?php


        $var='registration page enjoy our site ';
 	create_header($var);
	
// define variables and set to empty values
$passwordErr = $emailErr=$passwordErrc = "";
$password =$passwordc= $email = "";
$flag=1;
$msgErr="";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
	
	//e-mail management
  	if (empty($_POST["email"])) {
   		 $emailErr = "Email is required";
		 $flag=0;
  	} 
	else {
	    	$email = test_input($_POST["email"]);
    // check if e-mail address is well-formed
	    	if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
	    		  $emailErr = "Invalid email format"; 
			  $flag=0;
	    	}
	  }
	//password management
  	if (empty($_POST["password1"])) {
    		$passwordErr = "password is required";
		$flag=0;
  	} else {
    		$password = test_input($_POST["password1"]);
	
		if(!preg_match("#[A-Z0-9]+#",$password)) {
       			 $passwordErr = "Your Password Must Contain At Least 1 Capital Letter or a digit!";
			 $flag=0;
    		}
    		else if(!preg_match("#[a-z]+#",$password)) {
        		$passwordErr = "Your Password Must Contain At Least 1 Lowercase Letter!";
			$flag=0;
    		}
  	}	
  
	  if (empty($_POST["password2"])) {
		$passwordErrc= "password is required";
		$flag=0;
	  } else {
    		$passwordc = test_input($_POST["password2"]);
		if(strcmp($password,$passwordc)!=0){
	  		$msgErr= "the two password are differnt!";
			$flag=0;
		  }
	  }
  	$insertFlag=0;
  	if($flag==1 ){

	$conn=connect_db();

	try{
	
        mysqli_autocommit($conn, false);

		if ($table = mysqli_query($conn, "SELECT email FROM user WHERE email='$email' FOR UPDATE")) { 
			$line = mysqli_fetch_array($table, MYSQLI_ASSOC);
			if(empty($line['email'])){
				$sql = "INSERT INTO user (email,password) VALUES ('$email','$password')";

				if (mysqli_query($conn, $sql)) {
					$insertFlag=1;
				} else {
					$msgErr="registration fail    ".mysqli_error($conn);
					throw new Exception("CONCURENCY SOMEONE JUST GET THIS EMAIL");
				}
			}	
			else{
				$emailErr = "email already exsitent";
			}
			mysqli_free_result($table); // free buffer 
		} else die ("Operation failed ");
	}
	catch (Exception $e) { 
		mysqli_rollback($conn); 
		mysqli_autocommit($conn, true);
		echo "RollbackKKKK  ".$e->getMessage(); 
	}	
        mysqli_autocommit($conn, true);
	
	mysqli_close($conn);
	if($insertFlag==1){
		session_start(); 
   		cancel_session();
	        header('Location: login.php');
	}
  }
}
  
?>

	<p><span class="error">* required field</span></p>
	<form method="post" action="registration.php">  
		<span class="error"> <?php echo $msgErr;?></span><br>
		E-mail: <input type="text" name="email" placeholder="u1@p.it">
		<span class="error">* <?php echo $emailErr;?></span>
		<br><br>
		password: <input type="password" name="password1" placeholder="p1 or pA" >
		<span class="error">* <?php echo $passwordErr;?></span>
		<br><br>
		password: <input type="password" name="password2" placeholder="p1 or pA">
		<span class="error">* <?php echo $passwordErrc;?></span>
		<br><br>
		<input type="submit" name="submit" value="Submit">  
	</form>

<p >   your email should be like USER@DOMAIN and password must containt at least 1 ( digit o UPPERCASE LETTER) and 1 LOWERCASE LETTER</p>
<p > s251095  </p>

  </div>



 </div>


</body>
