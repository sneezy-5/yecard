
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
            // Title
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

            // "Mot de fin" if available
            if (mot_de_fin != null)
              Text(
                mot_de_fin!,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
              ),
            SizedBox(height: 16),

            // Photos with zoom effect on click
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: photos.take(3).map((photoUrl) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) => Dialog(
                        insetPadding: EdgeInsets.zero, // Full-screen dialog
                        backgroundColor: Colors.transparent, // Transparent background
                        child: GestureDetector(
                          onVerticalDragEnd: (details) {
                            if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
                              Navigator.of(context).pop(); // Close on swipe down
                            }
                          },
                          onTap: () {
                          Navigator.of(context).pop();
                          },
                          child: Stack(
                            children: [
                              // Dark overlay
                              Container(
                                color: Colors.black.withOpacity(0.8),
                              ),
                              // Interactive zoomable image in the center
                              Center(
                                child: InteractiveViewer(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      photoUrl,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(photoUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}



