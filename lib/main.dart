import 'package:alsharq_law_office_app/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lawyers CRM',
      theme: ThemeData(
        primaryColor: Colors.orange,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
        ),
        expansionTileTheme: const ExpansionTileThemeData(
          textColor: Colors.black87,
          iconColor: Colors.black54,
          childrenPadding: EdgeInsets.only(right: 16),
        ),
        textTheme: GoogleFonts.cairoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      locale: const Locale('ar'), // Set Arabic as default locale
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
