/**
 * BD Instant Office
 * BD225179 16'17
 *
 * @author Rui Ventura (ist181045)
 * @author Diogo Freitas (ist181586)
 * @author Sara Azinhal (ist181700)
 */

-- Query 1

ALTER TABLE Arrenda   DROP FOREIGN KEY Arrenda_ibfk_1;
ALTER TABLE Fiscaliza DROP FOREIGN KEY Fiscaliza_ibfk_1;
ALTER TABLE Fiscaliza DROP FOREIGN KEY Fiscaliza_ibfk_2;

ALTER TABLE Arrenda   DROP KEY nif;
ALTER TABLE Fiscaliza DROP KEY morada;

EXPLAIN
SELECT A.nif
  FROM Arrenda A
    INNER JOIN Fiscaliza F
     ON A.morada = F.morada
    AND A.codigo = F.codigo
  GROUP BY A.nif
  HAVING COUNT(DISTINCT F.id) = 1 \G

SET PROFILING = 1;
SELECT A.nif
  FROM Arrenda A
    INNER JOIN Fiscaliza F
     ON A.morada = F.morada
    AND A.codigo = F.codigo
  GROUP BY A.nif
  HAVING COUNT(DISTINCT F.id) = 1;
SET PROFILING = 0;

DROP INDEX IF EXISTS idx_fiscaliza_mc ON Fiscaliza;
DROP INDEX IF EXISTS idx_arrenda_nif  ON Arrenda;
CREATE INDEX idx_fiscaliza_mc ON Fiscaliza(morada, codigo);
CREATE INDEX idx_arrenda_nif ON Arrenda(nif);

EXPLAIN
SELECT A.nif
  FROM Arrenda A
    INNER JOIN Fiscaliza F
     ON A.morada = F.morada
    AND A.codigo = F.codigo
  GROUP BY A.nif
  HAVING COUNT(DISTINCT F.id) = 1 \G

SET PROFILING = 1;
SELECT A.nif
  FROM Arrenda A
    INNER JOIN Fiscaliza F
     ON A.morada = F.morada
    AND A.codigo = F.codigo
  GROUP BY A.nif
  HAVING COUNT(DISTINCT F.id) = 1;
SET PROFILING = 0;



-- Query 2

ALTER TABLE Aluga DROP FOREIGN KEY Aluga_ibfk_1;
ALTER TABLE Aluga DROP FOREIGN KEY Aluga_ibfk_2;
ALTER TABLE Aluga DROP FOREIGN KEY Aluga_ibfk_3;
ALTER TABLE Posto DROP FOREIGN KEY Posto_ibfk_1;
ALTER TABLE Posto DROP FOREIGN KEY Posto_ibfk_2;

ALTER TABLE Aluga DROP KEY nif;
ALTER TABLE Aluga DROP KEY numero;
ALTER TABLE Posto DROP KEY morada;

EXPLAIN
SELECT DISTINCT P.morada, P.codigo_espaco
  FROM Posto P
  WHERE (P.morada, P.codigo_espaco) NOT IN (
    SELECT P.morada, P.codigo_espaco
    FROM Posto P
      NATURAL JOIN Aluga A
      NATURAL JOIN Estado E
    WHERE E.estado = 'Aceite') \G

SET PROFILING = 1;
SELECT DISTINCT P.morada, P.codigo_espaco
  FROM Posto P
  WHERE (P.morada, P.codigo_espaco) NOT IN (
    SELECT P.morada, P.codigo_espaco
    FROM Posto P
      NATURAL JOIN Aluga A
      NATURAL JOIN Estado E
    WHERE E.estado = 'Aceite');
SET PROFILING = 0;

DROP INDEX IF EXISTS idx_aluga_numero  ON Aluga;
DROP INDEX IF EXISTS idx_estado_estado ON Estado;
DROP INDEX IF EXISTS idx_posto_mce     ON Posto;
CREATE INDEX idx_aluga_numero  ON Aluga(numero);
CREATE INDEX idx_estado_estado ON Estado(estado);
CREATE INDEX idx_posto_mce     ON Posto(morada, codigo_espaco);

EXPLAIN
SELECT DISTINCT P.morada, P.codigo_espaco
  FROM Posto P
  WHERE (P.morada, P.codigo_espaco) NOT IN (
    SELECT P.morada, P.codigo_espaco
    FROM Posto P
      NATURAL JOIN Aluga A
      NATURAL JOIN Estado E
    WHERE E.estado = 'Aceite') \G

SET PROFILING = 1;
SELECT DISTINCT P.morada, P.codigo_espaco
  FROM Posto P
  WHERE (P.morada, P.codigo_espaco) NOT IN (
    SELECT P.morada, P.codigo_espaco
    FROM Posto P
      NATURAL JOIN Aluga A
      NATURAL JOIN Estado E
    WHERE E.estado = 'Aceite');
SET PROFILING = 0;

SHOW PROFILES \G
