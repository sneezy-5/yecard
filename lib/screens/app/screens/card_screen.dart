
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../bloc/profile_bloc.dart';
import '../../../bloc/profile_event.dart';
import '../../../bloc/profile_state.dart';
import '../../../models/card_model.dart';
import '../../../models/profile_model.dart';
import '../../../repositories/card_repository.dart';
import '../../../routes.dart';
import '../../../services/card_service.dart';
import '../../../services/user_preference.dart';
import '../../../widgets/profil_card.dart';

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
  late final PageController _pageController;

  final CardRepository _cardRepository = CardRepository(CardService());

  String? userQrData;

  Timer? _timer;
  bool isLoading = true; // Added loading flag
  late int id;
  List portfolioItems = [];

  @override
  void initState() {
    super.initState();
    _fetchCardData();
    // Fetch profile data when the screen is loaded
    BlocProvider.of<ProfileBloc>(context).add(FetchProfile());
    _pageController = PageController();

    // Start auto-scroll timer
    _timer = Timer.periodic(Duration(seconds: 6), (timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.toInt() + 1;
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 1500), // Slower scroll animation
          curve: Curves.easeInOut,
        );
      }
    });

  }

  Future<void> _fetchCardData() async {
    try {
      final response = await _cardRepository.getCard();
      if (response['success']) {
        final cardData = CardData.fromJson(response['data'][0]);
        setState(() {
          userQrData = cardData.number.isNotEmpty ? cardData.number : "";
          isLoading = false;
        });
      } else {
        print("Error: ${response['message']}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching card data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }


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
                    child:CircleAvatar(
                      radius: 50,
                      backgroundImage:  NetworkImage(_profileImageController.text)
                    ),

                  ),
                  Text(
                    _nameController.text.isNotEmpty
                        ? _nameController.text
                        : 'Nom inconnu',
                    style: const TextStyle(
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
                  // Navigator.pop(context);
                  final String appLink = 'https://play.google.com/store/apps/details?id=com.yecard.yecard';
                  Share.share(
                    'Découvrez cette application incroyable! Téléchargez-la ici: $appLink',
                    subject: 'Mon code QR et lien de l\'application',
                  );
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
        body: isLoading
            ? Center(child: CircularProgressIndicator()) // Show loader when data is loading
            : ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState?.openEndDrawer();
                        },
                        child: Icon(Icons.menu_rounded),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed('/app/qr_code_screen');
                        },
                        child: const Icon(Icons.qr_code_scanner_rounded),
                      ),
                    ],
                  ),
                ),
        SizedBox(
    height: 90,
    child: PageView.builder(
    controller: _pageController,
    scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
      int actualIndex = index % 2;

      return Container(
        width: 360,
        margin: EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.asset(
          actualIndex == 0
              ? 'assets/images/slice3.png'
              : 'assets/images/slice4.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    },
    ),
    ),
                SizedBox(height: 30),
                SizedBox(
                  height: 350,
                  child: ProfileCard(
                    profileImageUrl: _profileImageController.text,
                    name: _nameController.text.isNotEmpty
                        ? _nameController.text
                        : 'Nom inconnu',
                    position: _fonctionController.text.isNotEmpty
                        ? _fonctionController.text
                        : 'Fonction inconnue',
                  ),
                ),
                SizedBox(height: 20),
                userQrData == null? SizedBox(
                  width: 293,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      AppRoutes.pushReplacement(
                          context, AppRoutes.appGetOrder);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                           'Commander la carte à 5.000 f cfa',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )

                ) : SizedBox(
                    width: 293,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        AppRoutes.pushReplacement(
                            context, AppRoutes.appGetOrder);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text(
                        'Partager',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )

                ),
                SizedBox(height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _fillProfileData(ProfileData profileData) {
    _nameController.text = profileData.name!;
    _fonctionController.text = profileData.fonction!;
    _entrepriseController.text = profileData.entreprise!;
    _biographieController.text = profileData.biographie!;
    _phoneController.text = profileData.phone!;
    _emailController.text = profileData.email!;
    _localisationController.text = profileData.localisation!;
    _profileImageController.text = profileData.profile_image!;
    print(_profileImageController.text.toString());
  }
}
