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
<?php $title = isset($_REQUEST['morada']) ? ucfirst($_REQUEST['morada']) : "Escolha um Edifício" ?>
  <head>
    <meta charset="utf-8">
    <title>Instant Office - <?php echo $title; ?></title>
  </head>
  <body>
    <h1><?php echo $title; ?></h1>
    <?php
      include_once("secret/login.php");

      try {
        $db = new PDO("mysql:host=$dbhost;dbname=$dbname;", $dbuser, $dbpass);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $result = null;

        if (isset($_REQUEST['morada'])) {
          $stmt = $db->prepare("SELECT codigo_espaco as codigo,
            SUM(tarifa * DATEDIFF(data_fim, data_inicio)) AS `montante total`
          FROM Oferta
            NATURAL JOIN Aluga
            NATURAL JOIN Paga
            NATURAL JOIN (
              SELECT morada, codigo, codigo_espaco
              FROM Alugavel NATURAL JOIN Posto
              UNION
              SELECT morada, codigo, codigo AS codigo_espaco
              FROM Alugavel NATURAL JOIN Espaco
            ) AS A
          WHERE morada = :morada
          GROUP BY codigo_espaco;");

          $stmt->bindParam(":morada", $_REQUEST['morada'], PDO::PARAM_STR);
          $stmt->execute();
          $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

        } else {
          $result = $db->query("SELECT * FROM Edificio");
        }

        $objs = $result->fetchAll(PDO::FETCH_ASSOC);
        $result = null;

        echo "<table border=\"2\">";
        echo "<thead><tr>";
        foreach(array_keys($objs[0]) as $key)
          echo "<td>".ucfirst($key)."</td>";
        echo "</tr></thead><tbody>";

        foreach($objs as $obj) {
          echo "<tr>";
          if(isset($_REQUEST['morada'])) {
            $str = "morada={$obj['morada']}";
            echo "<td>{$obj['codigo']}</td>";
            echo "<td>{$obj['montante_total']}</td>";
          } else {
            $str = "morada={$obj['morada']}";
            echo "<td>{$obj['morada']}</td>";
            echo "<td><a href=\"amount.php?$str\">Ver total por espaco</a></td>";
          }
          echo "</tr>";
        }

        echo "</tbody></table>";

        $db = null;

      } catch (PDOException $e) {
        echo "<p>PDOException: {$e->getMessage()}</p>";
      }

     ?>
    <br>
    <a href=\"index.php?$str\">Voltar ao Inicio</a>";
    <br><br>
    <footer>Copyright &copy; 2016 <?php echo date("Y") > 2016 ? " - ".date("Y") : ""; ?></footer>
  </body>
</html>
