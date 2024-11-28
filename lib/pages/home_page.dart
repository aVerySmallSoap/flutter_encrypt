import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:test_app/pages/conversion_page.dart';
import 'package:test_app/pages/history_page.dart';
import 'package:test_app/pages/settings_page.dart';

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
    ConversionPage(),
    const HistoryPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 1,
              spreadRadius: 1.5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
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
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              )
            ],
          ),
        ),
      ),
    );
  }
}
