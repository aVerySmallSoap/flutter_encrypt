import 'package:flutter/material.dart';
import 'package:test_app/api/registration.dart';

import '../../api/returnable.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirm = TextEditingController();
  bool _submitted = false;

  void registerUser(BuildContext context) async {
    Map<String, dynamic>? response =
        await Registration.register(_username.text, _password.text);
    if (!context.mounted) return;
    if (response?["status"] == STATUS.OK) {
      Navigator.pushNamed(context, '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response?["message"])),
      );
    }
  }

  // Text errors
  String? _textUsername() {
    if (_username.text.isEmpty) {
      return "Field can't be empty";
    }
    if (_username.text.length < 8) {
      return "Username must be at least 8 characters long";
    }
    return null;
  }

  String? _textPassword() {
    bool hasDigit = false;
    bool hasSpecial = false;
    List<int> chars = _password.text.codeUnits;
    for (var i = 0; i < chars.length; ++i) {
      // TODO: move to server
      if (chars[i] == 48 || chars[i] <= 57) {
        hasDigit = true;
      }
      // special characters: !-/ | :-@ | [-` | {-~ ; utf-16
      if ((chars[i] >= 33 && chars[i] <= 47) ||
          (chars[i] >= 58 && chars[i] <= 64) ||
          (chars[i] >= 91 && chars[i] <= 96) ||
          (chars[i] >= 123 && chars[i] <= 126)) {
        hasSpecial = true;
      }
    }

    if (_password.text.isEmpty) {
      return "Field can't be empty";
    }
    if (_password.text.length < 8) {
      return "Password must be at least 8 characters long";
    }
    if (!(hasDigit && hasSpecial)) {
      hasDigit = false;
      hasSpecial = false;
      return "Password must contain at least 1 digit and 1 special character";
    }
    return null;
  }

  String? _textConfirm() {
    if (_confirm.text.isEmpty) {
      return "Field can't be empty";
    }
    if (_confirm.text != _password.text) {
      return "Password must match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.only(left: 32, right: 32),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      blurStyle: BlurStyle.outer,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: ValueListenableBuilder(
                  valueListenable: _username,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: _username,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => _textUsername(),
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        labelText: "Username",
                        fillColor: Colors.white38,
                        filled: true,
                        floatingLabelStyle: TextStyle(color: Colors.blue),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white38,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        errorText: _submitted ? _textUsername() : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      blurStyle: BlurStyle.outer,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: ValueListenableBuilder(
                  valueListenable: _password,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: _password,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      validator: (value) => _textPassword(),
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        labelText: "Password",
                        fillColor: Colors.white38,
                        filled: true,
                        floatingLabelStyle: TextStyle(color: Colors.blue),
                        hintStyle: TextStyle(color: Colors.blue),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white38,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        errorText: _submitted ? _textUsername() : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      blurStyle: BlurStyle.outer,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: ValueListenableBuilder(
                  valueListenable: _confirm,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: _confirm,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      validator: (value) => _textConfirm(),
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        fillColor: Colors.white38,
                        filled: true,
                        floatingLabelStyle: TextStyle(color: Colors.blue),
                        hintStyle: TextStyle(color: Colors.blue),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white38,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        errorText: _submitted ? _textUsername() : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 18),
              width: double.maxFinite,
              child: FilledButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    registerUser(context);
                  } else {
                    setState(() {
                      _submitted = true;
                    });
                  }
                },
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
                  backgroundColor: WidgetStatePropertyAll(Colors.blue),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child: Text("Register"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
