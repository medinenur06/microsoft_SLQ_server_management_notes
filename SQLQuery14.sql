
--9.s�n�fda okuyan ��rencilerin bilgilerini getiren view olu�turunuz.
Create view sinif9 as
select top 1000 ogrno,ad,soyad,dtarih,cinsiyet,puan,il,sinif from ogrenci
where sinif like '9%' order by sinif
 
select * from sinif9

--10.s�n�fda okuyan ��rencilerin bilgilerini getiren view olu�turunuz.
Create view sinif10 as
select top 1000 ogrno,ad,soyad,dtarih,cinsiyet,puan,il,sinif from ogrenci
where sinif like '10%' order by sinif

select * from sinif10

--11.s�n�fda okuyan ��rencilerin bilgilerini getiren view olu�turunuz.
Create view sinif11 as
select top 1000 ogrno,ad,soyad,dtarih,cinsiyet,puan,il,sinif from ogrenci
where sinif like '11%' order by sinif

select * from sinif11

--12.s�n�fda okuyan ��rencilerin bilgilerini getiren view olu�turunuz.
Create view sinif12 as
select top 1000 ogrno,ad,soyad,dtarih,cinsiyet,puan,il,sinif from ogrenci
where sinif like '12%' order by sinif

select * from sinif12

--12.s�n�flardan puan� 90'dan b�y�k olan ��rencilerin bilgilerini getiren sql
select * from sinif12 where puan>90

--12.s�n�flardan puan� 100'den b�y�k olan ��rencilerin puan�n� 100 yapan sql
update sinif12 set puan=100 where puan>100

--A �ubesinde okuyan ��rencilerin bilgilerini getiren view olu�turunuz
Create view sinif_A as
select top 1000 ogrno,ad,soyad,dtarih,cinsiyet,puan,il,sinif from ogrenci
where sinif like '%A' order by sinif

select * from sinif_A

--B �ubesinde okuyan ��rencilerin bilgilerini getiren view olu�turunuz
Create view sinif_B as
select top 1000 ogrno,ad,soyad,dtarih,cinsiyet,puan,il,sinif from ogrenci
where sinif like '%B' order by sinif

select * from sinif_B

--C �ubesinde okuyan ��rencilerin bilgilerini getiren view olu�turunuz
Create view sinif_C as
select top 1000 ogrno,ad,soyad,dtarih,cinsiyet,puan,il,sinif from ogrenci
where sinif like '%C' order by sinif

select * from sinif_C

---"D, E, F" �ubelerinde mevcut olan ��renci bilgilerini getiren view olu�turunuz
Create view sinif_DEF as
select top 1000 ogrno,ad,soyad,dtarih,cinsiyet,puan,il,sinif from ogrenci
where sinif like '%[DEF]' order by sinif

select * from sinif_DEF

-- kitap ,yazar, tur tablolar�n�n bilgilerini i�eren view olu�turunuz.
create view kitap_yazar_tur as
select kitap.kitapno , concat( yazar.ad,'',yazar.soyad) as yazar , kitap.ad as kitapAdi ,tur.ad as t�r�  from kitap join yazar
on kitap.yazarno=yazar.yazarno
join tur on tur.turno=kitap.turno

select * from kitap_yazar_tur

--Peyami Safa ve Balzac yazarlar�ndan roman t�r�nde kitap okuyan ��rencileri view ile join kullanarak bulun
select * from islem i join kitap_yazar_tur kyt on i.kitapno=kyt.kitapno
join ogrenci o on i.ogrno=o.ogrno 
where yazar in('Peyami Safa','Balzac') and 
t�r� ='Roman' order by yazar

