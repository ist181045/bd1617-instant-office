/**
 * BD Instant Office
 * BD225179 16'17
 *
 * @author Rui Ventura (ist181045)
 * @author Diogo Freitas (ist181586)
 * @author Sara Azinhal (ist181700)
 */

 SELECT date_month, date_day, code_space, code_office, AVG(amount)
 FROM olap_Reservations
   NATURAL JOIN olap_Date_dim
   NATURAL JOIN olap_Location_dim
 GROUP BY date_month, date_day, code_space, code_office
 WITH ROLLUP

 UNION

 SELECT date_month, date_day, code_space, code_office, AVG(amount)
 FROM olap_Reservations
   NATURAL JOIN olap_Date_dim
   NATURAL JOIN olap_Location_dim
 GROUP BY date_day, code_space, code_office, date_month
 WITH ROLLUP

 UNION

 SELECT date_month, date_day, code_space, code_office, AVG(amount)
 FROM olap_Reservations
   NATURAL JOIN olap_Date_dim
   NATURAL JOIN olap_Location_dim
 GROUP BY code_space, code_office, date_month, date_day
 WITH ROLLUP

 UNION

 SELECT date_month, date_day, code_space, code_office, AVG(amount)
 FROM olap_Reservations
   NATURAL JOIN olap_Date_dim
   NATURAL JOIN olap_Location_dim
 GROUP BY code_office, date_month, date_day, code_space
 WITH ROLLUP

 UNION

 SELECT date_month, date_day, code_space, code_office, AVG(amount)
 FROM olap_Reservations
   NATURAL JOIN olap_Date_dim
   NATURAL JOIN olap_Location_dim
 GROUP BY date_month, code_space

 UNION

 SELECT date_month, date_day, code_space, code_office, AVG(amount)
 FROM olap_Reservations
   NATURAL JOIN olap_Date_dim
   NATURAL JOIN olap_Location_dim
 GROUP BY date_day, code_office
 ORDER BY date_month, date_day, code_space, code_office;
