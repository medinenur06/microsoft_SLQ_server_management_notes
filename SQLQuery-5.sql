select * from kitap
select * from yazar
select * from tur
select * from islem
select * from ogrenci

--T�rlere g�re kitap say�s�n� bulan Sqli yaz�n�z?
select tur.ad as t�r, count(*)as adet from 
kitap join tur on kitap.turno=tur.turno
group by tur.ad

--T�rlere g�re kitap say�s�n� 100'den fazla olan t�rleri s�ral� listeleyen Sqli yaz�n�z?
select tur.ad as t�r, count(*) as adet from 
kitap join tur on kitap.turno=tur.turno
group by tur.ad having count(tur.ad )>100

--Yazarlara g�re kitap say�s�n� s�ral� listeleyen Sqli yaz�n�z?
select yazar.ad+' '+soyad as yazar, count(*) as adet from 
yazar join kitap on yazar.yazarno=kitap.yazarno
group by yazar.ad+' '+soyad order by 2 desc

--Yazarlara g�re kitap say�s�n� b�y�kten k����e s�ral� ilk 3 yazar� listeleyen Sqli yaz�n�z?
select top 3 yazar.ad+' '+soyad as yazar, count(*) as adet from 
yazar join kitap on yazar.yazarno=kitap.yazarno
group by yazar.ad+' '+soyad order by 2 desc

--En y�ksek puan� olan ilk 5 kitab� bulan Sqli yaz�n�z?
select top 5 * from kitap 
order by puan desc

--En �ok kitap alan ilk 3 ��renciyi bulan Sqli yaz�n�z?
select top 3 ogrenci.ad+' '+soyad as ogrenci ,count(*) as adet from 
islem join ogrenci on ogrenci.ogrno=islem.ogrno
group by ogrenci.ad+' '+soyad
order by 2 desc

--En �ok okunan ilk 5 kitab� getiren Sqli yaz�n�z?
select top 5 kitap.ad,count(*) as adet from 
kitap join islem on kitap.kitapno=islem.kitapno
group by kitap.ad order by adet desc

--En �ok okunan 7 yazar� bulan Sqli yaz�n�z?
select top 7 yazar.ad,yazar.soyad, count(*) from 
islem join kitap on kitap.kitapno=islem.kitapno
join yazar on kitap.yazarno=yazar.yazarno
group by yazar.ad,yazar.soyad
order by 3 desc

--En az okunan son 4 t�r� bulunuz.
select top 4 tur.ad,count(*) as adet from 
islem join kitap on islem.kitapno=kitap.kitapno
join tur on kitap.turno=tur.turno
group by tur.ad order by adet 
----(k�sa hali)
select top 4 t.ad,count(*)from 
islem i join kitap k on i.kitapno=k.kitapno
join tur t on k.turno=t.turno
group by t.ad order by 2

--En �ok kitap okuyan s�n�f�, ilk kayd� getiren Sqli yaz�n�z.
select top 1 ogrenci.sinif,count(*) from 
ogrenci join islem on ogrenci.ogrno=islem.ogrno
group by ogrenci.sinif order by 2 desc

--"A" harfi ile ba�layan kitaplar�n toplam okunma say�s�n� getiren Sqli yaz�n�z
select left(kitap.ad,1), count(*) from 
islem join kitap on islem.kitapno=kitap.kitapno
where left(kitap.ad,1)='A'
group by left(kitap.ad,1)
----(sadece "A" harfi ile ba�layan kitaplar�n adetini yazar)
select count(*) from 
islem i join kitap k on i.kitapno=k.kitapno
where left(k.ad,1)='A'

--"A" harfi ile ba�layan kitaplar�n okunma say�lar�n� getiren Sqli yaz�n�z
select kitap.ad, count(*) from 
kitap join islem  on kitap.kitapno=islem.kitapno
group by kitap.ad having kitap.ad like 'A%'
order by 2 desc