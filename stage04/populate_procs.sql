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
      HOUR(v_full_time),
      MINUTE(v_full_time)
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
	
CRE	ATE PROCEDURE load_user_dim()
BEG	IN
  INSERT INTO olap_User_dim(nif, name, phone)
    SELECT nif, nome, telefone
    FROM User;
END;
$$

CREATE PROCEDURE load_space_reservations()
BEGIN
  INSERT INTO olap_Reservations (
    location_id, 
    time_id, 
    date_id, 
    user_id, 
    amount, 
    time_period)
      SELECT LD.location_id,TD.time_id, DD.date_id, UD.user_id, ( tarifa * DIFFDATE(O.data_inicio, O.data_fim) ) as amount, DIFFDATE(O.data_inicio, O.data_fim) as time_period)
      FROM (SELECT *
            FROM Reserva R
              NATURAL JOIN Espaco E
              NATURAL JOIN Oferta O
              NATURAL JOIN Aluga A)
        INNER JOIN olap_Location_dim LD
        INNER JOIN olap_Time_dim TD
        INNER JOIN olap_Date_dim DD
        INNER JOIN olap_User_dim UD
          ON  LD.address_building = E.morada
          AND LD.code_space       = E.codigo
          AND LD.code_office      IS NULL
          AND TD.time_hour        = HOUR(O.data_inicio)
          AND TD.time_minute      = MINUTE(O.data_inicio)
          AND DD.date_year        = YEAR(O.data_inicio)
          AND DD.date_month       = MONTH(O.data_inicio)
          AND DD.date_day         = DAY(O.data_inicio)
          AND UD.nif              = A.nif;
END;
$$

CREATE PROCEDURE load_office_reservations()
BEGIN
  INSERT INTO olap_Reservations (
    location_id, 
    time_id, 
    date_id, 
    user_id, 
    amount, 
    time_period)
      SELECT LD.location_id,TD.time_id, DD.date_id, UD.user_id, ( tarifa * DIFFDATE(O.data_inicio, O.data_fim) ) as amount, DIFFDATE(O.data_inicio, O.data_fim) as time_period)
      FROM (SELECT *
            FROM Reserva R
              NATURAL JOIN Posto P
              NATURAL JOIN Oferta O
              NATURAL JOIN Aluga A)
        INNER JOIN olap_Location_dim LD
        INNER JOIN olap_Time_dim TD
        INNER JOIN olap_Date_dim DD
        INNER JOIN olap_User_dim UD
          ON  LD.address_building = P.morada
          AND LD.code_space       = P.codigo_espaco
          AND LD.code_office      = P.codigo
          AND TD.time_hour        = HOUR(O.data_inicio)
          AND TD.time_minute      = MINUTE(O.data_inicio)
          AND DD.date_year        = YEAR(O.data_inicio)
          AND DD.date_month       = MONTH(O.data_inicio)
          AND DD.date_day         = DAY(O.data_inicio)
          AND UD.nif              = A.nif;
END;
$$

DELIMITER ;
