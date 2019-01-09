<?php include 'wapper.php';

    session_start(); 
    //session_unset(); 	// Deprecated
    cancel_session();
   if(!HTTPSCheck()){
		exit();
   }
    header('HTTP/1.1 307 temporary redirect');
    header('Location: login.php');
    exit; // IMPORTANT to avoid further output from the script

?> 
