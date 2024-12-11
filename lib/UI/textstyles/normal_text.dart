import 'package:flutter/material.dart';

class MyNormalText extends StatelessWidget {
  final String text;
  const MyNormalText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey[700],
        fontSize: 16,
      ),
    );
  }
}
