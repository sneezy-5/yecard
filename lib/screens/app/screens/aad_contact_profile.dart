import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yecard/repositories/portfolio_repository.dart';
import 'package:yecard/services/portfolio_service.dart';
import '../../../models/contact_model.dart';
import '../../../models/profile_model.dart';
import '../../../repositories/profile_repository.dart';
import '../../../services/contact_service.dart';
import '../../../services/profile_service.dart';
import '../../../services/user_preference.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/popup_widgets.dart';

class AddContactProfileWiew extends StatefulWidget {
  final Map<String, dynamic>? args;

  // Constructor to retrieve args
  const AddContactProfileWiew({Key? key, required this.args}) : super(key: key);

  @override
  _CProfileScreenState createState() => _CProfileScreenState(args: args);
}

class _CProfileScreenState extends State<AddContactProfileWiew>
    with SingleTickerProviderStateMixin {
  final PortfolioRepository _portfolioRepository = PortfolioRepository(PortfolioService());
  final ProfileRepository _profileRepository = ProfileRepository(ProfileService());
  ContactService contactService = ContactService();
  Map<String, String>? userInfo;

  Future<void> _getUserInfo() async {
    userInfo = await UserPreferences.getUserInfo();


  }


  final Map<String, dynamic>? args;

  _CProfileScreenState({Key? key, required this.args});

  late TabController _tabController;

  bool _isOnPortfolioTab = false;
  List<dynamic> portfolioItems = [];
  bool _isEditing = false;
  bool isLoading = true;
  bool _isSaving = false;

  File? _selectedProfileImage;
  File? _selectedBannerImage;

  final _nameController = TextEditingController();
  final _fonctionController = TextEditingController();
  final _entrepriseController = TextEditingController();
  final _biographieController = TextEditingController();
  final _phoneController = TextEditingController();
  final _siteController = TextEditingController();
  final _emailController = TextEditingController();
  final _localisationController = TextEditingController();
  final _profileImageController = TextEditingController();
  final _bannerImageController = TextEditingController();
  final _facebookController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _linkedinController = TextEditingController();

 late int id;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _getUserInfo();
    _tabController.addListener(() {
      setState(() {
        _isOnPortfolioTab = _tabController.index == 1;
      });
    });
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final portfolioResponse = await _portfolioRepository.getContactPortfolio(args?['id']);
      final profileResponse = await _profileRepository.contactProfile(args?['id']);

      setState(() {
        print("PROFILE: $profileResponse");
        print("PORTFOLIO: $portfolioResponse");

        // Handling portfolio response
        if (portfolioResponse != null && portfolioResponse['success']) {
          if (portfolioResponse['data'] != null) {
            // Process portfolio data here
            // Example: portfolioItems = portfolioResponse['data'];
          }
        }

        // Handling profile response
        if (profileResponse != null && profileResponse['success']) {
          final profileData = ProfileData.fromJson(profileResponse['data']);
          id = profileData.id;
          _fillProfileData(profileData);
        } else {
          // If profile data is empty, display a popup
          _showUserNotFoundPopup();
        }

        isLoading = false;
      });
    } catch (e) {
      print('Error fetching profile or portfolio data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showUserNotFoundPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomPopup(
          title: 'Erreur',
          content: 'Utilisateur introuvable',
          buttonText: 'Ok',
          onButtonPressed: () {
            Navigator.of(context).pop(); // Close the popup
            Navigator.of(context).pop(); // Navigate back
          },
        );
      },
    );
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
    _profileImageController.dispose();
    _bannerImageController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        title: '',
        showBackButton: true,
        customBackIcon: Icons.arrow_back_ios,
        actions: [

        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          Column(
            children: [
              _buildBannerImage(),
            ],
          ),
          Column(
            children: [
              _buildProfileImage(),
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
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: TabBarView(
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
    );
  }

  Widget _buildBannerImage() {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => {},
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

      ],
    );
  }

  Widget _buildProfileImage() {
    return Container(
      height: 200,
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: GestureDetector(
              onTap: () => {},
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
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutTab() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Section Biographie
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Biographie',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

            ],
          ),
          SizedBox(height: 10),
          _buildReadOnlyTextField(_biographieController.text),

          // Autres champs (Nom, Email, Fonction, etc.)
          _buildFieldWithLabel(Icons.label, 'Nom', _nameController),
          _buildFieldWithLabel(Icons.mail_outline, 'Email', _emailController),
          _buildFieldWithLabel(Icons.work, 'Fonction', _fonctionController),
          _buildFieldWithLabel(Icons.phone, 'Phone', _phoneController),
          _buildFieldWithLabel(Icons.language, 'Portfolio Site', _siteController),
          _buildFieldWithLabel(Icons.house, 'Domicile', _localisationController),

          // Section Réseaux sociaux
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

          // Facebook
          _buildSocialMediaField(Icons.facebook, 'Facebook', _facebookController),
          // WhatsApp
          _buildSocialMediaField(FontAwesomeIcons.whatsapp, 'WhatsApp', _whatsappController),
          // LinkedIn
          _buildSocialMediaField(FontAwesomeIcons.linkedin, 'LinkedIn', _linkedinController),
          SizedBox(height: 10),
          // Boutons d'enregistrement
          _isSaving
              ? Center(child: CircularProgressIndicator()) // Affiche un indicateur de chargement
              : ElevatedButton(
            onPressed: _saveProfileAsContact,
            child: Text("Enregistrer sur le téléphone"),
          ),

          ElevatedButton(
            onPressed: () {
              final userId = int.tryParse(userInfo?['id'] ?? '');

              ContactData contactdata = ContactData(from_user: 1, to_user: id);
              contactService.addContact(contactdata);
            },
            child: Text("Enregistrer dans l'application"),
          ),

          // ElevatedButton(onPressed: _saveProfileAsContact, child: Text("Enregistrer sur le telphone")),
          // ElevatedButton(onPressed: () {
          //   final userId = int.tryParse(userInfo?['id'] ?? '');
          //
          //   ContactData contactdata = ContactData(from_user: userId, to_user: id) ;
          //   contactService.addContact(contactdata);
          // }, child: Text("Enregistrer dans lapplication")),
          SizedBox(height: 10),
        ],
      ),
    );
  }
  Widget _buildFieldWithLabel(IconData icon, String label, TextEditingController controller) {
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
                    ? _buildEditableTextField(controller, 1)
                    : _buildReadOnlyTextField(controller.text),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaField(IconData icon, String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Add some vertical padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 30),
          SizedBox(width: 10), // Space between icon and text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                _isEditing
                    ? _buildEditableTextField(controller, 1)
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
          ? const Center(child: Text('No Portfolio Data'))
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                  'title': item['title'],
                  'description': item['description'],
                  'file_1': item['file_1'],
                  'file_2': item['file_2'],
                  'file_3': item['file_3']
                },
              );
            },
            child: Card(
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(item['file_1']),
                  const SizedBox(height: 10),
                  Text(
                    item['title'] ?? 'Item ${index + 1}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEditableTextField(TextEditingController controller, int maxLines) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: const InputDecoration(
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
    _nameController.text = profileData.name ?? '';
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



  // Future<void> _saveProfileAsContact() async {
  //   if (await FlutterContacts.requestPermission()) {
  //     // Create a new contact with full details
  //     final newContact = Contact(
  //       name: Name(first: _nameController.text),
  //       phones: [Phone(_phoneController.text)],
  //       emails: [Email(_emailController.text)],
  //       organizations: [
  //         Organization(
  //           company: _entrepriseController.text, // Company name
  //           title: _fonctionController.text,     // Job title
  //         )
  //       ],
  //       addresses: [
  //         Address(
  //           _localisationController.text,
  //           label: AddressLabel.home, // Address label (optional)
  //           street: '',
  //           city: 'Abidjan',         // City (example)
  //           state: '', // State (example)
  //           postalCode: '',    // Postal code (example)
  //           country: "Cote d'Ivoire",      // Country (example)
  //         )
  //       ],
  //       websites: [Website(_siteController.text)],
  //     );
  //
  //     try {
  //       // Save the contact to the phone's contact list
  //       await FlutterContacts.insertContact(newContact);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Contact enregistré avec succès')),
  //       );
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Erreur lors de l\'enregistrement du contact')),
  //       );
  //     }
  //   }
  // }

  Future<void> _saveProfileAsContact() async {
    if (await FlutterContacts.requestPermission()) {
      // Créer un nouveau contact avec toutes les informations
      final newContact = Contact(
        name: Name(first: _nameController.text),
        phones: [Phone(_phoneController.text)],
        emails: [Email(_emailController.text)],
        organizations: [
          Organization(
            company: _entrepriseController.text, // Nom de l'entreprise
            title: _fonctionController.text,      // Titre du poste
          )
        ],
        addresses: [
          Address(
            _localisationController.text,
            label: AddressLabel.home,
          )
        ],
        websites: [Website(_siteController.text)],
        socialMedias: [
          // SocialMedia(
          //   type: FontAwesomeIcons.facebook,
          //   userName: _facebookController.text, // Use .text to get the string value
          // ),
          // SocialMedia(
          //   type: FontAwesomeIcons.whatsapp,
          //   userName: _whatsappController.text, // Use .text to get the string value
          // ),
        ],
      );

      // Ajouter une photo
      if (_selectedProfileImage != null) {
        // Convertir l'image en bytes
        final bytes = await _selectedProfileImage!.readAsBytes();
        newContact.photo = bytes; // Attribuer les bytes de l'image au contact
      }

      try {
        // Enregistrer le contact dans la liste de contacts du téléphone
        await FlutterContacts.insertContact(newContact);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Contact enregistré avec succès')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l\'enregistrement du contact')),
        );
      }
    }
  }

}

