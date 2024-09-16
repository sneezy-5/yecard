import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logos/logo.png', width: 150),
            SizedBox(height: 30),
            Image.asset('assets/logos/splash_screen.png', width: 300),
            SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(

                  onPressed: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text('Créer une carte',style: TextStyle(
                  fontSize: 12,
                  color: Colors.white
                  ),),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text('Se connecter',style: TextStyle(
                      fontSize: 12,
                      color: Colors.white
                  ),),
                ),
              ],
            ),
            SizedBox(height: 50),
            Text('Aide & services'),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/nfc.png', width: 100),

                SizedBox(width: 10),
                Image.asset('assets/images/qr.png', width: 100),

              ],
            )
          ],
        ),
      ),
    );
  }
}
