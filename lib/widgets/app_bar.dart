import 'package:flutter/material.dart';

import '../routes.dart';

class ReusableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final List<Widget>? actions;
  final TabBar? bottom;
  final IconData? customBackIcon;
  // Constructor
  ReusableAppBar({
    required this.title,
    this.showBackButton = true,
    this.actions,
     this.bottom,
    this.customBackIcon

  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: showBackButton,
      leading: showBackButton
          ? IconButton(
        icon: Icon(customBackIcon ?? Icons.arrow_back),
        color: Colors.white,
        onPressed: () {
          // Navigator.of(context).pop();
          AppRoutes.pushReplacement(context, AppRoutes.appHome);

        },
      )
          : null,
      title: Text(
        title!,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
