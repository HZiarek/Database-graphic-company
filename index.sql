--plik przeznaczony do tesowania indeksow
drop index zamowienie_idx1;
drop index zamowienie_idx2;

create index zamowienie_tylko_klient on zamowienie (klient);

--pojedynczy indeks

EXECUTE DBMS_STATS.GATHER_TABLE_STATS ('hubert','zamowienie');

alter index zamowienie_tylko_klient invisible;

explain plan for
select klient from zamowienie where klient < 300; -- and cena < 450 ;
select *
from table (dbms_xplan.display);
--select count(*)/1001 from tab1 where parent_id =100;
--select count(*) from tab1;

select (select count(klient) from zamowienie where klient < 267)/(select count(klient) from zamowienie) from dual;

select COUNT(*) from zamowienie;
select * from klient;

--podwojny/potrijny indeks
create index zamowienie_idx1 on zamowienie(klient, cena, id);
create index zamowienie_idx2 on zamowienie(cena, klient, id);

EXECUTE DBMS_STATS.GATHER_TABLE_STATS ('hubert','zamowienie');

alter index zamowienie_idx1 invisible;
alter index zamowienie_idx2 invisible;

explain plan for
select id from zamowienie where klient < 790 and cena < 100 ;
select *
from table (dbms_xplan.display);
--select count(*)/1001 from tab1 where parent_id =100;
--select count(*) from tab1;

select (select count(klient) from zamowienie where klient < 267)/(select count(klient) from zamowienie) from dual;

EXECUTE DBMS_STATS.GATHER_TABLE_STATS ('hubert','zamowienie');

explain plan for
select /*+ USE_HASH(zamowienie klient) */ klient.nazwisko, zamowienie.id
from
klient join zamowienie on klient.id >= zamowienie.klient;
select *
from table (dbms_xplan.display);

select * from zamowienie;