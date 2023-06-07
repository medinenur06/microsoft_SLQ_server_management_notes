-- view ile en çok okuyan öðrencilerden ilk 10 öðrenciyi getiren sql(bilgiler viewý ile)
select top 10 ogrno, ogrenciAdSoyad ,count(*) from bilgiler
group by ogrno, ogrenciAdSoyad
order by count(*) desc

-- view ile en çok okunan yazarlardan ilk 3 yazarý getiren sql(bilgiler viewý ile)
select top 3 yazar ,count(*) from bilgiler
group by yazar
order by count(*) desc

--view ile en çok okunan kitabý getiren sql(bilgiler viewý ile)
select top 1 kitapAdi, count(*) from bilgiler
group by kitapAdi
order by count(*) desc

--Tur tablosuna kayýt silmesini engelleyen triggerý yazýnýz.
Create trigger trg_tur_silinmez_2 on tur
instead of delete
as
begin 
raiserror('instead of kullanýlarak tür tablosundan veri silinmez.',1,1) 
rollback transaction
end
-- instead of: DELETE iþlemlerini atlayýp, bunun yerine tetikleyici içinde tanýmlanan diðer ifadeleri (hata mesajý) yerine getirirmektedir.
-- for/after: DELETE iþlemleri yapýldýktan belli iþlemlerin yapýlmasý için (hata mesajý) kullanýlmaktadýr.

-- deniyelim:
select * from tur order by turno desc
delete from tur where turno=21
-- sonuc olarak silinmez hata mesajý verir.

-- Öðrenci tablosuna silindi ve silinme_zamani alana ekleyiniz. 
alter table ogrenci add silindi bit null
alter table ogrenci add silinme_zamani datetime 
-- Öðrenci silinmesin ama silindi alanýn deðeri 1 olsun ve silinme zamaný da sistem tarihi verilsin
create trigger ogrenci_sil on ogrenci
instead of delete --> deniyelim:instead of kullandýk
as
begin
update ogrenci set 
silindi=1, silinme_zamani = getdate(), aciklama='*** kiþi tarafýndan silindi'
where ogrno in(select ogrno from deleted)
end

--deniyelim:
select * from ogrenci order by ogrno desc
delete from ogrenci where ogrno=1016
delete from ogrenci where ogrno=1014
delete from ogrenci where ogrno=1013
-- Yukarýda bulunan üç öðrenci delete komutu ile silinmedi,
-- bu üç öðrencinin silindi alanýna 1 yazýldý,
-- silinme zamanýna sistem tarihi ve saati girildi,
-- açýklama kýsmýna ise '*** kiþi tarafýndan silindi' yazýldý.

-- Tür tablosuna guncelleme_zamani alaný ekleyiniz. 
alter table tur add guncelleme_zamani datetime
-- Tür tablosunda güncelleme yapýldýðýnda tarihi güncelleyen triger yazýnýz.
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
update tur set ad='HÝKAYE' where turno=4
update tur set ad='ANI' where turno=8
-- Yukarýda bulunan üç kitap türünün adý güncellendi ve sistem saati, tarihi girildi.