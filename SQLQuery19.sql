--ogrenci tablosuna yeni kay�t ekledi�imizde ekrana sadece yeni eklenen ki�inin kayd�n� getiren trigger� yazal�m.
create trigger trg_Listele on ogrenci
after insert
as begin
select top 1 'yeni kay�t_eklendi', * from ogrenci order by ogrno desc
end
 
-- deneyelim:
select * from ogrenci
insert into ogrenci (ad,soyad,sinif,cinsiyet) values ('Ahmet', 'Deneme','12A','E')
insert into ogrenci (ad,soyad,sinif,cinsiyet) values ('Ay�e', 'Deneme','11A','K')
-- iki kay�t ekliyerek istedi�imiz sonuca vard�k.

-- silinen ��renci tablosu yapal�m
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

-- ��renci tablosundan sildi�imiz kay�tlar silinen ��renci tablosuna ge�mesi i�in bir trigger olu�tural�m.
ALTER trigger trg_silinenOgrenciyiEkle on ogrenci
after delete as
begin 
insert into silinen_ogrenci 
select *,getdate(),'i�lem_yapan' from deleted;
end

-- deniyelim:
select * from ogrenci
delete from ogrenci where ogrno=1006
delete from ogrenci where ogrno=1005
select * from silinen_ogrenci
-- �nceden ekledi�imiz ��rencileri sildik.
-- silinen ��renciler, silinen ��renci tablosuna ge�i� yapt� (silme zaman� ve yapan ki�i ile kayda ge�ti)
-- NOT:kay�tl� ��rencinin birden fazla tabloda bulunmas� yani ili�kili olmas� halinde ��renci silinmez. Hata verir.

-- 10A s�n�f�na erkek ��renci kaydolmamas� i�in bir trigger olu�tural�m
Create trigger trg_10A_cinsiyet_kiz on ogrenci
for insert
as
if(exists (select * from inserted where sinif = '10A' and cinsiyet = 'E'))
begin 
raiserror('10A s�n�f�na erkek ��renci kay�t edilmez.',1,1) --> hata mesaj�
rollback transaction
end

-- deniyelim:
insert into ogrenci (ad,soyad,sinif,cinsiyet) values ('Emirhan', 'Test','10A','E')
-- Eklemedi , trigger sayesinde "10A s�n�f�na erkek ��renci kay�t edilmez." hata mesaj� verdi.

-- deniyelim:
insert into ogrenci (ad,soyad,sinif,cinsiyet) values ('Emirhan', 'Test','10A','K')
update ogrenci set cinsiyet= 'E' where ogrno=1008
select * from ogrenci where ogrno =1008
-- erkek ��renciyi "K" ��renci olarak insert ettim ve sonra
-- erkek ��rencinin cinsiyetini "E" yaparak g�ncelledim.
-- bu �ekil ile erkek ��renci 10A s�n�f�na kaydoldu.

-- Ogrenci tablosuna, cinsiyet alan�n� g�ncelliyerek kay�t yap�lmamas� i�in bir trigger olu�tural�m.
Create trigger trg_Cinsiyet_Guncelle_engel on ogrenci
after update
as begin
if(exists(select * from inserted , deleted
where inserted.ogrno=deleted.ogrno and
inserted.cinsiyet!=deleted.cinsiyet or 
deleted.cinsiyet is null)) --> exists i�indeki de�erin olup olmad���na bakar.
begin
raiserror('Cinsiyet G�ncellenemez',1,1) --> hata mesaj�
rollback transaction
end 
end

-- deneyelim:
insert into ogrenci (ad,soyad,sinif,cinsiyet) values ('Caner', 'Test','10A','K')
update ogrenci set cinsiyet= 'E' where ogrno=1010
-- erkek ��renciyi "K" ��renci olarak insert ettim ve sonra
-- erkek ��rencinin cinsiyetini "E" yaparak g�ncelledim ve sonra "Cinsiyet G�ncellenemez" hatas� ald�m.
-- yapt���m�z trigger sayesinde erkek ��renci, 10A s�n�f�na eklenmedi.

