import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoire/authentication_pages/login_page.dart';
import 'package:memoire/global_varibales.dart';
import 'package:memoire/principale_pages/favorite_page.dart';
import 'package:memoire/providers/favorite_provider.dart';
import 'package:memoire/providers/language_provider.dart';
import 'package:memoire/providers/posts_provider.dart';
import 'package:memoire/providers/usename_provider.dart';
import 'package:memoire/welcoming_pages/welcome_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //final languagechosen =
    //Provider.of<LanguageProvider>(context, listen: false).language;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UsernameProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PostsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LanguageProvider(),
        ),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return MaterialApp(
            routes: {
              '/login': (context) => const LoginPage(),
            },
            locale: languageProvider.locale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
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
              bottomAppBarTheme: const BottomAppBarTheme(
                  color: Color.fromARGB(255, 13, 51, 82)),
            ),
            home: const WelcomePage(),
          );
        },
      ),
    );
  }
}
