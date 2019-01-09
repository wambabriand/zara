<?php    

function reload_booking(){ // avoid reload booking

	if( empty($_POST["departure"]) && empty($_POST["depchoice"]) && empty($_POST["seat"])  ){
		if( empty($_POST["arrival"]) && empty($_POST["arrchoice"]) && isset($_SESSION["check"])){
			$_SESSION["nocheck"]=1;
		}     
	}
}




function booking($conn){


	$flag_in=1;
	$capacity=4;$flag="true";
	$arrErr = $depErr=$msgErr='';$numErr = "";


	$user=$_SESSION['user']; // juste pour etre tres sure car avec session['book'] je redirige deja ca 
	if ($res = mysqli_query($conn, "SELECT * FROM booking WHERE email='$user'")) { 
		$line = mysqli_fetch_array($res, MYSQLI_ASSOC);
		if(!empty($line['email'])){
			$flag_in=-1;
		}
	}

	//gestisco la partenza
	if(empty($_POST["departure"]) && strcmp($_POST["depchoice"],"choice")==0 ){
		$depErr = "departure is required";
		$flag_in=0;
	}else if(!empty($_POST["departure"]) && strcmp($_POST["depchoice"] ,"choice")!=0 ){
		$depErr = "two choice make for departure cancel one";
		$flag_in=0;
	}else if(!empty($_POST["departure"])){
		$dep=test_input($_POST["departure"]);
		$dep=strtoupper($_POST["departure"]);
		if(location_exist($dep,$conn)==0) {
			$depErr="departure already in the database make a choice";
			$flag_in=0;
		}
	}else {      		
		$dep= strtoupper($_POST["depchoice"]);
	}
	//gestisco l arrivo
	if(empty($_POST["arrival"]) && strcmp($_POST["arrchoice"],"choice")==0 ){
		$arrErr = "arrival is required";
		$flag_in=0;
	}else if(!empty($_POST["arrival"]) && strcmp($_POST["arrchoice"],"choice")!=0  ){
		$arrErr = "two choice make for arrival cancel one";
		$flag_in=0;
	}else if(!empty($_POST["arrival"])){
		$arr=test_input($_POST["arrival"]);
		$arr=strtoupper($_POST["arrival"]);
		if(location_exist($arr,$conn)==0) {
			$arrErr="arrival already in the database make a choice";
			$flag_in=0;
		}
	}else {      		
		$arr=$_POST["arrchoice"];
	}

	// gestisco i posti
	if($_POST["seat"]==0){
		$numErr = "number of seat is required";
		$flag_in=0;
	}else {      		
		$num=$_POST["seat"];
	}
	
	// check if the departure is greater than the arrival
	if($flag_in==1 ){
		if(strcmp($dep,$arr)>=0){   
			$flag_in=0;
			$arrErr="departure have to be alphabetically greater than the arrival ";
		}
		if( !ctype_alpha($dep) || !ctype_alpha($arr) ){
			$flag_in=0;
			$depErr="addresss must containt just letter  ";			
		}
	}
	// je commence ma transaction 
	if($flag_in==1){
		
		try{	
			mysqli_autocommit($conn, false);
			
			if ($res = mysqli_query($conn, "SELECT * FROM location ORDER BY name FOR UPDATE")) { 
				$i=0;
				while($i<mysqli_num_rows($res)){
					$line = mysqli_fetch_array($res, MYSQLI_ASSOC); 
					if(!empty($line['name'])){
						$vet[$i]=$line['name'];
						$i++;
					}
				}
				mysqli_free_result($res); 
			}else die ("Operation failed ");

			$flag="true";
if ($res = mysqli_query($conn, "SELECT SUM(nbr_of_r)  FROM booking WHERE ( '$dep' >= departure AND '$dep' < arrival ) OR ( '$arr' > departure AND '$arr' <= arrival ) FOR UPDATE "))
				{	
					$sum=0;
					$line = mysqli_fetch_array($res, MYSQLI_ASSOC); 
					mysqli_free_result($res);
					$sum = $line['SUM(nbr_of_r)'];
					$sum=$sum + $num ; 			
					if($sum > $capacity){
					      $flag="false" ;
					}
				}

			if($flag=="false"){
				echo "<br>THERE IS NOT ENAUGTH PLACE IN THE SHUTTLE ";
				$msgErr="YOUR BOOKING FAIL";
			}else {		 
				if(insert_booking($dep,$arr,$_SESSION['user'],$num,$conn)){
					$_SESSION['book']=1;
					$msgErr="YOUR BOOKING IS OK!";
				}else{
					echo "insertion fail";
					unset($_SESSION['book']);
					$msgErr="YOUR BOOKING FAIL";
				}
			}	
		}catch (Exception $e) { 
			mysqli_rollback($conn); 
			$flag_in=0;
			$msgErr="PROBLEM WITH DATA BASE";
			echo "Rollback 2222 ".$e->getMessage(); 
		}	
		mysqli_autocommit($conn, true);
	}
	else if( $flag_in ==-1){ 
		$msgErr="YOU HAVE ALREADY MAKE THE BOOKING ";
	}
	else if( $flag_in ==0){ 
	 		 unset($_SESSION['book']);
	 		 $msgErr="YOUR BOOKING FAIL";
 	}

      echo '<br>'.'<br>'.'<br>'.$msgErr.'<br>'.'<br>'.$arrErr.'<br>'.$depErr.'<br>'.$numErr;
	
}


