import 'package:flutter/material.dart';
import 'package:yecard/screens/app/screens/card_screen.dart';
import 'package:yecard/screens/app/screens/code_qr_screen.dart';
import 'package:yecard/screens/app/screens/contacts_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    CardScreen(),
    ContactsScreen(),
    QrCodeScannerScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            // icon: Image.asset(
            //   'assets/images/button_card.png',
            //   width: 50,
            //   height: 20,
            // ),
            icon: Icon(Icons.credit_card_outlined),
            label: 'Card',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            // icon: Image.asset(
            //   'assets/images/button_person.png',
            //   width: 50,
            //   height: 20,
            // ),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            // icon: Image.asset(
            //   'assets/images/buttom_qr.png',
            //   width: 50,
            //   height: 20,
            // ),
            icon: Icon(Icons.qr_code),
            label: 'QR Code',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}

