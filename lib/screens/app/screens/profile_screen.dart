
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yecard/repositories/portfolio_service.dart';
import 'package:yecard/services/portfolio_service.dart';
import '../../../bloc/profile_bloc.dart';
import '../../../bloc/profile_event.dart';
import '../../../bloc/profile_state.dart';  // Ajout de l'import du ProfileState
import '../../../models/profile_model.dart';
import '../../../repositories/profile_repository.dart';
import '../../../routes.dart';
import '../../../services/profile_service.dart';
import '../../../widgets/app_bar.dart';

class ProfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(ProfileRepository(ProfileService()),PortfolioRepository(PortfolioService())),
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
  bool isLoading = true; // Variable de gestion du chargement
  final _nameController = TextEditingController();
  final _fonctionController = TextEditingController();
  final _entrepriseController = TextEditingController();
  final _biographieController = TextEditingController();
  final _phoneController = TextEditingController();
  final _domicicleController = TextEditingController();
  final _siteController = TextEditingController();
  final _emailController = TextEditingController();
  final _localisationController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.add(FetchProfile());
    _profileBloc.add(FetchPortfolio());
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
    _domicicleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded) {
          _fillProfileData(state.profileData);
          setState(() {
            isLoading = false;
            id= state.profileData.id;
          });
        } else if (state is PortfolioLoaded) {
          setState(() {
            portfolioItems = state.portfolioData as List;
          });
        }
        else if (state is ProfileError) {
          setState(() {
            isLoading = false;
          });
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
                  // AppRoutes.pushReplacement(context, AppRoutes.appAddPortfolio);
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

                    Container(
                      width: double.infinity,
                      height: 100,
                      child: Image.network(
                        'https://cdn.shopify.com/static/sample-images/bath_grande_crop_center.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 8,
                      bottom: 0,
                      child: IconButton(
                        icon: Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          print('Edit button pressed');
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
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/profil.png'),
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
        child:ListView(
            padding: EdgeInsets.zero,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Biographie',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
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

              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mes coordonees',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
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
              ListTile(
                leading:  Icon(Icons.verified_user),
                title: Text('Nom'),
                onTap: () {

                },
              ),
              _isEditing
                  ? _buildEditableTextField(_nameController, 1)
                  : _buildReadOnlyTextField(_nameController.text),

              ListTile(
                leading:  Icon(Icons.email),
                title: Text('Email'),
                onTap: () {

                },
              ),
              _isEditing
                  ? _buildEditableTextField(_emailController, 1)
                  : _buildReadOnlyTextField(_emailController.text),


              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Phone'),
                onTap: () {

                },
              ),
              _isEditing
                  ? _buildEditableTextField(_phoneController, 1)
                  : _buildReadOnlyTextField(_phoneController.text),
              SizedBox(height: 10),

              ListTile(
                leading: Icon(Icons.web),
                title: Text('Portfolio Site'),
                onTap: () {

                },
              ),
              _isEditing
                  ? _buildEditableTextField(_siteController, 1)
                  : _buildReadOnlyTextField(_siteController.text),
              SizedBox(height: 10),

              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Domicile'),
                onTap: () {

                },
              ),
              _isEditing
                  ? _buildEditableTextField(_domicicleController, 1)
                  : _buildReadOnlyTextField(_domicicleController.text),
              SizedBox(height: 10),

              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mes Reseaux sociaux',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = !_isEditing;
                      });
                    },
                    icon: Icon(_isEditing ? Icons.check : Icons.edit),
                    tooltip: _isEditing ? 'Save' : 'Edit',
                  ),
                ],
              ),
              ListTile(
                leading: Container(
                  width: 50,
                  height: 10,
                  child: Icon(Icons.facebook_outlined),
                ),
                title: Text('Koffi yohan'),
                onTap: () {

                },
              ),
              ListTile(
                leading: Container(
                  width: 50,
                  height: 10,
                  child: Icon(Icons.whatshot_outlined),
                ),
                title: Text('225 00000000'),
                onTap: () {

                },
              ),
              ListTile(
                leading: Container(
                  width: 50,
                  height: 10,
                  child: Icon(Icons.face),
                ),
                title: Text('koffi yohan'),
                onTap: () {

                },
              ),
            ]
        )
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
  Widget _buildEditableTextField(TextEditingController controller, int maxlines) {
    return TextField(
      controller: controller,
      maxLines: maxlines,
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

    );

    _profileBloc.add(UpdateProfile(profileData: updatedProfile));

    setState(() {
      _isEditing != _isEditing;
    });
  }
}

