import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yecard/screens/app/screens/card_screen.dart';
import 'package:yecard/screens/app/screens/code_qr_screen.dart';
import 'package:yecard/screens/app/screens/contacts_screen.dart';

import '../../bloc/profile_bloc.dart';
import '../../bloc/profile_event.dart';
import '../../repositories/portfolio_repository.dart';
import '../../repositories/profile_repository.dart';
import '../../services/portfolio_service.dart';
import '../../services/profile_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
  BlocProvider(
  create: (context) => ProfileBloc(ProfileRepository(ProfileService()), PortfolioRepository(PortfolioService())),
  child: CardScreen(),
  ),
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
            icon:Icon(Icons.home, size: 30),

            label: 'Card',
          ),
          BottomNavigationBarItem(
            icon:  Icon(Icons.person, size: 30),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(

            icon: Icon(Icons.qr_code, size: 30,),
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


