--EXISTS OPERATÖRÜ
--True veya false döndüren bir boolean operatörüdür.
--Genellikle bir "var" durumunu test etmek için alt sorguda kullanýlýr.
--EXISTS operatörünün kullanýmý;

--SELECT
--sutunlar
--FROM tablo_adi
--WHERE [NOT] EXISTS (altsorgu);

--Alt sorgu herhangi bir satýr döndürürse, Exýsts operatörü true, aksi halde false döndürür.
--NOT operatörü ,exýsts operatörünü olumsuzlar.
--Baþa bir deyiþle,alt sorgu satýr döndürmezse, aksi taktirde false döndürürse nor exýsts true deðerini döndürür.

--bir ve birden fazla kitap alan öðrencileri listeleyen getiren sql(alt sorgu ile)
select* from ogrenci
where ogrno in (select ogrno from islem)

--bir ve birden fazla kitap alan öðrencileri listeleyen getiren sql(exýsts operatörü ile)
select* from ogrenci where
EXISTS ( select ogrno from islem
where islem.ogrno=ogrenci.ogrno)

--hiç kitap almayan öðrenci listesini getirren sql(alt sorgu ile)
select* from ogrenci
where ogrno not in(select ogrno from islem)

--hiç kitap almayan öðrenci listesini getirren sql(exýsts operatörü ile)
select* from ogrenci where
NOT EXISTS ( select ogrno from islem
where islem.ogrno=ogrenci.ogrno)

--9.sýnýflar puan ortalamasýndan yüksek olan öðrencilerin açýklama alanýna "Baþarýlý" yazan sql
select * from ogrenci where puan>
(select avg(puan) from ogrenci where sinif like '9%')  
and sinif like '9%'
-----
update ogrenci set aciklama='Baþarýlý' where puan>
(select avg(puan) from ogrenci where sinif like '9%')  
and sinif like '9%'

--puaný 100 üzerinden olan bütün öðrencilerin puaný 100 yapan sql
update ogrenci set puan=100 where puan>100

--puaný 85 üzeri olan 10.sýnýf öðrencilerinin açýklama alanýný "AA" yapan sql
select * from ogrenci
where puan >85 and sinif like'10%'
-----
update ogrenci set aciklama='AA'
where puan >85 and sinif like'10%'

--10'un üzerinde kitap okuyann öðrencilerin açýklama alanýna "iyi okur" yazan sql(açýklma alaný silinmeden)
select * from ogrenci
where ogrno in(select ogrno from islem group by ogrno having count(*)>20)
-----
update ogrenci set  aciklama=concat(aciklama,' Ýyi okur') 
where ogrno in(select ogrno from islem group by ogrno having count(*)>20)

--SELECT INTO :tablodaki veriyi baþka bir tabloya aktarmak için kullanýyoruz.
--SELECT alan_ad(larý)
--INTO yeni_tablo_adi
--FROM tablo1

--Öðrenci tablonu yedeðini alan sql
select* into ogrenci_yedek from ogrenci

--9.sýnýflarýn olduðu bir tablo oluþturan sql
select * into Siniflar_9 from ogrenci where sinif like '9%'

--A grubu sýnýflarýn olduðu bir tablo oluþturan sql 
select * into A_siniflari from ogrenci where  sinif like '%A%'
--drop table A_siniflari(tabloyu siler)
select * from A_siniflari order by sinif,ogrno

