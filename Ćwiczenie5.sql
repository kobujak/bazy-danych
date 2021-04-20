CREATE DATABASE firma;
USE firma
GO



CREATE SCHEMA ksiegowosc;
GO

CREATE TABLE ksiegowosc.pracownicy(id_pracownika int primary key not null, imie varchar(50) not null, nazwisko varchar(50) not null, adres varchar (100) not null, telefon int not null)
CREATE TABLE ksiegowosc.godziny(id_godziny int primary key not null, data date, liczba_godzin int, id_pracownika int)
CREATE TABLE ksiegowosc.pensje(id_pensji int primary key not null, stanowisko varchar(50),kwota smallmoney not null, id_premii int)
CREATE TABLE ksiegowosc.premie(id_premii int primary key not null, rodzaj varchar(100), kwota smallmoney)
CREATE TABLE ksiegowosc.wynagrodzenie(id_wynagordzenia int primary key not null, data date, id_pracownika int not null ,id_godziny int not null, id_pensji int not null, id_premii int not null)
GO

ALTER TABLE ksiegowosc.pensje ADD FOREIGN KEY(id_premii) REFERENCES ksiegowosc.premie(id_premii)
ALTER TABLE ksiegowosc.godziny ADD FOREIGN KEY(id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika)
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY(id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika)
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY(id_godziny) REFERENCES ksiegowosc.godziny(id_godziny)
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY(id_pensji) REFERENCES ksiegowosc.pensje(id_pensji)
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY(id_premii) REFERENCES ksiegowosc.premie(id_premii)
GO

INSERT INTO ksiegowosc.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES(1 , 'Kazimierz', 'Sczepaniak', 'Kraków, Leœna 16',527359800),
(2 , 'Zenon', 'B¹k', 'Kraków, Szkolna 29',546493108),
(3 , 'Jakub', 'Nowacki', 'Kraków, Parkowa 11/24',572957771),
(4 , 'Roman', 'Kurek', 'Wieliczka, Modrzewiowa 28',774232308),
(5 , 'El¿bieta', 'Wasilewska', 'Kraków, Rzemieœlnicza 5',679424333),
(6 , 'Wiktoria', 'Kowalczyk', 'Myœlenice, Herbaciana 94',646548181),
(7 , 'Olga', 'Kot', 'Kraków, Stawowa 60',559544322),
(8 , 'Kazimierz', 'Borowski', 'Kraków, Podmiejska 1',876916336),
(9 , 'Maciej', 'Zalewski', 'Skawina, Kasztanowa 44 ',615308212),
(10 , 'Miko³aj', 'WoŸniak', 'Kraków, Konopnickiej 122',540617888)
GO 

INSERT INTO ksiegowosc.godziny( id_godziny, data, liczba_godzin, id_pracownika)
VALUES(1, '2021-03-31', 160,1),
(2, '2021-03-31', 120,2),
(3, '2021-03-31', 200,3),
(4, '2021-03-31', 144,4),
(5, '2021-03-31', 156,5),
(6, '2021-03-31', 168,6),
(7, '2021-03-31', 152,7),
(8, '2021-03-31', 60,8),
(9, '2021-03-31', 160,9),
(10, '2021-03-31', 160,10)

INSERT INTO ksiegowosc.pensje(id_pensji, stanowisko, kwota, id_premii)
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

INSERT INTO ksiegowosc.premie(id_premii, rodzaj, kwota)
VALUES (1,'regulaminowa',200),
(2,'regulaminowa',200),
(3,'uznaniowa',600),
(4,'motywacyjna',300),
(5,NULL,NULL),
(6,NULL,NULL),
(7,'uznaniowa',200),
(8,'motywacyjna',100),
(9,'motywacyjna',400),
(10,'regulaminowa',200)

INSERT INTO ksiegowosc.wynagrodzenie(id_wynagordzenia, data, id_pracownika, id_godziny, id_pensji, id_premii)
VALUES (1,'2020-04-01',1,1,1,1),
(2,'2020-04-01',2,2,2,2),
(3,'2020-04-01',3,3,3,3),
(4,'2020-04-01',4,4,4,4),
(5,'2020-04-01',5,5,5,5),
(6,'2020-04-01',6,6,6,6),
(7,'2020-04-01',7,7,7,7),
(8,'2020-04-01',8,8,8,8),
(9,'2020-04-01',9,9,9,9),
(10,'2020-04-01',10,10,10,10)

--a) Wyœwietl tylko id pracownika oraz jego nazwisko.

SELECT id_pracownika, nazwisko from ksiegowosc.pracownicy

--b) Wyœwietl id pracowników, których p³aca jest wiêksza ni¿ 1000. 

SELECT id_pracownika from ksiegowosc.wynagrodzenie join ksiegowosc.pensje ON ksiegowosc.pensje.id_pensji = ksiegowosc.wynagrodzenie.id_pensji WHERE pensje.kwota > 3000

--c) Wyœwietl id pracowników nieposiadaj¹cych premii, których p³aca jest wiêksza ni¿ 2000.

