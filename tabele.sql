CREATE DATABASE testy;

USE testy;

--utworzenie tabel geochronologicznych wed³ug schematu znormalizowanegoi wype³nienie ich danymi

CREATE TABLE GeoEon(id_eon int primary key, nazwa_eon varchar(25))
CREATE TABLE GeoEra(id_era int primary key, id_eon int, nazwa_era varchar(25))
CREATE TABLE GeoOkres(id_okres int primary key, id_era int, nazwa_okres varchar(25))
CREATE TABLE GeoEpoka(id_epoka int primary key, id_okres int, nazwa_epoka varchar(25))
CREATE TABLE GeoPietro(id_pietro int primary key, id_epoka int, nazwa_pietro varchar(25))

ALTER TABLE GeoEra ADD FOREIGN KEY(id_eon) REFERENCES GeoEon(id_eon)
ALTER TABLE GeoOkres ADD FOREIGN KEY(id_era) REFERENCES GeoEra(id_era)
ALTER TABLE GeoEpoka ADD FOREIGN KEY(id_okres) REFERENCES GeoOkres(id_okres)
ALTER TABLE GeoPietro ADD FOREIGN KEY(id_epoka) REFERENCES GeoEpoka(id_epoka)

INSERT INTO GeoEon
VALUES(1,'Fanerozoik')

INSERT INTO GeoEra
VALUES(1,1,'Paleozoik'),
(2,1,'Mezozoik'),
(3,1,'Kenozoik')

INSERT INTO GeoOkres
VALUES(1,1,'Dewon'),
(2,1,'Karbon'),
(3,1,'Perm'),
(4,2,'Trias'),
(5,2,'Jura'),
(6,2,'Kreda'),
(7,3,'Paleogen'),
(8,3,'Neogen'),
(9,3,'Czwartorzêd')

INSERT INTO GeoEpoka
VALUES(1,1,'Dolny'),
(2,1,'Œrodkowy'),
(3,1,'Górny'),
(4,2,'Dolny'),
(5,2,'Górny'),
(6,3,'Dolny'),
(7,3,'Górny'),
(8,4,'Dolny'),
(9,4,'Œrodkowy'),
(10,4,'Górny'),
(11,5,'Dolna'),
(12,5,'Œrodkowa'),
(13,5,'Górna'),
(14,6,'Dolna'),
(15,6,'Górna'),
(16,7,'Paleocen'),
(17,7,'Eocen'),
(18,7,'Oligocen'),
(19,8,'Miocen'),
(20,8,'Pliocen'),
(21,9,'Plejstocen'),
(22,9,'Holocen')

INSERT INTO GeoPietro
VALUES(1,1,'lochkow'),
(2,1,'prag'),
(3,1,'ems'),
(4,2,'eifel'),
(5,2,'¿ywet'),
(6,3,'fran'),
(7,3,'famen'),
(8,4,'turnej'),
(9,4,'wizen'),
(10,4,'serpuchow'),
(11,5,'baszkir'),
(12,5,'moskow'),
(13,5,'kasimow'),
(14,5,'g¿el'),
(15,6,'assel'),
(16,6,'sakmar'),
(17,6,'artinsk'),
(18,6,'kungur'),
(19,7,'road'),
(20,7,'word'),
(21,7,'kapitan'),
(22,7,'wuczaping'),
(23,7,'czangsing'),
(24,8,'ind'),
(25,8,'olenek'),
(26,9,'anizyk'),
(27,9,'ladyn'),
(28,10,'karnik'),
(29,10,'noryk'),
(30,10,'retyk'),
(31,11,'hettang'),
(32,11,'synemur'),
(33,11,'pliensbach'),
(34,11,'toark'),
(35,12,'aalen'),
(36,12,'bajos'),
(37,12,'baton'),
(38,12,'kelowej'),
(39,13,'oksford'),
(40,13,'kimeryd'),
(41,13,'tyton'),
(42,14,'berrias'),
(43,14,'walan¿yn'),
(44,14,'hoteryw'),
(45,14,'barrem'),
(46,14,'apt'),
(47,14,'alb'),
(48,15,'cenoman'),
(49,15,'turon'),
(50,15,'koniak'),
(51,15,'santon'),
(52,15,'kampan'),
(53,15,'mastrycht'),
(54,16,'dan'),
(55,16,'zeland'),
(56,16,'tanet'),
(57,17,'iprez'),
(58,17,'lutet'),
(59,17,'barton'),
(60,17,'priabon'),
(61,18,'rupel'),
(62,18,'szat'),
(63,19,'akwitan'),
(64,19,'burdyga³'),
(65,19,'lang'),
(66,19,'serrawal'),
(67,19,'torton'),
(68,19,'messyn'),
(69,20,'zankl'),
(70,20,'piacent'),
(71,21,'gelas'),
(72,21,'kalabr'),
(73,21,'chiban'),
(74,21,'póŸny'),
(75,7,'grenland'),
(76,7,'northgrip'),
(77,8,'megalaj')

--utworzenie zdenormalizowanej tabeli geochronologicznej 

SELECT nazwa_eon, GeoEon.id_eon ,nazwa_era , GeoEra.id_era, nazwa_okres, GeoOkres.id_okres, nazwa_epoka, GeoEpoka.id_epoka, nazwa_pietro, GeoPietro.id_pietro INTO GeoTabela FROM GeoPietro JOIN GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka
JOIN GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres  JOIN GeoEra ON GeoOkres.id_era = GeoEra.id_era JOIN GeoEon ON GeoEra.id_eon = GeoEon.id_eon

SELECT * FROM GeoTabela

--utworzenie tabeli Dziesiêæ i Milion

CREATE TABLE Dziesiec(cyfra int, bit int);

INSERT INTO Dziesiec 
VALUES (0,1),
(1,1),
(2,1),
(3,0),
(4,0),
(5,1),
(6,1),
(7,0),
(8,1),
(9,0)

CREATE TABLE Milion(liczba int,cyfra int, bit int);
INSERT INTO Milion SELECT a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra
+ 10000*a5.cyfra + 10000*a6.cyfra AS liczba , a1.cyfra AS cyfra, a1.bit AS bit
FROM Dziesiec a1, Dziesiec a2, Dziesiec a3, Dziesiec a4, Dziesiec a5, Dziesiec a6 ;




