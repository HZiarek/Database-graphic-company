CREATE OR REPLACE TRIGGER sumowanie_punktow
AFTER INSERT OR UPDATE ON zamowienie
FOR EACH ROW
declare
    nowe_punkty INT;
    stare_punkty INT;
BEGIN
    select ilosc_punktow_klienta into stare_punkty from klient where id = :new.klient;
    nowe_punkty := :new.liczba_pkt_klienta + stare_punkty;
  if nowe_punkty > 300
  then
    update klient
    set ILOSC_PUNKTOW_KLIENTA = 300
    where id = :new.klient;
  else
    update klient
    set ILOSC_PUNKTOW_KLIENTA = nowe_punkty
    where id = :new.klient;
  end if;
END;
/

CREATE OR REPLACE TRIGGER liczenie_ceny_ze_znizka
BEFORE INSERT ON zamowienie
FOR EACH ROW
declare
    punkty INT;
BEGIN
    select ilosc_punktow_klienta into punkty from klient where id = :new.klient;
    :new.cena_ze_znizka := ROUND(:new.cena - (:new.cena *  punkty/1000), 2);
END;
/

CREATE OR REPLACE TRIGGER pracownik_prac_ograniczenia
BEFORE INSERT OR UPDATE ON pracownik_pracuje
FOR EACH ROW
declare
    poczatek INT;
    koniec INT;
BEGIN
    select COUNT(*) into poczatek from pracownik_pracuje where zamowienie = :new.zamowienie and etap = 'przyjecie';
    select COUNT(*) into koniec from pracownik_pracuje where zamowienie = :new.zamowienie and etap = 'oddanie' ;
    
    if (:new.etap = 'przyjecie' and poczatek <> 0)
      then
        RAISE_APPLICATION_ERROR( -20001, 'Zamowienie o tym id zostalo juz przyjete');
      end if;
  
      if (:new.etap = 'oddanie' and koniec <> 0)
      then
        RAISE_APPLICATION_ERROR( -20002, 'Zamowienie o tym id zostalo juz oddane');
      end if;
  
      if (:new.etap <> 'przyjecie' and poczatek = 0)
      then
        RAISE_APPLICATION_ERROR( -20003, 'Nie mozna wprowadzac danych odnosnie nieprzyjetego zamowienia');
      end if;
      
      if (koniec = 1)
      then
        RAISE_APPLICATION_ERROR( -20003, 'Nie mozna wprowadzac danych odnosnie oddanego zamowienia');
      end if;
      
      if :new.data_zakonczenia < :new.data_rozpoczecia
      then
        RAISE_APPLICATION_ERROR( -20004, 'Bledne daty');
      end if;
END;
/


CREATE OR REPLACE TRIGGER pracownik_a_etap
BEFORE INSERT OR UPDATE ON pracownik_pracuje
FOR EACH ROW
WHEN (NEW.etap <> 'przyjecie' and NEW.etap <> 'oddanie')
declare
    stan VARCHAR2(20);
BEGIN
    select stanowisko into stan from pracownik where pesel = :new.pracownik;
    
    if (stan <> 'grafik')
      then
        RAISE_APPLICATION_ERROR( -20005, 'Etapy graficzne moga realizowac jedynie graficy');
      end if;

END;
/


CREATE OR REPLACE TRIGGER zmiana_statusu_zamowienia
AFTER INSERT OR UPDATE ON pracownik_pracuje
FOR EACH ROW
WHEN (NEW.etap = 'oddanie')
BEGIN
    update zamowienie
    set STATUS_ZAMOWIENIA = 'zrealizowane'
    where id = :new.zamowienie;
END;
/