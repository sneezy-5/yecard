// import 'package:flutter/material.dart';
//
// import '../../../widgets/app_bar.dart';
//
//
// class ContactsScreen extends StatelessWidget {
//   final List<Map<String, String>> recentContacts = [
//     {'name': 'Daniel', 'role': 'Chef de Chantier', 'avatar': 'avatar1.png'},
//     {'name': 'Frank', 'role': 'Producteur', 'avatar': 'avatar2.png'},
//     {'name': 'Lisa', 'role': 'Mannequin', 'avatar': 'avatar3.png'},
//     {'name': 'Richard', 'role': 'Photographe', 'avatar': 'avatar4.png'},
//   ];
//
//   final List<Map<String, String>> members = [
//     {'name': 'KOULOU', 'role': 'Chef De Chantier', 'avatar': 'assets/koulou.png'},
//     {'name': 'Adjoua', 'role': 'Femme De Ménage', 'avatar': 'assets/adjoua.png'},
//     {'name': 'Traoré', 'role': 'CEO CordonnierCl', 'avatar': 'assets/traore.png'},
//     {'name': 'Couple koffi', 'role': 'Décoratrice', 'avatar': 'assets/koffi.png'},
//     {'name': 'Mr Zokou', 'role': 'Entrepreneur Développeur', 'avatar': 'assets/zokou.png'},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:  ReusableAppBar(
//         title: 'Relation',
//         showBackButton: true,
//         customBackIcon: Icons.arrow_back_ios,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.edit),
//             color: Colors.white,
//             onPressed: () {
//               print('edit button pressed');
//             },
//           ),
//         ],
//       ),
//
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Search bar
//             TextField(
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.blue.shade50,
//                 hintText: 'Rechercher Des Membre Par Nom Ou Activité',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//
//             // Recent contacts
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Recent',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     // Action Voir Plus
//                   },
//                   child: Text('Voir Plus'),
//                 ),
//               ],
//             ),
//             SizedBox(height: 8),
//             Container(
//               height: 80,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: recentContacts.length,
//                 itemBuilder: (context, index) {
//                   final contact = recentContacts[index];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Column(
//                       children: [
//                         CircleAvatar(
//                           radius: 30,
//                           backgroundImage: AssetImage(contact['avatar']!),
//                         ),
//                         // SizedBox(height: 4),
//                         Text(contact['name']!),
//                         // Text(
//                         //   contact['role']!,
//                         //   style: TextStyle(fontSize: 12, color: Colors.grey),
//                         // ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 16),
//
//             // List of members
//             Text(
//               '1500 Membres',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: members.length,
//                 itemBuilder: (context, index) {
//                   final member = members[index];
//                   return ListTile(
//                     leading: CircleAvatar(
//                       backgroundImage: AssetImage(member['avatar']!),
//                     ),
//                     title: Text(member['name']!),
//                     subtitle: Text(member['role']!),
//                     trailing: Icon(Icons.more_vert),
//                     onTap: () {
//
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import '../../../widgets/app_bar.dart';
// import 'package:yecard/services/contact_service.dart';
//
// class ContactsScreen extends StatefulWidget {
//   @override
//   _ContactsScreenState createState() => _ContactsScreenState();
// }
//
// class _ContactsScreenState extends State<ContactsScreen> {
//   late Future<Map<String, dynamic>> _futureContacts;
//   ContactService contactService = ContactService();
//
//
//   @override
//   void initState() {
//     super.initState();
//     _futureContacts = contactService.getContacts();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: ReusableAppBar(
//         title: 'Relation',
//         // showBackButton: true,
//         customBackIcon: Icons.arrow_back_ios,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add_circle_outline),
//             color: Colors.white,
//             onPressed: () {
//               Navigator.of(context)
//                   .pushNamed('/app/qr_code_screen');            },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Search bar
//             TextField(
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.blue.shade50,
//                 hintText: 'Rechercher Des Membre Par Nom Ou Activité',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//
//             // FutureBuilder to display contacts from API
//             FutureBuilder<Map<String, dynamic>>(
//               future: _futureContacts,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Erreur : ${snapshot.error}'));
//                 } else if (!snapshot.hasData || !(snapshot.data!['success'] || snapshot.data!['data'] == [])) {
//                   return Center(child: Text('Aucune donnée disponible'));
//                 }
//
//                 final contacts = snapshot.data!['data'] as List<dynamic>;
//
//                 return Expanded(
//                   child: ListView.builder(
//                     itemCount: contacts.length,
//                     itemBuilder: (context, index) {
//                       final contact = contacts[index];
//                       return ListTile(
//                         leading: CircleAvatar(
//                           backgroundImage: NetworkImage(contact['to_user']['profile_image'] ?? ''),
//                         ),
//                         title: Text(contact['to_user'] ['name']?? 'Unknown'),
//                         subtitle: Text(contact['to_user'] ['fonction']?? 'Unknown role'),
//                         trailing: Icon(Icons.more_vert),
//                         onTap: () {
//                           Navigator.of(context).pushNamed('/app/contact_profile',
//                               arguments: {
//                                 'id': contact['to_user']['id'],
//                               });
//                         },
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../widgets/app_bar.dart';
import 'package:yecard/services/contact_service.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<dynamic> _contacts = [];
  bool _isLoadingMore = false;
  int _currentPage = 0;
  bool _hasMore = true;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  ContactService contactService = ContactService();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchContacts();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
          !_isLoadingMore &&
          _hasMore) {
        _fetchContacts();
      }
    });

    _searchController.addListener(() {
      _searchQuery = _searchController.text;
      if (_searchQuery.isEmpty) {
        _resetAndFetchContacts();
      } else {
        _resetAndFetchContacts(query: _searchQuery);
      }
    });
  }

  Future<void> _fetchContacts() async {
    setState(() {
      _isLoadingMore = true;
    });

    try {
      final response = await contactService.getContacts(page: _currentPage, query: _searchQuery);

      if (response['success']) {
        setState(() {
          if (_currentPage == 0) _contacts.clear(); // Efface les contacts pour la recherche
          _contacts.addAll(response['data']);
          _currentPage++;
          _hasMore = response['data'].isNotEmpty;
        });
      }
    } catch (e) {
      print('Erreur : $e');
    } finally {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  void _resetAndFetchContacts({String query = ''}) {
    setState(() {
      _contacts.clear();
      _currentPage = 0;
      _hasMore = true;
      _searchQuery = query;
    });
    _fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        title: 'Relation',
        showBackButton: false,
        customBackIcon: Icons.arrow_back_ios,
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed('/app/qr_code_screen');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue.shade50,
                hintText: 'Rechercher Des Membre Par Nom Ou Activité',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),

            // List of contacts with pagination and search
            Expanded(
              child: _contacts.isEmpty && !_isLoadingMore
                  ? Center(child: Text('Aucun résultat trouvé'))
                  : ListView.builder(
                controller: _scrollController,
                itemCount: _contacts.length + (_isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _contacts.length) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final contact = _contacts[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(contact['to_user']['profile_image'] ?? ''),
                    ),
                    title: Text(contact['to_user']['name'] ?? 'Inconnu'),
                    subtitle: Text(contact['to_user']['fonction'] ?? 'Rôle inconnu'),
                    trailing: Icon(Icons.more_vert),
                    onTap: () {
                      Navigator.of(context).pushNamed('/app/contact_profile', arguments: {
                        'id': contact['to_user']['id'],
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
