import 'package:flutter/material.dart';
import 'package:order_app/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Image? imagedrawer;

  const CustomAppBar({super.key, this.imagedrawer});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: AppColors.whiteColor,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {},
        icon: imagedrawer ?? const Text(" "),
      ),
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 23.0),
        child: Image.asset(
          "assets/images/logo.png",
          height: 123,
          width: 123,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
