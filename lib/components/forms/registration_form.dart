import 'package:flutter/material.dart';
import 'package:test_app/api/registration.dart';

import '../../api/login.dart';

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
    if (_password.text.isEmpty) {
      return "Field can't be empty";
    }
    if (_password.text.length < 8) {
      return "Password must be at least 8 characters long";
    }
    return null;
  }

  String? _textConfirm() {
    if (_confirm.text.isEmpty) {
      return "Field can't be empty";
    }
    if (_password.text == _confirm.text) {
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
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      floatingLabelStyle: TextStyle(color: Colors.blue),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      errorText: _submitted ? _textUsername() : null,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
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
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      floatingLabelStyle: TextStyle(color: Colors.blue),
                      hintStyle: TextStyle(color: Colors.blue),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      errorText: _submitted ? _textUsername() : null,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
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
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      floatingLabelStyle: TextStyle(color: Colors.blue),
                      hintStyle: TextStyle(color: Colors.blue),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      errorText: _submitted ? _textUsername() : null,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 18),
              width: double.maxFinite,
              child: FilledButton(
                onPressed: () {
                  bool con = _formKey.currentState!.validate();
                  if (con) {
                    Registration.register(_username.text, _password.text);
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
