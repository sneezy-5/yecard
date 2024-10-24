import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String title;
  final String description;
  final List<dynamic> photos;
  final String? mot_de_fin;

  DetailScreen({
    required this.title,
    required this.description,
    required this.photos,
    required this.mot_de_fin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Titre
            Center(
          child: Text(
          title,
    style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    ),
    ),
          ),
            SizedBox(height: 16),

            // Description
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 16),

            // Description
            Text(
              mot_de_fin!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 16),

            // Photos
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: photos.take(3).map((photoUrl) => Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(photoUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}