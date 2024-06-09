import 'package:flutter/material.dart';
import 'package:myapp/categories.dart';
import 'package:myapp/detail_screen.dart';
import 'package:myapp/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        
      ),
      routes : {
   DetailScreen.routeName: (context) => DetailScreen(
      jsonDetailData: ModalRoute.of(context)?.settings.arguments as String,
    ),
       HomeScreen.routeName: (context) => HomeScreen(
      jsonDatas: ModalRoute.of(context)?.settings.arguments as String,
    ),
      },
      home:  CategoriesScreen(),
    );
  }
}

