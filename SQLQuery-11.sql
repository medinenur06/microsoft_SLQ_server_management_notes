--En �ok kitap okuyan ilk 3 ��rencinin a��klama k�sm�na "kitap kurdu" yazd�ran sql
select top 3 ogrenci.ogrno,concat(ogrenci.ad,' ',ogrenci.soyad),count(*) as adet 
from islem  join ogrenci on islem.ogrno=ogrenci.ogrno
group by ogrenci.ogrno, concat(ogrenci.ad,' ',ogrenci.soyad)
order by 3 desc
-----2.asa�ama update yapmak
update ogrenci set aciklama='Kitap kurdu' where ogrno in
(select top 3 ogrenci.ogrno as adet from islem  join ogrenci 
on islem.ogrno=ogrenci.ogrno
group by ogrenci.ogrno
order by count(*) desc)

--Hi� kitap okumayan ��rencilerin a��klama k�sm�na "Okuma �z�rl�" yazd�ran sql
update ogrenci set aciklama='Okuma �z�rl�' where ogrno in(
select ogrno from ogrenci where ogrno not in(select ogrno from islem))
-----select * from ogrenci where ogrno=35

--Hi� okumayan yazarlar�n a��klama k�sm�na "Hi� okunmayan yazar" yazd�ran sql
select * from yazar where yazarno not in(
select yazarno from islem join kitap on islem.kitapno=kitap.kitapno
)-----uptade k�sm�n� yapal�m
update yazar set aciklama='Hi� okunmayan yazar' where yazarno not in(
select yazarno from islem join kitap on islem.kitapno=kitap.kitapno
)

--Hi� okunmayan t�rleri bulan sql
select * from tur where turno not in(
select turno from kitap join islem on kitap.kitapno=islem.kitapno
)

--Hi� okunmayan kitaplar� bulan sql
select * from kitap where kitapno not in(
select kitapno from islem
)

--T�rlerin toplam puan�n� hesaplayan sql
select tur.ad as tur,sum(kitap.puan) as puan from kitap join tur on kitap.turno=tur.turno
group by tur.ad order by sum(kitap.puan) desc

--Yazarlar�n toplam puan�n� hesaplayan sql
select concat(yazar.ad,' ',yazar.soyad) as yazar,sum(kitap.puan) as puan from kitap join yazar on kitap.yazarno=yazar.yazarno
group by concat(yazar.ad,' ',yazar.soyad) order by sum(kitap.puan) desc

--��rencilerin herbirinin okuduklar� t�m kitaplar�n toplam puan�n� hesaplayan sql
select ogrenci.ogrno ,concat(ogrenci.ad,' ',ogrenci.soyad)as ogrenci, sum(kitap.puan) as okuma_puan�
from ogrenci join islem on islem.ogrno=ogrenci.ogrno
join kitap on islem.kitapno=kitap.kitapno
group by ogrenci.ogrno,concat(ogrenci.ad,' ',ogrenci.soyad)
order by sum(kitap.puan) desc

--T�m ��rencilerin max. min. ve ortalama kitap okuma puanlar�n� hesaplayan sql
select max(okuma_puan) as en_y�ksek, min(okuma_puan) as en_d���k, avg(okuma_puan) as ortalama 
from
(select ogrenci.ogrno ,concat(ogrenci.ad,' ',ogrenci.soyad)as ogrenci, sum(kitap.puan) as okuma_puan
from ogrenci join islem on islem.ogrno=ogrenci.ogrno
join kitap on islem.kitapno=kitap.kitapno
group by ogrenci.ogrno,concat(ogrenci.ad,' ',ogrenci.soyad)) Ogrenci_puan

--��rencilerin max. min. ve ortalama kitap say�lar�n� hesaplayan sql
select max(kitap_sayisi) as en_y�ksek, min(kitap_sayisi) as en_d���k, avg(kitap_sayisi) as ortalama 
from
(select ogrenci.ogrno ,concat(ogrenci.ad,' ',ogrenci.soyad)as ogrenci, count(*) as kitap_sayisi
from ogrenci join islem on islem.ogrno=ogrenci.ogrno
join kitap on islem.kitapno=kitap.kitapno
group by ogrenci.ogrno,concat(ogrenci.ad,' ',ogrenci.soyad)) Ogrenci_kitap_sayisi

--��rencilerin max. min. ve ortalama kitap sayfa say�lar�n� hesaplayan sql
select max(sayfa_sayisi) as en_y�ksek, min(sayfa_sayisi) as en_d���k, avg(sayfa_sayisi) as ortalama 
from
(select ogrenci.ogrno ,concat(ogrenci.ad,' ',ogrenci.soyad)as ogrenci, sum(kitap.sayfasayisi) as sayfa_sayisi
from ogrenci join islem on islem.ogrno=ogrenci.ogrno
join kitap on islem.kitapno=kitap.kitapno
group by ogrenci.ogrno,concat(ogrenci.ad,' ',ogrenci.soyad)) Ogrenci_sayfa_sayisi