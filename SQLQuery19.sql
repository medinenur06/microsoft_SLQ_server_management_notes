--ogrenci tablosuna yeni kayýt eklediðimizde ekrana sadece yeni eklenen kiþinin kaydýný getiren triggerý yazalým.
create trigger trg_Listele on ogrenci
after insert
as begin
select top 1 'yeni kayýt_eklendi', * from ogrenci order by ogrno desc
end
 
-- deneyelim:
select * from ogrenci
insert into ogrenci (ad,soyad,sinif,cinsiyet) values ('Ahmet', 'Deneme','12A','E')
insert into ogrenci (ad,soyad,sinif,cinsiyet) values ('Ayþe', 'Deneme','11A','K')
-- iki kayýt ekliyerek istediðimiz sonuca vardýk.

-- silinen öðrenci tablosu yapalým
CREATE TABLE [dbo].[silinen_ogrenci](
	id int IDENTITY(1,1), 
	[ogrno] [int]  NOT NULL,
	[ad] [varchar](20) NULL,
	[soyad] [varchar](20) NULL,
	[dtarih] [datetime] NULL,
	[cinsiyet] [char](1) NULL,
	[sinif] [varchar](4) NOT NULL,
	[puan] [int] NULL,
	[y_puan] [float] NULL,
	[il] [nvarchar](50) NULL,
	[aciklama] [nvarchar](50) NULL,
	silinme_zamani datetime,
	silen_kisi varchar(50),
	Constraint [PK_id] Primary key clustered(
	[id] ASC))

select * from silinen_ogrenci

-- öðrenci tablosundan sildiðimiz kayýtlar silinen öðrenci tablosuna geçmesi için bir trigger oluþturalým.
ALTER trigger trg_silinenOgrenciyiEkle on ogrenci
after delete as
begin 
insert into silinen_ogrenci 
select *,getdate(),'iþlem_yapan' from deleted;
end

-- deniyelim:
select * from ogrenci
delete from ogrenci where ogrno=1006
delete from ogrenci where ogrno=1005
select * from silinen_ogrenci
-- önceden eklediðimiz öðrencileri sildik.
-- silinen öðrenciler, silinen öðrenci tablosuna geçiþ yaptý (silme zamaný ve yapan kiþi ile kayda geçti)
-- NOT:kayýtlý öðrencinin birden fazla tabloda bulunmasý yani iliþkili olmasý halinde öðrenci silinmez. Hata verir.

-- 10A sýnýfýna erkek öðrenci kaydolmamasý için bir trigger oluþturalým
Create trigger trg_10A_cinsiyet_kiz on ogrenci
for insert
as
if(exists (select * from inserted where sinif = '10A' and cinsiyet = 'E'))
begin 
raiserror('10A sýnýfýna erkek öðrenci kayýt edilmez.',1,1) --> hata mesajý
rollback transaction
end

-- deniyelim:
insert into ogrenci (ad,soyad,sinif,cinsiyet) values ('Emirhan', 'Test','10A','E')
-- Eklemedi , trigger sayesinde "10A sýnýfýna erkek öðrenci kayýt edilmez." hata mesajý verdi.

-- deniyelim:
insert into ogrenci (ad,soyad,sinif,cinsiyet) values ('Emirhan', 'Test','10A','K')
update ogrenci set cinsiyet= 'E' where ogrno=1008
select * from ogrenci where ogrno =1008
-- erkek öðrenciyi "K" öðrenci olarak insert ettim ve sonra
-- erkek öðrencinin cinsiyetini "E" yaparak güncelledim.
-- bu þekil ile erkek öðrenci 10A sýnýfýna kaydoldu.

-- Ogrenci tablosuna, cinsiyet alanýný güncelliyerek kayýt yapýlmamasý için bir trigger oluþturalým.
Create trigger trg_Cinsiyet_Guncelle_engel on ogrenci
after update
as begin
if(exists(select * from inserted , deleted
where inserted.ogrno=deleted.ogrno and
inserted.cinsiyet!=deleted.cinsiyet or 
deleted.cinsiyet is null)) --> exists içindeki deðerin olup olmadýðýna bakar.
begin
raiserror('Cinsiyet Güncellenemez',1,1) --> hata mesajý
rollback transaction
end 
end

