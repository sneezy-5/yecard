import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yecard/repositories/portfolio_repository.dart';
import 'package:yecard/services/portfolio_service.dart';
import '../../../bloc/profile_bloc.dart';
import '../../../bloc/profile_event.dart';
import '../../../bloc/profile_state.dart';
import '../../../models/portfolio.dart';
import '../../../models/profile_model.dart';
import '../../../repositories/profile_repository.dart';
import '../../../services/profile_service.dart';
import '../../../widgets/app_bar.dart';

class ProfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(ProfileRepository(ProfileService()), PortfolioRepository(PortfolioService())),
      child: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  final PortfolioRepository _portfolioRepository = PortfolioRepository(PortfolioService());
  late TabController _tabController;
  int id = 0;
  bool _isOnPortfolioTab = false;
  List<dynamic> portfolioItems = [];
  late ProfileBloc _profileBloc;
  bool _isEditing = false;
  bool isLoading = true;

  File? _selectedProfileImage;
  File? _selectedBannerImage;

  final _nameController = TextEditingController();
  final _fonctionController = TextEditingController();
  final _entrepriseController = TextEditingController();
  final _biographieController = TextEditingController();
  final _phoneController = TextEditingController();
  final _domicileController = TextEditingController();
  final _siteController = TextEditingController();
  final _emailController = TextEditingController();
  final _localisationController = TextEditingController();
  final _profileImageController = TextEditingController();
  final _bannerImageController = TextEditingController();
  final _facebookController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _linkedinController = TextEditingController();
  bool _isPortfolioLoaded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.add(FetchProfile());
    _tabController.addListener(() {
      setState(() {
        _isOnPortfolioTab = _tabController.index == 1;
        _loadPortfolio();

      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _fonctionController.dispose();
    _entrepriseController.dispose();
    _biographieController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _localisationController.dispose();
    _siteController.dispose();
    _domicileController.dispose();
    _profileImageController.dispose();
    _bannerImageController.dispose();
    _facebookController.dispose();
    _whatsappController.dispose();
    _linkedinController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(bool isProfileImage) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (isProfileImage) {
          _selectedProfileImage = File(pickedFile.path);
          _saveProfile();
        } else {
          _selectedBannerImage = File(pickedFile.path);
          _saveProfile();
        }
      });
    }
  }
  Future<void> _loadPortfolio() async {
    // setState(() {
    //   isLoading = true;
    // });

    try {
      final responses = await _portfolioRepository.portfolio();
      if (responses['success']) {
        setState(() {
          portfolioItems = responses['data'];
          _isPortfolioLoaded = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Erreur lors du chargement du portfolio: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) async {

        if (state is ProfileLoaded) {
          _fillProfileData(state.profileData );
          setState(() {

            isLoading = false;
            id = state.profileData.id;
          });
        }
        if (state is PortfolioLoaded) {
          setState(() {
            isLoading = false;
            portfolioItems = state.portfolioData as List;
          });
        } else if (state is ProfileError) {
          setState(() {
            isLoading = false;
          });
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text(state.error)),
          // );
        } else if (state.error.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Scaffold(
        appBar: ReusableAppBar(
          title: '',
          showBackButton: true,
          customBackIcon: Icons.arrow_back_ios,
          actions: [
            if (_isOnPortfolioTab)

              IconButton(
                icon: Icon(Icons.add_circle_outline),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pushNamed('/app/add_portfolio');
                },
              ),
          ],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
    padding: EdgeInsets.zero,
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () => _pickImage(false), // Pick banner image
                          child: Container(
                            width: double.infinity,
                            height: 100,
                            child: _selectedBannerImage == null
                                ? Image.network(
                              _bannerImageController.text,
                              fit: BoxFit.cover,
                            )
                                : Image.file(
                              _selectedBannerImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 8,
                          bottom: 0,
                          child: IconButton(
                            icon: Icon(Icons.edit, color: Colors.white),
                            onPressed: () {
                              _pickImage(false); // Pick new banner image
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 200,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 50,
                            left: MediaQuery.of(context).size.width / 2 - 50,
                            child: GestureDetector(
                              onTap: () => _pickImage(true), // Pick profile image
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: _selectedProfileImage == null
                                    ? NetworkImage(_profileImageController.text)
                                    : FileImage(_selectedProfileImage!) as ImageProvider,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            top: 150,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _nameController.text,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    _fonctionController.text,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TabBar(
                            controller: _tabController,
                            indicatorColor: Colors.green,
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: const [
                              Tab(text: 'About'),
                              Tab(text: 'Portfolio'),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child:  TabBarView(
                              controller: _tabController,
                              children: [
                                _buildAboutTab(),
                                _buildPortfolioTab(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        )

      ),
    );
  }


  Widget _buildAboutTab() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Biographie Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Biographie',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  if (_isEditing) {
                    _saveProfile();
                  }
                  setState(() {
                    _isEditing = !_isEditing;
                  });
                },
                icon: Icon(_isEditing ? Icons.check : Icons.edit),
                tooltip: _isEditing ? 'Save' : 'Edit',
              ),
            ],
          ),
          SizedBox(height: 10),
          _isEditing
              ? _buildEditableTextField(_biographieController, 5)
              : _buildReadOnlyTextField(_biographieController.text),

          // Other Fields (Name, Email, etc.)
          _buildFieldWithLabel(Icons.label, 'Nom', _nameController),
          _buildFieldWithLabel(Icons.mail_outline, 'Email', _emailController),
          _buildFieldWithLabel(Icons.work, 'Fonction', _fonctionController),
          _buildFieldWithLabel(Icons.phone, 'Phone', _phoneController),
          _buildFieldWithLabel(Icons.language, 'Portfolio Site', _siteController),
          _buildFieldWithLabel(Icons.house, 'Domicile', _localisationController),

          // Social Media Section
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mes réseaux sociaux',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),

          // Social Media Links
          _buildSocialMediaField(Icons.facebook, 'Facebook', _facebookController, 'https://www.facebook.com/'),
          _buildSocialMediaField(FontAwesomeIcons.whatsapp, 'WhatsApp', _whatsappController, 'https://wa.me/'),
          _buildSocialMediaField(FontAwesomeIcons.linkedin, 'LinkedIn', _linkedinController, 'https://www.linkedin.com/in/'),
          SizedBox(height: 60),
        ],
      ),
    );
  }
  Widget _buildSocialMediaField(IconData icon, String label, TextEditingController controller, String baseUrl) {
    return GestureDetector(
      onTap: () async {
        final profileId = Uri.encodeComponent(controller.text.trim());
        if (profileId.isNotEmpty) {
          final url = '$baseUrl$profileId';
          try {
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Could not launch $url')),
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error launching URL: $e')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter your $label profile ID')),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: label,
                  border: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.zero, // Adjust padding for cleaner look
                ),
                readOnly: !_isEditing,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildSocialMediaField(IconData icon, String label, TextEditingController controller, String baseUrl) {
  //   return GestureDetector(
  //     onTap: () async {
  //       final profileId = controller.text.trim();
  //       if (profileId.isNotEmpty) {
  //         final url = '$baseUrl$profileId';
  //         if (await canLaunch(url)) {
  //           await launch(url);
  //         } else {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text('Could not launch $url')),
  //           );
  //         }
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Please enter your $label profile ID')),
  //         );
  //       }
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 8.0),
  //       child: Row(
  //         children: [
  //           Icon(icon, color: Colors.blue),
  //           SizedBox(width: 10),
  //           Expanded(
  //             child: TextFormField(
  //               controller: controller,
  //               decoration: InputDecoration(
  //                 labelText: label,
  //                 border: OutlineInputBorder(),
  //               ),
  //               readOnly: !_isEditing,
  //               onTap: _isEditing ? null : () async {
  //                 if (!_isEditing) {
  //                   final profileId = controller.text.trim();
  //                   final url = '$baseUrl$profileId';
  //                   if (await canLaunch(url)) {
  //                     await launch(url);
  //                   }
  //                 }
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildAboutTab() {
  //   return Padding(
  //     padding: const EdgeInsets.all(10.0),
  //     child: ListView(
  //       padding: EdgeInsets.zero,
  //       children: [
  //         // Section Biographie
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               'Biographie',
  //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //             ),
  //             IconButton(
  //               onPressed: () {
  //                 if (_isEditing) {
  //                   _saveProfile();
  //                 }                  setState(() {
  //                   _isEditing = !_isEditing;
  //                 });
  //               },
  //               icon: Icon(_isEditing ? Icons.check : Icons.edit),
  //               tooltip: _isEditing ? 'Save' : 'Edit',
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 10),
  //         _isEditing
  //             ? _buildEditableTextField(_biographieController, 5)
  //             : _buildReadOnlyTextField(_biographieController.text),
  //
  //         // Autres champs (Nom, Email, Fonction, etc.)
  //         _buildFieldWithLabel(Icons.label, 'Nom', _nameController),
  //         _buildFieldWithLabel(Icons.mail_outline, 'Email', _emailController),
  //         _buildFieldWithLabel(Icons.work, 'Fonction', _fonctionController),
  //         _buildFieldWithLabel(Icons.phone, 'Phone', _phoneController),
  //         _buildFieldWithLabel(Icons.language, 'Portfolio Site', _siteController),
  //         _buildFieldWithLabel(Icons.house, 'Domicile', _localisationController),
  //
  //         // Section Réseaux sociaux
  //         SizedBox(height: 20),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               'Mes réseaux sociaux',
  //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //             ),
  //
  //           ],
  //         ),
  //         SizedBox(height: 10),
  //
  //         // Facebook
  //         _buildSocialMediaField(Icons.facebook, 'Facebook', _facebookController),
  //         // WhatsApp
  //         _buildSocialMediaField(FontAwesomeIcons.whatsapp, 'WhatsApp', _whatsappController),
  //         // LinkedIn
  //         _buildSocialMediaField(FontAwesomeIcons.linkedin, 'LinkedIn', _linkedinController),
  //         SizedBox(height: 60),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildFieldWithLabel(IconData icon, String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    if (icon == Icons.phone) {
      keyboardType = TextInputType.number; // Set keyboardType to number if the icon is a phone
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Add some vertical padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 30),
          SizedBox(width: 10), // Add a little space between the icon and text field
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                _isEditing
                    ? _buildEditableTextField(controller, 1,keyboardType: keyboardType)
                    : _buildReadOnlyTextField(controller.text),
              ],
            ),
          ),
        ],
      ),
    );
  }





  Widget _buildPortfolioTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: portfolioItems.isEmpty
          ? Center(child: Text('No Portfolio Data'))
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 2,
        ),
        itemCount: portfolioItems.length,
        itemBuilder: (context, index) {
          final item = portfolioItems[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                '/app/portfolio_detail',
                arguments: {
                  'id': item['id'],
                  'title': item['title'],
                  'description': item['description'],
                  'mot_de_fin': item['mot_de_fin'],
                  'file_1': item['file_1'],
                  'file_2': item['file_2'],
                  'file_3': item['file_3']
                },
              );
            },
            onLongPress: () {
              _showDeleteConfirmationDialog(index, item['id']);
            },
            child: Card(
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 50,
                    child: Image.network(
                      item['file_1'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    item['title'] ?? 'Item ${index + 1}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(int index,int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Supprimer'),
          content: Text('Voulez-vous vraiment supprimer cet élément ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  portfolioItems.removeAt(index);
                  _portfolioRepository.deletePortfolio(id);
                });
                Navigator.of(context).pop();
              },
              child: Text(
                'Supprimer',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEditableTextField(
      TextEditingController controller, int maxLines, {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType, // Set dynamically
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: UnderlineInputBorder(),
        hintText: 'Edit text',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }


  Widget _buildReadOnlyTextField(String text) {
    return Text(text.isNotEmpty ? text : 'Non spécifié');
  }

  void _fillProfileData(ProfileData profileData) {
    _nameController.text = profileData.name ?? ''; // Default to empty string if null
    _fonctionController.text = profileData.fonction ?? '';
    _entrepriseController.text = profileData.entreprise ?? '';
    _biographieController.text = profileData.biographie ?? '';
    _phoneController.text = profileData.phone ?? '';
    _emailController.text = profileData.email ?? '';
    _localisationController.text = profileData.localisation ?? '';
    _profileImageController.text = profileData.profile_image ?? '';
    _bannerImageController.text = profileData.banier ?? '';
    _siteController.text = profileData.site_url ?? '';
    _facebookController.text = profileData.facebook ?? '';
    _whatsappController.text = profileData.whatsapp ?? '';
    _linkedinController.text = profileData.linkedin ?? '';
  }

  void _saveProfile() {
    final updatedProfile = ProfileData(
      id: id,
      name: _nameController.text,
      fonction: _fonctionController.text,
      entreprise: _entrepriseController.text,
      biographie: _biographieController.text,
      phone: _phoneController.text,
      email: _emailController.text,
      localisation: _localisationController.text,
      facebook: _facebookController.text,
      whatsapp: _whatsappController.text,
      linkedin: _linkedinController.text,

    );

    // _profileBloc.add(UpdateProfile(profileData: updatedProfile));
    _profileBloc.add(UpdateProfile(
      profileData: updatedProfile,
      picture: _selectedProfileImage,
      banier: _selectedBannerImage,
    ));
    setState(() {
      _isEditing != _isEditing;
    });
  }


}
