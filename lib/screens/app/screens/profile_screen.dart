import 'package:flutter/material.dart';
import '../../../routes.dart';
import '../../../widgets/app_bar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isOnPortfolioTab = false;

  bool _isEditing = false;
  TextEditingController _bioController = TextEditingController(text: 'dwfwefwfwefwefwefwefw wef wef wefkwefkle ewfwelfwe slfwe wfwksav ewfwkfwnfwe wdslwelsfw efw wsvnkwfwefw');
  TextEditingController _emailController = TextEditingController(text: 'Email');
  TextEditingController _phoneController = TextEditingController(text: 'Phone');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);


    _tabController.addListener(() {
      setState(() {
        _isOnPortfolioTab = _tabController.index == 1;
        print('on est sur portfolio');
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _bioController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
          if (_isOnPortfolioTab)
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              color: Colors.white,
              onPressed: () {
                AppRoutes.pushReplacement(context, AppRoutes.appAddPortfolio);

              },
            ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  // Image de couverture
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
                            // SizedBox(height: 120),
                            Text(
                              "Koffi Yohann",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Homme de média",
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
              // SizedBox(height: 10),
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
              ? _buildEditableTextField(_bioController, 5)
              : _buildReadOnlyTextField(_bioController.text),
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
              ? _buildEditableTextField(_phoneController, 1)
              : _buildReadOnlyTextField(_phoneController.text),
          SizedBox(height: 10),

          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Domicile'),
            onTap: () {

            },
          ),
          _isEditing
              ? _buildEditableTextField(_phoneController, 1)
              : _buildReadOnlyTextField(_phoneController.text),
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
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 2,
        ),
        itemCount: 20,
        itemBuilder: (context, index) {
          return  GestureDetector(
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
                    'Item ${index + 1}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          );

        },
      ),
    );
  }


  Widget _buildEditableTextField(TextEditingController controller,int maxlines) {
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
    return Text(text);
  }
}
