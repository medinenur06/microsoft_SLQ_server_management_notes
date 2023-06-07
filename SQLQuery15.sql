--Öðrenci tablosunda unique olabilecek alanlar
select * from ogrenci
--e posta alaný herkes için benzersiz olmalýdýr unique olabilir.

--!!! ilk tablo oluþturulduðunda tablo boþ olduðu için bütün alanlarý unique yapabiliriz.
--tablo dolu ise kayýtlarýn durumuna göre unique index oluþturabilmek iiçin 2 kural var
-- 1-) Tüm kayýtlar dolu olmalý(null olmamalý)
-- 2-) Tüm kayýtlar benzersiz olmalý
-- unique index oluþturduktan sonra zaten ayný kayýt yapýlamaz.

--1'den fazla olan, benzersiz olmayan eposta adreslerini getiren sql
select eposta, count(*) from ogrenci group by eposta
having count(*)>1

--test db de yapýldý--
select * from ogrenci
insert into ogrenci values('kadir','soylu',null)
 
 create unique index ad_inx on ogrenci
 (ad asc)


 -- aþaðýdaki sorguda index oluþturmaz çünki bolum_id alaný benzersiz deðil

 --create unique index bolum_id_inx on ogrenci
 --(bolum_id asc)


