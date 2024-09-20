// import 'package:flutter/material.dart';
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
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(
//           'Relation',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add, color: Colors.black),
//             onPressed: () {
//               // Action to add new contact
//             },
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
//                           backgroundImage: AssetImage(contact['avatar']!), // Replace with actual assets
//                         ),
//                         SizedBox(height: 4),
//                         Text(contact['name']!),
//                         Text(
//                           contact['role']!,
//                           style: TextStyle(fontSize: 12, color: Colors.grey),
//                         ),
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
//                       backgroundImage: AssetImage(member['avatar']!), // Replace with actual assets
//                     ),
//                     title: Text(member['name']!),
//                     subtitle: Text(member['role']!),
//                     trailing: Icon(Icons.more_vert),
//                     onTap: () {
//                       // Action when tapping on the member
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: 1, // Set the default selected tab
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.credit_card),
//             label: 'Cartes',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.contacts),
//             label: 'Contacts',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.qr_code),
//             label: 'Code Qr',
//           ),
//         ],
//         onTap: (index) {
//           // Action on tapping a tab
//         },
//       ),
//     );
//   }
// }
