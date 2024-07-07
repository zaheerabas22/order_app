import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_app/controller/product_controller.dart';
import 'package:order_app/screens/order_screen_one.dart';

void main() async {
  await injectControllers().then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Order App',
      theme: ThemeData(
        textTheme: GoogleFonts.publicSansTextTheme(),
      ),
      home: const OrderScreenNoTyped(),
    );
  }
}

Future injectControllers() async {
  Get.put(ProductController());
}
