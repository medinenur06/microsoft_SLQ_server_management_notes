alter table ogrenci add cinsiyet varchar(1);
select * from ogrenci
-- cinsiyet alaný eklendi

-- ogrenci tablosunun tüm alaný(ad,soyad,bolum_id,cinsiyet) güncellemesini engelleyen trigger(tetikleyici) yazýnýz
create trigger trg_guncellemeyi_engelle on ogrenci
after update
as begin
if(exists
	(
		select * from inserted,
		deleted where inserted.orgno =deleted.orgno) --> inserted ve deleted tablolarý where þartý ile baðlandý.
	)	
		begin
			raiserror('Güncelleme yapýlamaz',1,1) --> hata mesajý
			rollback transaction
		end
	end

-- deniyelim:
update ogrenci set ad ='esma sultan' where orgno=3
-- trg_guncellemeyi_engelle sayesinde güncelleme yapmadý 
-- güncelleme engellendiði için hata mesajý "Güncelleme yapýlamaz" yazdý

-- þimdi ise oluþturduðumuz güncellemeyi engelleyici trigger'a sadece cinsiyet alaný için oluþturalým.
alter trigger trg_guncellemeyi_engelle on ogrenci
after update
as begin
if(exists
	(
		select * from inserted,
		deleted where inserted.orgno =deleted.orgno 
		and inserted.cinsiyet!= deleted.cinsiyet) --> cinsiyet deðiþikliliði var mý?
		
	)	
		begin
			raiserror('Güncelleme yapýlamaz',1,1) --> hata mesajý
			rollback transaction
		end
	end

--deniyelim:
update ogrenci set cinsiyet ='K' where orgno=2
-- ogrno 3 olan öðrencinin cinsiyeti zaten "K" olduðu için gücelleme baþarýlýyla gerçekleþtirilir.

update ogrenci set cinsiyet ='E' where orgno=2
--ogrno 3 olan öðrencinin cinsiyeti güncellenmez.

update ogrenci set ad ='aaa', cinsiyet = 'E' where orgno=2
--ogrno 3 olan öðrencinin cinsiyeti güncellenmez.