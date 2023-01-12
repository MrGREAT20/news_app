import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/pages/MainPage.dart';
import 'package:news_app/pages/home.dart';
import 'package:news_app/pages/login.dart';
//import 'HomePage.dart';
// import 'pages/home.dart';
// import 'pages/posts.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(new MaterialApp(
    home: MainPage(),
  ));
}
