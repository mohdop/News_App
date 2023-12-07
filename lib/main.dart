import 'package:flutter/material.dart';
import 'package:news_app/pages/home.dart';
void main() {
  runApp( MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/home":(context) => HomePage(),
      },
      home: HomePage(),
    );
  }
}

