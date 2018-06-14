--plik prezentujacy dzialanie trigger'ow pracownik_a_etap oraz pracownik_prac_ograniczenia
insert into pracownik_pracuje values(
NULL,
'90060804786',
57,
'oddanie',
TO_DATE('11/01/2017', 'DD/MM/YYYY'),
TO_DATE('12/01/2017', 'DD/MM/YYYY')
);

select * from zamowienie;

select * from pracownik_pracuje;

delete from pracownik_pracuje;