//function to insert a booking in booking table with $l1=departure $l2=arrival $u=user $n=seats
function insert_booking($l1,$l2,$u,$n,$conn){ 
	$ret=true;
	
	$flag1=location_exist($l1,$conn);
	$flag2=location_exist($l2,$conn);
	
	if(!mysqli_query($conn, "INSERT INTO booking (email,departure,arrival,nbr_of_r )VALUES ('$u','$l1','$l2','$n')") )              
		throw new Exception("command 1 failed"); 
	if($flag1==1){
		if(!mysqli_query($conn, "INSERT INTO location (name,flag)VALUES ('$l1',1)") )              
			throw new Exception("command 2 failed"); 
	}else{
		if(!mysqli_query($conn,"UPDATE location SET flag = flag+1 WHERE name='$l1'") )              
			throw new Exception("command 3 failed"); 
	}
	if($flag2==1){
		if(!mysqli_query($conn,"INSERT INTO location (name,flag)VALUES ('$l2',1)")  )              
			throw new Exception("command 4 failed"); 
	}else{
		if(!mysqli_query($conn,"UPDATE location SET flag = flag+1 WHERE name='$l2'") )              
			throw new Exception("command 5 failed"); 
	}
	mysqli_commit($conn); 
	mysqli_autocommit($conn, true);	

	return $ret;
}



function connect_db(){

	$conn=mysqli_connect('localhost','s251095','bachader','s251095');
	if (mysqli_connect_errno()) { 
		echo "Connection failed: " . mysqli_connect_error();
		exit();
	} 
	return $conn ;
}     




//function to check if a location has to be cancel
function I_can_cancel_location($data,$conn){
	$c=1;     
	if ($res = mysqli_query($conn, "SELECT * FROM location WHERE name='$data' FOR UPDATE")) { 

		$line=mysqli_fetch_array($res, MYSQLI_ASSOC);
		if(mysqli_num_rows($res)==1){
			if($line['flag']>1){
				$c=1;
			}else {$c=0;}
		}
	}
	return $c;
}

function cancel_booking($l1,$l2,$u,$conn){ 
	$ret=true;
	
	$user=$_SESSION['user'];
	
	try { /* je commence avec une transaction*/
	mysqli_autocommit($conn, false); 
	
	$flag1=I_can_cancel_location($l1,$conn);
	$flag2=I_can_cancel_location($l2,$conn);

	if(!mysqli_query($conn, "DELETE FROM booking WHERE email='$user' "))              
		throw new Exception("command 1 failed  ng cancellation"); 
	if($flag1==0){
		if(!mysqli_query($conn, "DELETE FROM location WHERE name='$l1'"))              
			throw new Exception("command 2 failed during cancellation"); 
	}else{
		if(!mysqli_query($conn,"UPDATE location SET flag = flag-1 WHERE name='$l1' "))              
			throw new Exception("command 3 failed during cancellation"); 
	}
	if($flag2==0){
		if(!mysqli_query($conn,"DELETE FROM location WHERE name='$l2'"))              
			throw new Exception("command 4 failed during cancellation"); 
	}else{
		if(!mysqli_query($conn,"UPDATE location SET flag = flag-1 WHERE name='$l2' "))              
			throw new Exception("command 5 failed during cancellation"); 
	}
	mysqli_commit($conn); 
	} catch (Exception $e) { 
		mysqli_rollback($conn); 
		mysqli_autocommit($conn, true);
		$ret=false;
		echo "Rollbackaaaa  ".$e->getMessage(); 
	}
	mysqli_autocommit($conn, true);
	return $ret;
}



