/**
 * BD Instant Office
 * BD225179 16'17
 *
 * @author Rui Ventura (ist181045)
 * @author Diogo Freitas (ist181586)
 * @author Sara Azinhal (ist181700)
 */


-- a) Quais os espaços com postos que nunca foram alugados?

select distinct morada, codigo_espaco
from Posto
where (morada, codigo) not in (
  select distinct morada, codigo
  from Aluga
);



-- b) Quais edifícios com um número de reservas superior à média?

select distinct morada
from (
  select distinct morada, count(1) as c1
  from Aluga
  group by morada
) as A
where c1 > (
  select AVG(c2)
  from (
    select distinct morada, count(1) as c2
    from Aluga
    group by morada
  ) as Avg
);



-- c) Quais utilizadores cujos alugáveis foram fiscalizados sempre pelo mesmo
--    fiscal?

select distinct nif, nome
from User
where (nif, 1) in (
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

-- e.1) Com natural join

select distinct morada, codigo_espaco as codigo
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

-- e.2) Com multiplicação (join explícito)

select distinct PT.morada, PT.codigo_espaco as codigo
from (
 select distinct P1.morada, P1.codigo_espaco, count(1) as c
 from Posto P1, Aluga A, (
   select distinct E.numero
   from Estado E
   where E.estado = 'Aceite'
 ) as E
 where P1.morada = A.morada
   and P1.codigo = A.codigo
   and E.numero = A.numero
 group by P1.morada, P1.codigo_espaco
) as PA,
(
 select distinct P2.morada, P2.codigo_espaco, count(1) as c
 from Posto P2
 group by P2.morada, P2.codigo_espaco
) as PT
where PT.c = PA.c
 and PT.morada = PA.morada
 and PT.codigo_espaco = PT.codigo_espaco;
