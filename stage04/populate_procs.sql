/**
 * BD Instant Office
 * BD225179 16'17
 *
 * @author Corpo Docente de BD225179
 * @author Rui Ventura (ist181045)
 * @author Diogo Freitas (ist181586)
 * @author Sara Azinhal (ist181700)
 */

DROP PROCEDURE IF EXISTS load_date_dim;
DROP PROCEDURE IF EXISTS load_time_dim;
DROP PROCEDURE IF EXISTS load_location_dim;
DROP PROCEDURE IF EXISTS load_user_dim;
DROP PROCEDURE IF EXISTS load_reservations;

DELIMITER $$
CREATE PROCEDURE load_date_dim()
BEGIN
  DECLARE v_full_date DATETIME;
  SET v_full_date = '2016-01-01 00:00:00';
  WHILE v_full_date < '2018-01-01 00:00:00' DO
    INSERT INTO olap_Date_dim (
      date_day,
      date_week,
      date_month,
      date_semester,
      date_year
    ) VALUES (
      DAY(v_full_date),
      WEEK(v_full_date),
      MONTH(v_full_date),
      CEIL(MONTH(v_full_date) / 6),
      YEAR(v_full_date)
    );
    SET v_full_date = DATE_ADD(v_full_date, INTERVAL 1 DAY);
  END WHILE;
END;
$$

CREATE PROCEDURE load_time_dim()
BEGIN
  DECLARE v_full_time TIME;
  SET v_full_time = '00:00:00.0000';
  WHILE v_full_time <= '23:59:00.0000' DO
    INSERT INTO olap_Time_dim (
      time_minute,
      time_hour
    ) VALUES (
      MINUTE(v_full_time),
      HOUR(v_full_time)
    );
    SET v_full_time = ADDTIME(v_full_time, '00:01:0.0000');
  END WHILE;
END;
$$

CREATE PROCEDURE load_location_dim()
BEGIN
  INSERT INTO olap_Location_dim(code_office, code_space, address_building)
    SELECT codigo, codigo_espaco, morada
    FROM Posto;

  INSERT INTO olap_Location_dim(code_space, address_building)
    SELECT codigo, morada
    FROM Espaco;

  INSERT INTO olap_Location_dim(address_building)
    SELECT morada
    FROM Edificio;
END;
$$

CREATE PROCEDURE load_user_dim()
BEGIN
  INSERT INTO olap_User_dim(nif, name, phone)
    SELECT nif, nome, telefone
    FROM User;
END;
$$

CREATE PROCEDURE load_reservations()
BEGIN
  DECLARE v_nif         VARCHAR(9);
  DECLARE v_morada      VARCHAR(255);
  DECLARE v_codigo      VARCHAR(255);
  DECLARE v_data        TIMESTAMP;
  DECLARE v_data_inicio DATE;
  DECLARE v_data_fim    DATE;
  DECLARE v_tarifa      DECIMAL(19,4);

  DECLARE done INTEGER DEFAULT 0;
  DECLARE cur CURSOR FOR
    SELECT nif, morada, codigo, data, data_inicio, data_fim, tarifa
    FROM Aluga NATURAL JOIN Paga NATURAL JOIN Oferta;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  OPEN cur;
  loop_lbl: LOOP
    FETCH cur INTO v_nif, v_morada, v_codigo, v_data, v_data_inicio, v_data_fim, v_tarifa;
    IF done THEN
      LEAVE loop_lbl;
    END IF;

    INSERT INTO olap_Reservations (
      location_id,
      time_id,
      date_id,
      user_id,
      amount,
      time_period
    ) VALUES (
      (SELECT location_id
       FROM olap_Location_dim
       WHERE v_morada = address_building
         AND (v_codigo = code_office
           OR v_codigo = code_space AND code_office IS NULL)
      ),
      (SELECT time_id
       FROM olap_Time_dim
       WHERE HOUR(v_data)   = time_hour
         AND MINUTE(v_data) = time_minute
      ),
      (SELECT date_id
       FROM olap_Date_dim
       WHERE YEAR(v_data)  = date_year
         AND MONTH(v_data) = date_month
         AND DAY(v_data)   = date_day
      ),
      (SELECT user_id
       FROM olap_User_dim
       WHERE v_nif = nif
      ),
      DATEDIFF(v_data_fim, v_data_inicio) * v_tarifa,
      DATEDIFF(v_data_fim, v_data_inicio)
    );
  END LOOP;

END;
$$

DELIMITER ;
