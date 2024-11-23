import 'package:flutter/material.dart';
import 'package:test_app/textstyles/normal_text.dart';

class ConversionPage extends StatelessWidget {
  const ConversionPage({super.key});

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(
                      value: 'encode',
                      groupValue: 'action',
                      onChanged: (value) {},
                    ),
                    const Text('Encode'),
                    Radio<String>(
                      value: 'decode',
                      groupValue: 'action',
                      onChanged: (value) {},
                    ),
                    const Text('Decode'),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(
                      value: 'atbash',
                      groupValue: 'cipher',
                      onChanged: (value) {},
                    ),
                    const Text('Atbash'),
                    Radio<String>(
                      value: 'caesar',
                      groupValue: 'cipher',
                      onChanged: (value) {},
                    ),
                    const Text('Caesar'),
                    Radio<String>(
                      value: 'vignere',
                      groupValue: 'cipher',
                      onChanged: (value) {},
                    ),
                    const Text('Vignere'),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter text',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Submit'),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Result text',
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
