import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../api/cipher.dart';
import '../api/returnable.dart';
import '../api/sessions/session_manager.dart';

class CaesarPage extends StatefulWidget {
  const CaesarPage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _CaesarPageState();
}

class _CaesarPageState extends State<CaesarPage> {
  String _changeable = "";
  TextEditingController input = TextEditingController();
  TextEditingController shifts = TextEditingController();
  Shift direction = Shift.right;

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 128),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(243, 180, 98, 1),
                  Color.fromRGBO(240, 200, 127, 1),
                  Color.fromRGBO(239, 219, 158, 1),
                  Color.fromRGBO(242, 235, 192, 1),
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
                      "Caesar",
                      style: TextStyle(
                        fontFamily: "Antipasto",
                        fontSize: 48,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _changeable,
                      key: Key("caesar_key"),
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Courier New",
                        fontSize: 28,
                      ),
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
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 18),
                      child: TextField(
                        controller: input,
                        decoration: InputDecoration(
                          labelText: "Word",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: TextField(
                        controller: shifts,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          labelText: "Shifts",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<Shift>(
                            title: const Text("Left"),
                            value: Shift.left,
                            groupValue: direction,
                            onChanged: (Shift? val) {
                              setState(() {
                                direction = val!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<Shift>(
                            title: const Text("Right"),
                            value: Shift.right,
                            groupValue: direction,
                            onChanged: (Shift? val) {
                              setState(() {
                                direction = val!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.maxFinite,
                      child: FilledButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Color.fromRGBO(243, 180, 98, 1),
                          ),
                        ),
                        onPressed: () {
                          Map<String, dynamic>? response =
                              Cipher.encrypt.caesar(
                            direction,
                            int.parse(shifts.text),
                            input.text,
                          );
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
    );
  }
}
