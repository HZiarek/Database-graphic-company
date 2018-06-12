create or replace PROCEDURE KLIENT_GENERATOR IS
	TYPE TABSTR IS TABLE OF VARCHAR2(250);
	imie TABSTR;
    nazwisko TABSTR;
    skrzynka TABSTR;
    cyferka TABSTR;
    ulica TABSTR;
    miasto TABSTR;
	qimie NUMBER(5);
    qnazwisko NUMBER(5);
    qskrzynka NUMBER(5);
    qulica NUMBER(5);
    qmiasto NUMBER(5);
    nr_imie NUMBER(5);
    nr_nazwisko NUMBER(5);
    nr_skrzynka NUMBER(5);
    nr_cyferka NUMBER(5);
    ilosc_punktow NUMBER(5);
    numer_domu INT;
    numer VARCHAR2(9);
    
BEGIN
    imie := TABSTR ('Andrzej', 'Waclaw', 'Krzysztof', 'Alojzy', 'Baltazar', 'Zdzislaw', 'Piotr', 'Pawel',
                    'Bartlomiej', 'Slawomir', 'Adam', 'Kacper', 'Adrian', 'Dariusz', 'Marek', 'Stefan', 'Wladyslaw',
                    'Norbert', 'Karol');
	qimie := imie.count;
    
    nazwisko := TABSTR ('Nowak', 'Kowalski', 'Zalewski', 'Pietruszka', 'Aleksandrowicz', 'Malarz', 'Kalenik', 'Malik', 'Duda',
                        'Kaczynski', 'Tusk', 'Macierewicz', 'Duszek', 'Grzyb', 'Kowalik', 'Kowalewski', 'Komoszka');
	qnazwisko := nazwisko.count;
    
    skrzynka := TABSTR ('@gmail.com', '@vp.pl', '@wp.pl', '@o2.pl', '@interia.pl');
	qskrzynka := skrzynka.count;

    cyferka := TABSTR ('1', '2', '3', '4', '5', '6', '7', '8', '9', '0');
    
    ulica := TABSTR ('Zeromskiego', 'Wiejska', 'Polna', 'Florianska', 'Prosta', 'Gosciniec', 'Krzywa', 'Brzeska',
                    'Kolejowa', 'Tuwima', 'Brzechwy');
	qulica := ulica.count;
    
    miasto := TABSTR ('Warszawa', 'Krakow', 'Gdansk', 'Lublin', 'Siedlce', 'Sopot', 'Gdynia', 'Gliwice');
	qmiasto := miasto.count;

	FOR i IN 1..100 LOOP
        nr_imie := dbms_random.value(1, qimie);
        nr_nazwisko := dbms_random.value(1,qnazwisko);
        nr_skrzynka := dbms_random.value(1,qskrzynka);
        ilosc_punktow := dbms_random.value(0,100);
        numer_domu := dbms_random.value(1,400);
        
        numer := cyferka(DBMS_RANDOM.value(1, 9)) || cyferka(DBMS_RANDOM.value(1, 10)) || cyferka(DBMS_RANDOM.value(1, 10))
                || cyferka(DBMS_RANDOM.value(1, 10)) || cyferka(DBMS_RANDOM.value(1, 10)) || cyferka(DBMS_RANDOM.value(1, 10))
                || cyferka(DBMS_RANDOM.value(1, 10)) || cyferka(DBMS_RANDOM.value(1, 10)) || cyferka(DBMS_RANDOM.value(1, 10));

        INSERT INTO klient VALUES (NULL, imie(nr_imie), nazwisko(nr_nazwisko), imie(nr_imie)||'.'||nazwisko(nr_nazwisko)||skrzynka(nr_skrzynka),numer,
                    'ul. '||ulica(dbms_random.value(1,qulica))||' '||numer_domu||', '||miasto(dbms_random.value(1,qmiasto)),
                    ilosc_punktow);
	END LOOP;
       
	DBMS_OUTPUT.put_line('Nowe wiersze dodane.');
END  KLIENT_GENERATOR;









create or replace PROCEDURE ZAMOWIENIE_GENERATOR IS
    rok NUMBER(4);
	deadline VARCHAR2(10);
	dzien NUMBER(5);
    
    cena NUMBER(5, 2);
    liczba_punktow INT;

