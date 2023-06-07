--EXISTS OPERAT�R�
--True veya false d�nd�ren bir boolean operat�r�d�r.
--Genellikle bir "var" durumunu test etmek i�in alt sorguda kullan�l�r.
--EXISTS operat�r�n�n kullan�m�;

--SELECT
--sutunlar
--FROM tablo_adi
--WHERE [NOT] EXISTS (altsorgu);

--Alt sorgu herhangi bir sat�r d�nd�r�rse, Ex�sts operat�r� true, aksi halde false d�nd�r�r.
--NOT operat�r� ,ex�sts operat�r�n� olumsuzlar.
--Ba�a bir deyi�le,alt sorgu sat�r d�nd�rmezse, aksi taktirde false d�nd�r�rse nor ex�sts true de�erini d�nd�r�r.

--bir ve birden fazla kitap alan ��rencileri listeleyen getiren sql(alt sorgu ile)
select* from ogrenci
where ogrno in (select ogrno from islem)

--bir ve birden fazla kitap alan ��rencileri listeleyen getiren sql(ex�sts operat�r� ile)
select* from ogrenci where
EXISTS ( select ogrno from islem
where islem.ogrno=ogrenci.ogrno)

--hi� kitap almayan ��renci listesini getirren sql(alt sorgu ile)
select* from ogrenci
where ogrno not in(select ogrno from islem)

--hi� kitap almayan ��renci listesini getirren sql(ex�sts operat�r� ile)
select* from ogrenci where
NOT EXISTS ( select ogrno from islem
where islem.ogrno=ogrenci.ogrno)

--9.s�n�flar puan ortalamas�ndan y�ksek olan ��rencilerin a��klama alan�na "Ba�ar�l�" yazan sql
select * from ogrenci where puan>
(select avg(puan) from ogrenci where sinif like '9%')  
and sinif like '9%'
-----
update ogrenci set aciklama='Ba�ar�l�' where puan>
(select avg(puan) from ogrenci where sinif like '9%')  
and sinif like '9%'

--puan� 100 �zerinden olan b�t�n ��rencilerin puan� 100 yapan sql
update ogrenci set puan=100 where puan>100

--puan� 85 �zeri olan 10.s�n�f ��rencilerinin a��klama alan�n� "AA" yapan sql
select * from ogrenci
where puan >85 and sinif like'10%'
-----
update ogrenci set aciklama='AA'
where puan >85 and sinif like'10%'

--10'un �zerinde kitap okuyann ��rencilerin a��klama alan�na "iyi okur" yazan sql(a��klma alan� silinmeden)
select * from ogrenci
where ogrno in(select ogrno from islem group by ogrno having count(*)>20)
-----
update ogrenci set  aciklama=concat(aciklama,' �yi okur') 
where ogrno in(select ogrno from islem group by ogrno having count(*)>20)

--SELECT INTO :tablodaki veriyi ba�ka bir tabloya aktarmak i�in kullan�yoruz.
--SELECT alan_ad(lar�)
--INTO yeni_tablo_adi
--FROM tablo1

--��renci tablonu yede�ini alan sql
select* into ogrenci_yedek from ogrenci

--9.s�n�flar�n oldu�u bir tablo olu�turan sql
select * into Siniflar_9 from ogrenci where sinif like '9%'

--A grubu s�n�flar�n oldu�u bir tablo olu�turan sql 
select * into A_siniflari from ogrenci where  sinif like '%A%'
--drop table A_siniflari(tabloyu siler)
select * from A_siniflari order by sinif,ogrno

