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
    <title>Instant Office - Bem Vindo</title>
  </head>
  <body>
    <h1>Bem vindo ao Instant Office!</h1>
    <h2>Escolha uma das acções abaixo</h2>
    <ul>
      <li>Ofertas</li>
      <ul>
        <li><a href="create_offer.php">Criar</a></li>
        <li><a href="remove_offer.php?q=oferta">Remover</a></li>
      </ul>
      <li>Reservas</li>
      <ul>
        <li><a href="create_reservation.php?q=reserva">Criar</a></li>
        <li><a href="remove_reservation.php?q=reserva">Remover</a></li>
      </ul>
      <li>Edifício</li>
      <ul>
        <li><a href="insert_building.php?q=edificio">Inserir</a></li>
        <li><a href="remove_building.php?q=edificio">Remover</a></li>
        <li><a href="amount.php">Consultar total realizado por espaço</a></li>
      </ul>
      <li>Espaço</li>
      <ul>
        <li><a href="insert_space.php?q=espaco">Inserir</a></li>
        <li><a href="remove_space.php?q=espaco">Remover</a></li>
      </ul>
      <li>Posto</li>
      <ul>
        <li><a href="insert_office.php?q=posto">Inserir</a></li>
        <li><a href="insert_office.php?q=posto">Remover</a></li>
      </ul>
    </ul>

    <footer>Copyright &copy; 2016<?php echo date("Y") > 2016 ? " - ".date("Y") : "" ?> G02@BD225179L09</footer>
  </body>
</html>
