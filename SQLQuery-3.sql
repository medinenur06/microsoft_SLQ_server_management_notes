
--yazar ve kitap adýný veren sql
select yazar.ad+' '+soyad as yazar, kitap.ad as kitap_adý 
from yazar inner join kitap
on yazar.yazarno=kitap.yazarno

--kitap adý ve türünü getiren sql
select kitap.ad as kitap_adý,tur.ad as tür 
from kitap inner join tur
on kitap.turno=tur.turno
order by 2

--kitap adýný, yazarýný ve türünü getiren sql (3 tablo birleþtirme)
select yazar.ad+' '+soyad as yazar,kitap.ad as kitap_adý,tur.ad as tür from
yazar 
     inner join kitap on yazar.yazarno=kitap.yazarno
     inner join tur on kitap.turno=tur.turno
-----3 tablo ile
select yazar.ad+' '+soyad as yazar,kitap.ad as kitap_adý,tur.ad as tür, 
yazar.*, kitap.*, tur.* from
yazar 
     inner join kitap on yazar.yazarno=kitap.yazarno
     inner join tur on kitap.turno=tur.turno
-----yazar tablosu=Y, kitap tablosu=K, tur tablosu=T olarak isimlendirdik
select Y.ad+' '+soyad as yazar, K.ad as kitap_adý,T.ad as tür 
from yazar Y
             inner join kitap  K on Y.yazarno=K.yazarno
             inner join tur T on K.turno=T.turno

--kitap alan öðrencileri tarihleri ile getiren sql
select ogrenci.ad+' '+soyad as kitap_alan_ogrenci ,islem.atarih as alýnan_tarih 
from ogrenci inner join islem
on ogrenci.ogrno=islem.ogrno


--ogrenci adý soyadý ve aldýðý kitap adýný getiren sql
select O.ad+''+soyad as öðrenci ,K.ad as kitap_adý 
from kitap K 
            join islem I on K.kitapno=I.kitapno
            join ogrenci O on I.ogrno=O.ogrno

-- adý "A" ile baþlayan kütüphaneden kitap alan öðrenciyi ve kitap adýný getiren sql
select O.ad+''+soyad as öðrenci ,K.ad as kitap_adý 
from kitap K 
            join islem I on K.kitapno=I.kitapno
            join ogrenci O on I.ogrno=O.ogrno
where O.ad like 'A%'

-- adý ve aldýðý kitabýn adý "M" ile baþlayan kitap alan ogrenciyi getiren sql
select O.ad+''+soyad as öðrenci ,K.ad as kitap_adý 
from kitap K 
            join islem I on K.kitapno=I.kitapno
            join ogrenci O on I.ogrno=O.ogrno
where O.ad like 'M%' and K.ad like 'M%'



