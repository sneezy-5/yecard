import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../widgets/app_bar.dart';

class PortfolioFormScreen extends StatefulWidget {
  @override
  _PortfolioFormScreenState createState() => _PortfolioFormScreenState();
}

class _PortfolioFormScreenState extends State<PortfolioFormScreen> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        title: '',
        showBackButton: true,
        customBackIcon: Icons.arrow_back_ios,
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField('Titre de projet'),
            SizedBox(height: 16),
            _buildTextField('Description du projet', maxLines: 3),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildImageBox(),
                  SizedBox(height: 16),
                  _buildImageBox(),
                  SizedBox(height: 16),
                  _buildImageBox(),
                  SizedBox(height: 16),
                  _buildTextField('Mot de fin'),
                  SizedBox(height: 16),
                  _buildSaveButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildImageBox() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: _selectedImage == null
            ? Center(
          child: Icon(
            Icons.image,
            color: Colors.grey.shade400,
            size: 40,
          ),
        )
            : Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(vertical: 16.0),
        ),
        onPressed: () {
          // Action on save button press
        },
        child: Text(
          'Enregistrer',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
