select * from kitap
select * from yazar
select * from tur
select * from islem
select * from ogrenci

--Türlere göre kitap sayýsýný bulan Sqli yazýnýz?
select tur.ad as tür, count(*)as adet from 
kitap join tur on kitap.turno=tur.turno
group by tur.ad

--Türlere göre kitap sayýsýný 100'den fazla olan türleri sýralý listeleyen Sqli yazýnýz?
select tur.ad as tür, count(*) as adet from 
kitap join tur on kitap.turno=tur.turno
group by tur.ad having count(tur.ad )>100

--Yazarlara göre kitap sayýsýný sýralý listeleyen Sqli yazýnýz?
select yazar.ad+' '+soyad as yazar, count(*) as adet from 
yazar join kitap on yazar.yazarno=kitap.yazarno
group by yazar.ad+' '+soyad order by 2 desc

--Yazarlara göre kitap sayýsýný büyükten küçüðe sýralý ilk 3 yazarý listeleyen Sqli yazýnýz?
select top 3 yazar.ad+' '+soyad as yazar, count(*) as adet from 
yazar join kitap on yazar.yazarno=kitap.yazarno
group by yazar.ad+' '+soyad order by 2 desc

--En yüksek puaný olan ilk 5 kitabý bulan Sqli yazýnýz?
select top 5 * from kitap 
order by puan desc

--En çok kitap alan ilk 3 öðrenciyi bulan Sqli yazýnýz?
select top 3 ogrenci.ad+' '+soyad as ogrenci ,count(*) as adet from 
islem join ogrenci on ogrenci.ogrno=islem.ogrno
group by ogrenci.ad+' '+soyad
order by 2 desc

--En çok okunan ilk 5 kitabý getiren Sqli yazýnýz?
select top 5 kitap.ad,count(*) as adet from 
kitap join islem on kitap.kitapno=islem.kitapno
group by kitap.ad order by adet desc

--En çok okunan 7 yazarý bulan Sqli yazýnýz?
select top 7 yazar.ad,yazar.soyad, count(*) from 
islem join kitap on kitap.kitapno=islem.kitapno
join yazar on kitap.yazarno=yazar.yazarno
group by yazar.ad,yazar.soyad
order by 3 desc

--En az okunan son 4 türü bulunuz.
select top 4 tur.ad,count(*) as adet from 
islem join kitap on islem.kitapno=kitap.kitapno
join tur on kitap.turno=tur.turno
group by tur.ad order by adet 
----(kýsa hali)
select top 4 t.ad,count(*)from 
islem i join kitap k on i.kitapno=k.kitapno
join tur t on k.turno=t.turno
group by t.ad order by 2

--En çok kitap okuyan sýnýfý, ilk kaydý getiren Sqli yazýnýz.
select top 1 ogrenci.sinif,count(*) from 
ogrenci join islem on ogrenci.ogrno=islem.ogrno
group by ogrenci.sinif order by 2 desc

--"A" harfi ile baþlayan kitaplarýn toplam okunma sayýsýný getiren Sqli yazýnýz
select left(kitap.ad,1), count(*) from 
islem join kitap on islem.kitapno=kitap.kitapno
where left(kitap.ad,1)='A'
group by left(kitap.ad,1)
----(sadece "A" harfi ile baþlayan kitaplarýn adetini yazar)
select count(*) from 
islem i join kitap k on i.kitapno=k.kitapno
where left(k.ad,1)='A'

--"A" harfi ile baþlayan kitaplarýn okunma sayýlarýný getiren Sqli yazýnýz
select kitap.ad, count(*) from 
kitap join islem  on kitap.kitapno=islem.kitapno
group by kitap.ad having kitap.ad like 'A%'
order by 2 desc