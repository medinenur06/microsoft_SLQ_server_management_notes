select sinif,avg(puan),max(puan),min(puan)from ogrenci 
group by sinif
--s�n�flar�n puan ortalamalar�
select sinif, sum(puan)/count(puan)from ogrenci
group by sinif order by 2 desc
--s�n�f baz�nda erkek ve k�z ��rencilerin ortalama puanlar�
select cinsiyet,sinif,avg(puan) from ogrenci group by cinsiyet,sinif
--il baz�nda puan ortalamas�
select il,avg(puan) from ogrenci group by il
--ayn� isme sahip olan ��rencilerin say�s�n� bulun
select ad,count(*) from ogrenci 
group by ad having count(*)>1
order by 2
--yazarlar�n yazd��� kitap say�s�
select yazarno,count(*)from kitap
group by yazarno
--en cok kitap yazan yazarlar
select yazarno,count(*) from kitap group by yazarno
having count(*)>20 order by 2
--t�rlerin puan ortalamas� ve toplam puan� bulunuz
select turno,count(*),sum(turno),avg(turno) from kitap group by turno
select sinif,cinsiyet,count(*)from ogrenci
where sinif like '9%'
group by sinif,cinsiyet







