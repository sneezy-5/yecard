import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/profile_bloc.dart';
import '../../../bloc/profile_event.dart';
import '../../../bloc/profile_state.dart';
import '../../../models/profile_model.dart';
import '../../../routes.dart';
import '../../../services/user_preference.dart';

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _fonctionController = TextEditingController();
  final _entrepriseController = TextEditingController();
  final _biographieController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _localisationController = TextEditingController();
  final _profileImageController = TextEditingController();

  bool isLoading = true;
  late int id;
  List portfolioItems = [];

  void _onDrawerOpened() {
    BlocProvider.of<ProfileBloc>(context).add(FetchProfile());
  }

  Future<void> _removeUserInfo() async {
    await UserPreferences.clearUserToken();
    AppRoutes.pushReplacement(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded) {
          _fillProfileData(state.profileData);
          setState(() {
            isLoading = false;
            id = state.profileData.id;
          });
        } else if (state is PortfolioLoaded) {
          setState(() {
            portfolioItems = state.portfolioData as List;
          });
        } else if (state is ProfileError) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        } else if (state.message != '') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      child: Image.network(_profileImageController.text,
                        width: 95,
                        height: 95,
                      ),
                    ),
                  ),
                  Text(
                    _nameController.text.isNotEmpty
                        ? _nameController.text
                        : 'Nom inconnu',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    _fonctionController.text.isNotEmpty
                        ? _fonctionController.text
                        : "Fonction inconnue",
                  ),
                  Text(
                    _entrepriseController.text.isNotEmpty
                        ? _entrepriseController.text
                        : "Entreprise inconnue",
                  ),
                ],
              ),
              SizedBox(height: 50),
              ListTile(
                leading: Container(
                  width: 20,
                  height: 20,
                  child: Image.asset('assets/images/notif.png'),
                ),
                title: Text('Notification'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Container(
                  width: 20,
                  height: 20,
                  child: Image.asset('assets/images/share.png'),
                ),
                title: Text("Partager l'application"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 300),
              ListTile(
                leading: Container(
                  width: 20,
                  height: 20,
                  child: Image.asset('assets/images/exit.png'),
                ),
                title: Text('Quitter l’application'),
                onTap: () {
                  _removeUserInfo();
                },
              ),
            ],
          ),
        ),
        onEndDrawerChanged: (isOpened) {
          if (isOpened) {
            _onDrawerOpened();
          }
        },
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState?.openEndDrawer();
                      },
                      child: Icon(Icons.menu_rounded),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/app/qr_code_screen');
                      },
                      child: Icon(Icons.qr_code_scanner_rounded),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 110, // Hauteur fixe pour le ListView
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    // Item 1 avec bordure et espace
                    Container(
                      width: 380,
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(
                        'assets/images/slide1.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    // Item 2 avec bordure et espace
                    Container(
                      width: 380,
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(
                        'assets/images/slide1.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/app/profile');
                    },
                    child: Image.network(_profileImageController.text,
                      width: 248,
                      height: 351,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: 293,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    AppRoutes.pushReplacement(context, AppRoutes.appGetOrder);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text(
                    'Commander sa carte de visite physique',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
    print(_profileImageController.text.toString());
  }
}
