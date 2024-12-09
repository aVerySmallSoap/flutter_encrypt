import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/components/historylist.dart';

import '../api/login.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
                onPressed: () => {
                      Login.logout(),
                      Navigator.pop(context),
                      Navigator.popAndPushNamed(context, '/login')
                    },
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
                padding: EdgeInsets.only(top: 24),
                constraints: BoxConstraints(minHeight: 64),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(243, 181, 98, 1),
                      Color.fromRGBO(243, 181, 98, 1),
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
                        "History",
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 24,
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
                        child: Container(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: HistoryList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: PopScope<Object?>(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          if (didPop) return;
          final bool shouldPop = await _showLogoutDialog() ?? false;
          if (context.mounted && shouldPop) Navigator.pop(context);
        },
        child: HistoryList(),
      ),
    );
  }
}
