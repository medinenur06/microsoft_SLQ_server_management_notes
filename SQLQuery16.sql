CREATE TABLE [dbo].[kitaplar]( 
[kitapno] [int] IDENTITY(1,1) NOT NULL, 
[ad] [varchar](500) NULL, 
[sayfasayisi] [int] NOT NULL, 
[puan] [int] NULL, 
[yazarno] [int] NULL, 
[turno] [int] NULL)
-- kitaplar ad�nda bir tablo olu�turduk

insert into kitaplar values ('deneme',100,100,100,1000) 
insert into kitaplar values ('deneme2',200,200,200,200)
-- iki adet deneme kayd� eklendi
select * from kitaplar

insert into kitaplar
select ad, sayfasayisi, puan, yazarno, turno from kitap where kitapno<10
-- kitap tablosundan kitapnosu 10'dan k���k olanlar kitaplar tablosuna eklendi.

insert into kitaplar
select ad, sayfasayisi, puan, yazarno, turno from kitap 
-- kitap tablosundan kitaplar tablosuna  veri aktard�k.

insert into kitaplar
select ad, sayfasayisi, puan, yazarno, turno from kitaplar
-- kitaplar tablosundan kitaplar tablosuna  veri aktard�k.

select count(*) as kayit_sayisi from kitaplar
-- olu�turdu�umuz kay�t say�s�n� bulduk. // 894.464

select * from kitaplar where ad='Sefiller' -- index olmadan 3sn i�inde tamamlad�

select * from kitaplar where ad like 'S%' -- index olmadan 2sn i�inde tamamlad�

select * from kitaplar where ad in('Sefiller','�ile') -- index olmadan 2sn i�inde tamamlad�

select * from kitaplar where ad like 'a%' -- index olmadan 4sn i�inde tamamlad�

select * from kitaplar where left(ad,1)='A' -- yukardaki sorgunun ba�ka bir yaz�m ifadesi

-- kitap ad�ndan index olu�turuyoruz.(ad alan�nda ayr� bir tabloyu s�ral� halde olu�turur.)
create index ktp_ad_inx on kitaplar
(
ad asc
)
-- bu olu�turdu�umuz index sayesinde yazd���m�z sorgular s�re harcamadan direk sonucu getirecektir.

delete from kitaplar --> kitaplar tablosunu siler.

delete from kitaplar where kitapno > 50000 -->kitapno 50 bin �st�n� siler.

select * from kitaplar where ad='Su� ve Ceza'

select * from kitaplar where ad like 'M%'

-- birden fazla index olu�turabiliriz
create index ogr_ad_soyad_inx on ogrenci
(
ad, soyad 
)


