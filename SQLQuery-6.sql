select * from kitap
select * from yazar
select * from islem
select * from tur
--roman, masal ve hikaye türünde kitap okuyan 12.sýnýf öðrencilerinden
-- adý "a", "b", "c" ile baþlayan öðrenci listesini getiren sql
select ogrenci.ad+' '+soyad as ogrenci,sinif, tur.ad, kitap.ad from 
ogrenci join islem on ogrenci.ogrno=islem.ogrno
join kitap on  islem.kitapno=kitap.kitapno 
join tur on kitap.turno=tur.turno
where tur.ad in('hikaye','masal','roman') and 
ogrenci.sinif like '12%' and 
ogrenci.ad like '[abc]%'

--yazar adý "a" ile baþlayan kitap adý k ile baþlayan yazar ve 
 --kitaplarý yazar adýna göre listeleyen sql
select yazar.ad+''+soyad, kitap.ad from yazar join kitap
on yazar.yazarno=kitap.yazarno
where yazar.ad like 'a%' and kitap.ad like'k%'
order by yazar.ad

--hangi yazar hangi türde kaç kitap yazdý
select yazar.ad, tur.ad as tür, count(*) as adet from yazar join kitap
on yazar.yazarno=kitap.yazarno
join tur on kitap.turno=tur.turno 
group by yazar.ad, tur.ad having count(tur.ad)>1 
order by 3 desc

--SELF JOÝN--
--SQL’de bulunan özel bir JOIN iþlemidir. Birbirinden farklý iki veya 
--daha çok tablonun birleþtirildiði diðer JOIN metotlarýnýn aksine, 
--Self Join iþleminde tek bir tablo vardýr ve bu tablo kendisi ile birleþtirilir. 
--Join iþlemi tablo ve tablonun bir kopyasý ile gerçekleþir.
 --select
 --        t1.kolon_1,
 --        t1.kolon_2,
 --        t2.kolon_3,
 --        ..........
 --        t2.kolon_n
 --FROM tablo1 t1,
 --INNER JOÝN tablo1 t2,
 --ON t1.ortak_kolon = t2.ortak_kolon;

---hiyararþi kullanýma örnek---
select concat(p2.Ad,' ',p2.Soyad) as amir, 
concat(p1.Ad,' ',p1.Soyad) as personel from personel P1 left join personel P2
on p2.Personel_id=p1.Sorumlu_Amir
order by amir 

 ---alan karþýlaþtýrma---
select o1.ad, o1.soyad,o2.ad,o2.soyad,o1.il from ogrenci o1 join ogrenci o2 on o1.il=o2.il
where o1.ogrno<>o2.ogrno --> ayný kaydý kendisine hariç tutsun
order by o1.ad