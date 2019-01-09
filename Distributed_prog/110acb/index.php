
<html>
<head>

 <link rel="stylesheet" href="style.css" /> 


</head>
<body >  

<?php  
	include 'wapper.php';  
	if(!HTTPSCheck()){
		exit();
	}
	t_title("home");
	create_menu('login.php','login','registration.php','registration');
?>

<div  class='main' > 

<?php
	$conn=connect_db();
	create_header(' WELCOME TO SHUTTLE HOME PAGE');
	
?>
 
	
		<h2>   list of actual destinations </h2>
	 	<p>   <?php  $cmd=0; liste_of_destiantion($conn,$cmd);  ?>   </p> 
	

	
		<h2> list of differents segments   </h2>
		<?php $cmd=0;  liste_of_segment($conn,$cmd) ;  ?>
	




<p > s251095  </p>

</div>




</body>
</html>


