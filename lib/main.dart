import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/dzikir_page.dart';
import 'pages/doa_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TasbihKu',

      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Poppins',
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => HomePage(),
        '/dzikir': (context) => DzikirPage(),
        '/doa': (context) => DoaPage(),
      },
    );
  }
}