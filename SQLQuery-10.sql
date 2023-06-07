 --En �ok okunan 3 kitab� getiren sql
select top 3 kitap.ad ,count(*) as adet from islem join kitap
on islem.kitapno=kitap.kitapno
group by kitap.ad
order by 2 desc

--En az okunan 5 yazar� getiren sql
select top 5 concat(yazar.ad,' ',yazar.soyad) as Yazar ,count(*) as adet from islem join kitap
on islem.kitapno=kitap.kitapno 
join yazar on yazar.yazarno=kitap.yazarno
group by concat(yazar.ad,' ',yazar.soyad) 
order by 2

--En �ok okunan 3 yazar�n a��klama k�sm�na "En �ok okunan yazar" yazd�ran sql
select top 3 yazar.yazarno, concat(yazar.ad,' ',yazar.soyad) as Yazar ,count(*) as adet, aciklama 
from islem join kitap on islem.kitapno=kitap.kitapno 
join yazar on yazar.yazarno=kitap.yazarno
group by concat(yazar.ad,' ',yazar.soyad), aciklama, yazar.yazarno
order by 3 desc
-----bu yazarlara ait yazarno �zerinden update yap�lacak
update yazar set aciklama='En �ok okunan yazar' where yazar.yazarno in(
select top 3 yazar.yazarno 
from islem join kitap on islem.kitapno=kitap.kitapno 
join yazar on yazar.yazarno=kitap.yazarno
group by concat(yazar.ad,' ',yazar.soyad), aciklama, yazar.yazarno
order by count(*) desc
)--select* from yazar

--En az okunan yazar�n yan�na "En az okunan yazar" yazd�ran sql
select top 1 yazar.yazarno, concat(yazar.ad,' ',yazar.soyad) as Yazar ,count(*) as adet, aciklama 
from islem join kitap on islem.kitapno=kitap.kitapno 
join yazar on yazar.yazarno=kitap.yazarno
group by concat(yazar.ad,' ',yazar.soyad), aciklama, yazar.yazarno
order by 3
-----bu yazarlara ait yazarno �zerinden update yap�lacak
update yazar set aciklama='En �ok okunan yazar' where yazar.yazarno in(
select top 1 yazar.yazarno 
from islem join kitap on islem.kitapno=kitap.kitapno 
join yazar on yazar.yazarno=kitap.yazarno
group by concat(yazar.ad,' ',yazar.soyad), aciklama, yazar.yazarno
order by count(*) 
)
--Ayn� isim ve soyada sahip yazarlar�n kay�lar�n� getiren sql
select yazar.ad,yazar.soyad,count(*) as adet from yazar
group by yazar.ad,yazar.soyad having count(*)>1
-----bu yazarlar�n numaralar�n� getirelim
select * from yazar
where ad in(select ad from(select ad,soyad,count(*)as sayi from yazar group by ad, soyad having count(*)>1)as A)
and soyad in(select soyad from(select ad,soyad,count(*)as sayi from yazar group by ad, soyad having count(*)>1)as A)
order by ad,soyad

--En az okunan yazar�n a��klama k�sm�na "En az okunan yazar" yazd�ran sql
select top 1 yazar.yazarno, concat(yazar.ad,' ',yazar.soyad) as Yazar ,count(*) as adet, aciklama 
from islem join kitap on islem.kitapno=kitap.kitapno 
join yazar on yazar.yazarno=kitap.yazarno
group by concat(yazar.ad,' ',yazar.soyad), aciklama, yazar.yazarno
order by 3
-----bu yazarlara ait yazarno �zerinden update yap�lacak
update yazar set aciklama='En �ok okunan yazar' where yazar.yazarno in(
select top 1 yazar.yazarno 
from islem join kitap on islem.kitapno=kitap.kitapno 
join yazar on yazar.yazarno=kitap.yazarno
group by concat(yazar.ad,' ',yazar.soyad), aciklama, yazar.yazarno
order by count(*) 
)
--En �ok kitap okuyan 3 ��rencinin a��klama k�sm�na "kitap kurdu" yazd�ran sql
select top 3 ogrenci.ogrno, concat(ogrenci.ad,' ',ogrenci.soyad),count(*),aciklama from ogrenci join islem
on islem.ogrno=ogrenci.ogrno
group by ogrenci.ogrno,concat(ogrenci.ad,' ',ogrenci.soyad), aciklama
order by 3 desc
---a��klama k�sm�n� yapal�m(update taraf�)
update ogrenci set aciklama='Kitap Kurdu' where ogrno in(
select top 3 ogrenci.ogrno from ogrenci join islem
on islem.ogrno=ogrenci.ogrno
group by concat(ogrenci.ad,' ',ogrenci.soyad), aciklama, ogrenci.ogrno
order by count(*) desc
)









