/*
drop table zamowienie;
drop table reklamacje;
drop table pracownik_pracuje;
drop table pracownik;
drop table status_reklamacji;
drop table status_zamowienia;
drop table zrodlo_pozyskania_zamowienia;
drop table etap;
drop table klient;
commit;*/

create table pracownik(
pesel VARCHAR2(11) NOT NULL,
imie VARCHAR2(20),
nazwisko varchar2(20) NOT NULL,
mail VARCHAR2(30),
nr_telefonu VARCHAR2(9),
adres VARCHAR2(30),
stanowisko VARCHAR2(20),
primary key(pesel)
);

--drop table pracownik;

create table status_reklamacji(
nazwa VARCHAR2(40),
opis VARCHAR2(100),
primary key(nazwa)
);

--drop table status_reklamacji;

create table status_zamowienia(
nazwa VARCHAR2(40),
opis VARCHAR2(100),
primary key(nazwa)
);

select * from zrodlo_pozyskania_zamowienia;
--drop table status_zamowienia;

create table etap(
nazwa VARCHAR2(40) NOT NULL,
opis VARCHAR2(100),
primary key(nazwa)
);

--drop table etap;

create table zrodlo_pozyskania_zamowienia(
nazwa VARCHAR2(40),
data_uruchomienia_uslugi DATE,
primary key(nazwa)
);

--drop table zrodlo_pozyskania_zamowienia;

create table klient(
id INT NOT NULL,
imie VARCHAR2(20),
nazwisko varchar2(20) NOT NULL,
mail VARCHAR2(30),
nr_telefonu VARCHAR2(9),
adres VARCHAR2(50),
znizka INT,
--primary key(id)
CONSTRAINT klient_pk PRIMARY KEY(id) USING INDEX
);

CREATE SEQUENCE klient_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE INDEX klient_name_idx ON klient (nazwisko);

CREATE OR REPLACE TRIGGER klient_id_trigger
BEFORE INSERT ON klient
FOR EACH ROW
BEGIN
  SELECT klient_seq.nextval INTO :new.id FROM dual;
END;
/
--czyszczenie i resetowanie sekwencji
DELETE FROM klient;
SEQUENCE klient_seq RESET;

--generate data for companies table
 set serveroutput on;
 exec klient_generator;
 
 select * from klient;

--drop table klient;

create table zamowienie(
id INT NOT NULL,
cena NUMBER NOT NULL,
klient INT NOT NULL,
deadline DATE,
zrodlo_pozyskania VARCHAR2(40),
--nadruk
liczba_pkt_klienta INT,
dodatkowe_informacje VARCHAR2(50),
status_zamowienia VARCHAR2(40) NOT NULL,
CONSTRAINT zamowienie_pk PRIMARY KEY(id) USING INDEX,
FOREIGN KEY (klient) 
    REFERENCES klient(id),
FOREIGN KEY (zrodlo_pozyskania) 
    REFERENCES zrodlo_pozyskania_zamowienia(nazwa),
FOREIGN KEY (status_zamowienia) 
    REFERENCES status_zamowienia(nazwa)
);

CREATE SEQUENCE zamowienie_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE INDEX zamowienie_name_idx ON zamowienie (id);

CREATE OR REPLACE TRIGGER zamowienie_id_trigger
BEFORE INSERT ON zamowienie
FOR EACH ROW
BEGIN
  SELECT zamowienie_seq.nextval INTO :new.id FROM dual;
END;
/

--czyszczenie i resetowanie sekwencji
DELETE FROM zamowienie;
--ALTER SEQUENCE zamowienie_seq RESTART;

--generowanie danych do tabeli zamowienie
 set serveroutput on;
 exec zamowienie_generator;
 
select * from zamowienie;
select * from klient;

--drop table zamowienie;

create table reklamacje(
id INT NOT NULL,
id_zamowienia INT NOT NULL,
data_wplyniecia DATE NOT NULL,
przyczyna VARCHAR2(30),
pracownik_odpowiedzialny VARCHAR2(11) NOT NULL,
status_reklamacji VARCHAR2(40) NOT NULL,
primary key(id),
FOREIGN KEY (pracownik_odpowiedzialny) 
    REFERENCES pracownik(pesel),
FOREIGN KEY (id_zamowienia) 
    REFERENCES zamowienie(id),
FOREIGN KEY (status_reklamacji) 
    REFERENCES status_reklamacji(nazwa)
);

--drop table reklamacje;

create table pracownik_pracuje(
id INT NOT NULL,
pracownik VARCHAR2(11) NOT NULL,
zamowienie INT NOT NULL,
etap VARCHAR2(40) NOT NULL,
data_rozpoczenia DATE NOT NULL,
data_zakonczenia DATE,
procent_wykonanego_zadania INT,
primary key(id),
FOREIGN KEY (pracownik) 
    REFERENCES pracownik(pesel),
FOREIGN KEY (zamowienie) 
    REFERENCES zamowienie(id),
FOREIGN KEY (etap) 
    REFERENCES etap(nazwa)
);

--drop table pracownik_pracuje;

insert into klient values(
1,
'Jan',
'Kowalski',
'kowal@gmail.com',
'123456789',
null,
null
);

insert into  klient values(
2,
'Alan',
'Nowak',
'kowal@gmail.com',
'123456789',
null,
null
);

insert into etap values(
'przyjecie',
'zdefiniowanie oczekiwan'
);

insert into etap values(
'koncept',
'tworzenie wstepnego projektu'
);

insert into etap values(
'detale',
'dopracowywanie zamowienia'
);

insert into status_zamowienia values(
'przyjete',
'przyjecie przebieglo pomyslnie i niedlugo zamowienie trafi do realizacji'
);

insert into status_zamowienia values(
'odrzucone',
'klient zrezygnowal'
);

insert into status_zamowienia values(
'zrealizowane',
NULL
);

insert into status_zamowienia values(
'w trakcie realizacji',
'nad zamowieniem pracuja graficy'
);

insert into zrodlo_pozyskania_zamowienia values(
'facebook funpage',
NULL
);

insert into zrodlo_pozyskania_zamowienia values(
'strona internetowa',
NULL
);

insert into zrodlo_pozyskania_zamowienia values(
'allegro',
NULL
);


insert into status_reklamacji values(
'zaakceptowana',
NULL
);

insert into status_reklamacji values(
'odrzucona',
NULL
);

insert into status_reklamacji values(
'rozpatrywana',
NULL
);

select * from klient;
--update klient set imie = 'Krzysztof' where pesel = '12345678911';
--delete from klient where pesel = '12345678911';

commit;
--rollback;