import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yecard/repositories/portfolio_repository.dart';
import 'package:yecard/services/portfolio_service.dart';
import '../../../models/portfolio.dart';
import '../../../models/profile_model.dart';
import '../../../repositories/profile_repository.dart';
import '../../../routes.dart';
import '../../../services/profile_service.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/popup_widgets.dart';

class ContactProfileWiew extends StatefulWidget {
  final Map<String, dynamic>? args;

  // Constructor to retrieve args
  const ContactProfileWiew({Key? key, required this.args}) : super(key: key);

  @override
  _CProfileScreenState createState() => _CProfileScreenState(args: args);
}

class _CProfileScreenState extends State<ContactProfileWiew>
    with SingleTickerProviderStateMixin {
  final PortfolioRepository _portfolioRepository = PortfolioRepository(PortfolioService());
  final ProfileRepository _profileRepository = ProfileRepository(ProfileService());
  final Map<String, dynamic>? args;

  _CProfileScreenState({Key? key, required this.args});

  late TabController _tabController;

  bool _isOnPortfolioTab = false;
  List<dynamic> portfolioItems = [];
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _isOnPortfolioTab = _tabController.index == 1;
      });
    });
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      // final portfolioResponse = await _portfolioRepository.getContactPortfolio((args?['id']));
      final profileResponse = await _profileRepository.contactProfile(args?['id']);

      setState(() {
        print("PROFILEEA:${profileResponse }");
        print("PROFILEEE:${args?['id'] }");
        // print("PORTFOLIO:${portfolioResponse }");
        // if (portfolioResponse['success']) {
        //   if (portfolioResponse['data']){
        //     // final protfolioData = PortfolioData.fromJson(portfolioResponse['data']);
        //     portfolioItems = portfolioResponse['data'];
        //   }
        //
        //
        // }
        if (profileResponse['success'] ) {
          final profileData = ProfileData.fromJson(profileResponse['data']);
          _fillProfileData(profileData);
        } else {
          // Si les données du profil sont vides, afficher un popup
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomPopup(
                title: 'Succès',
                content: "Utilisateur introuvable",
                buttonText: 'ok',
                onButtonPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              );
            },
          );
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
    super.dispose();
  }

  Future<void> _pickImage(bool isProfileImage) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (isProfileImage) {
          _selectedProfileImage = File(pickedFile.path);
        } else {
          _selectedBannerImage = File(pickedFile.path);
        }
        _saveProfile();
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
                      height: MediaQuery.of(context).size.height * 0.6,
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
          onTap: () => _pickImage(false),
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
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              _pickImage(false);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    return Container(
      height: 130,
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: GestureDetector(
              onTap: () => _pickImage(true),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Biographie',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _isEditing = !_isEditing;
                  });
                  if (!_isEditing) {
                    _saveProfile();
                  }
                },
                icon: Icon(_isEditing ? Icons.check : Icons.edit),
                tooltip: _isEditing ? 'Save' : 'Edit',
              ),
            ],
          ),
          const SizedBox(height: 10),
          _isEditing
              ? _buildEditableTextField(_biographieController, 5)
              : _buildReadOnlyTextField(_biographieController.text),
          const SizedBox(height: 10),
          _buildFieldWithLabel(Icons.label, 'Nom', _nameController),
          _buildFieldWithLabel(Icons.mail_outline, 'Email', _emailController),
          _buildFieldWithLabel(Icons.phone, 'Phone', _phoneController),
          _buildFieldWithLabel(Icons.label, 'Portfolio Site', _siteController),
          _buildFieldWithLabel(Icons.house, 'Domicile', _domicileController),
          ElevatedButton(
            onPressed: _saveProfileAsContact,
            child: const Text('Enregistrer sur le téléphone',
            style: TextStyle(
              color: Colors.blue
            ),),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldWithLabel(IconData icon, String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(label),
        ),
        _isEditing
            ? _buildEditableTextField(controller, 1)
            : _buildReadOnlyTextField(controller.text),
        const SizedBox(height: 10),
      ],
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
    _nameController.text = profileData.name ?? ''; // Default to empty string if null
    _fonctionController.text = profileData.fonction ?? '';
    _entrepriseController.text = profileData.entreprise ?? '';
    _biographieController.text = profileData.biographie ?? '';
    _phoneController.text = profileData.phone ?? '';
    _emailController.text = profileData.email ?? '';
    _localisationController.text = profileData.localisation ?? '';
    _profileImageController.text = profileData.profile_image ?? '';
    _bannerImageController.text = profileData.banier ?? '';
    _domicileController.text = profileData.address ?? '';
    _siteController.text = profileData.site_url ?? '';
  }


  void _saveProfile() {
    final updatedProfile = ProfileData(
      id: 0, // Replace with the correct ID
      name: _nameController.text,
      fonction: _fonctionController.text,
      entreprise: _entrepriseController.text,
      biographie: _biographieController.text,
      phone: _phoneController.text,
      email: _emailController.text,
      localisation: _localisationController.text,
      address: _domicileController.text,
      site_url: _siteController.text,
      profile_image: '',
      banier: '',
    );

    // Save profile using updated data
    // Call API or handle saving logic
    setState(() {
      _isEditing = false;
    });
  }

  Future<void> _saveProfileAsContact() async {
    if (await FlutterContacts.requestPermission()) {
      final newContact = Contact(
        name: Name(first: _nameController.text),
        phones: [Phone(_phoneController.text)],
        emails: [Email(_emailController.text)],
        // company: _entrepriseController.text,
        // jobTitle: _fonctionController.text,
        // addresses: [Address(address: _domicileController.text)],
        websites: [Website(_siteController.text)],
      );

      try {
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
