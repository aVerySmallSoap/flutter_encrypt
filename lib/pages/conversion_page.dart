import 'package:flutter/material.dart';
import 'package:test_app/api/login.dart';
import 'package:test_app/components/cipherbuttons.dart';

import '../api/returnable.dart';
import '../api/session.dart';
import '../cipher.dart';

class ConversionPage extends StatefulWidget {
  const ConversionPage({super.key});

  @override
  State<ConversionPage> createState() => _ConversionPageState();
}

class _ConversionPageState extends State<ConversionPage> {
  final TextEditingController inputController = TextEditingController();
  final TextEditingController outputController = TextEditingController();

  void convert() {
    Map<String, dynamic>? response = Cipher.encrypt.bash(inputController.text);
    if (outputController.text.isNotEmpty && response?["status"] == STATUS.OK) {
      Session.user?.addHistory(outputController.text);
      outputController.clear();
      outputController.text = response!["optional"].toString();
      return;
    }
    if (response?["status"] == STATUS.OK) {
      outputController.text = response!["optional"].toString();
      Session.user?.addHistory(outputController.text);
    }
    return;
  }

  Future<bool?> _showLogoutDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Do you want to logout?"),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Stay")),
            TextButton(
                onPressed: () => {Login.logout(), Navigator.pop(context, true)},
                child: const Text("Logout"))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      body: Center(
          child: PopScope<Object?>(
              canPop: false,
              onPopInvokedWithResult: (bool didPop, Object? result) async {
                if (didPop) return;
                final bool shouldPop = await _showLogoutDialog() ?? false;
                if (context.mounted && shouldPop) Navigator.pop(context);
              },
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(minHeight: 64),
                    padding: EdgeInsets.only(top: 24, left: 12, bottom: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.blueAccent,
                        Colors.blue,
                        Colors.lightBlue,
                        Colors.lightBlueAccent
                      ], transform: GradientRotation(180)),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.4),
                          blurRadius: 2,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Conversion",
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Courier New"),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CipherButton(
                        action: () {},
                        text: "@Bash",
                        desc:
                            "Cipher your text using a reversed alphabet table",
                        image: AssetImage("images/w_email.png"),
                      ),
                      CipherButton(
                        action: () {},
                        text: "Caesar",
                        desc:
                            "Cipher your text by shifting the alphabet to the left or right",
                        image: AssetImage("images/w_caesar.png"),
                      ),
                      CipherButton(
                        action: () {},
                        text: "Vigenere",
                        desc: "Cipher your text by using a key",
                        image: AssetImage("images/w_key.png"),
                      ),
                    ],
                  ),
                ],
              ))),
    );
  }
}