-- deneyelim:
insert into ogrenci (ad,soyad,sinif,cinsiyet) values ('Ali', 'Test','11A','E')
update ogrenci set sinif= '10A' where ogrno=1012
-- erkek ��rencinin s�n�fn� 11A olarak insert ettim ve sonra
-- erkek ��rencinin s�n�fn� 10A yaparak g�ncelledim.
-- bu �ekil ile erkek ��renci 10A s�n�f�na kaydoldu.

-- Ogrenci tablosuna, hem s�n�f alan�n� hemde cinsiyet alan�n� g�ncelliyerek yeni kay�t yap�lmamas� i�in bir trigger olu�tural�m.
Create trigger trg_cinsiyet_sinif_guncelle_engeli on ogrenci
for update
as
if(exists (select * from inserted where sinif = '10A' and cinsiyet = 'E'))
begin 
raiserror('10A s�n�f�na erkek ��renci kay�t edilmez.',1,1) --> hata mesaj�
rollback transaction
end

-- deneyelim:
insert into ogrenci (ad,soyad,sinif,cinsiyet) values ('Poyraz', 'Test','12B','E')
update ogrenci set sinif= '10A' where ogrno=1017

insert into ogrenci (ad,soyad,sinif,cinsiyet) values ('Sedat', 'Test','10A','K')
update ogrenci set cinsiyet= 'E' where ogrno=1016
-- yapt���m�z trigger sayesinde, insert etti�imiz kay�tlar hem s�n�f g�ncellemesine hemde cinsiyet g�ncellemesine engel olmu�tur.
-- her iki sorgu sonucunda "10A s�n�f�na erkek ��renci kay�t edilmez." hatas� verir.

select * from ogrenci order by ogrno desc --> son ekledi�imiz ��renciler

-- 10A s�n�f�ndan k�z ��renci silinemesin ve hata mesaj� veren trigger� olu�tural�m.
Create trigger trg_10A_kizOgrenci_silinmez on ogrenci
for delete
as
if(exists (select * from deleted where sinif = '10A' and cinsiyet = 'K'))
begin 
raiserror('10A s�n�f�nda k�z ��renci silinmez.',1,1) --> hata mesaj�
rollback transaction
end

-- deniyelim:
insert into ogrenci (ad,soyad,sinif,cinsiyet) values ('Elif', 'Test','10A','K')
delete from ogrenci where ogrno=1018
-- trigger �al���r ve 10A s�n�f�ndan k�z ��renci silinmez.
-- sorgu sonucu ,'10A s�n�f�nda k�z ��renci silinmez.' hatas� verir.

-- kitap tablosu g�ncellenirken eski kitap sayfa say�s� yeni sayfa say�s�ndan fazla olmal�,
-- aksi taktir de uyar� veren trigger� yaz�n�z
alter trigger trg_kitap_sayfa_guncelle on kitap
for update
as
if(exists(select * from inserted , deleted
where 
inserted.sayfasayisi < deleted.sayfasayisi)) --> exists i�indeki de�erin olup olmad���na bakar.
begin 
raiserror('yeni girdi�iniz sayfa say�s� eski sayfa say�s�ndan b�y�k olmal�',1,1) --> hata mesaj�
rollback transaction
end

-- deniyelim:
select * from kitap
update kitap set sayfasayisi= 100 where kitapno=1 --> hata verir.(verdi�imiz de�er �nceki sayfa say�s�ndan k���kt�r.)
update kitap set sayfasayisi= 300 where kitapno=2 --> do�ru �al���r.(verdi�imiz de�er �nceki sayfa say�s�ndan b�y�kt�r.)

-- t�r tablosundan veri silinmesin, trigger olu�tural�m.
create trigger trg_tur_silinmesin on tur
for delete
as
begin 
raiserror('t�r tablosundan veri silinmez.',1,1) --> hata mesaj�
rollback transaction
end

-- deniyelim:
insert into tur(ad) values ('Yeni tur1')
select *from tur order by turno desc
delete from tur where turno=21 
-- Trigger�m�z �al���r t�r tablosundan veri silinmez.
-- ��kt�,'t�r tablosundan veri silinmez.'hatas� verir.