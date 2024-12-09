import 'package:flutter/material.dart';
import 'package:test_app/api/sessions/session_manager.dart';

import '../api/cipher.dart';
import '../api/returnable.dart';

class AtBashPage extends StatefulWidget {
  const AtBashPage({
    super.key,
  });

  @override
  State<AtBashPage> createState() => _AtBashPageState();
}

class _AtBashPageState extends State<AtBashPage> {
  String _changeable = "";
  TextEditingController input = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (!SessionManager.instance.validateSession("user")) {
      Navigator.popAndPushNamed(context, '/login');
    }
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.popAndPushNamed(context, "/home"),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(240, 96, 96, 1),
                      Color.fromRGBO(245, 125, 90, 1),
                      Color.fromRGBO(245, 153, 90, 1),
                      Color.fromRGBO(243, 180, 98, 1),
                    ],
                    transform: GradientRotation(240),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                margin: EdgeInsets.all(16),
                height: 256,
                child: Ink(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
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
                      Text(
                        _changeable,
                        key: Key("bash_key"),
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Courier New",
                          fontSize: 28,
                        ),
                      ),
                    ],
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
                  child: Container(
                    padding: EdgeInsets.only(top: 32, left: 32, right: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 18),
                          child: TextField(
                            controller: input,
                            decoration: InputDecoration(
                              hintText: "Word",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          child: FilledButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Color.fromRGBO(240, 96, 96, 1),
                              ),
                            ),
                            onPressed: () {
                              Map<String, dynamic>? response =
                                  Cipher.encrypt.bash(input.text);
                              if (response?["status"] == STATUS.OK) {
                                setState(() {
                                  _changeable = response?["optional"];
                                  SessionManager.instance
                                      .getSession("user")
                                      ?.user
                                      ?.addHistory(response?["optional"]);
                                });
                              }
                            },
                            child: Text("Encode"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
