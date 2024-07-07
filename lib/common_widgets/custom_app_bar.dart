import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Image? imagedrawer;

  const CustomAppBar({Key? key, this.imagedrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {},
        icon: imagedrawer ?? const Text(" "),
      ),
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Image.asset(
          "assets/images/logo.png",
          height: 100,
          scale: 1.5,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}