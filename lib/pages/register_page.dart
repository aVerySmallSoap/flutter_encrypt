import 'package:flutter/material.dart';
import 'package:test_app/components/mybutton.dart';
import 'package:test_app/components/mytextfield.dart';

import '../api/registration.dart';
import '../api/returnable.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void registerUser(BuildContext context) async {
    final username = usernameController.text;
    final password = passwordController.text;

    Map<String, dynamic>? response =
        await Registration.register(username, password);
    if (!context.mounted) return;
    if (response?["status"] == STATUS.OK) {
      Navigator.pushNamed(context, '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response?["message"])),
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
                  Icons.create,
                  size: 100,
                  color: Color.fromARGB(255, 6, 139, 248),
                ),

                const SizedBox(height: 50),

                // some text
                Text('Create an account!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    )),

                const SizedBox(height: 25),
                // username field
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                // password field
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                // confirm password field
                const SizedBox(height: 10),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                // register button
                MyButton(
                  onTap: () {
                    registerUser(context);
                  },
                  text: const Text(
                    'Register',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                // go to login page text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/login');
                      },
                      child: const Text(
                        "Login here!",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
