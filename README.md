# Veterinary


Bu akıllı sözleşme kayıt ve durum tutan bir veterinerlik sistem örneğidir. İhtiyaca göre şekillendirilebilir en basit anlatımıyla aşağıdaki gibidir.




![image](https://user-images.githubusercontent.com/96335654/194388844-769ccf04-b4d9-4abf-bd5b-56c795b6325c.png)

Struct olarak bir Client tanımladık burada structın içinde PetOwner'ımızı Pet Species'ımızı ve owner tarafından düzenlenen aşı durumunun kaydını tutucaz
Enum olarak bir Situation tanımı yaptık burada ise petin aşısının hangi durumda olduğunu takip edicez ve veterinere ilk kayıt olduğunda 0 ( Accepted ) olarak
ayarlanıcak daha sonrasında ise owner tarafından bu bilgiler güncellenicek.

![image](https://user-images.githubusercontent.com/96335654/194389365-ec696060-638c-4551-9f63-ffd13932f33f.png)


Array tanımladık bu arrayi Struct olan Client türünden tuttuk arrayemize de clients ismini verdik.
Örnek olsun diye fee değişkeni tanımladık bu zorunlu değildi ama üye olma ücreti 1 ethere sabitledik.
Contractı deploy eden kişiyi owner olarak atadığımız bir constructor var ve eventler tanımladık her yapılan işlemin sonunda bir event yayınlamak amacıyla.


![image](https://user-images.githubusercontent.com/96335654/194390142-be187ed2-51af-412b-8358-8b6fe3e0007b.png)

İlk fonksiyonumuz register burada kullanıcı pet speciesi girerek sisteme kayıt yaptırabilir ücret olarakda 1 ether göndermesi gerekir
Eğer gerekli şartı sağlamassa "Fee is 1 Ether" hatası alıcaktır
İşlem başarılı bir hale gelmesi sonucunda welcome adında bir event yayınlanacaktır.

![image](https://user-images.githubusercontent.com/96335654/194390564-0be78319-1093-4303-a1a4-3dbdec08d024.png)

İkinci fonksiyonumuz sadece Owner'ın kullanabileceği bir updateSituation fonksiyonu bu fonksiyon petin durumunu bir üst seviyeye taşır yani ilk aşısı yapılırsa
0(accepted)' dan 1(FirstVaccine)'e taşınır bu sayede petimizin ilk aşı olduğunu anlayabiliriz.
Fonksiyon başarılı bir şekilde çalışırsa hangi kullanıcının petinin bir üst seviyeye çıktığını gösteren bir event yayınlanır.

![image](https://user-images.githubusercontent.com/96335654/194391028-5d38e9ef-dfe0-449d-97bf-6b4affbb73a5.png)

Üçüncü fonksiyonumuz ise quitFromVeterinary bu fonksiyonda kayıtlanan kullanıcı istediği zaman veterinerden ayrılabilir. 
Her kullanıcı sadece kendi hesabı için işlem yapar aksi halde "Invalid client id" hatası alır.
Leaved diye bir event yayınlanır.

![image](https://user-images.githubusercontent.com/96335654/194391300-9d110130-e40b-40dd-80de-7f61843164dc.png)

Bu fonksiyon yanlış girilen pet speciesi düzeltmek için çalışır yine her kullanıcı kendi adına işlem yapabilir aksi halde "Invalid client id" hatası alır.
Fonksiyonun başarılı çalışması halinde fixed diye bir event yayınlanır.

![image](https://user-images.githubusercontent.com/96335654/194391718-bf97da55-53fe-493f-8533-a80bb14e5a4d.png)

Bu fonksiyon ise ownerın bir hesabı silmesini sağlar. Petin işlemleri bitmiş olabilir her hangi bir sebepten kullanıcı silmesi gerekirse bu fonksiyon çalıştırılır.
Fonksiyon başarılı sonuçlanması halinde Deleted user adında bir event yayınlanır.

![image](https://user-images.githubusercontent.com/96335654/194391942-5d2b82b9-be37-420b-ade3-242bda2e556c.png)

WithdrawMoney fonksiyonu ise contract üzerinde oluşan parayı ownerin adresine çeker. Sadece owner yapabilir fonksiyon bitmesi halinde Withdraw adında bir
event yayınlanır.

![image](https://user-images.githubusercontent.com/96335654/194392245-a7b165c3-7ec8-4eb7-b42e-fd7e49b755a9.png)

bu modifier ise klasik onlyOwner modifieridir fonksiyonları sadece ownerın yapabilmesini sağlar. Dışarıdan her hangi bir kişi yapamaz.



