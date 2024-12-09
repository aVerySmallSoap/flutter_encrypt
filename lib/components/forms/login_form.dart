import 'package:flutter/material.dart';

import '../../api/login.dart';
import '../../api/returnable.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _submitted = false;

  void signIn(BuildContext context) async {
    Map<String, dynamic>? response =
        await Login.login(_username.text, _password.text);
    if (!context.mounted) return;
    if (response?["status"] == STATUS.OK) {
      Navigator.of(context).pushNamed('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response!["message"])),
      );
    }
  }

  //String errors
  String? _textUsername() {
    if (_username.text.isEmpty) {
      return "Field can't be empty";
    }
    return null;
  }

  String? _textPassword() {
    if (_password.text.isEmpty) {
      return "Field can't be empty";
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
              margin: EdgeInsets.only(top: 18),
              width: double.maxFinite,
              child: FilledButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    signIn(context);
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
                child: Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
