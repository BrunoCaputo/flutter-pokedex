import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './pages/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pokédex',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
        useMaterial3: true,
        fontFamily: 'Roboto',
        primaryColor: const Color(0xFFDC0A2D),
        textTheme: TextTheme(
          headlineMedium: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            wordSpacing: 8,
            color: Colors.white,
          ),
        ),
        extensions: const [],
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
        useMaterial3: true,
        primaryColor: const Color(0xFFDC0A2D),
        textTheme: TextTheme(
          headlineMedium: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            wordSpacing: 8,
            color: Colors.white,
          ),
        ),
        extensions: const [],
      ),
      home: const HomePage(title: 'Flutter Pokédex'),
      debugShowCheckedModeBanner: false,
    );
  }
}
