/**
 * BD Instant Office
 * BD225179 16'17
 *
 * @author Rui Ventura (ist181045)
 * @author Diogo Freitas (ist181586)
 * @author Sara Azinhal (ist181700)
 */


-- a) Quais os espaços com postos que nunca foram alugados?

SELECT DISTINCT morada, codigo_espaco
FROM Posto
WHERE (morada, codigo) NOT IN (
  SELECT DISTINCT morada, codigo
  FROM Aluga
);



-- b) Quais edifícios com um número de reservas superior à média?

SELECT morada
FROM (
  SELECT morada, COUNT(1) AS c1
  FROM Aluga
  GROUP BY morada
  HAVING c1 > (
    SELECT AVG(c2)
    FROM (
      SELECT morada, COUNT(1) AS c2
      FROM Aluga
      GROUP BY morada
    ) AS C
  )
) AS R;



-- c) Quais utilizadores cujos alugáveis foram fiscalizados sempre pelo mesmo
--    fiscal?

SELECT nif, nome
FROM User
  NATURAL JOIN (
    SELECT nif, COUNT(1) AS c
    FROM (
      SELECT DISTINCT nif, id
      FROM Arrenda NATURAL JOIN Fiscaliza
    ) AS J
    GROUP BY nif
    HAVING c = 1
  ) AS R;



-- d) Qual o montante total realizado (pago) por cada espaço durante o ano de
--    2016? (Assume-se que a tarifa indicada na oferta é diária. Devem ser
--    considerados os espaços em que o espaço foi alugado totalmente ou por
--    postos)

SELECT morada, codigo_espaco,
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
WHERE YEAR(data) = 2016
GROUP BY morada, codigo_espaco;



-- e) Quais os espaços de trabalho cujos postos neles contidos foram todos
--    alugados? (Por alugado, entende-se um posto de trabalho que tenha pelo
--    menos uma oferta aceite, independentemente das suas datas)

-- e.1) Com NATURAL JOIN

SELECT DISTINCT morada, codigo_espaco AS codigo
FROM (
  SELECT morada, codigo_espaco, COUNT(1) AS c
  FROM Posto
    NATURAL JOIN Aluga
    NATURAL JOIN (
      SELECT DISTINCT numero
      FROM Estado
      WHERE estado = 'Aceite'
    ) AS R
  GROUP BY morada, codigo_espaco
) AS A
  NATURAL JOIN (
    SELECT morada, codigo_espaco, COUNT(1) AS c
    FROM Posto
    GROUP BY morada, codigo_espaco
) AS T;

-- e.2) Com multiplicação/produto (join explícito)

SELECT PT.morada, PT.codigo_espaco AS codigo
FROM (
  SELECT P1.morada, P1.codigo_espaco, COUNT(1) AS c
  FROM Posto P1, Aluga A, (
    SELECT DISTINCT E.numero
    FROM Estado E
    WHERE E.estado = 'Aceite'
 ) AS E
  WHERE P1.morada = A.morada
    and P1.codigo = A.codigo
    and E.numero = A.numero
  GROUP BY P1.morada, P1.codigo_espaco
) AS PA,
(
  SELECT P2.morada, P2.codigo_espaco, COUNT(1) AS c
  FROM Posto P2
  GROUP BY P2.morada, P2.codigo_espaco
) AS PT
WHERE PT.c = PA.c
  and PT.morada = PA.morada
  and PT.codigo_espaco = PT.codigo_espaco;
