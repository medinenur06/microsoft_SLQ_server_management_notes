--ALT SORGULAR
--Çoðunlukla bir sorgulamayý tek bir tablo ile yapmakla olamaz.
--Bazen select sorgusundaki þart, baþka bir tablodaki verilere göre 
--sýnýrlandýrmak istenirse alt joinler kullanýlýr.

--Ortalama puanýn üstünde olan öðrencileri bulan sql
select * from ogrenci where puan >
(select avg(puan) from ogrenci)

--11 sýnýflarýn minumum puanlarýndan büyük olan öðrencileri listeleyen sql
select * from ogrenci where puan >
(select min(puan) from ogrenci where sinif like '11%' )

--"roman" türündeki kitaplarý alt sorgu yöntemi kullanarak listeleyen sql
select ad ,turno from kitap where turno in
(select turno from tur where ad='roman')

--"roman" türünde olan ve ortalama kitap sayfasýndan fazla olan kitaplarý listeleyen sql 
select ad, sayfasayisi from kitap where turno in
(select turno from tur where ad='roman' and sayfasayisi >
(select avg(sayfasayisi) from kitap))

--Tür numarasý 3 olan kitaplardan en büyük sayfa sayýsýndan büyük eþit olan kitaplarý listeleyen sql
select * from kitap where sayfasayisi >=
(select max(sayfasayisi) from kitap where turno=3)

--9.sýnýf not ortalamasýna göre yüksek olan 10.sýnýf öðrencilerini listeleyen sql
select * from ogrenci where sinif like '10%' and puan > 
(select avg(puan) from ogrenci where sinif like '9%' )

--Yazar adý "S" ile baþlayan yazarlarýn yazdýklarý kitaplarý listeleyen sql
select ad from kitap where yazarno in
(select yazarno from yazar where ad like 'S%') 
---(inner join ile yapýmý)
select K.ad as kitap_adi, Y.ad+' '+soyad as yazar from 
yazar Y inner join kitap K on Y.yazarno=K.yazarno
where Y.ad like 'S%'

---Sadece 1 kitap yazan yazarlarý alt sorgu yöntemi ile listeleyen sql
select* from yazar where yazarno in
(select yazarno from kitap group by yazarno having count(*)=1)
