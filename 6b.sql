USE firma


--a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodaj�c do niego kierunkowy dla Polski w nawiasie (+48) 
BEGIN TRANSACTION

ALTER TABLE ksiegowosc.pracownicy
ALTER COLUMN telefon varchar(20);

UPDATE ksiegowosc.pracownicy SET telefon = concat('(+48)',telefon) WHERE telefon IS NOT NULL

SELECT * FROM ksiegowosc.pracownicy
ROLLBACK TRANSACTION

--b) Zmodyfikuj atrybut telefon w tabeli pracownicy tak, aby numer oddzielony by� my�lnikami wg wzoru: �555-222-333� \
BEGIN TRANSACTION

UPDATE ksiegowosc.pracownicy
SET telefon = SUBSTRING(telefon, 1, 8) + '-' + SUBSTRING(telefon, 8, 3) + '-' + SUBSTRING(telefon, 12, 3)

SELECT * FROM ksiegowosc.wynagrodzenie

ROLLBACK TRANSACTION
--c) Wy�wietl dane pracownika, kt�rego nazwisko jest najd�u�sze, u�ywaj�c du�ych liter 

SELECT TOP 1 id_pracownika, UPPER(imie) as imie, UPPER(nazwisko) as nazwisko from ksiegowosc.pracownicy ORDER BY len(nazwisko) DESC

--d) Wy�wietl dane pracownik�w i ich pensje zakodowane przy pomocy algorytmu md5 

SELECT ksiegowosc.pracownicy.id_pracownika, CONVERT(varchar(32),HashBytes('MD5',imie),2) as imie, CONVERT(varchar(32),HashBytes('MD5',nazwisko),2) as nazwisko, CONVERT(varchar(32),HashBytes('MD5',cast(kwota as varchar)),2) as pensja from ksiegowosc.pracownicy
join ksiegowosc.wynagrodzenie ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika join ksiegowosc.pensje ON ksiegowosc.pensje.id_pensji = ksiegowosc.wynagrodzenie.id_pensji

--f) Wy�wietl pracownik�w, ich pensje oraz premie. Wykorzystaj z��czenie lewostronne. 

SELECT imie, nazwisko, pensje.kwota as pensja, premie.kwota as premia from ksiegowosc.pracownicy 
LEFT JOIN ksiegowosc.wynagrodzenie on ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
LEFT JOIN ksiegowosc.pensje on ksiegowosc.pensje.id_pensji = ksiegowosc.wynagrodzenie.id_pensji 
LEFT JOIN ksiegowosc.premie on ksiegowosc.premie.id_premii = ksiegowosc.wynagrodzenie.id_premii


--g) wygeneruj raport (zapytanie), kt�re zwr�ci w wyniki tre�� wg poni�szego szablonu:


ALTER TABLE ksiegowosc.godziny ADD nadgodziny smallmoney 
UPDATE ksiegowosc.godziny SET ksiegowosc.godziny.nadgodziny =liczba_godzin-160 WHERE  liczba_godzin>160

SELECT pracownicy.id_pracownika,
   
CONCAT('Pracownik ', imie, ' ', nazwisko, ' w dniu ', wynagrodzenie.data , ' otrzyma� pensj� ca�kowit� na kwot� ', pensje.kwota + premie.kwota , ' z�, gdzie wynagrodzenie zasadnicze wynosi�o: ', pensje.kwota, 'z�, premia: ', premie.kwota, 'z�, nadgodziny:', godziny.nadgodziny*30 , ' z�') 
 
FROM ksiegowosc.pracownicy 
join ksiegowosc.wynagrodzenie ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
join ksiegowosc.pensje ON ksiegowosc.pensje.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
join ksiegowosc.premie ON ksiegowosc.premie.id_premii = ksiegowosc.wynagrodzenie.id_premii
join ksiegowosc.godziny ON ksiegowosc.godziny.id_godziny = ksiegowosc.wynagrodzenie.id_godziny WHERE ksiegowosc.pracownicy.id_pracownika = 3