-- deneyelim:
insert into ogrenci (ad,soyad,sinif,cinsiyet) values ('Caner', 'Test','10A','K')
update ogrenci set cinsiyet= 'E' where ogrno=1010
-- erkek öðrenciyi "K" öðrenci olarak insert ettim ve sonra
-- erkek öðrencinin cinsiyetini "E" yaparak güncelledim ve sonra "Cinsiyet Güncellenemez" hatasý aldým.
-- yaptýðýmýz trigger sayesinde erkek öðrenci, 10A sýnýfýna eklenmedi.

-- deneyelim:
insert into ogrenci (ad,soyad,sinif,cinsiyet) values ('Ali', 'Test','11A','E')
update ogrenci set sinif= '10A' where ogrno=1012
-- erkek öðrencinin sýnýfný 11A olarak insert ettim ve sonra
-- erkek öðrencinin sýnýfný 10A yaparak güncelledim.
-- bu þekil ile erkek öðrenci 10A sýnýfýna kaydoldu.

-- Ogrenci tablosuna, hem sýnýf alanýný hemde cinsiyet alanýný güncelliyerek yeni kayýt yapýlmamasý için bir trigger oluþturalým.
Create trigger trg_cinsiyet_sinif_guncelle_engeli on ogrenci
for update
as
if(exists (select * from inserted where sinif = '10A' and cinsiyet = 'E'))
begin 
raiserror('10A sýnýfýna erkek öðrenci kayýt edilmez.',1,1) --> hata mesajý
rollback transaction
end

-- deneyelim:
insert into ogrenci (ad,soyad,sinif,cinsiyet) values ('Poyraz', 'Test','12B','E')
update ogrenci set sinif= '10A' where ogrno=1017

insert into ogrenci (ad,soyad,sinif,cinsiyet) values ('Sedat', 'Test','10A','K')
update ogrenci set cinsiyet= 'E' where ogrno=1016
-- yaptýðýmýz trigger sayesinde, insert ettiðimiz kayýtlar hem sýnýf güncellemesine hemde cinsiyet güncellemesine engel olmuþtur.
-- her iki sorgu sonucunda "10A sýnýfýna erkek öðrenci kayýt edilmez." hatasý verir.

select * from ogrenci order by ogrno desc --> son eklediðimiz öðrenciler

-- 10A sýnýfýndan kýz öðrenci silinemesin ve hata mesajý veren triggerý oluþturalým.
Create trigger trg_10A_kizOgrenci_silinmez on ogrenci
for delete
as
if(exists (select * from deleted where sinif = '10A' and cinsiyet = 'K'))
begin 
raiserror('10A sýnýfýnda kýz öðrenci silinmez.',1,1) --> hata mesajý
rollback transaction
end

-- deniyelim:
insert into ogrenci (ad,soyad,sinif,cinsiyet) values ('Elif', 'Test','10A','K')
delete from ogrenci where ogrno=1018
-- trigger çalýþýr ve 10A sýnýfýndan kýz öðrenci silinmez.
-- sorgu sonucu ,'10A sýnýfýnda kýz öðrenci silinmez.' hatasý verir.

-- kitap tablosu güncellenirken eski kitap sayfa sayýsý yeni sayfa sayýsýndan fazla olmalý,
-- aksi taktir de uyarý veren triggerý yazýnýz
alter trigger trg_kitap_sayfa_guncelle on kitap
for update
as
if(exists(select * from inserted , deleted
where 
inserted.sayfasayisi < deleted.sayfasayisi)) --> exists içindeki deðerin olup olmadýðýna bakar.
begin 
raiserror('yeni girdiðiniz sayfa sayýsý eski sayfa sayýsýndan büyük olmalý',1,1) --> hata mesajý
rollback transaction
end

-- deniyelim:
select * from kitap
update kitap set sayfasayisi= 100 where kitapno=1 --> hata verir.(verdiðimiz deðer önceki sayfa sayýsýndan küçüktür.)
update kitap set sayfasayisi= 300 where kitapno=2 --> doðru çalýþýr.(verdiðimiz deðer önceki sayfa sayýsýndan büyüktür.)

-- tür tablosundan veri silinmesin, trigger oluþturalým.
create trigger trg_tur_silinmesin on tur
for delete
as
begin 
raiserror('tür tablosundan veri silinmez.',1,1) --> hata mesajý
rollback transaction
end

-- deniyelim:
insert into tur(ad) values ('Yeni tur1')
select *from tur order by turno desc
delete from tur where turno=21 
-- Triggerýmýz çalýþýr tür tablosundan veri silinmez.
-- Çýktý,'tür tablosundan veri silinmez.'hatasý verir.