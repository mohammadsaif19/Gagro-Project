import 'package:flutter/material.dart';
import 'package:gagro/Home/home.dart';
import 'package:gagro/Login/login.dart';
import 'package:gagro/Profile/profile.dart';
import 'package:gagro/Test/test.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      ),
      home: Login(),
    );
  }
}
