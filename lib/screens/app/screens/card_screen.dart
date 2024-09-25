import 'package:flutter/material.dart';

import '../../../routes.dart';

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    child: Image.asset(
                      'assets/images/profil.png',
                      width: 95,
                      height: 95,
                    ),
                  ),
                ),
                Text(
                  "Koffi Yohann",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text("Ceo de Dulces"),
                Text("communication"),
              ],
            ),
            SizedBox(height: 50),
          ListTile(
            leading: Container(
              width: 20,
              height: 20,
              child: Image.asset('assets/images/notif.png'),
            ),
            title: Text('Notification'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

            SizedBox(height: 10),

            ListTile(
              leading: Container(
                width: 20,
                height: 20,
                child: Image.asset('assets/images/share.png'),
              ),
              title: Text("Partager l'application"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            SizedBox(height: 300),
            ListTile(
              leading: Container(
                width: 20,
                height: 20,
                child: Image.asset('assets/images/exit.png'),
              ),
              title: Text('Quitter l’application'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/logos/logo.png',
                    width: 82,
                    height: 37,
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                    child: Image.asset(
                      'assets/images/setting.png',
                      width: 30,
                      height: 30,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              // elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:   GestureDetector(
                  onTap: () {
                    AppRoutes.pushReplacement(context, AppRoutes.appProfile);

                  },
                  child: Image.asset(
                    'assets/images/profile.png',
                    width: 248,
                    height: 351,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 293,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  AppRoutes.pushReplacement(context, AppRoutes.appGetOrder);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  'Commander la carte à 5.000 f cfa',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
