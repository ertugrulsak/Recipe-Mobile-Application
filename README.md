# Mobile Application Project

ERCİYES ÜNİVERSİTESİ

BİLGİSAYAR MÜHENDİSLİĞİ

Dr. Öğr. Üyesi FEHİM KÖYLÜ

Mobile Application Development Dersi Final Proje Ödevi

1030510153 - Ertuğrul SAK



# CategoriesScreen:

Uygulamanın açılış ekranı, kullanıcıları farklı yemek kategorilerini listeleyerek karşılıyor.

Kullanıcılar bir kategoriye tıkladıklarında, o kategoriye ait yemeklerin listelendiği ana ekran (HomeScreen) açılıyor.



# HomeScreen:

Kullanıcının seçtiği kategorideki yemekleri listeleyen ekran.

Kullanıcılar bir yemeğe tıkladıklarında, o yemeğin detaylarını gösteren ekran (DetailScreen) açılıyor.



# DetailScreen:

Kullanıcının seçtiği yemeğin detaylarını gösteren ekran.

Yemek adı, görseli ve tarifi gibi detaylar bu ekranda yer alıyor.


# Önemli Noktalar

http paketi kullanılarak API'den veri alınıyor.

setState() metodu kullanılarak ekran yenileniyor ve veriler güncelleniyor.

ListView.builder widget'ı kullanılarak dinamik liste oluşturuluyor.

Navigator.pushNamed metodu kullanılarak sayfa yönlendirmeleri yapılıyor.
