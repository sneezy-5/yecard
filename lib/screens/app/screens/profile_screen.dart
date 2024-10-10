import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yecard/repositories/portfolio_repository.dart';
import 'package:yecard/services/portfolio_service.dart';
import '../../../bloc/profile_bloc.dart';
import '../../../bloc/profile_event.dart';
import '../../../bloc/profile_state.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.add(FetchProfile());
    // _profileBloc.add(FetchPortfolio());
    _tabController.addListener(() {
      setState(() {
        _isOnPortfolioTab = _tabController.index == 1;
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded) {
          _fillProfileData(state.profileData );
          setState(() {
            isLoading = false;
            id = state.profileData.id;
            print("PROFILELLE${state.portfolioData}");
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        } else if (state.message.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
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
            : Stack(
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
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _nameController.text,
                                style: TextStyle(
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
                      Container(
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
          SizedBox(height: 10),
          // Similar sections for other fields...
          _buildFieldWithLabel(Icons.label,'Nom', _nameController),
          _buildFieldWithLabel(Icons.mail_outline,'Email', _emailController),
          _buildFieldWithLabel(Icons.phone,'Phone', _phoneController),
          _buildFieldWithLabel(Icons.label,'Portfolio Site', _siteController),
          _buildFieldWithLabel(Icons.house,'Domicile', _domicileController),
        ],
      ),
    );
  }

  Widget _buildFieldWithLabel( IconData icon, String label, TextEditingController controller) {
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
        SizedBox(height: 10),
      ],
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
              Navigator.of(context).pushNamed('/app/portfolio_detail');
            },
            child: Card(
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image, size: 50, color: Colors.grey),
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

  Widget _buildEditableTextField(TextEditingController controller, int maxLines) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
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
    _nameController.text = profileData.name;
    _fonctionController.text = profileData.fonction;
    _entrepriseController.text = profileData.entreprise;
    _biographieController.text = profileData.biographie;
    _phoneController.text = profileData.phone;
    _emailController.text = profileData.email;
    _localisationController.text = profileData.localisation;
    _profileImageController.text = profileData.profile_image;
    _bannerImageController.text = profileData.banier;

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
      profile_image: '',
      banier: '',
    );

    _profileBloc.add(UpdateProfile(
      profileData: updatedProfile,
      picture: _selectedProfileImage,
      banier: _selectedBannerImage,
    ));

    setState(() {
      _isEditing = false;
    });
  }
}
