/**
 * BD Instant Office
 * BD225179 16'17
 *
 * @author Rui Ventura (ist181045)
 * @author Diogo Freitas (ist181586)
 * @author Sara Azinhal (ist181700)
 */


-- a) Quais os espaços com postos que nunca foram alugados?

SELECT distinct morada, codigo_espaco
FROM Posto
WHERE (morada, codigo) NOT IN (
  SELECT distinct morada, codigo
  FROM Aluga
);



-- b) Quais edifícios com um número de reservas superior à média?

SELECT distinct morada
FROM (
  SELECT distinct morada, count(1) AS c1
  FROM Aluga
  GROUP BY morada
) AS A
WHERE c1 > (
  SELECT AVG(c2)
  FROM (
    SELECT distinct morada, count(1) AS c2
    FROM Aluga
    GROUP BY morada
  ) AS Avg
);



-- c) Quais utilizadores cujos alugáveis foram fiscalizados sempre pelo mesmo
--    fiscal?

SELECT distinct nif, nome
FROM User
WHERE (nif, 1) in (
  SELECT distinct nif, count(1) AS c
  FROM (
    SELECT distinct nif, id
    FROM Arrenda NATURAL JOIN Fiscaliza
  ) AS R
  GROUP BY nif
);



-- d) Qual o montante total realizado (pago) por cada espaço durante o ano de
--    2016? (Assume-se que a tarifa indicada na oferta é diária. Devem ser
--    considerados os espaços em que o espaço foi alugado totalmente ou por
--    postos)

-- TODO: This query



-- e) Quais os espaços de trabalho cujos postos neles contidos forma todos
--    alugados? (Por alugado, entende-se um posto de trabalho que tenha pelo
--    menos uma oferta aceite, independentemente das suas datas)

-- e.1) Com NATURAL JOIN

SELECT distinct morada, codigo_espaco AS codigo
FROM (
  SELECT distinct morada, codigo_espaco, count(1) AS c
  FROM Posto
    NATURAL JOIN Aluga
    NATURAL JOIN (
      SELECT distinct numero
      FROM Estado
      WHERE estado = 'Aceite'
    ) AS R
  GROUP BY morada, codigo_espaco
) AS A
  NATURAL JOIN (
    SELECT distinct morada, codigo_espaco, count(1) AS c
    FROM Posto
    GROUP BY morada, codigo_espaco
) AS T;

-- e.2) Com multiplicação (join explícito)

SELECT distinct PT.morada, PT.codigo_espaco AS codigo
FROM (
  SELECT distinct P1.morada, P1.codigo_espaco, count(1) AS c
  FROM Posto P1, Aluga A, (
    SELECT distinct E.numero
    FROM Estado E
    WHERE E.estado = 'Aceite'
 ) AS E
  WHERE P1.morada = A.morada
    and P1.codigo = A.codigo
    and E.numero = A.numero
  GROUP BY P1.morada, P1.codigo_espaco
) AS PA,
(
  SELECT distinct P2.morada, P2.codigo_espaco, count(1) AS c
  FROM Posto P2
  GROUP BY P2.morada, P2.codigo_espaco
) AS PT
WHERE PT.c = PA.c
  and PT.morada = PA.morada
  and PT.codigo_espaco = PT.codigo_espaco;