BEGIN
	FOR i IN 1..1000 LOOP
        cena := dbms_random.value(1, 500);
        liczba_punktow := dbms_random.value(1, 10);
        
        rok := dbms_random.value(2017,2020);
		dzien := dbms_random.value(1,355);
		deadline := to_char(rok) || to_char(dzien,'999');

        
        INSERT INTO zamowienie VALUES (
            NULL,    --id INT NOT NULL,
            cena,    --cena NUMBER NOT NULL,
            (select id from (select * from klient order by DBMS_random.value) where rownum = 1),    --klient INT NOT NULL,
            to_date(deadline,'yyyyddd'),    --deadline DATE,
            (select nazwa from (select * from zrodlo_pozyskania_zamowienia order by DBMS_random.value) where rownum = 1),    --zrodlo_pozyskania VARCHAR2(40), 
            liczba_punktow,    --liczba_pkt_klienta INT,
            NULL,    --dodatkowe_informacje VARCHAR2(50),
            (select nazwa from (select * from status_zamowienia order by DBMS_random.value) where rownum = 1)    --status_zamowienia VARCHAR2(40) NOT NULL,
            );
	END LOOP;
       
	DBMS_OUTPUT.put_line('Nowe wiersze dodane.');
END ZAMOWIENIE_GENERATOR;









CREATE OR REPLACE PROCEDURE REKLAMACJE_GENERATOR IS 
	TYPE TABSTR IS TABLE OF VARCHAR2(250);
	przyczyna TABSTR;
    qprzyczyna NUMBER(5);
    
    rok NUMBER(4);
	data_wplyniecia VARCHAR2(10);
	dzien NUMBER(5);

BEGIN
    przyczyna := TABSTR ('uszkodzony plik', 'niezgodnosc z zamowieniem', 'niedporacowane detale', 'podejrzenie plagiatu');
	qprzyczyna := przyczyna.count;
    
	FOR i IN 1..10 LOOP
        rok := dbms_random.value(2015,2017);
		dzien := dbms_random.value(1,355);
		data_wplyniecia := to_char(rok) || to_char(dzien,'999');

        INSERT INTO reklamacje VALUES (
            NULL,    --id INT NOT NULL,
            (select id from (select * from zamowienie order by DBMS_random.value) where rownum = 1), --id zamowienia
            to_date(data_wplyniecia,'yyyyddd'),    --data wplyniecia DATE,
            przyczyna(DBMS_RANDOM.value(1, qprzyczyna)),    --przyczyna,
            (select pesel from (select * from pracownik where stanowisko = 'sprzedawca' order by DBMS_random.value) where rownum = 1),    --pracownik odpowiedzialny,
            (select nazwa from (select * from STATUS_REKLAMACJI order by DBMS_random.value) where rownum = 1)    --status reklamacji, 
            );
	END LOOP;
       
	DBMS_OUTPUT.put_line('Nowe wiersze dodane.');

END REKLAMACJE_GENERATOR;









CREATE OR REPLACE PROCEDURE PRACOWNIK_PRAC_GENERATOR IS
    
    rok NUMBER(4);
	data_rozpoczecia VARCHAR2(10);
    data_zakonczenia VARCHAR2(10);
	dzien NUMBER(5);
    dzien_zakonczenia NUMBER(5);
    procent INT;

BEGIN
	FOR i IN 1..10 LOOP
        rok := dbms_random.value(2015,2017);
		dzien := dbms_random.value(1,340);
        dzien_zakonczenia := dzien + dbms_random.value(1,15);
		data_rozpoczecia := to_char(rok) || to_char(dzien,'999');
        data_zakonczenia := to_char(rok) || to_char(dzien_zakonczenia,'999');
        procent := dbms_random.value(1,100);

        INSERT INTO pracownik_pracuje VALUES (
            NULL,    --id INT NOT NULL,
            (select pesel from (select * from pracownik where stanowisko = 'sprzedawca' order by DBMS_random.value) where rownum = 1),    --pracownik
            (select id from (select * from zamowienie order by DBMS_random.value) where rownum = 1), --id zamowienia
            (select nazwa from (select * from etap order by DBMS_random.value) where rownum = 1),   --etap, 
            to_date(data_rozpoczecia,'yyyyddd'),   --data wplyniecia DATE,
            to_date(data_zakonczenia,'yyyyddd'),
            procent
            );
	END LOOP;
       
	DBMS_OUTPUT.put_line('Nowe wiersze dodane.');
END PRACOWNIK_PRAC_GENERATOR;