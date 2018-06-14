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

create table status_reklamacji(
nazwa VARCHAR2(40),
opis VARCHAR2(100),
primary key(nazwa)
);

create table status_zamowienia(
nazwa VARCHAR2(40),
opis VARCHAR2(100),
primary key(nazwa)
);

create table etap(
nazwa VARCHAR2(40) NOT NULL,
opis VARCHAR2(100),
primary key(nazwa)
);

create table zrodlo_pozyskania_zamowienia(
nazwa VARCHAR2(40),
data_uruchomienia_uslugi DATE,
primary key(nazwa)
);

create table klient(
id INT NOT NULL,
imie VARCHAR2(20),
nazwisko varchar2(20) NOT NULL,
mail VARCHAR2(50),
nr_telefonu VARCHAR2(9),
adres VARCHAR2(70),
ilosc_punktow_klienta INT NOT NULL,
primary key(id)
);

CREATE SEQUENCE klient_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;

CREATE OR REPLACE TRIGGER klient_id_trigger
BEFORE INSERT ON klient
FOR EACH ROW
BEGIN
  SELECT klient_seq.nextval INTO :new.id FROM dual;
END;
/

create table zamowienie(
id INT NOT NULL,
cena NUMBER NOT NULL,
cena_ze_znizka NUMBER,
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

CREATE OR REPLACE TRIGGER zamowienie_id_trigger
BEFORE INSERT ON zamowienie
FOR EACH ROW
BEGIN
  SELECT zamowienie_seq.nextval INTO :new.id FROM dual;
END;
/

create table reklamacje(
id INT NOT NULL,
id_zamowienia INT NOT NULL UNIQUE,
data_wplyniecia DATE NOT NULL,
przyczyna VARCHAR2(50),
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

CREATE SEQUENCE reklamacje_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;

CREATE OR REPLACE TRIGGER reklamacje_id_trigger
BEFORE INSERT ON reklamacje
FOR EACH ROW
BEGIN
  SELECT reklamacje_seq.nextval INTO :new.id FROM dual;
END;
/

create table pracownik_pracuje(
id INT NOT NULL,
pracownik VARCHAR2(11) NOT NULL,
zamowienie INT NOT NULL,
etap VARCHAR2(40) NOT NULL,
data_rozpoczecia DATE NOT NULL,
data_zakonczenia DATE,
primary key(id),
FOREIGN KEY (pracownik) 
    REFERENCES pracownik(pesel),
FOREIGN KEY (zamowienie) 
    REFERENCES zamowienie(id),
FOREIGN KEY (etap) 
    REFERENCES etap(nazwa)
);

CREATE SEQUENCE pracownik_prac_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE;

CREATE OR REPLACE TRIGGER pracownik_prac_id_trigger
BEFORE INSERT ON pracownik_pracuje
FOR EACH ROW
BEGIN
  SELECT pracownik_prac_seq.nextval INTO :new.id FROM dual;
END;
/

commit;