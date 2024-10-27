import 'package:flutter/material.dart';

class CustomPopup extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final VoidCallback? onButtonPressed;

  const CustomPopup({
    Key? key,
    required this.title,
    required this.content,
    required this.buttonText,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onButtonPressed ?? () {
            Navigator.of(context).pop(); // Fermer le popup par défaut
          },
          child: Text(buttonText),
        ),
      ],
    );
  }
}


void showSuccessPopup(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          width: 266,
          height: 187,
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.close, color: Colors.grey),
                ),
              ),
              SizedBox(height: 10),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.green,
                child: Icon(Icons.check, color: Colors.white, size: 30),
              ),
              // SizedBox(height: 20),
              // Text(
              //   '',
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.black87,
              //   ),
              // ),
              SizedBox(height: 8),
              Text(
                'Viens d’être ajouté à tes contacts avec succès',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}