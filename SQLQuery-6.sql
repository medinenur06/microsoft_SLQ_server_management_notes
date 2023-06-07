select * from kitap
select * from yazar
select * from islem
select * from tur
--roman, masal ve hikaye t�r�nde kitap okuyan 12.s�n�f ��rencilerinden
-- ad� "a", "b", "c" ile ba�layan ��renci listesini getiren sql
select ogrenci.ad+' '+soyad as ogrenci,sinif, tur.ad, kitap.ad from 
ogrenci join islem on ogrenci.ogrno=islem.ogrno
join kitap on  islem.kitapno=kitap.kitapno 
join tur on kitap.turno=tur.turno
where tur.ad in('hikaye','masal','roman') and 
ogrenci.sinif like '12%' and 
ogrenci.ad like '[abc]%'

--yazar ad� "a" ile ba�layan kitap ad� k ile ba�layan yazar ve 
 --kitaplar� yazar ad�na g�re listeleyen sql
select yazar.ad+''+soyad, kitap.ad from yazar join kitap
on yazar.yazarno=kitap.yazarno
where yazar.ad like 'a%' and kitap.ad like'k%'
order by yazar.ad

--hangi yazar hangi t�rde ka� kitap yazd�
select yazar.ad, tur.ad as t�r, count(*) as adet from yazar join kitap
on yazar.yazarno=kitap.yazarno
join tur on kitap.turno=tur.turno 
group by yazar.ad, tur.ad having count(tur.ad)>1 
order by 3 desc

--SELF JO�N--
--SQL�de bulunan �zel bir JOIN i�lemidir. Birbirinden farkl� iki veya 
--daha �ok tablonun birle�tirildi�i di�er JOIN metotlar�n�n aksine, 
--Self Join i�leminde tek bir tablo vard�r ve bu tablo kendisi ile birle�tirilir. 
--Join i�lemi tablo ve tablonun bir kopyas� ile ger�ekle�ir.
 --select
 --        t1.kolon_1,
 --        t1.kolon_2,
 --        t2.kolon_3,
 --        ..........
 --        t2.kolon_n
 --FROM tablo1 t1,
 --INNER JO�N tablo1 t2,
 --ON t1.ortak_kolon = t2.ortak_kolon;

---hiyarar�i kullan�ma �rnek---
select concat(p2.Ad,' ',p2.Soyad) as amir, 
concat(p1.Ad,' ',p1.Soyad) as personel from personel P1 left join personel P2
on p2.Personel_id=p1.Sorumlu_Amir
order by amir 

 ---alan kar��la�t�rma---
select o1.ad, o1.soyad,o2.ad,o2.soyad,o1.il from ogrenci o1 join ogrenci o2 on o1.il=o2.il
where o1.ogrno<>o2.ogrno --> ayn� kayd� kendisine hari� tutsun
order by o1.ad