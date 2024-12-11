import 'package:flutter/material.dart';
import 'package:test_app/UI/components/forms/login_form.dart';

import '../../api/login.dart';
import '../../api/returnable.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn(BuildContext context) async {
    final username = usernameController.text;
    final password = passwordController.text;

    Map<String, dynamic>? response = await Login.login(username, password);
    if (!context.mounted) return;
    if (response?["status"] == STATUS.OK) {
      Navigator.of(context).pushNamed('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response!["message"])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // logo
                const Icon(
                  Icons.vpn_lock,
                  size: 100,
                  color: Color.fromARGB(255, 6, 139, 248),
                ),
                const SizedBox(height: 50),
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                LoginForm(),
                const SizedBox(height: 25),
                // register ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("No account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/register');
                      },
                      child: const Text(
                        "Register here!",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
