import 'package:flutter/material.dart';
import 'package:sayakaya_test/const/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    super.key,
    this.title = 'Covid Tracker',
  });

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: Text(title),
      elevation: 0,
      backgroundColor: kDarkGreyColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
