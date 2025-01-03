
import 'package:flutter/material.dart';
import '../../../services/contact_service.dart';
import '../../../widgets/app_bar.dart';

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
