
insert into ogrenci values('TGR1','aaa',8)
insert into ogrenci values('TGR2','bbb',6)
select* from ogrenci
--öncelikle test db de ogrenci tablosuna 2 kiþi ekledim.
--tabloyu görüntülemek için sorgu yazdým (select* from ogrenci)

--bu iki iþlemi bir sorguda yapmak için trigger oluþturdum.
create trigger trg_listele on ogrenci
after insert as
begin 
select * from ogrenci order by orgno desc
end

--denemek için 2 kayýt ekledim
insert into ogrenci values('TGR3','ddd',7)
insert into ogrenci values('TGR4','ddd',9)
--sonuc olarak tabloya kayýt ekledi ve tabloyu listeledi(ogrno çoktan aza doðru)

--daha önce oluþturduðumuz tirggerý gücelliyelim
alter trigger trg_listele on ogrenci
after insert as
begin 
select top 1 *,'yeni kayýt eklendi' as aciklama from ogrenci order by orgno desc
end
--yeni kayýt eklendiðinde 1 satýr halinde ve  açýklama kýsmýyla görünecek

--denemek için 2 kayýt ekledim
insert into ogrenci values('TGR5','eee',5)
insert into ogrenci values('TGR6','fff',8)

--silinen oðrenciler için tablo oluþturalým
CREATE TABLE silinen_ogrenciler(  
	[id] [int]  IDENTITY(1,1) NOT NULL,
	[orgno] [int]  NOT NULL,
	[ad] [nvarchar](50) NULL,
	[soyad] [nvarchar](50) NULL,
	[bolum_id] [int] NULL
)

--tablomuza silinme_tarihi alanýný ekledim ve güncelledim(alter)
alter table silinen_ogrenciler add silinme_tarihi datetime

--tablomuza aciklama alanýný ekledim ve güncelledim(alter)
alter table silinen_ogrenciler add aciklama varchar(100)

select * from silinen_ogrenciler
 
--silinen öðrencinin bilgilerini silinen_ogrenciler tablosuna ekleyen trigger'ý oluþturalým.
create trigger trg_silineniEkle on ogrenci
after delete as
begin 
insert into  silinen_ogrenciler
select *,getdate(), 'kayýt silindi' aciklama from deleted
end

--deniyelim:
select * from ogrenci 
select * from silinen_ogrenciler

delete from ogrenci where orgno = 22 --> silinen kayýt

--oluþturduðumuz triggerý güncelledik sildiðimiz kayýtý silinen_ogrenciler tablosunda direk bize gösterecek 
alter trigger trg_silineniEkle on ogrenci
after delete as
begin 
insert into silinen_ogrenciler 
select *,getdate(), 'kayýt silindi' aciklama from deleted;
select * from silinen_ogrenciler order by id desc;
end

--deniyelim:
delete from ogrenci where orgno = 7 --> silinen kayýt

--ayný anda birden fazla kayýt silelim 
delete from ogrenci where orgno >18
--ögrenci tablosundan 3 kayýt silindi ve silinen o 3 kayýt silinen_ogrenciler tablosuna eklendi.

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
