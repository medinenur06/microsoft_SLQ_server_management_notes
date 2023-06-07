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
--ogrno 3 olan ��rencinin cinsiyeti g�ncellenmez.