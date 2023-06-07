select sinif,avg(puan),max(puan),min(puan)from ogrenci 
group by sinif
--sýnýflarýn puan ortalamalarý
select sinif, sum(puan)/count(puan)from ogrenci
group by sinif order by 2 desc
--sýnýf bazýnda erkek ve kýz öðrencilerin ortalama puanlarý
select cinsiyet,sinif,avg(puan) from ogrenci group by cinsiyet,sinif
--il bazýnda puan ortalamasý
select il,avg(puan) from ogrenci group by il
--ayný isme sahip olan öðrencilerin sayýsýný bulun
select ad,count(*) from ogrenci 
group by ad having count(*)>1
order by 2
--yazarlarýn yazdýðý kitap sayýsý
select yazarno,count(*)from kitap
group by yazarno
--en cok kitap yazan yazarlar
select yazarno,count(*) from kitap group by yazarno
having count(*)>20 order by 2
--türlerin puan ortalamasý ve toplam puaný bulunuz
select turno,count(*),sum(turno),avg(turno) from kitap group by turno
select sinif,cinsiyet,count(*)from ogrenci
where sinif like '9%'
group by sinif,cinsiyet







