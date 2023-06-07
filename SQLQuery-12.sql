--T�rlerin Max , min ve ortalama okunma say�lar�n� bulunuz.
select max(sayi) as en_�ok, 
min(sayi) as en_az ,AVG(sayi) as ortalama from 
(select tur.ad , count(*)sayi from islem 
join kitap on islem.kitapno=kitap.kitapno 
join tur on tur.turno =kitap.kitapno 
group by tur.ad ) okunmasayisi

--Yazarlar�n max min ve ortalama okunma say�lar�n� bulunuz
select max(sayi) as en_y�ksek, min(sayi) as en_d���k ,
avg(sayi) as ortalama  from 
(select yazar.yazarno, count(*) sayi from islem 
join kitap on islem.kitapno=kitap.kitapno 
join yazar on yazar.yazarno=kitap.yazarno 
group by yazar.yazarno  -- yazarno kullan�lmal� ��nk� ayn� isme sahip yazarlar olabilir
 ) yazar_okunma_sayisi

--illerin max min ve ortalama okuma say�lar�n�z bulunuz
select max(sayi) as en_cok,  min(sayi) as en_d���k , avg(sayi) as ortalama 
from  (select il , count(*) sayi from islem  
join ogrenci on ogrenci.ogrno =islem.ogrno  
where il is not null -- il girilmeyen hesaba dahil olmas�n diye eklendi
group by ogrenci.il ) sayi

--S�n�flar�n max min ve ortalama okuma say�lar�n� bulunuz
select max(sayi) as en_y�ksek, min(sayi) as en_d���k ,avg(sayi) as ortalama 
from (select ogrenci.sinif , count(*) sayi 
from islem join ogrenci on islem.ogrno =ogrenci.ogrno 
group by ogrenci.sinif ) okunma_sayisi

--S�n�flar�n max min ve ortalama sayfa okuma say�lar� say�lar�n� bulunuz
select max(sayi) En_�ok,min(sayi) En_az,Avg(sayi) ortalama from
(select o.sinif,sum(sayfasayisi) as sayi from ogrenci o join islem i on o.ogrno=i.ogrno
join kitap k on i.kitapno=k.kitapno
group by o.sinif) Okunma_sayisi

--Do�um Y�llar�na g�re kitap okuma say�lar�n�n max min ve ortalamay� bulunuz
select max(sayi) En_�ok,min(sayi) En_az,Avg(sayi) ortalama from
( select DATEPART(year,o.dtarih) d_yil  ,count(*)as sayi from ogrenci o join islem i 
on o.ogrno=i.ogrno group by DATEPART(year,o.dtarih ) ) Okuma_sayilari

--kontrol ama�l� en y�ksek en az say�lar� kar��la�t�rabilirsiniz. 
select DATEPART(year,o.dtarih) d_yil  ,count(*)as sayi from ogrenci o join islem i 
on o.ogrno=i.ogrno group by DATEPART(year,o.dtarih) order by count(*)desc 

--ortalaman�n �st�nde okuyan ��rencilerin a��klama "okuma �z�rl�" ve "kitap kurdu hari�" k�sm�na "kitap okur" yazd�r�n 
select *  from ogrenci where aciklama not like 'kitap kurdu%'
and ogrno in
(select ogrno as sayi from islem group by ogrno
having count(*)> (select avg(sayi)as sayi 
from (select ogrno,count(*) as sayi from islem group by ogrno) okuma_say))
----Update K�sm�
update ogrenci set aciklama='K�TAP OKUR' 
where ogrno in (
select ogrno from ogrenci where aciklama not like 'kitap kurdu%'
and ogrno in
(select ogrno as sayi from islem group by ogrno
having count(*)> (select avg(sayi)as sayi 
from (select ogrno,count(*) as sayi from islem group by ogrno) okuma_say)))





