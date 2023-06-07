 --En çok okunan 3 kitabý getiren sql
select top 3 kitap.ad ,count(*) as adet from islem join kitap
on islem.kitapno=kitap.kitapno
group by kitap.ad
order by 2 desc

--En az okunan 5 yazarý getiren sql
select top 5 concat(yazar.ad,' ',yazar.soyad) as Yazar ,count(*) as adet from islem join kitap
on islem.kitapno=kitap.kitapno 
join yazar on yazar.yazarno=kitap.yazarno
group by concat(yazar.ad,' ',yazar.soyad) 
order by 2

--En çok okunan 3 yazarýn açýklama kýsmýna "En çok okunan yazar" yazdýran sql
select top 3 yazar.yazarno, concat(yazar.ad,' ',yazar.soyad) as Yazar ,count(*) as adet, aciklama 
from islem join kitap on islem.kitapno=kitap.kitapno 
join yazar on yazar.yazarno=kitap.yazarno
group by concat(yazar.ad,' ',yazar.soyad), aciklama, yazar.yazarno
order by 3 desc
-----bu yazarlara ait yazarno üzerinden update yapýlacak
update yazar set aciklama='En çok okunan yazar' where yazar.yazarno in(
select top 3 yazar.yazarno 
from islem join kitap on islem.kitapno=kitap.kitapno 
join yazar on yazar.yazarno=kitap.yazarno
group by concat(yazar.ad,' ',yazar.soyad), aciklama, yazar.yazarno
order by count(*) desc
)--select* from yazar

--En az okunan yazarýn yanýna "En az okunan yazar" yazdýran sql
select top 1 yazar.yazarno, concat(yazar.ad,' ',yazar.soyad) as Yazar ,count(*) as adet, aciklama 
from islem join kitap on islem.kitapno=kitap.kitapno 
join yazar on yazar.yazarno=kitap.yazarno
group by concat(yazar.ad,' ',yazar.soyad), aciklama, yazar.yazarno
order by 3
-----bu yazarlara ait yazarno üzerinden update yapýlacak
update yazar set aciklama='En çok okunan yazar' where yazar.yazarno in(
select top 1 yazar.yazarno 
from islem join kitap on islem.kitapno=kitap.kitapno 
join yazar on yazar.yazarno=kitap.yazarno
group by concat(yazar.ad,' ',yazar.soyad), aciklama, yazar.yazarno
order by count(*) 
)
--Ayný isim ve soyada sahip yazarlarýn kayýlarýný getiren sql
select yazar.ad,yazar.soyad,count(*) as adet from yazar
group by yazar.ad,yazar.soyad having count(*)>1
-----bu yazarlarýn numaralarýný getirelim
select * from yazar
where ad in(select ad from(select ad,soyad,count(*)as sayi from yazar group by ad, soyad having count(*)>1)as A)
and soyad in(select soyad from(select ad,soyad,count(*)as sayi from yazar group by ad, soyad having count(*)>1)as A)
order by ad,soyad

--En az okunan yazarýn açýklama kýsmýna "En az okunan yazar" yazdýran sql
select top 1 yazar.yazarno, concat(yazar.ad,' ',yazar.soyad) as Yazar ,count(*) as adet, aciklama 
from islem join kitap on islem.kitapno=kitap.kitapno 
join yazar on yazar.yazarno=kitap.yazarno
group by concat(yazar.ad,' ',yazar.soyad), aciklama, yazar.yazarno
order by 3
-----bu yazarlara ait yazarno üzerinden update yapýlacak
update yazar set aciklama='En çok okunan yazar' where yazar.yazarno in(
select top 1 yazar.yazarno 
from islem join kitap on islem.kitapno=kitap.kitapno 
join yazar on yazar.yazarno=kitap.yazarno
group by concat(yazar.ad,' ',yazar.soyad), aciklama, yazar.yazarno
order by count(*) 
)
--En çok kitap okuyan 3 öðrencinin açýklama kýsmýna "kitap kurdu" yazdýran sql
select top 3 ogrenci.ogrno, concat(ogrenci.ad,' ',ogrenci.soyad),count(*),aciklama from ogrenci join islem
on islem.ogrno=ogrenci.ogrno
group by ogrenci.ogrno,concat(ogrenci.ad,' ',ogrenci.soyad), aciklama
order by 3 desc
---açýklama kýsmýný yapalým(update tarafý)
update ogrenci set aciklama='Kitap Kurdu' where ogrno in(
select top 3 ogrenci.ogrno from ogrenci join islem
on islem.ogrno=ogrenci.ogrno
group by concat(ogrenci.ad,' ',ogrenci.soyad), aciklama, ogrenci.ogrno
order by count(*) desc
)









