<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title></title>
    <style media="screen">
    body {
      background-color: lightblue;
    }
    </style>
    <!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

  </head>
  <body>
    <nav>
  <div class="nav-wrapper">
    <a href="#" class="brand-logo"> <img src="https://techflourish.com/images/money-cliparts-15.jpg" alt="" height="60" width="60">Bank of Canada</a>
    <ul id="nav-mobile" class="right hide-on-med-and-down">
    <li><a href="welcome.php">Accounts</a></li>
      <li><a href="paybill.php">Pay Bill</a></li>
      <li><a href="withdraw.php">Withdraw</a></li>
      <li><a href="deposit.php">Deposit</a></li>
      <li><a href="signout.php">Log Out</a></li>
    </ul>
  </div>
  </nav>
    <h3>Welcome to the bank</h3>

    <?php
        session_start();
        $client_card_number = $_SESSION['client_card_number'];

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


        $sql = "SELECT * FROM account WHERE account_client_id=".$client_card_number.";";
        $result = $conn->query($sql);


        if ($result->num_rows > 0) {
          echo     "<table border='1' class='highlight' >
              <tr >
                <th >account_number</th>
                <th>balance</th>
                <th>interest_rate_id</th>
                <th>account_type</th>
                <th>client_card_number</th>
              </tr>";
            // output data of each row
            while($row = $result->fetch_assoc()) {
                echo "<tr onclick='console.log(\"Hello\")'>";
                foreach($row as $data){
                  echo "<td>".$data."</td>";
                }
                echo "</tr>";
            }
            echo "</table>";
        }

      $conn->close();
    ?>

  </body>
</html>
