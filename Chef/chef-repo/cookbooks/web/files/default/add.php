<?php

include_once('db.php');

$newword = mysqli_real_escape_string($master, $_REQUEST['newword']);

$add = "INSERT INTO main (word) VALUES ('$newword')";
if(mysqli_query($master, $add)){
	header("Location: .?msg=$newword");
} else{
	echo "ERROR:" . mysqli_error($master);
}
?>
