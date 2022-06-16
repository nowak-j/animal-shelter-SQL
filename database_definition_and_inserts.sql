SET DATEFORMAT ymd;

CREATE TABLE wolontariusz (
    idwolontariusz int IDENTITY(1,1) PRIMARY KEY,
    imie VARCHAR(20) NOT NULL,
    nazwisko VARCHAR(45) NOT NULL,
    e_mail VARCHAR(45),
    tel_komorkowy VARCHAR(15) NOT NULL,
    kod_pocztowy VARCHAR(20),
    miasto VARCHAR(20),
    ulica VARCHAR(45),
    nr_budynku VARCHAR(4),
    nr_mieszkania INT,
    zakres_obowiazkow VARCHAR(255)
);

CREATE TABLE gatunek (
    idgatunek int IDENTITY(1,1) PRIMARY KEY,
    nazwa VARCHAR(45) NOT NULL UNIQUE
);

CREATE TABLE zwierze (
    idzwierze int IDENTITY(1,1) PRIMARY KEY,
    idwolontariusz int references wolontariusz(idwolontariusz),
    idgatunek int references gatunek(idgatunek) NOT NULL,
    imie VARCHAR(20) NOT NULL,
    data_przyjecia DATETIME DEFAULT GETDATE(),
    plec VARCHAR(20) NOT NULL,
    wiek INT,
    waga DECIMAL(3,1),
    informacje VARCHAR(255) NOT NULL,
    czy_kastracja BIT NOT NULL DEFAULT 0,
    zdjecie IMAGE,

    CONSTRAINT fk_zwierze_wolontariusz
    FOREIGN KEY (idwolontariusz)
    REFERENCES wolontariusz(idwolontariusz)
    ON DELETE SET NULL 
);

CREATE TABLE osoba_adoptujaca (
    idosoba_adoptujaca int IDENTITY(1,1) PRIMARY KEY,
    imie VARCHAR(20) NOT NULL,
    nazwisko VARCHAR(45) NOT NULL,
    e_mail VARCHAR(45),
    tel_komorkowy VARCHAR(15) NOT NULL,
    kod_pocztowy VARCHAR(20) NOT NULL,
    miasto VARCHAR(20) NOT NULL,
    ulica VARCHAR(45),
    nr_budynku VARCHAR(4) NOT NULL,
    nr_mieszkania INT
);

CREATE TABLE stanowisko (
    idstanowisko int IDENTITY(1,1) PRIMARY KEY,
    nazwa VARCHAR(45) NOT NULL UNIQUE,
    zakres_obowiazkow VARCHAR(255),
    wynagrodzenie_brutto DECIMAL(6,2) NOT NULL,
    wymiar_godzin INT NOT NULL
);

CREATE TABLE pracownik (
    idpracownik int IDENTITY(1,1) PRIMARY KEY,
    idstanowisko int references stanowisko(idstanowisko) NOT NULL,
    imie VARCHAR(20) NOT NULL,
    nazwisko VARCHAR(45) NOT NULL,
    e_mail VARCHAR(45),
    tel_komorkowy VARCHAR(15) NOT NULL,
    kod_pocztowy VARCHAR(20) NOT NULL,
    miasto VARCHAR(20) NOT NULL,
    ulica VARCHAR(45),
    nr_budynku VARCHAR(4) NOT NULL,
    nr_mieszkania INT
);

CREATE TABLE adopcja (
    idadopcja int IDENTITY(1,1) PRIMARY KEY,
    idzwierze int references zwierze(idzwierze) NOT NULL,
    idosoba_adoptujaca int references osoba_adoptujaca(idosoba_adoptujaca) NOT NULL,
    idwolontariusz int references wolontariusz(idwolontariusz),
    idpracownik int references pracownik(idpracownik) NOT NULL,
    data_adopcji DATETIME DEFAULT GETDATE(),
    notatki VARCHAR(255),

    CONSTRAINT fk_adopcja_wolontariusz
    FOREIGN KEY (idwolontariusz)
    REFERENCES wolontariusz(idwolontariusz)
    ON DELETE SET NULL
);

