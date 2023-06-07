
insert into ogrenci values('TGR1','aaa',8)
insert into ogrenci values('TGR2','bbb',6)
select* from ogrenci
--�ncelikle test db de ogrenci tablosuna 2 ki�i ekledim.
--tabloyu g�r�nt�lemek i�in sorgu yazd�m (select* from ogrenci)

--bu iki i�lemi bir sorguda yapmak i�in trigger olu�turdum.
create trigger trg_listele on ogrenci
after insert as
begin 
select * from ogrenci order by orgno desc
end

--denemek i�in 2 kay�t ekledim
insert into ogrenci values('TGR3','ddd',7)
insert into ogrenci values('TGR4','ddd',9)
--sonuc olarak tabloya kay�t ekledi ve tabloyu listeledi(ogrno �oktan aza do�ru)

--daha �nce olu�turdu�umuz tirgger� g�celliyelim
alter trigger trg_listele on ogrenci
after insert as
begin 
select top 1 *,'yeni kay�t eklendi' as aciklama from ogrenci order by orgno desc
end
--yeni kay�t eklendi�inde 1 sat�r halinde ve  a��klama k�sm�yla g�r�necek

--denemek i�in 2 kay�t ekledim
insert into ogrenci values('TGR5','eee',5)
insert into ogrenci values('TGR6','fff',8)

--silinen o�renciler i�in tablo olu�tural�m
CREATE TABLE silinen_ogrenciler(  
	[id] [int]  IDENTITY(1,1) NOT NULL,
	[orgno] [int]  NOT NULL,
	[ad] [nvarchar](50) NULL,
	[soyad] [nvarchar](50) NULL,
	[bolum_id] [int] NULL
)

--tablomuza silinme_tarihi alan�n� ekledim ve g�ncelledim(alter)
alter table silinen_ogrenciler add silinme_tarihi datetime

--tablomuza aciklama alan�n� ekledim ve g�ncelledim(alter)
alter table silinen_ogrenciler add aciklama varchar(100)

select * from silinen_ogrenciler
 
--silinen ��rencinin bilgilerini silinen_ogrenciler tablosuna ekleyen trigger'� olu�tural�m.
create trigger trg_silineniEkle on ogrenci
after delete as
begin 
insert into  silinen_ogrenciler
select *,getdate(), 'kay�t silindi' aciklama from deleted
end

--deniyelim:
select * from ogrenci 
select * from silinen_ogrenciler

delete from ogrenci where orgno = 22 --> silinen kay�t

--olu�turdu�umuz trigger� g�ncelledik sildi�imiz kay�t� silinen_ogrenciler tablosunda direk bize g�sterecek 
alter trigger trg_silineniEkle on ogrenci
after delete as
begin 
insert into silinen_ogrenciler 
select *,getdate(), 'kay�t silindi' aciklama from deleted;
select * from silinen_ogrenciler order by id desc;
end

--deniyelim:
delete from ogrenci where orgno = 7 --> silinen kay�t

--ayn� anda birden fazla kay�t silelim 
delete from ogrenci where orgno >18
--�grenci tablosundan 3 kay�t silindi ve silinen o 3 kay�t silinen_ogrenciler tablosuna eklendi.

alter table ogrenci add cinsiyet varchar(1);
select * from ogrenci
-- cinsiyet alan� eklendi

-- ogrenci tablosunun t�m alan�(ad,soyad,bolum_id,cinsiyet) g�ncellemesini engelleyen trigger(tetikleyici) yaz�n�z
create trigger trg_guncellemeyi_engelle on ogrenci
after update
as begin
if(exists
	(
		select * from inserted,
		deleted where inserted.orgno =deleted.orgno) --> inserted ve deleted tablolar� where �art� ile ba�land�.
	)	
		begin
			raiserror('G�ncelleme yap�lamaz',1,1) --> hata mesaj�
			rollback transaction
		end
	end

-- deniyelim:
update ogrenci set ad ='esma sultan' where orgno=3
-- trg_guncellemeyi_engelle sayesinde g�ncelleme yapmad� 
-- g�ncelleme engellendi�i i�in hata mesaj� "G�ncelleme yap�lamaz" yazd�

-- �imdi ise olu�turdu�umuz g�ncellemeyi engelleyici trigger'a sadece cinsiyet alan� i�in olu�tural�m.
alter trigger trg_guncellemeyi_engelle on ogrenci
after update
as begin
if(exists
	(
		select * from inserted,
		deleted where inserted.orgno =deleted.orgno 
		and inserted.cinsiyet!= deleted.cinsiyet) --> cinsiyet de�i�iklili�i var m�?
		
	)	
		begin
			raiserror('G�ncelleme yap�lamaz',1,1) --> hata mesaj�
			rollback transaction
		end
	end

--deniyelim:
update ogrenci set cinsiyet ='K' where orgno=2
-- ogrno 3 olan ��rencinin cinsiyeti zaten "K" oldu�u i�in g�celleme ba�ar�l�yla ger�ekle�tirilir.

update ogrenci set cinsiyet ='E' where orgno=2
--ogrno 3 olan ��rencinin cinsiyeti g�ncellenmez.

update ogrenci set ad ='aaa', cinsiyet = 'E' where orgno=2
