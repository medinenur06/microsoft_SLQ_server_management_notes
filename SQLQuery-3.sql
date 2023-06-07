
--yazar ve kitap ad�n� veren sql
select yazar.ad+' '+soyad as yazar, kitap.ad as kitap_ad� 
from yazar inner join kitap
on yazar.yazarno=kitap.yazarno

--kitap ad� ve t�r�n� getiren sql
select kitap.ad as kitap_ad�,tur.ad as t�r 
from kitap inner join tur
on kitap.turno=tur.turno
order by 2

--kitap ad�n�, yazar�n� ve t�r�n� getiren sql (3 tablo birle�tirme)
select yazar.ad+' '+soyad as yazar,kitap.ad as kitap_ad�,tur.ad as t�r from
yazar 
     inner join kitap on yazar.yazarno=kitap.yazarno
     inner join tur on kitap.turno=tur.turno
-----3 tablo ile
select yazar.ad+' '+soyad as yazar,kitap.ad as kitap_ad�,tur.ad as t�r, 
yazar.*, kitap.*, tur.* from
yazar 
     inner join kitap on yazar.yazarno=kitap.yazarno
     inner join tur on kitap.turno=tur.turno
-----yazar tablosu=Y, kitap tablosu=K, tur tablosu=T olarak isimlendirdik
select Y.ad+' '+soyad as yazar, K.ad as kitap_ad�,T.ad as t�r 
from yazar Y
             inner join kitap  K on Y.yazarno=K.yazarno
             inner join tur T on K.turno=T.turno

--kitap alan ��rencileri tarihleri ile getiren sql
select ogrenci.ad+' '+soyad as kitap_alan_ogrenci ,islem.atarih as al�nan_tarih 
from ogrenci inner join islem
on ogrenci.ogrno=islem.ogrno


--ogrenci ad� soyad� ve ald��� kitap ad�n� getiren sql
select O.ad+''+soyad as ��renci ,K.ad as kitap_ad� 
from kitap K 
            join islem I on K.kitapno=I.kitapno
            join ogrenci O on I.ogrno=O.ogrno

-- ad� "A" ile ba�layan k�t�phaneden kitap alan ��renciyi ve kitap ad�n� getiren sql
select O.ad+''+soyad as ��renci ,K.ad as kitap_ad� 
from kitap K 
            join islem I on K.kitapno=I.kitapno
            join ogrenci O on I.ogrno=O.ogrno
where O.ad like 'A%'

-- ad� ve ald��� kitab�n ad� "M" ile ba�layan kitap alan ogrenciyi getiren sql
select O.ad+''+soyad as ��renci ,K.ad as kitap_ad� 
from kitap K 
            join islem I on K.kitapno=I.kitapno
            join ogrenci O on I.ogrno=O.ogrno
where O.ad like 'M%' and K.ad like 'M%'



