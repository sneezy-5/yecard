import 'package:flutter/material.dart';
import 'package:yecard/screens/app/screens/card_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    CardScreen(),
    // Center(child: Text('Cartes', style: TextStyle(fontSize: 24))),
    Center(child: Text('Contacts', style: TextStyle(fontSize: 24))),
    Center(child: Text('Code Qr', style: TextStyle(fontSize: 24))),
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
            icon: Image.asset(
              'assets/images/button_card.png',
              width: 50,
              height: 60,
            ),
            label: '',
          ),
           BottomNavigationBarItem(
            icon:Image.asset(
              'assets/images/button_person.png',
              width: 50,
              height: 60,
            ),
            label: '',
          ),
           BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/buttom_qr.png',
              width: 50,
              height: 60,
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex, // Indicate the selected tab
        selectedItemColor: Colors.green, // Color for the selected item
        onTap: _onItemTapped, // Function to handle taps
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}



