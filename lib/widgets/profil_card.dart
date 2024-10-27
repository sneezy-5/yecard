import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String profileImageUrl;
  final String name;
  final String position;

  ProfileCard({
    required this.profileImageUrl,
    required this.name,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Stack(
          children: [
            // Profile Image
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/app/profile');
              },
              child: Image.network(
                profileImageUrl,
                width: 270,
                height: 330,
                fit: BoxFit.cover,
              ),
            ),
            // Overlay with information at the bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                color: Colors.black.withOpacity(0.6),
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      position,
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
