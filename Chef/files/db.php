<?php
$master = mysqli_connect("localhost", "root", "root", "words");
$slave = mysqli_connect("ec2-18-222-109-65.us-east-2.compute.amazonaws.com", "master_user", "master", "words");
if (!$master){
die("ERROR: Could not connect to master DB" . mysqli_connect_error());
}
if (!$slave){
die("ERROR: Could not connect to slave DB" . mysqli_connect_error());
}

?>
