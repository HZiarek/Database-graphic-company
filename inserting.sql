insert into etap values(
'przyjecie',
'zdefiniowanie oczekiwan klienta i ustalenie ceny'
);

insert into etap values(
'koncept',
'tworzenie wstepnego zarysu projektu'
);

insert into etap values(
'realizacja',
'wykonanie kluczowych elementow'
);

insert into etap values(
'detale',
'dopracowywanie zamowienia'
);

insert into etap values(
'oddanie',
'przedstawienie efektow pracy klientowi'
);

insert into status_zamowienia values(
'przyjete',
'przyjecie przebieglo pomyslnie i niedlugo zamowienie trafi do realizacji'
);

insert into status_zamowienia values(
'odrzucone',
'klient zrezygnowal lub firma nie byla w stanie zrealizowac zamowienia'
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
TO_DATE('11/01/2017', 'DD/MM/YYYY')
);

insert into zrodlo_pozyskania_zamowienia values(
'strona internetowa',
TO_DATE('12/01/2016', 'DD/MM/YYYY')
);

insert into zrodlo_pozyskania_zamowienia values(
'allegro',
TO_DATE('15/08/2015', 'DD/MM/YYYY')
);


insert into status_reklamacji values(
'zaakceptowana',
NULL
);

insert into status_reklamacji values(
'odrzucona',
'pracownik nie znalazl podstaw do zaakceptowania reklamacji'
);

insert into status_reklamacji values(
'rozpatrywana',
'pracownik analizuje reklamacje'
);

insert into pracownik values(
'81100216357',
'Marcin',
'Kowalski',
'mkowal@gmail.com',
'346986235',
'ul. Warynskiego 13, Warszawa',
'manager'
);

insert into pracownik values(
'92071314764',
'Karolina',
'Nowak',
'karolcia@o2.pl',
'346152358',
'ul. Platnicza 72, Warszawa',
'grafik'
);

insert into pracownik values(
'80072909146',
'Marta',
'Nowak',
'mnowak@o2.pl',
'346152123',
'ul. Platnicza 72, Warszawa',
'grafik'
);

insert into pracownik values(
'90080517455',
'Artur',
'Korolczuk',
'akorol@ineria.pl',
'390152123',
'ul. Marymoncka 17, Warszawa',
'sprzedawca'
);

insert into pracownik values(
'90060804786',
'Angelika',
'Korzeniewska',
'angelk@gmail.com',
'724678234',
'ul. Kolejowa 10, Siedlce',
'sprzedawca'
);

set serveroutput on;
exec klient_generator;
exec zamowienie_generator;
exec reklamacje_generator;
--exec pracownik_prac_generator;

commit;