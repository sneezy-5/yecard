// import 'package:flutter/material.dart';
//
// import '../../../repositories/portfolio_repository.dart';
// import '../../../routes.dart';
// import '../../../services/portfolio_service.dart';
// import '../../../widgets/app_bar.dart';
// import '../../../widgets/detail_widget.dart';
//
// class PortfolioDetailScreen extends StatelessWidget {
//   final Map<String, dynamic>? args;
//
//   // Constructor to retrieve args
//   PortfolioDetailScreen({Key? key, this.args}) : super(key: key);
//   final PortfolioRepository _portfolioRepository = PortfolioRepository(PortfolioService());
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: ReusableAppBar(
//         title: '',
//         showBackButton: true,
//         customBackIcon: Icons.arrow_back_ios,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.edit),
//             color: Colors.white,
//             onPressed: () {
//
//               Navigator.of(context).pushNamed(
//                 '/app/portfolio_edit',
//                 arguments: {
//                   'id': args?['id'],
//                   'title': args?['title'],
//                   'description': args?['description'],
//                   'mot_de_fin': args?['mot_de_fin'],
//                   'file_1': args?['file_1'],
//                   'file_2': args?['file_2'],
//                   'file_3': args?['file_3']
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child:DetailScreen(
//           title: args?['title'] ?? 'Not data',
//           description: args?['description'] ?? 'Not data',
//           mot_de_fin: args?['mot_de_fin'] ?? 'Not data',
//           photos: [
//             args?['file_1'],
//             args?['file_2'],
//             args?['file_3'],
//           ].where((file) => file != null).toList(),
//         ),
//
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../../../repositories/portfolio_repository.dart';
import '../../../routes.dart';
import '../../../services/portfolio_service.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/detail_widget.dart';

class PortfolioDetailScreen extends StatelessWidget {
  final Map<String, dynamic>? args;
  final PortfolioRepository _portfolioRepository = PortfolioRepository(PortfolioService());

  PortfolioDetailScreen({Key? key, this.args}) : super(key: key);

  Future<Map<String, dynamic>?> _fetchPortfolioDetail() async {
    final id = args?['id'];
    if (id != null) {
      return await _portfolioRepository.portfoliobyId(id);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        title: '',
        showBackButton: true,
        customBackIcon: Icons.arrow_back_ios,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/app/portfolio_edit',
                arguments: args,
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchPortfolioDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data available'));
          }

          final data = snapshot.data!['data'];
          return Center(
            child: DetailScreen(
              title: data['title'] ?? 'No data',
              description: data['description'] ?? 'No data',
              mot_de_fin: data['mot_de_fin'] ?? 'No data',
              photos: [
                data['file_1'],
                data['file_2'],
                data['file_3'],
              ].where((file) => file != null).toList(),
            ),
          );
        },
      ),
    );
  }
}
