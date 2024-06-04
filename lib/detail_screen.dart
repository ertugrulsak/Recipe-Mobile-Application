import 'dart:convert';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detailScreen';

  final String jsonDetailData;

  const DetailScreen({super.key, required this.jsonDetailData});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final decodedData;

  @override
  void initState() {
    super.initState();
    decodedData = jsonDecode(widget.jsonDetailData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          decodedData['meals'][0]['strMeal'],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .4,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Image.network(
                decodedData['meals'][0]['strMealThumb'],
                fit: BoxFit.cover,
              ),
            ),
            // Display the meal name
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Meal Instructions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    decodedData['meals'][0]['strInstructions'],
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