CREATE TABLE wizyta_weterynaryjna (
    idwizyta_weterynaryjna int IDENTITY(1,1) PRIMARY KEY,
    idpracownik int references pracownik(idpracownik) NOT NULL,
    idzwierze int references zwierze(idzwierze) NOT NULL,
    data_wizyty DATETIME DEFAULT GETDATE()
);

CREATE TABLE wizyta_poadopcyjna (
    idwizyta_poadopcyjna int IDENTITY(1,1) PRIMARY KEY,
    idadopcja int references adopcja(idadopcja) NOT NULL,
    idpracownik int references pracownik(idpracownik) NOT NULL,
    data_wizyty DATETIME DEFAULT GETDATE(),
    komentarz VARCHAR(255) NOT NULL CHECK (len(komentarz)>10)
);

CREATE TABLE diagnoza (
    iddiagnoza int IDENTITY(1,1) PRIMARY KEY,
    nazwa VARCHAR(45) NOT NULL UNIQUE
);

CREATE TABLE zwierze_has_diagnoza (
    idzwierze_has_diagnoza int IDENTITY(1,1) PRIMARY KEY,
    iddiagnoza int references diagnoza(iddiagnoza) NOT NULL,
    idzwierze int references zwierze(idzwierze) NOT NULL,
    idwizyta_weterynaryjna int references wizyta_weterynaryjna(idwizyta_weterynaryjna) NOT NULL,
    komentarz VARCHAR(255),
    zalecenia VARCHAR(255) NOT NULL CHECK (len(zalecenia)>10)
)


INSERT INTO gatunek (nazwa) VALUES ('pies')

INSERT INTO gatunek (nazwa) VALUES ('kot')

INSERT INTO gatunek (nazwa) VALUES ('szynszyla')

INSERT INTO wolontariusz (imie, nazwisko, tel_komorkowy, zakres_obowiazkow)
VALUES ('Jan', 'Kowalski', '123456789', 'praca ze zwierzętami nadpobudliwymi, lękliwymi lub agresywnymi')

INSERT INTO wolontariusz (imie, nazwisko, tel_komorkowy, zakres_obowiazkow, e_mail)
VALUES ('Joanna', 'Nowak', '987654321', 'nauka podstaw posłuszeństwa, spacery poza teren schroniska', 'to_jest_email@wp.pl')

INSERT INTO wolontariusz (imie, nazwisko, tel_komorkowy, zakres_obowiazkow)
VALUES ('Jan', 'Sienkiewicz', '231313624', 'spacery poza teren schroniska')

INSERT INTO zwierze (imie, plec, wiek, waga, informacje, czy_kastracja, idgatunek, idwolontariusz) 
VALUES ('Reksio', 'samiec', 5, 10.5, 'ufny, ładnie chodzi na smyczy', 1, 1, 1)

INSERT INTO zwierze (imie, plec, wiek, waga, informacje, idgatunek, idwolontariusz) 
VALUES ('Azor', 'samiec', 0.5, 10, 'agresywny w stosunku do dzieci', 1, 1)

INSERT INTO zwierze (imie, plec, wiek, waga, informacje, idgatunek) 
VALUES ('Blanka', 'kot', 2, 3, 'może przebywać z innymi kotami', 2)

INSERT INTO zwierze (imie, plec, wiek, waga, informacje, idgatunek) 
VALUES ('Kitek', 'kot', 7, 2, 'nie akceptuje psów', 2)

INSERT INTO zwierze (imie, plec, wiek, waga, informacje, idgatunek) 
VALUES ('Kropek', 'kot', 7, 2, 'nie akceptuje psów', 2)

INSERT INTO zwierze (imie, plec, wiek, waga, informacje, idgatunek) 
VALUES ('Fafik', 'pies', 8, 35, 'ma tendencję do uciekania', 1)

INSERT INTO zwierze (imie, plec, wiek, waga, informacje, idgatunek) 
VALUES ('Rambo', 'pies', 4, 20, 'ma tendencję do uciekania', 1)

INSERT INTO stanowisko (nazwa, wynagrodzenie_brutto, wymiar_godzin)
VALUES ('pracownik administracyjny', 4220, 160)

INSERT INTO stanowisko (nazwa, wynagrodzenie_brutto, wymiar_godzin)
VALUES ('lekarz weterynarii', 5340.80, 160)

INSERT INTO stanowisko (nazwa, wynagrodzenie_brutto, wymiar_godzin)
VALUES ('kierownik schroniska', 6340.80, 160)

