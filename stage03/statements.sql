/**
 * BD Instant Office
 * BD225179 16'17
 *
 * @author Rui Ventura (ist181045)
 * @author Diogo Freitas (ist181586)
 * @author Sara Azinhal (ist181700)
 */


-- a)
-- Inserir/Remover Edificios

INSERT INTO Edificio(morada) VALUES( ? );

DELETE FROM Edificio WHERE morada = ? ;

-- Inserir Espacos

INSERT INTO Espaco(morada, codigo) VALUES( ? );

-- Inserir Postos de trabalho

INSERT INTO Posto(morada, codigo, codigo_espaco) VALUES( ? );

-- Remover Espacos ou Postos de trabalho

DELETE FROM Alugavel WHERE morada = ? AND codigo = ? ;

-- b) Criar/Remover Ofertas

INSERT INTO Oferta(morada, codigo, data_inicio, data_fim, tarifa) VALUES( ? );

DELETE FROM Oferta WHERE morada = ? 
					AND codigo = ?
					AND data_inicio = ?
					AND data_fim = ?
					AND tarifa = ?

-- c) Criar reservas sobre Ofertas

INSERT INTO Aluga(morada, codigo, data_inicio, numero, nif) VALUES( ? );

-- d) Pagar reservas

INSERT INTO Paga(numero, metodo) VALUES( ? );

-- e) Para um Edificio, mostrar o total realizado para cada espaco

SELECT codigo_espaco, 
  SUM(tarifa * DATEDIFF(data_fim, data_inicio)) AS montante_total
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
WHERE morada = ?
GROUP BY codigo_espaco;