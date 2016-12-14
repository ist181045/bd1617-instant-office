/**
 * BD Instant Office
 * BD225179 16'17
 *
 * @author Rui Ventura (ist181045)
 * @author Diogo Freitas (ist181586)
 * @author Sara Azinhal (ist181700)
 */

DROP TABLE if exists olap_Reservations;
DROP TABLE if exists olap_User_dim;
DROP TABLE if exists olap_Location_dim;
DROP TABLE if exists olap_Date_dim;
DROP TABLE if exists olap_Time_dim;

SOURCE populate_procs.sql;

CREATE TABLE olap_User_dim (
  user_id  INTEGER(10) UNIQUE NOT NULL AUTO_INCREMENT,
  nif      VARCHAR(9)  NOT NULL,
  name     VARCHAR(80) NOT NULL,
  phone    VARCHAR(26) NOT NULL,
  PRIMARY KEY(user_id)
);

CREATE TABLE olap_Location_dim (
  location_id   INTEGER(10)  UNIQUE NOT NULL,
  address       VARCHAR(255) NOT NULL,
  code_office   VARCHAR(255),
  code_space    VARCHAR(255) NOT NULL,
  PRIMARY KEY(location_id)
);

CREATE TABLE olap_Date_dim (
  date_id    INTEGER(8)  UNIQUE NOT NULL,
  date_month INTEGER(2)  NOT NULL,
  date_day   INTEGER(2)  NOT NULL,
  PRIMARY KEY(date_id)
);
CALL load_date_dim;

CREATE TABLE olap_Time_dim (
  time_id     INTEGER(10) UNIQUE NOT NULL,
  time_hour   INTEGER(2)  NOT NULL,
  time_minute INTEGER(2)  NOT NULL,
  PRIMARY KEY(time_id)
);
CALL load_time_dim;

CREATE TABLE olap_Reservations (
  user_id     INTEGER(10)   NOT NULL,
  location_id INTEGER(10)   NOT NULL,
  time_id     INTEGER(10)   NOT NULL,
  date_id     INTEGER(10)   NOT NULL,
  amount      DECIMAL(19,4) NOT NULL,
  time_period INTEGER(3)    NOT NULL,
  PRIMARY KEY(user_id, location_id, time_id, date_id),
  FOREIGN KEY(user_id)     REFERENCES olap_User_dim(user_id),
  FOREIGN KEY(location_id) REFERENCES olap_Location_dim(location_id),
  FOREIGN KEY(time_id)     REFERENCES olap_Time_dim(time_id),
  FOREIGN KEY(date_id)     REFERENCES olap_Date_dim(date_id)
);
