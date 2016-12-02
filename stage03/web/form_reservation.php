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
    <title>Instant Office - Detalhes da Reserva </title>
  </head>
  <body>
    <h1>Detalhes da Reserva </h1>
    <?php
      include_once("secret/login.php");

      try {
        $db = new PDO("mysql:host=$dbhost;dbname=$dbname;", $dbuser, $dbpass);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        if ($_SERVER['REQUEST_METHOD'] === "POST") {
          try {
            $db->beginTransaction();
            $ins_alugavel = $db->prepare("INSERT INTO Aluga VALUES (?, ?, ?, ?, ?)");

            $ins_alugavel->execute(
              array($_REQUEST['morada'], $_REQUEST['codigo'], $_REQUEST['data_inicio'], $_REQUEST['nif'], $_REQUEST['numero']));

            echo "<p>Inserção feita com sucesso!</p>";

            $db->commit();
          } catch (PDOException $e) {
            $db->rollBack();
            echo "<p>{$e->getMessage()}</p>";
          }
        } else {
          echo "
            <form method=\"post\">
              <p>Numero: <input type=\"text\" name=\"numero\" required /></p>
              <p>Nif: <input type=\"text\" name=\"nif\" required /></p>
              <input type=\"hidden\" name=\"morada\" value=\"".$_REQUEST['morada']."\"/>
              <input type=\"hidden\" name=\"codigo\" value=\"".$_REQUEST['codigo']."\"/>
              <input type=\"hidden\" name=\"data_inicio\" value=\"".$_REQUEST['data_inicio']."\"/>
              <input type=\"submit\" value=\"Inserir\"/>
            </form>";
        }

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
