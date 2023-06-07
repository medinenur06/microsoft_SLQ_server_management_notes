CREATE TABLE [dbo].[kitaplar]( 
[kitapno] [int] IDENTITY(1,1) NOT NULL, 
[ad] [varchar](500) NULL, 
[sayfasayisi] [int] NOT NULL, 
[puan] [int] NULL, 
[yazarno] [int] NULL, 
[turno] [int] NULL)
-- kitaplar adýnda bir tablo oluþturduk

insert into kitaplar values ('deneme',100,100,100,1000) 
insert into kitaplar values ('deneme2',200,200,200,200)
-- iki adet deneme kaydý eklendi
select * from kitaplar

insert into kitaplar
select ad, sayfasayisi, puan, yazarno, turno from kitap where kitapno<10
-- kitap tablosundan kitapnosu 10'dan küçük olanlar kitaplar tablosuna eklendi.

insert into kitaplar
select ad, sayfasayisi, puan, yazarno, turno from kitap 
-- kitap tablosundan kitaplar tablosuna  veri aktardýk.

insert into kitaplar
select ad, sayfasayisi, puan, yazarno, turno from kitaplar
-- kitaplar tablosundan kitaplar tablosuna  veri aktardýk.

select count(*) as kayit_sayisi from kitaplar
-- oluþturduðumuz kayýt sayýsýný bulduk. // 894.464

select * from kitaplar where ad='Sefiller' -- index olmadan 3sn içinde tamamladý

select * from kitaplar where ad like 'S%' -- index olmadan 2sn içinde tamamladý

select * from kitaplar where ad in('Sefiller','Çile') -- index olmadan 2sn içinde tamamladý

select * from kitaplar where ad like 'a%' -- index olmadan 4sn içinde tamamladý

select * from kitaplar where left(ad,1)='A' -- yukardaki sorgunun baþka bir yazým ifadesi

-- kitap adýndan index oluþturuyoruz.(ad alanýnda ayrý bir tabloyu sýralý halde oluþturur.)
create index ktp_ad_inx on kitaplar
(
ad asc
)
-- bu oluþturduðumuz index sayesinde yazdýðýmýz sorgular süre harcamadan direk sonucu getirecektir.

delete from kitaplar --> kitaplar tablosunu siler.

delete from kitaplar where kitapno > 50000 -->kitapno 50 bin üstünü siler.

select * from kitaplar where ad='Suç ve Ceza'

select * from kitaplar where ad like 'M%'

-- birden fazla index oluþturabiliriz
create index ogr_ad_soyad_inx on ogrenci
(
ad, soyad 
)


