<html>
<head>
	<meta charset="UTF-8">
	<title>Test PHP</title>
</head>
<body>
	<h1 align=center>Hello there!</h1>
	<h2 align=center>Here you can see the last 3 words from the DB:</h2>
	<?php
	// db connection
	include_once('db.php');

	// show last 3 words from db
	$get = "SELECT word FROM main ORDER BY id DESC LIMIT 3";
	$result = mysqli_query($slave, $get);

	while ($arr = $result->fetch_assoc()){
	echo "<h3 align=center style='color:blue'>" . $arr['word'] . "</h3>";
	}
	?>
	<br><br>
	<h2 align=center>Add word to the DB</h2>
	<form action="add.php" method ="post">
		<p align=center>
		<input type="text" name="newword" maxlength="50"><br>
		<input type="submit" value="ADD">
		</p>
	</form>

	<?php
	if($_GET['msg']){
	echo "<h3 align=center style='color:green'>The word " . $_GET['msg'] . " added!</h3>";
	} ?>
</body>
</html>
