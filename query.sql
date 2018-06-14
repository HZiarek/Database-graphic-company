--wszystkie odrzucone zamowienia
select id, cena from zamowienie
where STATUS_ZAMOWIENIA = 'odrzucone';

--ilosc odrzuconych zamowien i ich wartosc
select count(*) as liczba_odrzuconych, sum(cena) as wartosc from zamowienie
where STATUS_ZAMOWIENIA = 'odrzucone';

--klienci ktorych choc jedno zamowienie zostalo odrzucone
select klient.id, imie, nazwisko from klient, zamowienie
where klient.id=zamowienie.klient and STATUS_ZAMOWIENIA = 'odrzucone';

--liczba zgloszonych reklamacji
select COUNT(*) from reklamacje;

--klienci ktorzy dokonali zamowien na co najmniej
select klient.id, imie, nazwisko from klient, zamowienie
where klient.id=zamowienie.klient and STATUS_ZAMOWIENIA = 'odrzucone';

--liczenie liczby zamowien kazdego z klientow
select k.id, count(distinct z.id) as liczba from klient k join zamowienie z on k.id = z.klient
group by k.id
ORDER BY k.id;

--liczenie liczby i wartosci zamowien kazdego z klientow
select k.id, count(distinct z.id) as liczba, sum (z.cena) as wartosc from klient k join zamowienie z on k.id = z.klient
group by k.id
ORDER BY k.id;

--klienci z zamowieniami o wartosci wiekszej niz srednia wartosc na klienta
select k.id, count(distinct z.id) as liczba, sum (z.cena) as wartosc from klient k join zamowienie z on k.id = z.klient
group by k.id
having sum (z.cena) > (
select avg(sum (z.cena)) from klient k join zamowienie z on k.id = z.klient 
group by k.id)
order by 1;

--srednia warosc zamowienia
select round(avg(cena),2) as sr_warosc from zamowienie;
