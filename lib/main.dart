// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_app/screens/order_screen.dart';
import 'package:order_app/screens/order_screen_one.dart';
import 'package:order_app/screens/order_screen_typed.dart';
import 'package:order_app/screens/ordr_settings.dart';
// import 'package:order_app/screens/order_screen.dart';

void main() {
  runApp(const MyApp());
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
      home: OrderScreenTyped(),
    );
  }
}
