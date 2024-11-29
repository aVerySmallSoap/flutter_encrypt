import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AtBashPage extends StatefulWidget {
  const AtBashPage({
    super.key,
  });

  @override
  State<AtBashPage> createState() => _AtBashPageState();
}

class _AtBashPageState extends State<AtBashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 128),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepOrangeAccent,
                  Colors.orange,
                  Colors.orangeAccent,
                ],
                transform: GradientRotation(180),
              ),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            margin: EdgeInsets.all(16),
            height: 256,
            child: Ink(
              color: Colors.transparent,
              child: Expanded(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      width: double.maxFinite,
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.only(top: 24, right: 8),
                    ),
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(4),
                      child: Text(
                        "@Bash",
                        style: TextStyle(
                          fontFamily: "Antipasto",
                          fontSize: 48,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.4),
                      spreadRadius: 2,
                      blurRadius: 8)
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Text("test"),
            ),
          )
        ],
      ),
    );
  }
}
