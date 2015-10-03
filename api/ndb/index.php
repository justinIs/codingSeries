<?php
//SQL Configuration
$dbhost = "localhost";
$dbuser = "root";
$dbpass = "cscodingchallenge";
$dbname = "codingchamps";
$link = mysql_connect($dbhost, $dbuser, $dbpass) or die(mysql_error());
mysql_select_db($dbname, $link) or die(mysql_error());

//SQL Query Cleaner
function cleanQuery($string) {
    $string = stripslashes($string);
    $string = mysql_real_escape_string($string);
    $string = str_replace('`','',$string);
    $string = htmlspecialchars($string);
    return $string;
}

$userId = cleanQuery($_POST['user_id']);
$challengeId = cleanQuery($_POST['challenge_id']);
$sourceFile = mysql_real_escape_string($_POST['source_file']);
$outputFile = $_POST['output_file'];

$result = mysql_query("SELECT * FROM `challenges`");
while ($row = mysql_fetch_assoc($result)) {
    $challenges[$row['id']] = $row;
}

if($challenges[$challengeId]['secret_output'] == $outputFile) {
	$points = $challenges[$challengeId]['points'];
	http_response_code(200);
} else {
	$points = 0;
	http_response_code(400);
}

$outputFile = mysql_real_escape_string($outputFile);

mysql_query("INSERT INTO `codingchamps`.`attempts` (`id`, `time`, `user`, `challenge`, `code`, `output`, `points`) VALUES (NULL, CURRENT_TIMESTAMP, '$userId', '$challengeId', '$sourceFile', '$outputFile', '$points');");
?>
