<?php 
$conn = mysqli_connect("mysql", "wauser", "wara2074");
$r = $conn->query("show databases");
while($n = mysqli_fetch_row($r)) {
    var_dump($n);
}