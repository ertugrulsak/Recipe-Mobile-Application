import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/detail_screen.dart';

// Ana ekran bileşeni, API'den yemek verilerini alır ve listeler
class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  final String? jsonDatas; // Ana ekran için JSON verisi

  HomeScreen({Key? key, required this.jsonDatas});

  // API'den alınan yemek verileri ve detay verileri için değişkenler
  Map<String, dynamic>? jsonData;
  String? jsonDetailData;
  int? idMeal = 0;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final decodedData; // API'den gelen JSON verisinin çözümlenmiş hali

  @override
  void initState() {
    super.initState();
    // Ana bileşen yüklendiğinde, API'den alınan JSON verisini çözümle
    decodedData = jsonDecode(widget.jsonDatas!);
  }

  // Asenkron olarak yemek verilerini API'den getirir
  void asyncMethod() async {
    var data = await fetchMeal();
    // Yeni veri geldiğinde, bileşenin yeniden çizilmesi için setState çağırılır
    setState(() {
      widget.jsonData = data;
    });
  }

  // API'den yemek verilerini getiren asenkron fonksiyon
  Future<Map<String, dynamic>?> fetchMeal() async {
    var request = http.Request('GET', Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?f=a'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return jsonDecode(await response.stream.bytesToString());
    } else {
      // Hata durumunda konsola bildirim yazdır
      print(response.reasonPhrase);
      return null;
    }
  }

  // Seçilen yemeğin detay verilerini API'den getirir
  fetchDetailMeal() async {
    var request = http.Request('GET', Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=${widget.idMeal}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // API'den gelen detay verilerini saklar ve konsola yazdırır
      widget.jsonDetailData = await response.stream.bytesToString();
      print(widget.jsonDetailData);
    } else {
      // Hata durumunda konsola bildirim yazdır
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meals'), // Sayfa başlığı
        centerTitle: true, // Başlık ortalanır
      ),
      body: decodedData != null // Eğer veri varsa
          ? ListView.builder(
              itemCount: decodedData['meals'].length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Image.network(decodedData['meals'][index]['strMealThumb']), // Yemek görseli
                    title: InkWell(
                      onTap: () async {
                        setState(() {
                          // Seçilen yemeğin ID'sini alır
                          widget.idMeal = int.tryParse(decodedData['meals'][index]['idMeal']);
                        });
                        await fetchDetailMeal(); // Yemek detaylarını getir
                        Navigator.pushNamed(
                          context,
                          DetailScreen.routeName,
                          arguments: widget.jsonDetailData, // Detay ekranına detay verilerini gönderir
                        ).then((_) {
                          asyncMethod(); // Geri döndüğünde ana bileşeni yeniler
                        });
                      },
                      child: Text(decodedData['meals'][index]['strMeal']), // Yemek adı
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(), // Veri yüklenirken dönme animasyonu
            ),
    );
  }
}
