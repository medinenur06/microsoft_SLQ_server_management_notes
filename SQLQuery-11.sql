--En çok kitap okuyan ilk 3 öðrencinin açýklama kýsmýna "kitap kurdu" yazdýran sql
select top 3 ogrenci.ogrno,concat(ogrenci.ad,' ',ogrenci.soyad),count(*) as adet 
from islem  join ogrenci on islem.ogrno=ogrenci.ogrno
group by ogrenci.ogrno, concat(ogrenci.ad,' ',ogrenci.soyad)
order by 3 desc
-----2.asaþama update yapmak
update ogrenci set aciklama='Kitap kurdu' where ogrno in
(select top 3 ogrenci.ogrno as adet from islem  join ogrenci 
on islem.ogrno=ogrenci.ogrno
group by ogrenci.ogrno
order by count(*) desc)

--Hiç kitap okumayan öðrencilerin açýklama kýsmýna "Okuma özürlü" yazdýran sql
update ogrenci set aciklama='Okuma özürlü' where ogrno in(
select ogrno from ogrenci where ogrno not in(select ogrno from islem))
-----select * from ogrenci where ogrno=35

--Hiç okumayan yazarlarýn açýklama kýsmýna "Hiç okunmayan yazar" yazdýran sql
select * from yazar where yazarno not in(
select yazarno from islem join kitap on islem.kitapno=kitap.kitapno
)-----uptade kýsmýný yapalým
update yazar set aciklama='Hiç okunmayan yazar' where yazarno not in(
select yazarno from islem join kitap on islem.kitapno=kitap.kitapno
)

--Hiç okunmayan türleri bulan sql
select * from tur where turno not in(
select turno from kitap join islem on kitap.kitapno=islem.kitapno
)

--Hiç okunmayan kitaplarý bulan sql
select * from kitap where kitapno not in(
select kitapno from islem
)

--Türlerin toplam puanýný hesaplayan sql
select tur.ad as tur,sum(kitap.puan) as puan from kitap join tur on kitap.turno=tur.turno
group by tur.ad order by sum(kitap.puan) desc

--Yazarlarýn toplam puanýný hesaplayan sql
select concat(yazar.ad,' ',yazar.soyad) as yazar,sum(kitap.puan) as puan from kitap join yazar on kitap.yazarno=yazar.yazarno
group by concat(yazar.ad,' ',yazar.soyad) order by sum(kitap.puan) desc

--Öðrencilerin herbirinin okuduklarý tüm kitaplarýn toplam puanýný hesaplayan sql
select ogrenci.ogrno ,concat(ogrenci.ad,' ',ogrenci.soyad)as ogrenci, sum(kitap.puan) as okuma_puaný
from ogrenci join islem on islem.ogrno=ogrenci.ogrno
join kitap on islem.kitapno=kitap.kitapno
group by ogrenci.ogrno,concat(ogrenci.ad,' ',ogrenci.soyad)
order by sum(kitap.puan) desc

--Tüm öðrencilerin max. min. ve ortalama kitap okuma puanlarýný hesaplayan sql
select max(okuma_puan) as en_yüksek, min(okuma_puan) as en_düþük, avg(okuma_puan) as ortalama 
from
(select ogrenci.ogrno ,concat(ogrenci.ad,' ',ogrenci.soyad)as ogrenci, sum(kitap.puan) as okuma_puan
from ogrenci join islem on islem.ogrno=ogrenci.ogrno
join kitap on islem.kitapno=kitap.kitapno
group by ogrenci.ogrno,concat(ogrenci.ad,' ',ogrenci.soyad)) Ogrenci_puan

--Öðrencilerin max. min. ve ortalama kitap sayýlarýný hesaplayan sql
select max(kitap_sayisi) as en_yüksek, min(kitap_sayisi) as en_düþük, avg(kitap_sayisi) as ortalama 
from
(select ogrenci.ogrno ,concat(ogrenci.ad,' ',ogrenci.soyad)as ogrenci, count(*) as kitap_sayisi
from ogrenci join islem on islem.ogrno=ogrenci.ogrno
join kitap on islem.kitapno=kitap.kitapno
group by ogrenci.ogrno,concat(ogrenci.ad,' ',ogrenci.soyad)) Ogrenci_kitap_sayisi

--Öðrencilerin max. min. ve ortalama kitap sayfa sayýlarýný hesaplayan sql
select max(sayfa_sayisi) as en_yüksek, min(sayfa_sayisi) as en_düþük, avg(sayfa_sayisi) as ortalama 
from
(select ogrenci.ogrno ,concat(ogrenci.ad,' ',ogrenci.soyad)as ogrenci, sum(kitap.sayfasayisi) as sayfa_sayisi
from ogrenci join islem on islem.ogrno=ogrenci.ogrno
join kitap on islem.kitapno=kitap.kitapno
group by ogrenci.ogrno,concat(ogrenci.ad,' ',ogrenci.soyad)) Ogrenci_sayfa_sayisi