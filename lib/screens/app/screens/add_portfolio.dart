// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import '../../../widgets/app_bar.dart';
// //
// // class PortfolioFormScreen extends StatefulWidget {
// //   @override
// //   _PortfolioFormScreenState createState() => _PortfolioFormScreenState();
// // }
// //
// // class _PortfolioFormScreenState extends State<PortfolioFormScreen> {
// //   File? _selectedImage;
// //
// //   Future<void> _pickImage() async {
// //     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
// //
// //     if (pickedFile != null) {
// //       setState(() {
// //         _selectedImage = File(pickedFile.path);
// //       });
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: ReusableAppBar(
// //         title: '',
// //         showBackButton: true,
// //         customBackIcon: Icons.arrow_back_ios,
// //         actions: [],
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             _buildTextField('Titre de projet'),
// //             SizedBox(height: 16),
// //             _buildTextField('Description du projet', maxLines: 3),
// //             SizedBox(height: 16),
// //             Expanded(
// //               child: ListView(
// //                 padding: EdgeInsets.zero,
// //                 children: [
// //                   _buildImageBox(),
// //                   SizedBox(height: 16),
// //                   _buildImageBox(),
// //                   SizedBox(height: 16),
// //                   _buildImageBox(),
// //                   SizedBox(height: 16),
// //                   _buildTextField('Mot de fin'),
// //                   SizedBox(height: 16),
// //                   _buildSaveButton(),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildTextField(String label, {int maxLines = 1}) {
// //     return TextField(
// //       maxLines: maxLines,
// //       decoration: InputDecoration(
// //         labelText: label,
// //         border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(12.0),
// //         ),
// //         filled: true,
// //         fillColor: Colors.white,
// //       ),
// //     );
// //   }
// //
// //   Widget _buildImageBox() {
// //     return GestureDetector(
// //       onTap: _pickImage,
// //       child: Container(
// //         height: 100,
// //         width: double.infinity,
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(12.0),
// //           border: Border.all(color: Colors.grey.shade300),
// //         ),
// //         child: _selectedImage == null
// //             ? Center(
// //           child: Icon(
// //             Icons.image,
// //             color: Colors.grey.shade400,
// //             size: 40,
// //           ),
// //         )
// //             : Image.file(
// //           _selectedImage!,
// //           fit: BoxFit.cover,
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildSaveButton() {
// //     return SizedBox(
// //       width: double.infinity,
// //       child: ElevatedButton(
// //         style: ElevatedButton.styleFrom(
// //           backgroundColor: Colors.green,
// //           shape: StadiumBorder(),
// //           padding: EdgeInsets.symmetric(vertical: 16.0),
// //         ),
// //         onPressed: () {
// //           // Action on save button press
// //         },
// //         child: Text(
// //           'Enregistrer',
// //           style: TextStyle(
// //             fontSize: 18,
// //             color: Colors.white,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../bloc/portfolio_bloc.dart';
// import '../../../bloc/portfolio_event.dart';
// import '../../../bloc/portfolio_state.dart';
// import '../../../models/portfolio.dart';
// import '../../../repositories/portfolio_repository.dart';
// import '../../../services/portfolio_service.dart';
// import '../../../widgets/app_bar.dart';
// import '../../../widgets/popup_widgets.dart';
//
// class PortfolioFormScreen extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => PortfolioBloc(PortfolioRepository(PortfolioService())),
//       child: PortfolioWiev(),
//     );
//   }
// }
//
// class PortfolioWiev extends StatefulWidget {
//   @override
//   _PortfolioFormScreenState createState() => _PortfolioFormScreenState();
// }
//
// class _PortfolioFormScreenState extends State<PortfolioWiev> {
//   File? _selectedFile1;
//    File? _selectedFile2;
//    File? _selectedFile3;
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _motDeFinController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   Future<void> _pickImage(int imageNumber) async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         if (imageNumber == 1) {
//           _selectedFile1 = File(pickedFile.path);
//         } else if (imageNumber == 2) {
//           _selectedFile2 = File(pickedFile.path);
//         } else if (imageNumber == 3) {
//           _selectedFile3 = File(pickedFile.path);
//         }
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: ReusableAppBar(
//         title: '',
//         showBackButton: true,
//         customBackIcon: Icons.arrow_back_ios,
//         actions: [],
//       ),
//       body: BlocListener<PortfolioBloc, PortfolioState>(
//         listener: (context, state) {
//           if (state.isSuccess) {
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return CustomPopup(
//                   title: 'Succès',
//                   content: "Enregistre avec success",
//                   buttonText: 'ok',
//                   onButtonPressed: () {
//                     Navigator.of(context).pop();
//                     // AppRoutes.pushReplacement(context, AppRoutes.createPassword);
//                   },
//                 );
//               },
//             );
//           } else if (state.errorMessages.isNotEmpty) {
//             final errorMessage = state.errorMessages.entries
//                 .map((entry) => '${entry.key}: ${entry.value.join(', ')}')
//                 .join('\n');
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(errorMessage)),
//             );
//           } else if (state.errorMessage != null) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.errorMessage!)),
//             );
//           }
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 _buildTextField('Titre de projet', state.errorMessages['title']?.join(', '), _titleController, state.errorMessages['password']?.join(', ')),
//                 SizedBox(height: 16),
//                 _buildTextField('Description du projet', state.errorMessages['description']?.join(', '), _descriptionController, maxLines: 3),
//                 SizedBox(height: 16),
//                 _buildTextField('Mot de fin',  state.errorMessages['mot_de_fin']?.join(', '),_motDeFinController),
//                 SizedBox(height: 16),
//                 Expanded(
//                   child: ListView(
//                     padding: EdgeInsets.zero,
//                     children: [
//                       _buildImageBox(1, _selectedFile1),
//                       SizedBox(height: 16),
//                       _buildImageBox(2, _selectedFile2),
//                       SizedBox(height: 16),
//                       _buildImageBox(3, _selectedFile3),
//                       SizedBox(height: 16),
//                       _buildSaveButton(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(String label, String errorText, TextEditingController controller, {int maxLines = 1}) {
//     return TextFormField(
//       controller: controller,
//       maxLines: maxLines,
//       decoration: InputDecoration(
//         errorText: errorText,
//         labelText: label,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         filled: true,
//         fillColor: Colors.white,
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Veuillez entrer $label';
//         }
//         return null;
//       },
//     );
//   }
//
//   Widget _buildImageBox(int imageNumber, File? imageFile) {
//     return GestureDetector(
//       onTap: () => _pickImage(imageNumber),
//       child: Container(
//         height: 100,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.0),
//           border: Border.all(color: Colors.grey.shade300),
//         ),
//         child: imageFile == null
//             ? Center(
//           child: Icon(
//             Icons.image,
//             color: Colors.grey.shade400,
//             size: 40,
//           ),
//         )
//             : Image.file(
//           imageFile,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSaveButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.green,
//           shape: const StadiumBorder(),
//           padding: const EdgeInsets.symmetric(vertical: 16.0),
//         ),
//         onPressed: context.watch<PortfolioBloc>().state.isLoading
//           ? null
//           : (){
//             if (_formKey.currentState!.validate()) {
//             if (_selectedFile1 != null && _selectedFile2 != null && _selectedFile3 != null) {
//             final portfolioData = PortfolioData(
//             id: 0,
//             title: _titleController.text,
//             description: _descriptionController.text,
//             file_1: '',
//             file_2: '',
//             file_3: '',
//             mot_de_fin: _motDeFinController.text,
//             );
//
//             BlocProvider.of<PortfolioBloc>(context).add(
//             CreatePortfolio(
//             portfolioData: portfolioData,
//             file1: _selectedFile1,
//             file2: _selectedFile2,
//             file3: _selectedFile3,
//             ),
//             );
//             } else {
//             ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Veuillez sélectionner toutes les images')));
//             }
//             }
//     },
//
//   child: context.watch<PortfolioBloc>().state.isLoading
//   ? CircularProgressIndicator(
//   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//   ):
//   Text(
//           'Enregistrer',
//           style: TextStyle(
//             fontSize: 18,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../bloc/portfolio_bloc.dart';
import '../../../bloc/portfolio_event.dart';
import '../../../bloc/portfolio_state.dart';
import '../../../models/portfolio.dart';
import '../../../repositories/portfolio_repository.dart';
import '../../../routes.dart';
import '../../../services/portfolio_service.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/popup_widgets.dart';

class PortfolioFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PortfolioBloc(PortfolioRepository(PortfolioService())),
      child: PortfolioView(),
    );
  }
}

class PortfolioView extends StatefulWidget {
  @override
  _PortfolioFormScreenState createState() => _PortfolioFormScreenState();
}

class _PortfolioFormScreenState extends State<PortfolioView> {
  File? _selectedFile1;
  File? _selectedFile2;
  File? _selectedFile3;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _motDeFinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        title: '',
        showBackButton: true,
        customBackIcon: Icons.arrow_back_ios,
        actions: [],
      ),
      body: BlocListener<PortfolioBloc, PortfolioState>(
        listener: (context, state) {
          if (state.isSuccess) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomPopup(
                  title: 'Succès',
                  content: "Enregistré avec succès",
                  buttonText: 'OK',
                  onButtonPressed: () {
                    Navigator.of(context).pop();
                    AppRoutes.pushReplacement(context, AppRoutes.appProfile);
                  },
                );
              },
            );
          } else if (state.errorMessages.isNotEmpty) {
            final errorMessage = state.errorMessages.entries
                .map((entry) => '${entry.key}: ${entry.value.join(', ')}')
                .join('\n');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMessage)),
            );
          } else if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        child: BlocBuilder<PortfolioBloc, PortfolioState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField('Titre de projet', state.errorMessages['title']?.join(', '), _titleController),
                    SizedBox(height: 16),
                    _buildTextField('Description du projet', state.errorMessages['description']?.join(', '), _descriptionController, maxLines: 3),
                    SizedBox(height: 16),
                    _buildTextField('Mot de fin', state.errorMessages['mot_de_fin']?.join(', '), _motDeFinController),
                    SizedBox(height: 16),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          _buildImageBox(1, _selectedFile1),
                          SizedBox(height: 16),
                          _buildImageBox(2, _selectedFile2),
                          SizedBox(height: 16),
                          _buildImageBox(3, _selectedFile3),
                          SizedBox(height: 16),
                          _buildSaveButton(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String? errorText, TextEditingController controller, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        errorText: errorText,
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

  Widget _buildSaveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        onPressed: context.watch<PortfolioBloc>().state.isLoading
            ? null
            : () {
          if (_formKey.currentState!.validate()) {
            if (_selectedFile1 != null && _selectedFile2 != null && _selectedFile3 != null) {
              final portfolioData = PortfolioData(
                id: 0,
                title: _titleController.text,
                description: _descriptionController.text,
                file_1: '',
                file_2: '',
                file_3: '',
                mot_de_fin: _motDeFinController.text,
              );

              BlocProvider.of<PortfolioBloc>(context).add(
                CreatePortfolio(
                  portfolioData: portfolioData,
                  file1: _selectedFile1,
                  file2: _selectedFile2,
                  file3: _selectedFile3,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Veuillez sélectionner toutes les images')),
              );
            }
          }
        },
        child: context.watch<PortfolioBloc>().state.isLoading
            ? CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        )
            : Text(
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

