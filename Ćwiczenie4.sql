CREATE DATABASE firma;
USE firma
GO

CREATE SCHEMA rozliczenia;
GO

CREATE TABLE rozliczenia.pracownicy(id_pracownika int primary key not null, imie varchar(50) not null, nazwisko varchar(50) not null, adres varchar (100) not null, telefon int not null)
CREATE TABLE rozliczenia.godziny(id_godziny int primary key not null, data date, liczba_godzin int, id_pracownika int)
CREATE TABLE rozliczenia.pensje(id_pensji int primary key not null, stanowisko varchar(50),kwota smallmoney not null, id_premii int)
CREATE TABLE rozliczenia.premie(id_premii int primary key not null, rodzaj varchar(100), kwota smallmoney not null)
GO
ALTER TABLE rozliczenia.pensje ADD FOREIGN KEY(id_premii) REFERENCES rozliczenia.premie(id_premii)
ALTER TABLE rozliczenia.godziny ADD FOREIGN KEY(id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika)

GO

INSERT INTO rozliczenia.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES(1 , 'Kazimierz', 'Sczepaniak', 'Kraków, Leœna 16',527359800),
(2 , 'Zenon', 'B¹k', 'Kraków, Szkolna 29',546493108),
(4 , 'Jakub', 'Nowacki', 'Kraków, Parkowa 11/24',572957771),
(5 , 'Roman', 'Kurek', 'Wieliczka, Modrzewiowa 28',774232308),
(8 , 'El¿bieta', 'Wasilewska', 'Kraków, Rzemieœlnicza 5',679424333),
(9 , 'Wiktoria', 'Kowalczyk', 'Myœlenice, Herbaciana 94',646548181),
(10 , 'Olga', 'Kot', 'Kraków, Stawowa 60',559544322),
(11 , 'Kazimierz', 'Borowski', 'Kraków, Podmiejska 1',876916336),
(13 , 'Maciej', 'Zalewski', 'Skawina, Kasztanowa 44 ',615308212),
(14 , 'Miko³aj', 'WoŸniak', 'Kraków, Konopnickiej 122',540617888)
GO 

INSERT INTO rozliczenia.godziny( id_godziny, data, liczba_godzin, id_pracownika)
VALUES(1, '2021-03-31', 160,1),
(2, '2021-03-31', 120,2),
(3, '2021-03-31', 200,4),
(4, '2021-03-31', 144,5),
(5, '2021-03-31', 156,8),
(6, '2021-03-31', 168,9),
(7, '2021-03-31', 152,10),
(8, '2021-03-31', 60,11),
(9, '2021-03-31', 160,13),
(10, '2021-03-31', 160,14)

INSERT INTO rozliczenia.pensje(id_pensji, stanowisko, kwota, id_premii)
VALUES(1,'kierownik',7500,1),
(2,'kierownik',5600,2),
(3,'zastêpca',7500,3),
(4,'pracownik biurowy',3800,4),
(5,'sprz¹taj¹cy',3000,5),
(6,'przedstawiciel handlowy',4600,6),
(7,'przedstawiciel handlowy',4200,7),
(8,'NULL',2100,8),
(9,'IT',6300,9),
(10,'IT',6300,10)

INSERT INTO rozliczenia.premie(id_premii, rodzaj, kwota)
VALUES (1,'regulaminowa',200),
(2,'regulaminowa',200),
(3,'uznaniowa',600),
(4,'motywacyjna',300),
(5,'regulaminowa',100),
(6,'uznaniowa',200),
(7,'uznaniowa',200),
(8,'motywacyjna',100),
(9,'motywacyjna',400),
(10,'regulaminowa',200)


SELECT nazwisko, adres FROM rozliczenia.pracownicy






SELECT *, DATEPART(WEEKDAY,data) AS 'Dzieñ Tygodnia' , DATEPART(MONTH,data) AS 'Miesi¹c' from rozliczenia.godziny

EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN'

ALTER TABLE rozliczenia.pensje ADD kwota_netto smallmoney

UPDATE rozliczenia.pensje SET kwota_netto = 0.73*kwota_brutto

SELECT * FROM rozliczenia.pensje





