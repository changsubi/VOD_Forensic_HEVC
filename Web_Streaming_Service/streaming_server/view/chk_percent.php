<?php
$host ='localhost:3306';
$user = 'root';
$password = '1234';
$dbname = 'test';

$conn = mysqli_connect($host, $user, $password, $dbname);

if (mysqli_connect_errno($conn)) {
    $data['status'] = 'error';
    $data['text'] = 'DB연결 오류!!';
    echo json_encode($data,JSON_UNESCAPED_UNICODE);
    exit();
}

//GET,POST 받은값 정의
$identification_char = trim(strip_tags(mysqli_real_escape_string($conn, $_GET['identification_char'])));

$qry = "SELECT progress FROM forensicmark WHERE search = '$identification_char'";
$data = array();
if($result = mysqli_query($conn, $qry)){
    $row = mysqli_fetch_assoc($result);

    $data['percent'] = $row['progress'];
}

echo json_encode($data);
?>
