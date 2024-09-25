import 'package:flutter/material.dart';

class LinkCardScreen extends StatefulWidget {
  @override
  _LinkCardScreenState createState() => _LinkCardScreenState();
}

class _LinkCardScreenState extends State<LinkCardScreen> {
  String cardNumber = '';

  void _onNumberTap(String number) {
    setState(() {
      if (cardNumber.length < 16) {
        cardNumber += number;
      }
    });
  }

  void _onDeleteTap() {
    setState(() {
      if (cardNumber.isNotEmpty) {
        cardNumber = cardNumber.substring(0, cardNumber.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Lier ma carte',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Entrer le numéro inscrit sur la carte',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade100,
              ),
              child: TextField(
                readOnly: true,  // Empêche l'entrée manuelle via le clavier natif
                style: const TextStyle(fontSize: 20, letterSpacing: 2),
                decoration: const InputDecoration(
                  hintText: 'Insérer le numéro de la carte',
                  border: InputBorder.none,
                ),
                controller: TextEditingController(text: cardNumber),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Valider l'entrée et continuer
                if (cardNumber.length == 16) {
                  // Navigate to the next screen
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Continuer',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Spacer(),
            _buildNumberPad(),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberPad() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton('1'),
            _buildNumberButton('2'),
            _buildNumberButton('3'),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton('4'),
            _buildNumberButton('5'),
            _buildNumberButton('6'),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton('7'),
            _buildNumberButton('8'),
            _buildNumberButton('9'),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton('0'),
            _buildDeleteButton(),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildNumberButton(String number) {
    return GestureDetector(
      onTap: () => _onNumberTap(number),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return GestureDetector(
      onTap: _onDeleteTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: const Center(
          child: Icon(Icons.backspace, size: 24),
        ),
      ),
    );
  }
}
