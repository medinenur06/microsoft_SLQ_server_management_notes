--Türlerin Max , min ve ortalama okunma sayýlarýný bulunuz.
select max(sayi) as en_çok, 
min(sayi) as en_az ,AVG(sayi) as ortalama from 
(select tur.ad , count(*)sayi from islem 
join kitap on islem.kitapno=kitap.kitapno 
join tur on tur.turno =kitap.kitapno 
group by tur.ad ) okunmasayisi

--Yazarlarýn max min ve ortalama okunma sayýlarýný bulunuz
select max(sayi) as en_yüksek, min(sayi) as en_düþük ,
avg(sayi) as ortalama  from 
(select yazar.yazarno, count(*) sayi from islem 
join kitap on islem.kitapno=kitap.kitapno 
join yazar on yazar.yazarno=kitap.yazarno 
group by yazar.yazarno  -- yazarno kullanýlmalý çünkü ayný isme sahip yazarlar olabilir
 ) yazar_okunma_sayisi

--illerin max min ve ortalama okuma sayýlarýnýz bulunuz
select max(sayi) as en_cok,  min(sayi) as en_düþük , avg(sayi) as ortalama 
from  (select il , count(*) sayi from islem  
join ogrenci on ogrenci.ogrno =islem.ogrno  
where il is not null -- il girilmeyen hesaba dahil olmasýn diye eklendi
group by ogrenci.il ) sayi

--Sýnýflarýn max min ve ortalama okuma sayýlarýný bulunuz
select max(sayi) as en_yüksek, min(sayi) as en_düþük ,avg(sayi) as ortalama 
from (select ogrenci.sinif , count(*) sayi 
from islem join ogrenci on islem.ogrno =ogrenci.ogrno 
group by ogrenci.sinif ) okunma_sayisi

--Sýnýflarýn max min ve ortalama sayfa okuma sayýlarý sayýlarýný bulunuz
select max(sayi) En_çok,min(sayi) En_az,Avg(sayi) ortalama from
(select o.sinif,sum(sayfasayisi) as sayi from ogrenci o join islem i on o.ogrno=i.ogrno
join kitap k on i.kitapno=k.kitapno
group by o.sinif) Okunma_sayisi

--Doðum Yýllarýna göre kitap okuma sayýlarýnýn max min ve ortalamayý bulunuz
select max(sayi) En_çok,min(sayi) En_az,Avg(sayi) ortalama from
( select DATEPART(year,o.dtarih) d_yil  ,count(*)as sayi from ogrenci o join islem i 
on o.ogrno=i.ogrno group by DATEPART(year,o.dtarih ) ) Okuma_sayilari

--kontrol amaçlý en yüksek en az sayýlarý karþýlaþtýrabilirsiniz. 
select DATEPART(year,o.dtarih) d_yil  ,count(*)as sayi from ogrenci o join islem i 
on o.ogrno=i.ogrno group by DATEPART(year,o.dtarih) order by count(*)desc 

--ortalamanýn üstünde okuyan öðrencilerin açýklama "okuma özürlü" ve "kitap kurdu hariç" kýsmýna "kitap okur" yazdýrýn 
select *  from ogrenci where aciklama not like 'kitap kurdu%'
and ogrno in
(select ogrno as sayi from islem group by ogrno
having count(*)> (select avg(sayi)as sayi 
from (select ogrno,count(*) as sayi from islem group by ogrno) okuma_say))
----Update Kýsmý
update ogrenci set aciklama='KÝTAP OKUR' 
where ogrno in (
select ogrno from ogrenci where aciklama not like 'kitap kurdu%'
and ogrno in
(select ogrno as sayi from islem group by ogrno
having count(*)> (select avg(sayi)as sayi 
from (select ogrno,count(*) as sayi from islem group by ogrno) okuma_say)))





