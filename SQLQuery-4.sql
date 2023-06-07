select *from tur
select *from ogrenci
select *from islem
select *from kitap  

--beyaz gemi kitabýný alan öðrencileri listeleyen sql
select ogrenci.ad+soyad as ad_soyad, kitap.ad as kitap_adý from
islem 
join kitap on kitap.kitapno=islem.kitapno
join ogrenci on islem.ogrno=ogrenci.ogrno
where kitap.ad= 'beyaz gemi'
order by ogrenci.ad+soyad

--kitap türü roman olan kitaplarý alan öðrencileri getiren sql(4 tablo birleþtirdik)
select distinct ogrenci.ad+soyad, tur.ad as tur_adý from 
islem 
join kitap on islem.kitapno=kitap.kitapno
join tur on kitap.turno=tur.turno
join ogrenci on islem.ogrno=ogrenci.ogrno
where tur.ad='roman'

--"cehov, stefan, dostoyevski, emily" yazarlarýn yazdýðý kitalarýn isimlerini getiren sql
select Y.ad, K.ad as kitap_adý from 
yazar Y join kitap K on  Y.yazarno=K.yazarno
where Y.ad   in('cehov', 'stefan', 'dostoyevski', 'emily')
order by 2

--"cehov, stefan, dostoyevski, emily" yazarlarýn yazdýðý kitabý alan öðrencileri getiren sql
select ogrenci.ad,ogrenci.soyad, yazar.ad as yazar from 
islem 
join kitap on islem.kitapno=kitap.kitapno
join yazar on kitap.yazarno=yazar.yazarno
join ogrenci on islem.ogrno=ogrenci.ogrno
where yazar.ad in('cehov','stefan','dostoyevski','emily')
order by ogrenci.ad