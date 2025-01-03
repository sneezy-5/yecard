import 'package:flutter/material.dart';

import '../../../widgets/app_bar.dart';
import '../../../widgets/detail_widget.dart';

class PortfolioDetailAddScreen extends StatelessWidget {
  final Map<String, dynamic>? args;

  // Constructor to retrieve args
  PortfolioDetailAddScreen({Key? key, this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: ReusableAppBar(
        title: '',
        showBackButton: true,
        customBackIcon: Icons.arrow_back_ios,
        actions: [

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