function come_from_a_user(){ // avoid to go directly in the booking page
	if( !isset($_SESSION['user']) ){
		header('Location: login.php');exit;
	}
}




function print_choice($res){
       $i=0;
	while($i<mysqli_num_rows($res)){
		$line = mysqli_fetch_array($res, MYSQLI_ASSOC); 
		echo "<option value=".$line["name"].">".$line["name"];
		$i++;
	}
	echo "<OPTION VALUE=choice SELECTED> choice";
	echo "</select>";
}


function form_for_booking($conn)
{  
		echo"<div><h1>fill the form to make a booking</h1>";

		echo "<form method='post' action='booking2.php' >
		        insert departure if new: 
			<input type='text' name='departure'>
			choose departure if existing:" ;
 		

		if ($res = mysqli_query($conn, "SELECT * FROM location ORDER BY name ")) { 
			echo "<select  name=depchoice size=1>";
				print_choice($res);	
		} else die ("Operation failed ");


		echo "<br>insert arrival if new: <input type='text' name='arrival'>";
		echo "choose arrival  if existing:";

		   
		if ($res = mysqli_query($conn, "SELECT * FROM location ORDER BY name")) { 
			echo "<select  name=arrchoice size=1>";
				print_choice($res);
		} else die ("Operation failed ");
		
		echo "<br><br>number of seat:";
		  	
		$i=1;$capacity=4;
		echo "<select  name='seat' size=1>";
			echo "<OPTION VALUE=0 SELECTED>0";
				while($i<=$capacity){
					echo "<option value=".$i.">".$i;
					$i++;
				}
		echo "</select>";
		
		echo "<br> <br><br><input type='submit'name='submit' value='submit'> ";
		
		echo "</form> ";
		$_SESSION["check"]=1;
}


//function to check if a location is already in the database
function location_exist($data,$conn){
	$c=1;
	if ($res = mysqli_query($conn, "SELECT name FROM location WHERE name='$data'")) { 

		$line=mysqli_fetch_array($res, MYSQLI_ASSOC);
		              
		if(empty($line['name'])){
			$c=1;
		}
		else { 
			$c=0;
		}
	}
	return $c;
}


function booking_or_cancel_booking($conn){

	if(!isset($_SESSION['book'])){
		$_SESSION['nocheck']=1;
       		echo	'<form method="post" action="booking2.php" > 
				<input type="submit"  value="booking" />
			</form > ';
	}
	else{
		echo	'<form method="post" action="cancel.php" > 
				<input type="submit"  value="cancel" />
			</form > ';
	}
}




