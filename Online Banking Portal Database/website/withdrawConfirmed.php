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


  
    <h3>Withdrawal Confirmed</h3>



    <!-- <?php 
    echo $_GET['value']; 
    echo $_GET['value']; 
    ?> -->

    <?php
        session_start();
        $client_card_number = $_SESSION['client_card_number'];

        $servername = "localhost";
        $username = "root";
        $client_password_db = "";


        // get params from withdraw.php
        $valueToAdd = $_GET['value']; 
        $account_number = $_GET['account_number'];
        $client_card_number = $_GET['client_card_number'];

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
        $sql = "UPDATE account SET balance = balance - $valueToAdd WHERE client_card_number=$client_card_number AND account_number=$account_number AND client_card_number=$client_card_number;";
        $result = $conn->query($sql);

      $conn->close();
    ?>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <script type="text/javascript">

        var userInput= null;

        $(document).ready(function () {

          console.log('depositConfirmed Jquery ready');
          var qsParm = new Array();

          function qs() {
          var query = window.location.search.substring(1);
          var parms = query.split('&');
          console.log(parms);
          }

        });
    </script>
  </body>
</html>
