-- koty tylko do adopcji
SELECT zwierze.imie, zwierze.wiek FROM zwierze 
LEFT JOIN gatunek ON zwierze.idgatunek = gatunek.idgatunek
LEFT JOIN adopcja ON zwierze.idzwierze = adopcja.idzwierze
WHERE gatunek.nazwa = 'kot' AND adopcja.idzwierze IS NULL ORDER BY wiek ASC

-- ile zwierząt ma alergię pokarmową
SELECT zwierze.idzwierze, zwierze.imie, gatunek.nazwa, diagnoza.nazwa FROM zwierze
JOIN zwierze_has_diagnoza ON zwierze_has_diagnoza.idzwierze = zwierze.idzwierze
JOIN diagnoza ON zwierze_has_diagnoza.iddiagnoza = diagnoza.iddiagnoza 
JOIN gatunek on gatunek.idgatunek = zwierze.idgatunek
WHERE diagnoza.nazwa = 'alergia pokarmowa'

-- ile zwierząt ma każda osoba adoptująca
SELECT osoba_adoptujaca.nazwisko, osoba_adoptujaca.imie, 
COUNT (osoba_adoptujaca.idosoba_adoptujaca) AS liczba_adoptowanych_zwierzat
FROM osoba_adoptujaca JOIN adopcja ON osoba_adoptujaca.idosoba_adoptujaca = adopcja.idosoba_adoptujaca
GROUP BY osoba_adoptujaca.nazwisko, osoba_adoptujaca.imie 
ORDER BY COUNT(osoba_adoptujaca.idosoba_adoptujaca) ASC

-- iloma zwierzętami opiekują się poszczególni wolontariusze
SELECT  wolontariusz.idwolontariusz, wolontariusz.nazwisko, 
COUNT (wolontariusz.idwolontariusz) AS liczba_zwierzat_pod_opieka
FROM wolontariusz LEFT JOIN zwierze ON wolontariusz.idwolontariusz = zwierze.idwolontariusz
GROUP BY  wolontariusz.idwolontariusz, wolontariusz.nazwisko 
ORDER BY COUNT (wolontariusz.idwolontariusz) ASC

-- znaleźć weterynarza
SELECT nazwisko, imie FROM pracownik JOIN stanowisko ON pracownik.idstanowisko = stanowisko.idstanowisko 
WHERE stanowisko.nazwa = 'lekarz weterynarii'

-- pokazać diagnozy weterynarza o nazwisku Kwiatkowski
SELECT pracownik.nazwisko, diagnoza.nazwa FROM pracownik 
JOIN wizyta_weterynaryjna ON pracownik.idpracownik = wizyta_weterynaryjna.idpracownik
JOIN zwierze_has_diagnoza ON wizyta_weterynaryjna.idwizyta_weterynaryjna = zwierze_has_diagnoza.idwizyta_weterynaryjna
JOIN diagnoza ON zwierze_has_diagnoza.iddiagnoza = diagnoza.iddiagnoza
WHERE pracownik.nazwisko = 'Kwiatkowski'

-- zakres obowiązków wolontariusza o konkretnym nazwisku
SELECT wolontariusz.nazwisko, wolontariusz.zakres_obowiazkow FROM wolontariusz WHERE nazwisko = 'Kowalski'

-- ilu jest pracowników
SELECT COUNT(pracownik.idpracownik) AS liczba_pracownikow FROM pracownik 

-- jakie wynagrodzenie dostaje weterynarz
SELECT pracownik.idpracownik, pracownik.nazwisko, stanowisko.wynagrodzenie_brutto 
FROM pracownik JOIN stanowisko ON pracownik.idstanowisko = stanowisko.idstanowisko

-- średnie wynagrodzenie pracowników
SELECT ROUND(AVG(stanowisko.wynagrodzenie_brutto), 2) FROM stanowisko 

-- data wizyty poadopcyjnej konkretnego zwierzęcia
SELECT zwierze.imie, gatunek.nazwa, wizyta_poadopcyjna.data_wizyty as data_wizyty_poadopcyjnej 
FROM zwierze 
JOIN adopcja ON zwierze.idzwierze = adopcja.idzwierze
JOIN wizyta_poadopcyjna ON adopcja.idadopcja = wizyta_poadopcyjna.idadopcja
JOIN gatunek ON zwierze.idgatunek = gatunek.idgatunek
WHERE zwierze.imie = 'Kitek'