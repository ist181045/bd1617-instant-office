<!--
 - BD Instant Office
 - BD225179 16'17
 -
 - @author Rui Ventura (ist181045)
 - @author Diogo Freitas (ist181586)
 - @author Sara Azinhal (ist181700)
 -->

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Instant Office - Detalhes Edificio</title>
  </head>
  <body>
    <h1>Detalhes Edificio</h1>
    <?php
      include_once("secret/login.php");

      try {
        $db = new PDO("mysql:host=$dbhost;dbname=$dbname;", $dbuser, $dbpass);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        if (isset($_REQUEST['morada'])) {
          try {
            $db->beginTransaction();
            $stm = $db->prepare("INSERT INTO Alugavel VALUES (?)");

            $stm->execute(array($_REQUEST['morada'])
            );

            $db->commit();
          } catch (PDOException $e) {
            $db->rollBack();
            echo "<p>{$e->getMessage()}</p>";
          }
        }


          echo "Morada: <input type="text" name="morada" required />";
          echo "<p></p>";

          $str = "morada=$morada";
          echo "<td><a href=\"index_building.php?$str\">Inserir Edificio</a></td>";

        $db = null;

      } catch (PDOException $e) {
        echo "<p>PDOException: {$e->getMessage()}</p>";
      }

     ?>
    <br>
    <a href="index.php">Voltar ao Inicio</a>
    <br><br>
    <footer>Copyright &copy; 2016 <?php echo date("Y") > 2016 ? " - ".date("Y") : ""; ?></footer>
  </body>
</html>
