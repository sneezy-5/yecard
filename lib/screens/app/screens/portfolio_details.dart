// import 'package:flutter/material.dart';
//
// import '../../../routes.dart';
// import '../../../widgets/app_bar.dart';
// import '../../../widgets/detail_widget.dart';
//
// class PortfolioDetailScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:  ReusableAppBar(
//         title: '',
//         showBackButton: true,
//         customBackIcon: Icons.arrow_back_ios,
//         actions: [
//             IconButton(
//               icon: Icon(Icons.edit),
//               color: Colors.white,
//               onPressed: () {
//                 AppRoutes.pushReplacement(context, AppRoutes.appAddPortfolio);
//               },
//             ),
//         ],
//       ),
//       body: Center(
//         child: DetailScreen(
//           title: 'Mon Portfolio',
//           description: 'Voici une description détaillée de mon portfolio. Il peut contenir des projets, des expériences, et plus encore. wswdWD WDKWLDKLW efkewfewf FKEWFWEFKEKWF WEFKWEFMLWEKFE FEMWLFKWEFKLE lefm,ewdfmewf wefkwe fmefwwe  ewfnlwfwnkf',
//           photos: [
//             'https://cdn.shopify.com/static/sample-images/bath_grande_crop_center.jpeg',
//             'https://cdn.shopify.com/static/sample-images/bath_grande_crop_center.jpeg',
//             'https://cdn.shopify.com/static/sample-images/bath_grande_crop_center.jpeg',
//           ],
//         ),
//       ),
//
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../routes.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/detail_widget.dart';

class PortfolioDetailScreen extends StatelessWidget {
  final Map<String, dynamic>? args;

  // Constructor to retrieve args
  PortfolioDetailScreen({Key? key, this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: ReusableAppBar(
        title: '',
        showBackButton: true,
        customBackIcon: Icons.arrow_back_ios,
        actions: [
          // IconButton(
          //   icon: Icon(Icons.edit),
          //   color: Colors.white,
          //   onPressed: () {
          //     AppRoutes.pushReplacement(context, AppRoutes.appAddPortfolio);
          //   },
          // ),
        ],
      ),
      body: Center(
        child:DetailScreen(
          title: args?['title'] ?? 'Not data',
          description: args?['description'] ?? 'Not data',
          mot_de_fin: args?['mot_de_fin'] ?? 'Not data',
          photos: [
            args?['file_1'],
            args?['file_2'],
            args?['file_3'],
          ].where((file) => file != null).toList(),
        ),

      ),
    );
  }
}
