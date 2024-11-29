import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: PopScope<Object?>(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          if (didPop) return;
          final bool shouldPop = await _showLogoutDialog() ?? false;
          if (context.mounted && shouldPop) Navigator.pop(context);
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                constraints: BoxConstraints(minHeight: 64),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueAccent,
                      Colors.blue,
                      Colors.lightBlue,
                      Colors.lightBlueAccent
                    ],
                    transform: GradientRotation(180),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Conversion",
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CipherButton(
                              action: () =>
                                  Navigator.of(context).pushNamed('/bash'),
                              text: "@Bash",
                              desc:
                                  "Cipher your text using a reversed alphabet table",
                              image: AssetImage("assets/images/w_email.png"),
                            ),
                            CipherButton(
                              action: () {},
                              text: "Caesar",
                              desc:
                                  "Cipher your text by shifting the alphabet to the left or right",
                              image: AssetImage("assets/images/w_caesar.png"),
                            ),
                            CipherButton(
                              action: () {},
                              text: "Vigenere",
                              desc: "Cipher your text by using a key",
                              image: AssetImage("assets/images/w_key.png"),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
