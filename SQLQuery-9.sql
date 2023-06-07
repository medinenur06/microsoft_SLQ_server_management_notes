--9. 10. 11. ve 12. s�n�flar� ayr� bir tabloya yazd�ran sql

select * into siniflar_9 from ogrenci where sinif='10'--bo� tablo olu�turmak i�in yaz�ld�
insert into siniflar_9
select ad,soyad, dtarih, cinsiyet, sinif,puan, y_puan, il, aciklama, ogrno
from ogrenci where sinif like '9%' order by sinif
--select * from siniflar_9 

select * into siniflar_10 from ogrenci where sinif='10' --bo� tablo olu�turmak i�in yaz�ld�
insert into siniflar_10
select ad, soyad, dtarih, cinsiyet, sinif, puan, y_puan, il, aciklama, ogrno
from ogrenci where sinif like '10%' order by sinif
--select * from siniflar_10

select * into siniflar_11 from ogrenci where sinif='10' --bo� tablo olu�turmak i�in yaz�ld�
insert into siniflar_11
select * from ogrenci where sinif like '11a%'
insert into siniflar_11
select * from ogrenci where sinif like '11b%'
insert into siniflar_11
select * from ogrenci where sinif like '11c%'
insert into siniflar_11
select * from ogrenci where sinif like '11d%'
insert into siniflar_11
select * from ogrenci where sinif like '11e%'
insert into siniflar_11
select * from ogrenci where sinif like '11f%'
select * from ogrenci where sinif like '12a%' --12a kay�t ediliyor
insert into siniflar_12
select * from ogrenci where sinif like '12b%' --12b kay�t ediliyor
insert into siniflar_12
select * from ogrenci where sinif like '12c%' --12c kay�t ediliyor
insert into siniflar_12
select * from ogrenci where sinif like '12d%' --12d kay�t ediliyor
insert into siniflar_12
select * from ogrenci where sinif like '12e%' --12e kay�t ediliyor
insert into siniflar_12
select * from ogrenci where sinif like '12f%' --12f kay�t ediliyor
select ogrno,ad,soyad,cinsiyet,sinif,puan
from ogrenci where sinif like '10%' order by sinif

--Yazar kitap tablosunu sql ile birle�tirip bir tek tablo gibi kullan�labilir.
select * from (select y.ad +' '+ soyad as yazar,k.ad as kitap, k.sayfasayisi
from yazar y join kitap k on y.yazarno=k.yazarno) as Yazar_Kitap

--Yazar ad� "S" ile kitap ad� "A" ile ba�layan ve sayfa say�lar� ile getiren sql
select * from (select yazar.ad +' '+ soyad as yazar,kitap.ad as kitap, kitap.sayfasayisi
from yazar  join kitap  on yazar.yazarno=kitap.yazarno) as Yazar_Kitap
where yazar like 'S%' and kitap like 'A%'
--T�r� roman edebiyar ve komedi olup a-b-c harfleri ile ba�layan kitap listesini getiren sql
sum(sayfasayisi)as okunan_sayfa
from islem  join kitap  on islem.kitapno=kitap.kitapno
join ogrenci  on ogrenci.ogrno=islem.ogrno
group by islem.ogrno,concat(ogrenci.ad,' ',soyad)
order by okunan_sayfa desc
select * from ogrenci
where ogrno in( select ogrno from islem group by ogrno having count(*)>20 )

update ogrenci set aciklama = concat(aciklama,' �yi Okur')
where ogrno in( select ogrno from islem group by ogrno having count(*)>20 )