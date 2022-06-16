-- Funkcja zwraca ilość dokonanych adopcji poprzez osobę o identyfikatorze zadanym jako parametr funkcji.
CREATE FUNCTION ilosc_adopcji_przez_osobe (@id INT)
returns INT
AS
BEGIN
DECLARE @ilosc INT
SET @ilosc = (SELECT COUNT(*) FROM adopcja WHERE idosoba_adoptujaca = @id)
return @ilosc
END

SELECT dbo.ilosc_adopcji_przez_osobe(2) AS ilosc


-- Funkcja zwraca różnicę pomiędzy największym a najmniejszym wiekiem zwierzęcia.
CREATE FUNCTION roznica_wieku ()
returns INT
AS
BEGIN
DECLARE @roznica_wieku INT
SET @roznica_wieku = (SELECT max(wiek) FROM zwierze WHERE idzwierze NOT IN (SELECT idzwierze FROM adopcja)) - (SELECT min(wiek) FROM zwierze WHERE idzwierze NOT IN (SELECT idzwierze FROM adopcja))
return @roznica_wieku
END

SELECT dbo.roznica_wieku()


--Procedura wyświetla informacje na temat wszystkich zwierząt danego gatunku.
CREATE PROCEDURE wypisz_zwierzeta @nazwa VARCHAR(30) 
AS
SELECT * FROM zwierze JOIN gatunek ON zwierze.idgatunek = gatunek.idgatunek WHERE gatunek.nazwa = @nazwa

EXEC wypisz_zwierzeta @nazwa = "kot"


-- Procedura dodaje nowe stanowisko do bazy.
CREATE PROCEDURE nowe_stanowisko @nazwa VARCHAR(45), @zakres_obowiazkow VARCHAR(255), @wynagrodzenie_brutto DECIMAL (5), @wymiar_godzin INT
AS
INSERT INTO stanowisko VALUES (@nazwa, @zakres_obowiazkow, @wynagrodzenie_brutto, @wymiar_godzin)

EXEC nowe_stanowisko @nazwa = "pracownik budowlany", @zakres_obowiazkow = "prace naprawcze na terenie budynku", @wynagrodzenie_brutto = "4500", @wymiar_godzin = "80"


-- Widok zawiera informacje o tym, ile razy została postawiona każda diagnoza.
CREATE VIEW diagnoza_raport
AS
SELECT diagnoza.iddiagnoza, diagnoza.nazwa, COUNT(zwierze_has_diagnoza.iddiagnoza) AS ilosc
from zwierze_has_diagnoza JOIN diagnoza ON zwierze_has_diagnoza.iddiagnoza = diagnoza.iddiagnoza
GROUP BY diagnoza.iddiagnoza, diagnoza.nazwa

SELECT * FROM diagnoza_raport


-- Widok zawiera informacje o ilości adopcji, przy których obecny był każdy wolontariusz.
CREATE VIEW wolontariusz_raport
AS
SELECT wolontariusz.idwolontariusz, wolontariusz.nazwisko, wolontariusz.imie, COUNT(adopcja.idwolontariusz) AS ilosc_adopcji
FROM adopcja JOIN wolontariusz ON wolontariusz.idwolontariusz = adopcja.idwolontariusz
GROUP BY wolontariusz.idwolontariusz, wolontariusz.nazwisko, wolontariusz.imie

SELECT * FROM wolontariusz_raport


-- Po usunięciu wolontariusza wyzwalacz przenosi jego dane do archiwum.
CREATE TABLE wolontariusz_archiwum(
    idwolontariusz INT,
    imie VARCHAR(20) NOT NULL,
    nazwisko VARCHAR(45) NOT NULL,
    e_mail VARCHAR(45),
    tel_komorkowy VARCHAR(15) NOT NULL,
    kod_pocztowy VARCHAR(20),
    miasto VARCHAR(20),
    ulica VARCHAR(45),
    nr_budynku VARCHAR(4),
    nr_mieszkania INT,
    zakres_obowiazkow VARCHAR(255),
    data_usuniecia DATETIME)

CREATE TRIGGER archiwizuj
on wolontariusz
AFTER DELETE
AS
BEGIN
SET NOCOUNT ON
INSERT INTO wolontariusz_archiwum
SELECT idwolontariusz, imie, nazwisko, e_mail, tel_komorkowy, kod_pocztowy, miasto, ulica, nr_budynku,
nr_mieszkania, zakres_obowiazkow, GETDATE() FROM deleted
END

DELETE FROM wolontariusz WHERE idwolontariusz = 3