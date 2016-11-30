/**
 * BD Instant Office
 * BD225179 16'17
 *
 * @author Rui Ventura (ist181045)
 * @author Diogo Freitas (ist181586)
 * @author Sara Azinhal (ist181700)
 */

DROP TRIGGER IF EXISTS TRG_Paga_state_timestamp;
DROP TRIGGER IF EXISTS TRG_Oferta_dates_overlap;

-- RI-1: "Nao podem existir ofertas com datas sobrepostas"

DELIMITER //

CREATE TRIGGER TRG_Oferta_dates_overlap
BEFORE INSERT ON Oferta
FOR EACH ROW
BEGIN

  IF NEW.data_inicio > New.data_fim
    THEN CALL exception_date ();
  END IF
  
  IF EXISTS (
    SELECT 1
    FROM Oferta
    WHERE NEW.morada = morada
      AND NEW.codigo = codigo
      AND data_inicio < NEW.data_fim
      AND NEW.data_inicio < data_fim
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
    WHERE NEW.data < time_stamp
      AND NEW.numero = numero
    )
    THEN CALL exception_date_timestamp ();
  END IF;

END //

DELIMITER ;


/** 

Estado actual de todas as reservas pagas:

SELECT numero, estado
FROM Paga
  NATURAL JOIN Estado
  NATURAL JOIN (
   SELECT numero, MAX(time_stamp) AS time_stamp
   FROM Estado
   GROUP BY numero ) AS R;
 
 */