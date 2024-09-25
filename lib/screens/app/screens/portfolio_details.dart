import 'package:flutter/material.dart';

import '../../../routes.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/detail_widget.dart';

class PortfolioDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  ReusableAppBar(
        title: '',
        showBackButton: true,
        customBackIcon: Icons.arrow_back_ios,
        actions: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.white,
              onPressed: () {
                AppRoutes.pushReplacement(context, AppRoutes.appAddPortfolio);
              },
            ),
        ],
      ),
      body: Center(
        child: DetailScreen(
          title: 'Mon Portfolio',
          description: 'Voici une description détaillée de mon portfolio. Il peut contenir des projets, des expériences, et plus encore. wswdWD WDKWLDKLW efkewfewf FKEWFWEFKEKWF WEFKWEFMLWEKFE FEMWLFKWEFKLE lefm,ewdfmewf wefkwe fmefwwe  ewfnlwfwnkf',
          photos: [
            'https://cdn.shopify.com/static/sample-images/bath_grande_crop_center.jpeg',
            'https://cdn.shopify.com/static/sample-images/bath_grande_crop_center.jpeg',
            'https://cdn.shopify.com/static/sample-images/bath_grande_crop_center.jpeg',
          ],
        ),
      ),

    );
  }
}
