--wszystkie odrzucone zamowienia
select id, cena from zamowienie
where STATUS_ZAMOWIENIA = 'odrzucone';

--ilosc odrzuconych zamowien i ich wartosc
select count(*) as liczba_odrzuconych, sum(cena) as wartosc from zamowienie
where STATUS_ZAMOWIENIA = 'odrzucone';

--klienci ktorych choc jedno zamowienie zostalo odrzucone
select klient.id, imie, nazwisko from klient, zamowienie
where klient.id=zamowienie.klient and STATUS_ZAMOWIENIA = 'odrzucone';

--reklamacje
select * from reklamacje;