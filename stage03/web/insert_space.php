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
    <title>Instant Office - Escolha um Edifício</title>
  </head>
  <body>
    <h1>Escolha um Edifício</h1>
    <?php
      include_once("secret/login.php");

      try {
        $db = new PDO("mysql:host=$dbhost;dbname=$dbname;", $dbuser, $dbpass);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

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
          echo "<td><a href=\"form_espaco.php?$str\">Inserir Espaco</a></td>";
          echo "</tr>";
        }

        echo "</tbody></table>";

        $db = null;

      } catch (PDOException $e) {
        echo "<p>PDOException: {$e->getMessage()}</p>";
      }

     ?>
    <a href="#">Voltar ao Início</a>
    <br><br>
    <footer>Copyright &copy; 2016 <?php echo date("Y") > 2016 ? " - ".date("Y") : ""; ?></footer>
  </body>
</html>