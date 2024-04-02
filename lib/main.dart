import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoire/global_varibales.dart';
import 'package:memoire/principale_pages/favorite_page.dart';
import 'package:memoire/providers/favorite_provider.dart';
import 'package:memoire/providers/usename_provider.dart';
import 'package:memoire/welcoming_pages/welcome_page.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UsernameProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(),
        ),
      ],
      child: MaterialApp(
        title: "Projet D'etude",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.roboto().fontFamily,
          textTheme: TextTheme(
            displayLarge: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: greenColor,
            ),
          ),
          snackBarTheme: const SnackBarThemeData(
            backgroundColor: Colors.green,
            contentTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            behavior: SnackBarBehavior.floating,
            elevation: 6.0,
          ),
          bottomAppBarTheme:
              const BottomAppBarTheme(color: Color.fromARGB(255, 13, 51, 82)),
        ),
        home: const WelcomePage(),
      ),
    );
  }
}