SELECT id_pracownika from ksiegowosc.wynagrodzenie join ksiegowosc.pensje ON ksiegowosc.pensje.id_pensji = ksiegowosc.wynagrodzenie.id_pensji 
join ksiegowosc.premie ON ksiegowosc.premie.id_premii = ksiegowosc.wynagrodzenie.id_premii WHERE pensje.kwota >2000 AND premie.kwota IS NULL

--d) Wyœwietl pracowników, których pierwsza litera imienia zaczyna siê na literê ‘J’. 

SELECT imie, nazwisko from ksiegowosc.pracownicy WHERE imie LIKE 'J%'

--e) Wyœwietl pracowników, których nazwisko zawiera literê ‘n’ oraz imiê koñczy siê na literê ‘a’. 

SELECT imie, nazwisko from ksiegowosc.pracownicy WHERE nazwisko LIKE '%a' OR nazwisko LIKE '%n%'

--f) Wyœwietl imiê i nazwisko pracowników oraz liczbê ich nadgodzin, przyjmuj¹c, i¿ standardowy czas pracy to 160 h miesiêcznie.

SELECT imie, nazwisko, ksiegowosc.godziny.liczba_godzin - 160 AS nadgodziny from ksiegowosc.pracownicy join ksiegowosc.godziny ON ksiegowosc.godziny.id_pracownika = ksiegowosc.pracownicy.id_pracownika
WHERE liczba_godzin >160

--g) Wyœwietl imiê i nazwisko pracowników, których pensja zawiera siê w przedziale 1500 – 3000 PLN. 

SELECT imie, nazwisko from ksiegowosc.pracownicy join ksiegowosc.wynagrodzenie ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
join ksiegowosc.pensje ON ksiegowosc.pensje.id_pensji = ksiegowosc.wynagrodzenie.id_pensji WHERE kwota >= 1500 AND kwota <= 3000

--h) Wyœwietl imiê i nazwisko pracowników, którzy pracowali w nadgodzinach i nie otrzymali premii. 

SELECT imie ,nazwisko from ksiegowosc.pracownicy join ksiegowosc.godziny ON ksiegowosc.godziny.id_pracownika = ksiegowosc.pracownicy.id_pracownika
join ksiegowosc.wynagrodzenie ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
join ksiegowosc.premie ON ksiegowosc.premie.id_premii = ksiegowosc.wynagrodzenie.id_premii WHERE premie.kwota IS NULL AND godziny.liczba_godzin >160

--i) Uszereguj pracowników wed³ug pensji. 

SELECT imie, nazwisko, ksiegowosc.pensje.kwota from ksiegowosc.pracownicy join ksiegowosc.wynagrodzenie ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
join ksiegowosc.pensje ON ksiegowosc.pensje.id_pensji = ksiegowosc.wynagrodzenie.id_pensji ORDER BY kwota

--j) Uszereguj pracowników wed³ug pensji i premii malej¹co. 

SELECT imie, nazwisko, ksiegowosc.pensje.kwota AS Pensja, ksiegowosc.premie.kwota AS Premia from ksiegowosc.pracownicy join ksiegowosc.wynagrodzenie ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
join ksiegowosc.pensje ON ksiegowosc.pensje.id_pensji = ksiegowosc.wynagrodzenie.id_pensji 
join ksiegowosc.premie ON ksiegowosc.premie.id_premii = ksiegowosc.wynagrodzenie.id_premii ORDER BY premie.kwota ,pensje.kwota

--k) Zlicz i pogrupuj pracowników wed³ug pola ‘stanowisko’. 

SELECT stanowisko, COUNT(*) AS iloœæ from ksiegowosc.pracownicy
join ksiegowosc.wynagrodzenie ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
join ksiegowosc.pensje ON ksiegowosc.pensje.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
GROUP BY stanowisko

--l) Policz œredni¹, minimaln¹ i maksymaln¹ p³acê dla stanowiska ‘kierownik’ (je¿eli takiego nie masz, to przyjmij dowolne inne). 

SELECT stanowisko, avg(kwota) AS œrednia, max(kwota)AS najwy¿sze, min(kwota)AS najni¿sze from ksiegowosc.pensje WHERE stanowisko = 'kierownik' GROUP BY stanowisko

--m) Policz sumê wszystkich wynagrodzeñ. 

SELECT sum(pensje.kwota) AS suma_wynagrodzeñ from ksiegowosc.pensje

--f) Policz sumê wynagrodzeñ w ramach danego stanowiska. 

SELECT sum(pensje.kwota) AS suma_wynagrodzeñ_stan, pensje.stanowisko from ksiegowosc.pensje GROUP BY stanowisko

--g) Wyznacz liczbê premii przyznanych dla pracowników danego stanowiska. 

SELECT count(premie.id_premii) as liczba_premii_stan, pensje.stanowisko from ksiegowosc.premie
join ksiegowosc.pensje ON ksiegowosc.pensje.id_premii = ksiegowosc.premie.id_premii GROUP BY stanowisko

--h) Usuñ wszystkich pracowników maj¹cych pensjê mniejsz¹ ni¿ 1200 z³.

DELETE pracownicy from ksiegowosc.pracownicy join ksiegowosc.wynagrodzenie ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
join ksiegowosc.pensje ON ksiegowosc.pensje.id_pensji = ksiegowosc.wynagrodzenie.id_pensji WHERE kwota <1200