INSERT INTO diagnoza (nazwa) VALUES ('niedożywienie')

INSERT INTO diagnoza (nazwa) VALUES ('alergia pokarmowa')

INSERT INTO diagnoza (nazwa) VALUES ('koci katar')

INSERT INTO pracownik (idstanowisko, nazwisko, imie, tel_komorkowy, kod_pocztowy, miasto, nr_budynku) 
VALUES (1, 'Kowalska', 'Anna', '123456123', '82-320', 'Mała Wieś', 5)

INSERT INTO pracownik (idstanowisko, nazwisko, imie, tel_komorkowy, kod_pocztowy, miasto, ulica, nr_budynku) 
VALUES (2, 'Kwiatkowski', 'Krzysztof', '645829137', '72-520', 'Warszawa', 'Bajkowa', 7)

INSERT INTO pracownik (idstanowisko, nazwisko, imie, tel_komorkowy, kod_pocztowy, miasto, ulica, nr_budynku) 
VALUES (3, 'Kwiatkowska', 'Maria', '456456789', '72-520', 'Warszawa', 'Bajkowa', 7)

INSERT INTO wizyta_weterynaryjna (idpracownik, idzwierze) VALUES (2, 2)

INSERT INTO wizyta_weterynaryjna (idpracownik, idzwierze) VALUES (2, 1)

INSERT INTO wizyta_weterynaryjna (idpracownik, idzwierze) VALUES (2, 3)

INSERT INTO zwierze_has_diagnoza (iddiagnoza, idzwierze, idwizyta_weterynaryjna, zalecenia)
VALUES (2, 2, 1, 'unikanie pokarmów zawierających w składzie zboża lub drób')

INSERT INTO zwierze_has_diagnoza (iddiagnoza, idzwierze, idwizyta_weterynaryjna, zalecenia)
VALUES (1, 1, 2, 'karma weterynaryjna')

INSERT INTO zwierze_has_diagnoza (iddiagnoza, idzwierze, idwizyta_weterynaryjna, zalecenia)
VALUES (3, 3, 3, 'antybiotyk, izolatka')

INSERT INTO osoba_adoptujaca (nazwisko, imie, tel_komorkowy, kod_pocztowy, miasto, ulica, nr_budynku)
VALUES ('Jakaś', 'Alicja', '523698741', '72-520', 'Warszawa', 'Pieskowa', 7)

INSERT INTO osoba_adoptujaca (nazwisko, imie, tel_komorkowy, kod_pocztowy, miasto, ulica, nr_budynku, nr_mieszkania)
VALUES ('Ktoś', 'Krzysztof', '213645897', '82-400', 'Złe Mięso', 'Kolorowa', 23, 7)

INSERT INTO osoba_adoptujaca (nazwisko, imie, tel_komorkowy, kod_pocztowy, miasto, ulica, nr_budynku, nr_mieszkania)
VALUES ('Jackiewicz', 'Jan', '122345568', '82-400', 'Złe Mięso', 'Zbędna', 15, 8)

INSERT INTO adopcja (idzwierze, idosoba_adoptujaca, idwolontariusz, idpracownik)
VALUES (4, 1, 1, 1)

INSERT INTO adopcja (idzwierze, idosoba_adoptujaca, idwolontariusz, idpracownik)
VALUES (5, 1, 1, 1)

INSERT INTO adopcja (idzwierze, idosoba_adoptujaca, idwolontariusz, idpracownik)
VALUES (6, 2, 2, 1)

INSERT INTO adopcja (idzwierze, idosoba_adoptujaca, idwolontariusz, idpracownik)
VALUES (7, 3, 2, 1)

INSERT INTO wizyta_poadopcyjna (idadopcja, idpracownik, komentarz)
VALUES (1, 3, 'brak zastrzeżeń, kot wykazuje poprawę w obcowaniu z ludźmi')

INSERT INTO wizyta_poadopcyjna (idadopcja, idpracownik, komentarz)
VALUES (2, 3, 'brak zastrzeżeń')

INSERT INTO wizyta_poadopcyjna (idadopcja, idpracownik, komentarz)
VALUES (4, 3, 'pies wciąż przejawia tendencję do ucieczek')