function liste_of_segment($conn,$cmd)  
{
	$departure = $arrival =' ';

	if($cmd==1){
		$user1=$_SESSION['user'];
	        if ($table = mysqli_query($conn, "SELECT * FROM booking WHERE '$user1' = email ")){
	                $i=0;
			$line = mysqli_fetch_array($table, MYSQLI_ASSOC);
			if(!empty($line['email'])  && $i < mysqli_num_rows($table) ){
				$departure = $line["departure"];
				$arrival = $line["arrival"];		
			}
			mysqli_free_result($table);
	        }
		else die ("Operation failed ");
	}

	$i=0;
	if ($table = mysqli_query($conn, "SELECT * FROM location ORDER BY name")) { 

		while($i<mysqli_num_rows($table)){
			$line = mysqli_fetch_array($table, MYSQLI_ASSOC); 
			$vet[$i]=$line['name'];
			$i++;
		}
     		mysqli_free_result($table); // free buffer 
	} else die ("Operation failed ");


	for($j=0; $j < $i-1 ;$j=$j+1)  // I make the combinason of segment ( i,i+1 )
	{ 
		$c=$j+1;
	        if( $cmd==1 && $vet[$j]==$departure  )  echo "<a class='error'>".$vet[$j]."</a>" ;	
		else echo $vet[$j] ; 	echo '-->';

	   	if( $cmd==1 &&  $vet[$c]==$arrival  ) echo "<a class='error'>".$vet[$c]."</a>" ;	
		else echo $vet[$c]." " ; 


 if ($table = mysqli_query($conn, "SELECT SUM(nbr_of_r)  FROM booking WHERE '$vet[$j]' >= departure AND '$vet[$c]' <= arrival  "))
		{	 
			$line = mysqli_fetch_array($table, MYSQLI_ASSOC); 
			if( isset($line['SUM(nbr_of_r)']) ){
				echo "total : ".$line['SUM(nbr_of_r)']." : ";
			}
			else{
				echo "total : 0 : empty";
			}
			mysqli_free_result($table);

if ($table = mysqli_query($conn,"SELECT * FROM booking WHERE '$vet[$j]' >= departure AND '$vet[$c]' <= arrival ") )
			if( $cmd==1)
			{	
				$t=0;
				while( $t < mysqli_num_rows($table) ){
					$line = mysqli_fetch_array($table, MYSQLI_ASSOC); 
					$pieces = explode("@", $line['email']);
					$user = $pieces[0]; 
					if( $line['nbr_of_r']==1 ) 
						$user= $user." ( ".$line['nbr_of_r']."passenger )  "; 
					else 
						$user= $user." ( ".$line['nbr_of_r']."passengers )  ";
					//if( ($vet[$j]==$departure || $vet[$c]==$arrival ) && $user1==$line['email'] ) 
					if(  $user1==$line['email'] ) 
						echo "<a class='error'>".$user."</a>";
					else    echo $user;

					$t++;	
				}
				
				mysqli_free_result($table);
			}
			echo "<br>" ;	
		}
	}
}


function t_title($var){
	echo "<TITLE>".$var."</TITLE>";
}

function liste_of_destiantion($conn,$cmd){
	
	$departure = $arrival =' ';

	if($cmd==1){
		$user=$_SESSION['user'];

	        if ($table = mysqli_query($conn, "SELECT * FROM booking WHERE '$user' = email ")){
	                $i=0;
			$line = mysqli_fetch_array($table, MYSQLI_ASSOC);
			if(!empty($line['email'])  && $i < mysqli_num_rows($table) ){
				$departure = $line["departure"];
				$arrival = $line["arrival"];		
			}
			mysqli_free_result($table);
	        }
		else die ("Operation failed ");
	}


	if ($table = mysqli_query($conn, "SELECT * FROM location ORDER BY name ")) { 
		$i=0;
		while($i<mysqli_num_rows($table)){
			$line = mysqli_fetch_array($table, MYSQLI_ASSOC); 				
  			if($line["name"]==$departure || $line["name"]==$arrival ) { 
				echo "<a class='error'>".$line['name']."<br></a>";
			}
			else {
				echo  $line["name"]."<br>";
			} 
			$i++;
		}

		mysqli_free_result($table); 
	} else die ("Operation failed ");

}



function create_header($name)
{
 ?>
	<div id="top">
	  <h1 id="h1">  <?php  echo  $name ; ?>  </h1>
	</div>
 <?php
}


?> <?php


function create_menu($href,$name,$href2,$name2)
{
 ?>
	<div class="menu" > 
		<a href=  <?php  echo$href ;?>  class="link1"> <?php   echo$name;?>  </a>   
		<a href=  <?php  echo$href2 ;?> class="link2" > <?php  echo$name2;?>  </a>  
	</div>
<?php
}


function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}


function cancel_session(){

    $_SESSION=array();  

    if (ini_get("session.use_cookies")) {
        $params = session_get_cookie_params();
        setcookie(session_name(), '', time() - 3600*24,
            $params["path"], $params["domain"],
            $params["secure"], $params["httponly"]
        );
    }
    session_destroy();  

}





function cookies_java(){
	setcookie('test','value');
	if( !isset( $_COOKIE['test'] ) ){
		header('Location: vide.php');
	}
	echo "<noscript><h1 >  JAVA IS NOT AVAILABLE </h1> </noscript>";
}

  
function HTTPSCheck(){
	if(!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS']!= 'off') {
		return true;
	}
	else{
		session_destroy();
		$redirect='https://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
		header('HTTP/1.1 301 moved permanently');
 		header('Location:' . $redirect);
  		return false;
	} 
}



?>












