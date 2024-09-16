import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  // TextEditingController _controller = TextEditingController(text: 'Texte par défaut sdfvsfa svasdsadds  dfvdsvasdv dcvdsavdsv dvdsvsdvds dfvdsavsdvds dvdsvdsvds sdfvsdvdv  dvdsvsvsdfa dfsddsvsdvds');

  bool _haveCard = true;
  bool _notHaveCard = false;

  String? _password;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  void _nextTab() {
    if (_tabController!.index < _tabController!.length - 1) {
      _tabController!.index++;
    }
  }
  void _backTab() {
    if (_tabController!.index < _tabController!.length - 1) {
      _tabController!.index--;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Créer un compte'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.green,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: 'Niveau 1'),
            Tab(text: 'Niveau 2'),
            Tab(text: 'Niveau 3'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildStepOne(),
          _buildStepTwo(),
          _buildStepThree(),
        ],
      ),

    );
  }

  Widget _buildStepOne() {
    return Padding(
    padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(

            'Detail personnel',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),

          TextFormField(
            decoration: InputDecoration(
              filled: true,  // Assure que le fond est rempli
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),

              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(6.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(6.0),
              ),
              hintText: 'Nom et prenom',
              hintStyle: TextStyle(color: Colors.grey),

            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              filled: true,  // Assure que le fond est rempli
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),

              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(6.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(6.0),
              ),
              hintText: 'Fonction',
              hintStyle: TextStyle(color: Colors.grey),

            ),
          ),
          SizedBox(height: 20),

          TextFormField(
            decoration: InputDecoration(
              filled: true,  // Assure que le fond est rempli
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),

              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(6.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(6.0),
              ),
              hintText: 'Entreprise',
              hintStyle: TextStyle(color: Colors.grey),

            ),
          ),
          SizedBox(height: 20),
          Text(
            'Biographie',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),

          TextFormField(
            maxLines: 5, // Permet plusieurs lignes
            decoration: InputDecoration(
              filled: true,  // Assure que le fond est rempli
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),

              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(6.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(6.0),
              ),
              hintText: 'Decrivez-vous',
              hintStyle: TextStyle(color: Colors.grey),
              // prefixIcon: Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: Icon(Icons.edit, color: Colors.grey),
              // ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer une bio';
              }
              return null;
            },
          ),
      Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Vous n'avez pas de compte?",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                  child: const Text(
                    "Se connecter",
                    style: TextStyle(
                      color: Colors.green,
                      // fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ],
            ),

          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _nextTab,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text('Continuer',

                style: TextStyle(
                fontSize: 16,

                  color: Colors.white
              ), ),
            ),
          ),
        ],

      )
    );
  }

  Widget _buildStepTwo() {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(

                  'Contacts',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),

                TextFormField(

                  decoration: InputDecoration(
                    filled: true,  // Assure que le fond est rempli
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),

                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    hintText: 'Numero',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(Icons.phone, color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une numero';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    filled: true,  // Assure que le fond est rempli
                    fillColor: Colors.white,

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(Icons.email, color: Colors.grey),
                    ),

                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                TextFormField(
                  decoration: InputDecoration(
                    filled: true,  // Assure que le fond est rempli
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),

                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    hintText: 'Localisation',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(Icons.gps_fixed, color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une localisation';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
              ],
            ),

          Column(
            children: [

                  Text(
                    "Vous n'avez pas de compte?",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: const Text(
                      "Se connecter",
                      style: TextStyle(
                        color: Colors.green,
                        // fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),



              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _backTab,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: Text('Retour',

                      style: TextStyle(
                          fontSize: 16,

                          color: Colors.white
                      ), ),
                  ),

                  ElevatedButton(
                    onPressed: _nextTab,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: Text('Continuer',

                      style: TextStyle(
                          fontSize: 16,

                          color: Colors.white
                      ), ),
                  ),
                ],
              ),

            ],
          )



          ],

        )
    );
  }

  Widget _buildStepThree() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child:
                Image.asset('assets/images/card.png', width: 168,height: 140,),

          ),

          Text(
            'Lier ma carte physique',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: _haveCard,  // État de la checkbox
                onChanged: (bool? value) {  // Gérer l'état de la checkbox
                  setState(() {
                    _haveCard = value ?? false;
                  });
                },
              ),
              Text("J'ai une carte physique"),
            ],
          ),
          TextFormField(
            decoration: InputDecoration(
              filled: true,  // Assure que le fond est rempli
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),

              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(6.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(6.0),
              ),
              hintText: 'Inserer le numero de la carte',
              hintStyle: TextStyle(color: Colors.grey),

            ),
          ),
          Row(
            children: [
              Checkbox(
                value: _notHaveCard,  // État de la checkbox
                onChanged: (bool? value) {  // Gérer l'état de la checkbox
                  setState(() {
                    _notHaveCard = value ?? false;
                  });
                },
              ),
              Text("Je n'ai pas de carte physique"),
            ],
          ),
          Divider(
            color: Colors.grey,  // Couleur du trait
            thickness: 1,        // Épaisseur du trait
          ),
          SizedBox(height: 20),

          Row(
            children: [
              Checkbox(
                value: _haveCard,  // État de la checkbox
                onChanged: (bool? value) {  // Gérer l'état de la checkbox
                  setState(() {
                    _haveCard = value ?? false;
                  });
                },
              ),
              Text("Accepter les condition de confidentialité et d’utilisation ", style: TextStyle(
                fontSize: 12,
              ),
              ),
            ],
          ),
          TextFormField(
            maxLines: 5,

            initialValue: 'Accepter les conditions de confidentialité et d’utilisation wefaewfsdf sdfgsdggsdagsdg g grwgwg gw gwr gweg wg wg  g g g wgwrgrgggrwwegweg',  // Texte par défaut
            decoration: InputDecoration(
              enabled: false,
              filled: true,
              fillColor: Colors.white,  // Couleur de fond blanche
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),

              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(6.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(6.0),
              ),
              hintStyle: TextStyle(color: Colors.grey),
            ),
            style: TextStyle(color: Colors.black),  // Style du texte affiché
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _backTab,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text('Retour',

                  style: TextStyle(
                      fontSize: 16,

                      color: Colors.white
                  ), ),
              ),

              ElevatedButton(
                onPressed: ()=>{
                Navigator.of(context).pushNamed('/create_password')
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text('Continuer',

                  style: TextStyle(
                      fontSize: 16,

                      color: Colors.white
                  ), ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
