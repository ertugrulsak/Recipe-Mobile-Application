import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/home_screen.dart';

class CategoriesScreen extends StatefulWidget {
  // Kategorilerin ve detay verilerinin tutulacağı değişkenler
  Map<String, dynamic>? jsonCategoriesData;
  String? jsonCategoriesDetailData;
  String? categoryName;

  CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // Kategorileri getiren API çağrısı
  fetchCategories() async {
    var request = http.Request('GET', Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // API'den gelen JSON verisini çözümler
      return jsonDecode(await response.stream.bytesToString());
    } else {
      // Hata durumunda konsola bildirim yazdırır
      print(response.reasonPhrase);
    }
  }

  // Seçilen kategoriye göre detay verilerini getiren API çağrısı
  fetchDetailCategory() async {
    var request = http.Request('GET', Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=${widget.categoryName}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // API'den gelen JSON detay verisini saklar
      widget.jsonCategoriesDetailData = await response.stream.bytesToString();
      // Konsola detay verilerini yazdırır
      print(widget.jsonCategoriesDetailData);
    } else {
      // Hata durumunda konsola bildirim yazdırır
      print(response.reasonPhrase);
    }
  }

  // Kategorileri asenkron olarak getiren metot
  void asyncMethod() async {
    // Kategorileri getir
    var data = await fetchCategories();
    // State'i güncelle
    setState(() {
      widget.jsonCategoriesData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    // initState içinde kategorileri getiren metodu çağırır
    asyncMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kategoriler'), centerTitle: true,),
      body: SingleChildScrollView(
        child: widget.jsonCategoriesData != null
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: widget.jsonCategoriesData?['categories'].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      setState(() {
                        // Seçilen kategoriyi güncelle
                        widget.categoryName = widget.jsonCategoriesData?['categories'][index]['strCategory'];
                      });
                      // Seçilen kategoriye ait detay verilerini getir
                      await fetchDetailCategory();
                      // Detay ekranına git
                      Navigator.pushNamed(
                        context,
                        HomeScreen.routeName,
                        arguments: widget.jsonCategoriesDetailData,
                      ).then((_) {
                        // Geri döndüğünde kategorileri yenile
                        asyncMethod();
                      });
                    },
                    title: Text(widget.jsonCategoriesData?['categories'][index]['strCategory'] ?? ''),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
