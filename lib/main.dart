import 'package:flutter/material.dart';
import 'package:test_app/UI/pages/atbash_page.dart';
import 'package:test_app/UI/pages/caesar_page.dart';
import 'package:test_app/UI/pages/home_page.dart';
import 'package:test_app/UI/pages/login_page.dart';
import 'package:test_app/UI/pages/register_page.dart';
import 'package:test_app/UI/pages/vigenere_page.dart';

import 'api/database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Database.init();
    return MaterialApp(
        title: 'Cipher Cracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        routes: {
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage(),
          '/register': (context) => RegisterPage(),
          '/bash': (context) => AtBashPage(),
          '/caesar': (context) => CaesarPage(),
          '/vigenere': (context) => VigenerePage(),
        });
  }
}
