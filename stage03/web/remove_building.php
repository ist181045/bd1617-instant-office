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
    <title>Instant Office - Escolha uma Edificio</title>
  </head>
  <body>
    <h1>Escolha uma Edificio</h1>
    <?php
      include_once("secret/login.php");

      try {
        $db = new PDO("mysql:host=$dbhost;dbname=$dbname;", $dbuser, $dbpass);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        if (isset($_REQUEST['morada'])) {
          try {
            $db->beginTransaction();

            $stmt = $db->prepare("DELETE FROM Edificio
              WHERE morada = ?");
            $stmt->execute(array($_REQUEST['morada']));
            $stmt = null;

            echo "<p>Remoção feita com sucesso!</p>";

            $db->commit();
          } catch (PDOException $e) {
            $db->rollBack();
            echo "<p>PDOException: {$e->getMessage()}</p>";
          }
        }

        $result = $db->query("SELECT * FROM Edificio");
        $objs = $result->fetchAll(PDO::FETCH_ASSOC);
        $result = null;

        echo "<table border=\"2\">";
        echo "<thead><tr>";
        foreach(array_keys($objs[0]) as $key)
          echo "<td>".ucfirst($key)."</td>";
        echo "</tr></thead><tbody>";

        foreach($objs as $obj) {
          $str = "morada={$obj['morada']}";
          echo "<tr>";
          echo "<td>{$obj['morada']}</td>";
          echo "<td><a href=\"remove_building.php?$str\">Remover Edificio</a></td>";
          echo "</tr>";
        }

        echo "</tbody></table>";

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
