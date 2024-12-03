import 'package:flutter/material.dart';
import 'package:test_app/pages/atbash_page.dart';
import 'package:test_app/pages/caesar_page.dart';
import 'package:test_app/pages/home_page.dart';
import 'package:test_app/pages/login_page.dart';
import 'package:test_app/pages/register_page.dart';

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
        title: 'TestApp',
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
        });
  }
}
