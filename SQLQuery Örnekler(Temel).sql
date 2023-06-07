--sýnýf ortalamasýna göre 9. sýnýflarý büyükten küçüðe sýralayýnýz
select sinif, avg(puan) puanort from ogrenci
where sinif like '9%' 
group by sinif
order by 2 desc
--
select * from ogrenci
select sayfasayisi, 
sayfasayisi/2 as sayfa_yarisi ,
sayfasayisi+ 20 as sayfanin20fazlasi 
from kitap 
---
select ad,soyad, ad+' '+soyad from ogrenci
---
select
count(puan) as toplamKisi,
sum(puan) as toplamPuan,
avg(puan) as ortalamaPuan,
max(puan) as enYuksekPuan,
min(puan) as enDusukPuan
from ogrenci
where sinif like '10%' and cinsiyet='E'
---
select substring(ad,1,1)+'.'+substring(soyad,1,50) adsoyad from ogrenci
---
select substring(ad,1,2)+'**** '+ substring(soyad,1,2)+'****' adsoyad from ogrenci
---
select left(ad,3)+'******'+right(soyad,2)from ogrenci
---
select replicate('*',len(ad))+' '+replicate('*',len(soyad)) from ogrenci
---
select left(ad,2)+replicate('*',len(ad)-2)from ogrenci
---
select left(ad,2)+replicate('*',len(ad)-2)from ogrenci
---
select left(ad,1)+replicate('*',len(ad)-1)+' '+left(soyad,1)+replicate('*',len(ad)-1) from ogrenci
---
select upper(ad) , lower(soyad) from ogrenci
---
select 5*10, 1+3, 12-6, 15/3
---
select* ,charindex('b',ad,0) from ogrenci
where CHARINDEX('b',ad,0)>0
---
select soyad, charindex('c',soyad,0) from ogrenci
where charindex('c',soyad,0)>0
---
select * from ogrenci
---
select lower(substring(ad,1,1))+'.'+lower(substring(soyad,1,50))+'@gmail.com' from ogrenci
---
select sum(sayfasayisi) from kitap
---
select substring(ad,3,2) from ogrenci
---
select count(sayfasayisi) from kitap
---
alter table ogrenci
add y_puan float;
update ogrenci set y_puan=puan;
update ogrenci set y_puan=y_puan*1.1
select ad,y_puan,
floor(y_puan) as altayuvarla,
ceiling(y_puan) as yukariyuvarla,
round(y_puan,0) as enyakinsayi
from ogrenci
---
select ad, substring(ad,2,3) from ogrenci
---
select puan from ogrenci
where puan between 70 and 90
---
select puan from ogrenci
where puan>70 and puan<90
---
select ad,charindex('a',ad) from kitap
where CHARINDEX('a',ad)>0
---
select puan from ogrenci
where puan in(70,80,90)
---
select puan from ogrenci
where puan like('_5') and puan<56
order by 1 desc
---
select * from ogrenci
where puan like('[0-3]5')
---
select getdate()
---
select datepart(year,getdate())
---
select datepart(month,getdate())
---
select datepart(day,getdate())
---
select datepart(month,'2023-05-12')
--- 
select datepart(day,'2023-05-12')
---
select datepart(day,getdate()+5)
---
select datepart(quarter,'2023-05-12')
---
select current_timestamp as curent,
sysdatetime() as sysdate,
getdate() as gettdate
---
select datediff(year,dtarih,getdate()) as yas
from ogrenci
where datediff(year,dtarih,getdate()) between 20 and 40
---
select ad,soyad, datepart(year,dtarih) as d_yili
from ogrenci
where datepart(year,dtarih) between 1980 and 1990
order by 3 desc
---
select dateadd(month,1,getdate())as taksit1,
dateadd(month,2,getdate())as taksit2,
dateadd(month,3,getdate())as taksit3,
dateadd(month,4,getdate())as taksit4,
dateadd(month,5,getdate())as taksit5,
dateadd(month,6,getdate())as taksit6
---
select *,datename(weekday,dtarih) as d_günü from ogrenci
where datename(weekday,dtarih)='Friday'
---
select ad,soyad, datename(weekday,dtarih) from ogrenci
where datename(weekday,dtarih) in('sunday','saturday','monday')
---
select dtarih,dateadd(day,20,dtarih) from ogrenci
---
select dateadd(month,4,'2023-04-12')
---
select dtarih,dateadd(month,3,dtarih) from ogrenci
---
select datepart(hour,getdate())as saat,
datepart(MINUTE,getdate())as dk,
datepart(second,getdate())as saniye
---
select dtarih,datename(month,dtarih)as ay, 
datename(WEEKDAY,dtarih) as gün from ogrenci
---
select cast('medine' as char(4))
---
select ad, cast(ad as char(3))from ogrenci
---
select cast(4.56 as int)
---
select dtarih,convert(varchar(20),dtarih,103)from ogrenci
---
select dtarih,convert(varchar(50),dtarih,104) from ogrenci
---
select dtarih,convert(varchar(5),dtarih,103),
convert(varchar(20),dtarih,104) from ogrenci
---
select ad,reverse(ad) from ogrenci
---
select reverse('medine')
---
select* from ogrenci
select convert(varchar(20),getdate(),13),
convert(varchar(20),getdate(),14)
---
select count(*) from ogrenci
where sinif='12F'and cinsiyet='E'
---
select ad,lower(soyad),ogrno from ogrenci
order by 3 desc
---
select count(*) from ogrenci
where soyad='ÖZTÜRK'
---
select soyad,count(*)from ogrenci
group by soyad
---
select ad,count(ad)from ogrenci
group by ad having ad like 'A%'
---
select ad,count(*)from ogrenci
where ad like 'A%'
group by ad 
---
select distinct soyad from ogrenci
---
select soyad from ogrenci
group by soyad
---
select ad,soyad,count(*) from ogrenci
group by ad,soyad
order by 3 desc
---
select sinif,count(*)from ogrenci
group by sinif
order by 2 desc
---
select ad,
count(puan)puanýGirilenOgrenciSayisi,
max (puan)maxpuan,
min (puan)minpuan,
avg (puan)ortpuan,
sum (puan)toplampuan
from ogrenci
where soyad='öztürk'
group by ad 
---
select soyad,
count(puan)puanýGirilenOgrenciSayisi,
max (puan)maxpuan,
min (puan)minpuan,
avg (puan)ortpuan,
sum (puan)toplampuan
from ogrenci
where  soyad='öztürk' or soyad='yýlmaz'
group by soyad 
select soyad from ogrenci
---
select soyad,
count(puan) puaný_girilen_ogrenci_sayisi,
sum(puan) toplam_puanlar,
max(puan) max_puan,
min(puan) min_puan,
avg(puan) ort_puan
from ogrenci
where soyad in('çelik','demir','kaya')
group by soyad
order by puaný_girilen_ogrenci_sayisi desc
---
select ad,
count(puan),
max(puan) as max_puan,
min(puan) as min_puan,
sum(puan) as toplam_puan,
avg(puan) as ort_puan
from ogrenci
--where ad like 'A%' or ad like 'B%'
group by ad having ad like 'A%' or ad like 'B%'
---
select ad as kitap_adi,count(*) as kitap_adeti
from kitap
group by ad order by 2 desc
---
select sinif,cinsiyet,count(*) as sayi
from ogrenci 
group by sinif, cinsiyet
order by sinif,cinsiyet, sayi
---
select left(sinif,len(sinif)-1) as sinif,cinsiyet,
count(*) as sayi
from ogrenci
group by cinsiyet, left(sinif,len(sinif)-1)
order by sinif,cinsiyet, sayi
---
select left(sinif,len(sinif)-1)as sýnýf ,cinsiyet ,count(*) as sayi
from ogrenci 
group by left(sinif,len(sinif)-1),cinsiyet
order by sýnýf ,cinsiyet ,sayi
---
select left(sinif,len(sinif)-1),cinsiyet,count(*) as sayi
from ogrenci
where left(sinif,len(sinif)-1) in('11','10')
group by left(sinif,len(sinif)-1),cinsiyet
order by 1 ,2,3
---
select left(sinif,len(sinif)-1),cinsiyet,count(*) as sayi
from ogrenci
where left(sinif,len(sinif)-1) in('11','10')
group by left(sinif,len(sinif)-1),cinsiyet
order by 1 ,2,3
---
select left(sinif,2) as sýnýf ,cinsiyet,count(*) as sayi
from ogrenci
where left(sinif,2)='10'
group by left(sinif,2), cinsiyet
order by sýnýf,2,3
---
select left(sinif,2) as sýnýf ,cinsiyet,count(*) as sayi
from ogrenci
where left(sinif,2) like ('1_')
group by left(sinif,2), cinsiyet
order by sýnýf,2,3
---
select left(sinif,2) as sýnýf ,cinsiyet,count(*) as sayi
from ogrenci
where left(sinif,2) like '1%'
group by left(sinif,2), cinsiyet
order by sýnýf,2,3
---
select yazarno ,sum(sayfasayisi)
from kitap
group by yazarno
order by 2
---
select yazarno,
sum(sayfasayisi) toplam,
avg(sayfasayisi) ort,
max(sayfasayisi) 'max',
min(sayfasayisi) 'min',
count(*) as kitapsayisi
from kitap
group by yazarno
order by 1
---
select cinsiyet,sinif,count(*)
from ogrenci
where sinif like '9%'
group by cinsiyet,sinif
---
select left(sinif,2),cinsiyet,count(*)
from ogrenci
where sinif like '10%'
group by left(sinif,2),cinsiyet
---
select left(sinif,2),cinsiyet,count(*)
from ogrenci
where sinif like '11%'
group by left(sinif,2),cinsiyet
---
select left(sinif,2),cinsiyet,count(*)
from ogrenci
where sinif like '11%' and cinsiyet='K'
group by left(sinif,2),cinsiyet
---
select kitapno ,count(*) alýnma_sayisi
from islem
group by kitapno
order by alýnma_sayisi desc
---
select cinsiyet,count(*)
from ogrenci
group by cinsiyet
---
select ad,count(*)
from ogrenci
group by ad
---
select ad, count(*) as kisi
from ogrenci
group by ad having count(*)=1
---
select sinif ,sum(puan) from ogrenci
group by sinif having sum(puan)>2500
---
select ad ,puan,count(*),avg(puan) as ort
from ogrenci 
group by ad,puan having count(*)>1
order by 2 desc
---
select ad,puan,avg(puan),count(*)
from ogrenci
group by ad, puan having count(*)>1
order by 2 desc
---
select sinif,avg(puan)
from ogrenci
group by sinif having avg(puan)>50
---
select sinif,avg(puan)
from ogrenci
group by sinif having avg(puan) between 40 and 50
---
select ad,count(*)
from kitap
group by ad having count(*)>1
---
select yazarno ,count(*) from kitap
group by yazarno having count(*)>20
---
select ad from kitap
where kitapno in (4,5)
---
select count(*),datepart(year,dtarih)from ogrenci
group by datepart(year,dtarih)
order by 2 desc
---
select turno ,count(*) from kitap
group by turno
---
select sinif ,count(*)from ogrenci
group by sinif having count(*)<40
order by 2 desc
---
select sinif ,count(*)from ogrenci
group by sinif having sinif like'10%' and count(*)<50
---
insert into ogrenci(ogrno,ad,soyad) values(1001,'Medine','ATAMAN')
---
select sinif,avg(puan)
from ogrenci
group by sinif having sinif like '9%'
order by 2 desc
---
select len(ad) as karakterSayisi,
count(*) kisiSayisi from ogrenci
where len(ad)>7
group by len(ad)
---
select len(ad) as karakterSayisi,
count(*) kisiSayisi from ogrenci
group by len(ad) having count(*)>20
---
select len(ad) as karakterSayisi,
count(*) kisiSayisi from ogrenci
group by len(ad)
---
select sinif,sum(puan)
from ogrenci
group by sinif having sum(puan)>2000

































































 









































































