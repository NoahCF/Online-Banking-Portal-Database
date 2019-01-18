<?php
  include('index.php');
  if($_SERVER["REQUEST_METHOD"] == "POST"){
    $card_number = $_POST['card_number'];
    $client_password = $_POST['client_password'];

    $servername = "localhost";
    $username = "root";
    $client_password_db = "";
    // Create connection
    $conn = new mysqli($servername, $username, $client_password_db);

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    $sql = "USE bank_db";

    if ($conn->query($sql) === TRUE) {

    } else {
        echo "<br>" . $conn->error;
    }


    $sql = "SELECT client_card_number, client_password FROM client WHERE client_card_number=".$card_number.";";
    $result = $conn->query($sql);


    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
          $client_card_number = $row['client_card_number'];
          $auth_client_password= $row['client_password'];
        }
    }

    if ($auth_client_password == $client_password){
      session_start();
      $_SESSION['client_card_number'] = $client_card_number;
      header('Location: welcome.php');
    }
    else{
      echo "<script>M.toast({html: 'Incorrect client_password!', classes: 'rounded'});</script>";
    }
  }
  else{
    echo 'something went wrong!';
  }

  $conn->close();
?>
