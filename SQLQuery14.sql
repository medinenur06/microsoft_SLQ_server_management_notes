
--9.sýnýfda okuyan öðrencilerin bilgilerini getiren view oluþturunuz.
Create view sinif9 as
select top 1000 ogrno,ad,soyad,dtarih,cinsiyet,puan,il,sinif from ogrenci
where sinif like '9%' order by sinif
 
select * from sinif9

--10.sýnýfda okuyan öðrencilerin bilgilerini getiren view oluþturunuz.
Create view sinif10 as
select top 1000 ogrno,ad,soyad,dtarih,cinsiyet,puan,il,sinif from ogrenci
where sinif like '10%' order by sinif

select * from sinif10

--11.sýnýfda okuyan öðrencilerin bilgilerini getiren view oluþturunuz.
Create view sinif11 as
select top 1000 ogrno,ad,soyad,dtarih,cinsiyet,puan,il,sinif from ogrenci
where sinif like '11%' order by sinif

select * from sinif11

--12.sýnýfda okuyan öðrencilerin bilgilerini getiren view oluþturunuz.
Create view sinif12 as
select top 1000 ogrno,ad,soyad,dtarih,cinsiyet,puan,il,sinif from ogrenci
where sinif like '12%' order by sinif

select * from sinif12

--12.sýnýflardan puaný 90'dan büyük olan öðrencilerin bilgilerini getiren sql
select * from sinif12 where puan>90

--12.sýnýflardan puaný 100'den büyük olan öðrencilerin puanýný 100 yapan sql
update sinif12 set puan=100 where puan>100

--A þubesinde okuyan öðrencilerin bilgilerini getiren view oluþturunuz
Create view sinif_A as
select top 1000 ogrno,ad,soyad,dtarih,cinsiyet,puan,il,sinif from ogrenci
where sinif like '%A' order by sinif

select * from sinif_A

--B þubesinde okuyan öðrencilerin bilgilerini getiren view oluþturunuz
Create view sinif_B as
select top 1000 ogrno,ad,soyad,dtarih,cinsiyet,puan,il,sinif from ogrenci
where sinif like '%B' order by sinif

select * from sinif_B

--C þubesinde okuyan öðrencilerin bilgilerini getiren view oluþturunuz
Create view sinif_C as
select top 1000 ogrno,ad,soyad,dtarih,cinsiyet,puan,il,sinif from ogrenci
where sinif like '%C' order by sinif

select * from sinif_C

---"D, E, F" þubelerinde mevcut olan öðrenci bilgilerini getiren view oluþturunuz
Create view sinif_DEF as
select top 1000 ogrno,ad,soyad,dtarih,cinsiyet,puan,il,sinif from ogrenci
where sinif like '%[DEF]' order by sinif

select * from sinif_DEF

-- kitap ,yazar, tur tablolarýnýn bilgilerini içeren view oluþturunuz.
create view kitap_yazar_tur as
select kitap.kitapno , concat( yazar.ad,'',yazar.soyad) as yazar , kitap.ad as kitapAdi ,tur.ad as türü  from kitap join yazar
on kitap.yazarno=yazar.yazarno
join tur on tur.turno=kitap.turno

select * from kitap_yazar_tur

--Peyami Safa ve Balzac yazarlarýndan roman türünde kitap okuyan öðrencileri view ile join kullanarak bulun
select * from islem i join kitap_yazar_tur kyt on i.kitapno=kyt.kitapno
join ogrenci o on i.ogrno=o.ogrno 
where yazar in('Peyami Safa','Balzac') and 
türü ='Roman' order by yazar

