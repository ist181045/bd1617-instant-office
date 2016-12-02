/**
 * BD Instant Office
 * BD225179 16'17
 *
 * @author Rui Ventura (ist181045)
 * @author Diogo Freitas (ist181586)
 * @author Sara Azinhal (ist181700)
 */


-- Delete triggers if they exist

DROP TRIGGER IF EXISTS TRG_Aluga_reserva_sobre_oferta;
DROP TRIGGER IF EXISTS TRG_Edificio_delete;
DROP TRIGGER IF EXISTS TRG_Espaco_delete_alugavel;
DROP TRIGGER IF EXISTS TRG_Espaco_delete_posto;
DROP TRIGGER IF EXISTS TRG_Espaco_insert_alugavel;
DROP TRIGGER IF EXISTS TRG_Oferta_dates_overlap;
DROP TRIGGER IF EXISTS TRG_Paga_state_timestamp;
DROP TRIGGER IF EXISTS TRG_Posto_insert_alugavel;
DROP TRIGGER IF EXISTS TRG_Posto_delete_alugavel;
DROP TRIGGER IF EXISTS TRG_Reserva_estado_inicial;


-- RI-1: "Nao podem existir ofertas com datas sobrepostas"

DELIMITER //

CREATE TRIGGER TRG_Oferta_dates_overlap
BEFORE INSERT ON Oferta
FOR EACH ROW
  BEGIN

    IF New.data_inicio > New.data_fim
      THEN CALL exception_date ();
    END IF;

    IF EXISTS (
      SELECT 1
      FROM Oferta
      WHERE New.morada = morada
        AND New.codigo = codigo
        AND data_inicio < New.data_fim
        AND New.data_inicio < data_fim
      )
      THEN CALL exception_dates_overlap ();
  	END IF;

  END //

DELIMITER ;

-- RI-2: "A data de pagamento de uma reserva paga tem que ser superior ao
--        timestamp do ultimo estado da reserva"

DELIMITER //

CREATE TRIGGER TRG_Paga_state_timestamp
BEFORE INSERT ON Paga
FOR EACH ROW
  BEGIN

    IF EXISTS (
      SELECT 1
      FROM Estado
      WHERE New.data < time_stamp
        AND New.numero = numero
      )
      THEN
        CALL exception_date_timestamp ();
      ELSE
        INSERT INTO Estado(numero, estado) VALUES(New.numero, 'Paga');
    END IF;

  END //

DELIMITER ;



-- OTHER TRIGGERS

-- Insert an initial state of reservation after insertion in 'Reserva'

DELIMITER //

CREATE TRIGGER TRG_Reserva_estado_inicial
AFTER INSERT ON Reserva
FOR EACH ROW
  BEGIN

    INSERT INTO Estado(numero, estado) VALUES(New.numero, 'Pendente');

  END //

DELIMITER ;

-- Create a reservation of a rentable space or office

DELIMITER //

CREATE TRIGGER TRG_Aluga_reserva_sobre_oferta
BEFORE INSERT ON Aluga
FOR EACH ROW
  BEGIN

    INSERT INTO Reserva(numero) VALUES(New.numero);

  END //

DELIMITER ;

-- Remove building's spaces

DELIMITER //

CREATE TRIGGER TRG_Edificio_delete
BEFORE DELETE ON Edificio
FOR EACH ROW
  BEGIN

    DELETE FROM Espaco WHERE morada = Old.morada;

  END //

DELIMITER ;

-- Remove spaces' offices

DELIMITER //

CREATE TRIGGER TRG_Espaco_delete_posto
BEFORE DELETE ON Espaco
FOR EACH ROW
  BEGIN

    DELETE FROM Posto WHERE morada = Old.morada AND codigo_espaco = Old.codigo;

  END //

DELIMITER ;

-- Remove space from 'Alugavel'

DELIMITER //

CREATE TRIGGER TRG_Espaco_delete_alugavel
AFTER DELETE ON Espaco
FOR EACH ROW
  BEGIN

    DELETE FROM Alugavel WHERE morada = Old.morada AND codigo = Old.codigo;

  END //

DELIMITER ;

-- Remove office from 'Alugavel'

DELIMITER //

CREATE TRIGGER TRG_Posto_delete_alugavel
AFTER DELETE ON Posto
FOR EACH ROW
  BEGIN

    DELETE FROM Alugavel WHERE morada = Old.morada and codigo = Old.codigo;

  END //

DELIMITER ;
