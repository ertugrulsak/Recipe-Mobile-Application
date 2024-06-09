# Mobile Application Project

ERCİYES ÜNİVERSİTESİ

BİLGİSAYAR MÜHENDİSLİĞİ

Dr. Öğr. Üyesi FEHİM KÖYLÜ

Mobile Application Development Dersi Final Proje Ödevi

1030510153 - Ertuğrul SAK

# Geliştirme Ortamı

Project IDX, web tabanlı bir geliştirme ortamıdır ve Flutter projeleri geliştirmek için idealdir. Bu platformda, sıfırdan bir Flutter projesi oluşturarak üç sayfalık bir yemek tarifi uygulaması geliştirdim.

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


# ENG

# Development Environment

Project IDX is a web-based development environment ideal for developing Flutter projects. I created a Flutter project from scratch on this platform and developed a three-page recipe app.

# CategoriesScreen:

The opening screen of the app welcomes users by listing different food categories.

When users click on a category, the home screen (HomeScreen) opens, listing the dishes in that category.



# HomeScreen:

The screen that lists the dishes in the category selected by the user.

When users click on a dish, a screen (DetailScreen) opens showing the details of that dish.



# DetailScreen:

The screen that shows the details of the dish the user has selected.

Details such as the name, picture and recipe of the dish are displayed on this screen.


# Important Points

Retrieve data from the API using the http package.

Refresh the screen and update the data using the SetState() method.

Create a dynamic list using the ListView.builder widget.

Use the Navigator.pushNamed method to redirect the page.
