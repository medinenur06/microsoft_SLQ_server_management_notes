select *from ogrenci,bolum 
where ogrenci.bolum_id=bolum.bolum_id --inner joindir

select* from ogrenci join bolum 
on ogrenci.bolum_id=bolum.bolum_id --inner joindir

select* from ogrenci org inner join bolum blm
on org.bolum_id=blm.bolum_id

select* from ogrenci org left join bolum blm
on org.bolum_id=blm.bolum_id

select* from ogrenci org right join bolum blm
on org.bolum_id=blm.bolum_id

select* from ogrenci A full outer join bolum B
on A.bolum_id=B.bolum_id

select ogrenci.ad, bolum.bolum_ad 
from ogrenci inner join bolum
on ogrenci.bolum_id=bolum.bolum_id

select ogrenci.orgno,ad,soyad, bolum.bolum_ad 
from ogrenci join bolum
on ogrenci.bolum_id=bolum.bolum_id

select ad,bolum_ad,bolum.bolum_id
from ogrenci join bolum
on ogrenci.bolum_id=bolum.bolum_id
--eðer alan ismi bütün tablolarda tek ise alan isimlerinin baþýna tablo ismi yazmamýz gerekir

select ogrenci.*from ogrenci inner join bolum 
on ogrenci.bolum_id=bolum.bolum_id

select bolum.*from ogrenci inner join bolum 
on ogrenci.bolum_id=bolum.bolum_id

select ogrenci.*,bolum.*from ogrenci inner join bolum 
on ogrenci.bolum_id=bolum.bolum_id


















