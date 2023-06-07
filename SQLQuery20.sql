-- view ile en �ok okuyan ��rencilerden ilk 10 ��renciyi getiren sql(bilgiler view� ile)
select top 10 ogrno, ogrenciAdSoyad ,count(*) from bilgiler
group by ogrno, ogrenciAdSoyad
order by count(*) desc

-- view ile en �ok okunan yazarlardan ilk 3 yazar� getiren sql(bilgiler view� ile)
select top 3 yazar ,count(*) from bilgiler
group by yazar
order by count(*) desc

--view ile en �ok okunan kitab� getiren sql(bilgiler view� ile)
select top 1 kitapAdi, count(*) from bilgiler
group by kitapAdi
order by count(*) desc

--Tur tablosuna kay�t silmesini engelleyen trigger� yaz�n�z.
Create trigger trg_tur_silinmez_2 on tur
instead of delete
as
begin 
raiserror('instead of kullan�larak t�r tablosundan veri silinmez.',1,1) 
rollback transaction
end
-- instead of: DELETE i�lemlerini atlay�p, bunun yerine tetikleyici i�inde tan�mlanan di�er ifadeleri (hata mesaj�) yerine getirirmektedir.
-- for/after: DELETE i�lemleri yap�ld�ktan belli i�lemlerin yap�lmas� i�in (hata mesaj�) kullan�lmaktad�r.

-- deniyelim:
select * from tur order by turno desc
delete from tur where turno=21
-- sonuc olarak silinmez hata mesaj� verir.

-- ��renci tablosuna silindi ve silinme_zamani alana ekleyiniz. 
alter table ogrenci add silindi bit null
alter table ogrenci add silinme_zamani datetime 
-- ��renci silinmesin ama silindi alan�n de�eri 1 olsun ve silinme zaman� da sistem tarihi verilsin
create trigger ogrenci_sil on ogrenci
instead of delete --> deniyelim:instead of kulland�k
as
begin
update ogrenci set 
silindi=1, silinme_zamani = getdate(), aciklama='*** ki�i taraf�ndan silindi'
where ogrno in(select ogrno from deleted)
end

--deniyelim:
select * from ogrenci order by ogrno desc
delete from ogrenci where ogrno=1016
delete from ogrenci where ogrno=1014
delete from ogrenci where ogrno=1013
-- Yukar�da bulunan �� ��renci delete komutu ile silinmedi,
-- bu �� ��rencinin silindi alan�na 1 yaz�ld�,
-- silinme zaman�na sistem tarihi ve saati girildi,
-- a��klama k�sm�na ise '*** ki�i taraf�ndan silindi' yaz�ld�.

-- T�r tablosuna guncelleme_zamani alan� ekleyiniz. 
alter table tur add guncelleme_zamani datetime
-- T�r tablosunda g�ncelleme yap�ld���nda tarihi g�ncelleyen triger yaz�n�z.
create trigger tur_guncelle on tur
after update
as
begin
update tur set guncelleme_zamani =getdate() 
where turno in(select turno from deleted)
end

--deniyelim:
select * from tur
update tur set ad='DRAM' where turno=1
update tur set ad='H�KAYE' where turno=4
update tur set ad='ANI' where turno=8
-- Yukar�da bulunan �� kitap t�r�n�n ad� g�ncellendi ve sistem saati, tarihi girildi.