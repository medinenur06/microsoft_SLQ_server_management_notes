--ALT SORGULAR
--�o�unlukla bir sorgulamay� tek bir tablo ile yapmakla olamaz.
--Bazen select sorgusundaki �art, ba�ka bir tablodaki verilere g�re 
--s�n�rland�rmak istenirse alt joinler kullan�l�r.

--Ortalama puan�n �st�nde olan ��rencileri bulan sql
select * from ogrenci where puan >
(select avg(puan) from ogrenci)

--11 s�n�flar�n minumum puanlar�ndan b�y�k olan ��rencileri listeleyen sql
select * from ogrenci where puan >
(select min(puan) from ogrenci where sinif like '11%' )

--"roman" t�r�ndeki kitaplar� alt sorgu y�ntemi kullanarak listeleyen sql
select ad ,turno from kitap where turno in
(select turno from tur where ad='roman')

--"roman" t�r�nde olan ve ortalama kitap sayfas�ndan fazla olan kitaplar� listeleyen sql 
select ad, sayfasayisi from kitap where turno in
(select turno from tur where ad='roman' and sayfasayisi >
(select avg(sayfasayisi) from kitap))

--T�r numaras� 3 olan kitaplardan en b�y�k sayfa say�s�ndan b�y�k e�it olan kitaplar� listeleyen sql
select * from kitap where sayfasayisi >=
(select max(sayfasayisi) from kitap where turno=3)

--9.s�n�f not ortalamas�na g�re y�ksek olan 10.s�n�f ��rencilerini listeleyen sql
select * from ogrenci where sinif like '10%' and puan > 
(select avg(puan) from ogrenci where sinif like '9%' )

--Yazar ad� "S" ile ba�layan yazarlar�n yazd�klar� kitaplar� listeleyen sql
select ad from kitap where yazarno in
(select yazarno from yazar where ad like 'S%') 
---(inner join ile yap�m�)
select K.ad as kitap_adi, Y.ad+' '+soyad as yazar from 
yazar Y inner join kitap K on Y.yazarno=K.yazarno
where Y.ad like 'S%'

---Sadece 1 kitap yazan yazarlar� alt sorgu y�ntemi ile listeleyen sql
select* from yazar where yazarno in
(select yazarno from kitap group by yazarno having count(*)=1)
