import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:test_app/UI/pages/conversion_page.dart';
import 'package:test_app/UI/pages/history_page.dart';
import '../../api/sessions/session_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const ConversionPage(),
    const HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    if (!SessionManager.instance.validateSession("user")) {
      Navigator.of(context).pushNamed('/login');
    }
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 1,
              spreadRadius: 1.5,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 10),
          child: GNav(
            gap: 4,
            color: Colors.blue,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.blue,
            padding: EdgeInsets.all(16),
            onTabChange: _navigateBottomBar,
            tabs: [
              GButton(
                icon: Icons.hourglass_bottom_rounded,
                text: 'Conversion',
              ),
              GButton(
                icon: Icons.history,
                text: 'History',
              )
            ],
          ),
        ),
      ),
    );
  }
}
