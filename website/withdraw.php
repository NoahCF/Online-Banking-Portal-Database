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


    <h3>Withdraw Screen</h3>
    <h3>Select an Account to Withdraw from:</h3>




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
        echo     "<table border='1' class='highlight' id=\"table_main\" >
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
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>


    <script type="text/javascript">

      var userInput= null;


      $(document).ready(function () {
        $("#table_main tbody tr").click(function () {
          
          var tableData = $(this).children("td").map(function() {
            return $(this).text();
          }).get();

          var td=tableData[1];
          var value = prompt("How much would you like to withdraw? : ", 100,"prompt", "$");



          while (value > tableData[1]){
            var value = prompt("You broke! Ask for less: ", 100,"prompt", "$");
          }
          

          console.log("Amount to be taken:", value);
          console.log("Account Number:", tableData[0]);
          console.log("Client ID:", tableData[4])


          var account_number=tableData[0];
          var client_card_number=tableData[4];

          var ask = window.confirm(`Confirm withdrawal of ${value} money.`);

          if (ask) {
              window.alert("Transaction Complete.");

              window.location.href = "withdrawConfirmed.php?value="+value+"&account_number="+account_number+"&client_card_number="+client_card_number;
          }
        });
      });
    </script>
  </body>
</html>
