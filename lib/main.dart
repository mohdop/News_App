import 'package:flutter/material.dart';
import 'package:news_app/pages/Auth/Login.dart';
import 'package:news_app/pages/Auth/Signup.dart';
import 'package:news_app/pages/home.dart';
import 'package:news_app/pages/searchNews.dart';
import 'package:news_app/pages/source.dart';
import 'package:news_app/pages/splashScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:SplashScreen() ,
    routes: {
      "/home": (context) => const HomePage(),
      "/splash": (context) => const SplashScreen(),
      "/login": (context) => const Login(),
      "/register": (context) => const Register(),
      "/search":(context) => const SearchNews(),
      "/source":(context) => const NewsSource(),
    },
  ));
}