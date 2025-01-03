import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/portfolio.dart';
import '../../../repositories/portfolio_repository.dart';
import '../../../services/portfolio_service.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/popup_widgets.dart';

class PortfolioFormEditScreen extends StatelessWidget {
  final Map<String, dynamic>? args;

  PortfolioFormEditScreen({required this.args});

  @override
  Widget build(BuildContext context) {
    return PortfolioView(args: args);
  }
}

class PortfolioView extends StatefulWidget {
  final Map<String, dynamic>? args;

  PortfolioView({required this.args});

  @override
  _PortfolioFormScreenState createState() => _PortfolioFormScreenState();
}

class _PortfolioFormScreenState extends State<PortfolioView> {
  File? _selectedFile1;
  File? _selectedFile2;
  File? _selectedFile3;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _motDeFinController;
  late int id;
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _isDataLoading = true;
  final PortfolioRepository portfolioRepository = PortfolioRepository(PortfolioService());

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _motDeFinController = TextEditingController();
    id = widget.args?['id'] ?? 0;

    _fetchPortfolioData();  // Fetch data on initialization
  }

  Future<void> _fetchPortfolioData() async {
    setState(() {
      _isDataLoading = true;
    });

    try {
      final data = await portfolioRepository.portfoliobyId(id);
      if (data != null) {
        _titleController.text = data['data']['title'] ?? '';
        _descriptionController.text = data['data']['description'] ?? '';
        _motDeFinController.text = data['data']['mot_de_fin'] ?? '';

        // Load initial files if available (mock paths or URLs)
        if (data['file_1'] != null) _selectedFile1 = File(data['file_1']);
        if (data['file_2'] != null) _selectedFile2 = File(data['file_2']);
        if (data['file_3'] != null) _selectedFile3 = File(data['file_3']);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors du chargement des données')),
      );
    } finally {
      setState(() {
        _isDataLoading = false;
      });
    }
  }

  Future<void> _pickImage(int imageNumber) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (imageNumber == 1) {
          _selectedFile1 = File(pickedFile.path);
        } else if (imageNumber == 2) {
          _selectedFile2 = File(pickedFile.path);
        } else if (imageNumber == 3) {
          _selectedFile3 = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> _updatePortfolio() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final updatedPortfolioData = PortfolioData(
        id: id,
        title: _titleController.text,
        description: _descriptionController.text,
        file_1: _selectedFile1?.path ?? '',
        file_2: _selectedFile2?.path ?? '',
        file_3: _selectedFile3?.path ?? '',
        mot_de_fin: _motDeFinController.text,
      );

      try {
        await portfolioRepository.updatePortfolio(
          updatedPortfolioData,
          id,
          _selectedFile1,
          _selectedFile2,
          _selectedFile3,
        );

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomPopup(
              title: 'Succès',
              content: "Mise à jour réussie",
              buttonText: 'OK',
              onButtonPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            );
          },
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $error')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        title: '',
        showBackButton: true,
        customBackIcon: Icons.arrow_back_ios,
      ),
      body: _isDataLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField('Titre de projet', _titleController),
                  SizedBox(height: 16),
                  _buildTextField('Description du projet', _descriptionController, maxLines: 3),
                  SizedBox(height: 16),
                  _buildTextField('Mot de fin', _motDeFinController),
                  SizedBox(height: 16),
                  _buildImageBox(1, _selectedFile1),
                  SizedBox(height: 16),
                  _buildImageBox(2, _selectedFile2),
                  SizedBox(height: 16),
                  _buildImageBox(3, _selectedFile3),
                  SizedBox(height: 16),
                  _buildUpdateButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer $label';
        }
        return null;
      },
    );
  }

  Widget _buildImageBox(int imageNumber, File? imageFile) {
    return GestureDetector(
      onTap: () => _pickImage(imageNumber),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: imageFile == null
            ? Center(
          child: Icon(
            Icons.image,
            color: Colors.grey.shade400,
            size: 40,
          ),
        )
            : Image.file(
          imageFile,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildUpdateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        onPressed: _isLoading ? null : _updatePortfolio,
        child: _isLoading
            ? CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        )
            : Text(
          'Mettre à jour',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
