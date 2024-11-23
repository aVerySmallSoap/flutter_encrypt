import 'package:flutter/material.dart';
import 'package:test_app/textstyles/normal_text.dart';

class ConversionPage extends StatelessWidget {
  const ConversionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: MyNormalText(text: 'Welcome to the Conversion Page!'),
      ),
    );
  }
}
