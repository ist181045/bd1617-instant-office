/**
 * BD Instant Office
 * BD225179 16'17
 *
 * @author Rui Ventura (ist181045)
 * @author Diogo Freitas (ist181586)
 * @author Sara Azinhal (ist181700)
 */


-- a) Quais os espaços com postos que nunca foram alugados?

select distinct P.morada, P.codigo_espaco
from Posto P
where (P.morada, P.codigo) not in (
  select distinct morada, codigo
  from Aluga
);



-- b) Quais edifícios com um número de reservas superior à média?

select distinct M.morada
from (
  select distinct morada, count(1) as c
  from Aluga
  group by morada
) as M
where M.c > (
  select AVG(R.c)
  from (
    select distinct morada, count(1) as c
    from Aluga
    group by morada
  ) as R
);



-- c) Quais utilizadores cujos alugáveis foram fiscalizados sempre pelo mesmo
--    fiscal?

select distinct nome
from User U
where (U.nif, 1) in (
  select distinct nif, count(1) as c
  from (
    select distinct nif, id
    from Arrenda natural join Fiscaliza
  ) as R
  group by nif
);

-- d) Qual o montante total realizado (pago) por cada espaço durante o ano de
--    2016? (Assume-se que a tarifa indicada na oferta é diária. Devem ser
--    considerados os espaços em que o espaço foi alugado totalmente ou por
--    postos)

-- TODO: This query



-- e) Quais os espaços de trabalho cujos postos neles contidos forma todos
--    alugados? (Por alugado, entende-se um posto de trabalho que tenha pelo
--    menos uma oferta aceite, independentemente das suas datas)

select distinct morada, codigo_espaco
from (
  select distinct morada, codigo_espaco, count(1) as c
  from Posto
    natural join Aluga
    natural join (
      select distinct numero
      from Estado
      where estado = 'Aceite'
    ) as R
  group by morada, codigo_espaco
) as A
  natural join (
    select distinct morada, codigo_espaco, count(1) as c
    from Posto
    group by morada, codigo_espaco
) as T;

-- B
