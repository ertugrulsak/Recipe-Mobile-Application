import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/detail_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  final String? jsonDatas; // Değiştirildi

  HomeScreen({Key? key, required this.jsonDatas});

  Map<String, dynamic>? jsonData;
  String? jsonDetailData;
  int? idMeal = 0;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final decodedData;
  @override
  void initState() {
    super.initState();
    // asyncMethod();
    decodedData = jsonDecode(widget.jsonDatas!); 
  }

  void asyncMethod() async {
    var data = await fetchMeal();
    setState(() {
      widget.jsonData = data;
    });
  }

  Future<Map<String, dynamic>?> fetchMeal() async {
    var request = http.Request('GET', Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?f=a'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return jsonDecode(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  fetchDetailMeal() async {
    var request = http.Request('GET', Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=${widget.idMeal}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      widget.jsonDetailData = await response.stream.bytesToString();
      print(widget.jsonDetailData);
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meals'),
        centerTitle: true,
      ),
      body: decodedData != null
          ? ListView.builder(
              itemCount: decodedData['meals'].length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Image.network(decodedData['meals'][index]['strMealThumb']),
                    title: InkWell(
                      onTap: () async {
                        setState(() {
                          widget.idMeal = int.tryParse(decodedData['meals'][index]['idMeal']);
                        });
                        await fetchDetailMeal();
                        Navigator.pushNamed(
                          context,
                          DetailScreen.routeName,
                          arguments: widget.jsonDetailData,
                        ).then((_) {
                          asyncMethod();
                        });
                      },
                      child: Text(decodedData['meals'][index]['strMeal']),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
