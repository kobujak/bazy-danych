use testy

--Zapytanie 1 (1 ZL), którego celem jest z³¹czenie syntetycznej tablicy miliona wyników
--z tabel¹ geochronologiczn¹ w postaci zdenormalizowanej


SET STATISTICS TIME ON

SELECT COUNT(*) FROM Milion INNER JOIN GeoTabela ON Milion.liczba%68=(GeoTabela.id_pietro);

SET STATISTICS TIME OFF


--Zapytanie 2 (2 ZL), którego celem jest z³¹czenie syntetycznej tablicy miliona wyników z tabel¹ geochronologiczn¹ w postaci znormalizowanej

SET STATISTICS TIME ON

SELECT COUNT(*) FROM Milion INNER JOIN GeoPietro ON (Milion.liczba%68 = GeoPietro.id_pietro)  JOIN GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka
JOIN GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres JOIN GeoEra ON GeoOkres.id_era = GeoEra.id_era JOIN GeoEon ON GeoEra.id_eon = GeoEon.id_eon;

SET STATISTICS TIME OFF

--Zapytanie 3 (3 ZG), którego celem jest z³¹czenie syntetycznej tablicy miliona wyników z tabel¹ geochronologiczn¹ w postaci zdenormalizowanej, przy czym z³¹czenie jest wy-konywane poprzez zagnie¿d¿enie skorelowane:

SET STATISTICS TIME ON

SELECT COUNT(*) FROM Milion WHERE Milion.liczba%68=
(SELECT id_pietro FROM GeoTabela WHERE Milion.liczba%68=(id_pietro));

SET STATISTICS TIME OFF

--Zapytanie 4 (4 ZG), którego celem jest z³¹czenie syntetycznej tablicy miliona wyników z tabel¹ geochronologiczn¹ w postaci znormalizowanej, przy czym z³¹czenie jest wyko-nywane poprzez zagnie¿d¿enie skorelowane, a zapytanie wewnêtrzne jest z³¹czeniem ta-bel poszczególnych jednostek geochronologicznych:

SET STATISTICS TIME ON

SELECT COUNT(*) FROM Milion WHERE Milion.liczba%68=
(SELECT GeoPietro.id_pietro FROM GeoPietro JOIN GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka JOIN GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres JOIN GeoEra ON GeoOkres.id_era = GeoEra.id_era 
JOIN GeoEon ON GeoEra.id_eon = GeoEon.id_eon WHERE Milion.liczba%68 = id_pietro);

SET STATISTICS TIME OFF

--Utworzenie indeksów dla tabeli liczbowej i tabel geochronologicznych
-- Tabele znormalizowane
CREATE NONCLUSTERED INDEX Eon_index1
ON GeoEon (id_eon)

CREATE NONCLUSTERED INDEX Eon_index2
ON GeoEon (nazwa_eon)

CREATE NONCLUSTERED INDEX Era_index1
ON GeoEra (nazwa_era)

CREATE NONCLUSTERED INDEX Era_index2
ON GeoEra (id_eon)

CREATE NONCLUSTERED INDEX Era_index3
ON GeoEra (id_era)

CREATE NONCLUSTERED INDEX Okres_index1
ON GeoOkres (id_okres)

CREATE NONCLUSTERED INDEX Okres_index2
ON GeoOkres (id_era)

CREATE NONCLUSTERED INDEX Okres_index3
ON GeoOkres (nazwa_okres)

CREATE NONCLUSTERED INDEX Epoka_index1
ON GeoEpoka (id_epoka)

CREATE NONCLUSTERED INDEX Epoka_index2
ON GeoEpoka (id_okres)

CREATE NONCLUSTERED INDEX Epoka_index3
ON GeoEpoka (nazwa_epoka)

CREATE NONCLUSTERED INDEX Pietro_index1
ON GeoPietro (id_pietro)

CREATE NONCLUSTERED INDEX Pietro_index2
ON GeoPietro (nazwa_pietro)

CREATE NONCLUSTERED INDEX Pietro_index3
ON GeoPietro (id_epoka)

-- Tabela zdenormalizowana 

CREATE NONCLUSTERED INDEX Geo_index1
ON GeoTabela (id_okres)

CREATE NONCLUSTERED INDEX Geo_index2
ON GeoTabela (nazwa_epoka)

CREATE NONCLUSTERED INDEX Geo_index3
ON GeoTabela (id_pietro)

CREATE NONCLUSTERED INDEX Geo_index4
ON GeoTabela (nazwa_pietro)

CREATE NONCLUSTERED INDEX Geo_index5
ON GeoTabela (id_epoka)

CREATE NONCLUSTERED INDEX Geo_index6
ON GeoTabela (nazwa_okres)

CREATE NONCLUSTERED INDEX Geo_index7
ON GeoTabela (id_era)

CREATE NONCLUSTERED INDEX Geo_index8
ON GeoTabela (nazwa_era)

CREATE NONCLUSTERED INDEX Geo_index9
ON GeoTabela (id_eon)

CREATE NONCLUSTERED INDEX Geo_index10
ON GeoTabela (nazwa_eon)

--Tabela liczbowa

CREATE NONCLUSTERED INDEX Milion_index1
ON Milion (liczba)

CREATE NONCLUSTERED INDEX Milion_index2
ON Milion (cyfra)

CREATE NONCLUSTERED INDEX Milion_index3
ON Milion (bit)