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
    <title>Instant Office - Detalhes do Posto</title>
  </head>
  <body>
    <h1>Detalhes do Posto</h1>
    <?php
      include_once("secret/login.php");

      try {
        $db = new PDO("mysql:host=$dbhost;dbname=$dbname;", $dbuser, $dbpass);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        if ($_SERVER['REQUEST_METHOD'] === "POST") {
          try {
            $db->beginTransaction();
            $ins_alugavel = $db->prepare("INSERT INTO Alugavel VALUES (?, ?, ?)");
            $ins_posto = $db->prepare("INSERT INTO Posto VALUES (?, ?, ?)");

            $ins_alugavel->execute(
              array($_REQUEST['morada'], $_REQUEST['codigo'], $_REQUEST['foto'])
            );
            $ins_posto->execute(
              array($_REQUEST['morada'], $_REQUEST['codigo'], $_REQUEST['codigo_espaco'])
            );
            echo "<p>Inserção feita com sucesso!</p>";

            $db->commit();
          } catch (PDOException $e) {
            $db->rollBack();
            echo "<p>PDOException: {$e->getMessage()}</p>";
          }
        } else {
          echo "
            <form method=\"post\">
              <p>Código: <input type=\"text\" name=\"codigo\" required /></p>
              <p>Foto: <input type=\"text\" name=\"foto\"/></p>
              <input type=\"hidden\" name=\"morada\" value=\"".$_REQUEST['morada']."\"/>
              <input type=\"hidden\" name=\"codigo_espaco\" value=\"".$_REQUEST['codigo_espaco']."\"/>
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
