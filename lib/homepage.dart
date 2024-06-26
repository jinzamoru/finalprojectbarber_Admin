import 'package:finalprojectbarber/screen/profile_screen.dart';

import 'screen/admin_screen.dart';
import 'screen/barber_screen.dart';
import 'screen/hair_screen.dart';
import 'screen/home.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      BarberDashboard(),
      const BarberPage(),
      AdminPage(),
      HairPage(),
      UserProfileScreen(),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 255, 255,
            255), // Set the background color of the BottomNavigationBar
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(
            255, 253, 168, 94), // Set the color when item is selected
        unselectedItemColor: const Color.fromARGB(
            255, 197, 197, 197), // Set the color for unselected items
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_ind), label: 'ช่างตัดผม'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: 'ผู้ดูแลระบบ'),
          BottomNavigationBarItem(icon: Icon(Icons.face), label: 'ทรงผม'),
          BottomNavigationBarItem(icon: Icon(Icons.person_pin), label: 'โปรไฟล์'),
        ],
      ),
    );
  }
}
