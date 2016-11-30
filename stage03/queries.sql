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
  select distinct A.morada, A.codigo
  from Aluga A
);
