drop table zamowienie CASCADE CONSTRAINTS;
drop table reklamacje CASCADE CONSTRAINTS;
drop table pracownik_pracuje CASCADE CONSTRAINTS;
drop table pracownik CASCADE CONSTRAINTS;
drop table status_reklamacji CASCADE CONSTRAINTS;
drop table status_zamowienia CASCADE CONSTRAINTS;
drop table zrodlo_pozyskania_zamowienia CASCADE CONSTRAINTS;
drop table etap CASCADE CONSTRAINTS;
drop table klient CASCADE CONSTRAINTS;

drop sequence klient_seq;
drop sequence zamowienie_seq;
drop sequence pracownik_prac_seq;
drop sequence reklamacje_seq;

commit;