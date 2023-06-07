--��renci tablosunda unique olabilecek alanlar
select * from ogrenci
--e posta alan� herkes i�in benzersiz olmal�d�r unique olabilir.

--!!! ilk tablo olu�turuldu�unda tablo bo� oldu�u i�in b�t�n alanlar� unique yapabiliriz.
--tablo dolu ise kay�tlar�n durumuna g�re unique index olu�turabilmek ii�in 2 kural var
-- 1-) T�m kay�tlar dolu olmal�(null olmamal�)
-- 2-) T�m kay�tlar benzersiz olmal�
-- unique index olu�turduktan sonra zaten ayn� kay�t yap�lamaz.

--1'den fazla olan, benzersiz olmayan eposta adreslerini getiren sql
select eposta, count(*) from ogrenci group by eposta
having count(*)>1

--test db de yap�ld�--
select * from ogrenci
insert into ogrenci values('kadir','soylu',null)
 
 create unique index ad_inx on ogrenci
 (ad asc)


 -- a�a��daki sorguda index olu�turmaz ��nki bolum_id alan� benzersiz de�il

 --create unique index bolum_id_inx on ogrenci
 --(bolum_id asc)


