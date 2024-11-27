import 'package:flutter/material.dart';
import 'package:test_app/api/login.dart';
import 'package:test_app/components/mybutton.dart';
import 'package:test_app/components/mytextfield.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PopScope<Object?>(
              canPop: false,
              onPopInvokedWithResult: (bool didPop, Object? result) async {
                if (didPop) return;
                final bool shouldPop = await _showLogoutDialog() ?? false;
                if (context.mounted && shouldPop) Navigator.pop(context);
              },
              child: TextButton(
                  onPressed: () async {
                    final shouldPop = await _showLogoutDialog() ?? false;
                    if (context.mounted && shouldPop) Navigator.pop(context);
                  },
                  child: Visibility(
                    visible: false,
                    child: const Text(""),
                  )),
            ),
            MyTextField(
                controller: inputController,
                hintText: "Input",
                obscureText: false),
            MyButton(
              onTap: () => convert(),
              text: const Text("convert"),
            ),
            TextField(
              controller: outputController,
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }
}
