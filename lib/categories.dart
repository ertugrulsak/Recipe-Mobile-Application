import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/home_screen.dart';

class CategoriesScreen extends StatefulWidget {
   Map<String, dynamic>? jsonCategoriesData;
   String? jsonCategoriesDetailData;
   String? categoryName;

   CategoriesScreen({super.key});


  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  

  fetchCategories() async {
    var request = http.Request('GET', Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));


http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {

  return jsonDecode(await response.stream.bytesToString());
 
}
else {
  print(response.reasonPhrase);
}

  }

  fetchDetailCategory() async {
 var request = http.Request('GET', Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=${widget.categoryName}'));


http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  widget.jsonCategoriesDetailData = await response.stream.bytesToString();
  print(widget.jsonCategoriesDetailData);
}
else {
  print(response.reasonPhrase);
}

  }

  

  void asyncMethod()async{
    var data = await fetchCategories();
    setState(() {
      widget.jsonCategoriesData = data;
    });
  }

  @override
  void initState() {
    super.initState();
asyncMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kategoriler'),centerTitle: true,),
     body: SingleChildScrollView(
        child: widget.jsonCategoriesData != null
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: widget.jsonCategoriesData?['categories'].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: ()async{
                      setState(() {
                        widget.categoryName = widget.jsonCategoriesData?['categories'][index]['strCategory'];
                       
                      });
                      await fetchDetailCategory();
                           Navigator.pushNamed(
                          context,
                          HomeScreen.routeName,
                          arguments: widget.jsonCategoriesDetailData,
                        ).then((_) {
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