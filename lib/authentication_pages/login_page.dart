import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoire/authentication_pages/singup_page.dart';
import 'package:http/http.dart' as http;
import 'package:memoire/global_varibales.dart';
import 'dart:convert';

import 'package:memoire/home_page.dart';
import 'package:memoire/providers/usename_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _message = '';

  Future<void> login() async {
    // Validate form fields

    final username = usernameController.text;
    final password = passwordController.text;

    try {
      // Send POST request with secure HTTPS connection
      final response = await http.post(
        Uri.parse('$urlhttp/login'), // Replace with your server URL
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'username': username, 'password': password}),
      );

      // Handle response
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        setState(() {
          _message = responseBody['message'];
        });

        updateUserProvider(responseBody['user']);
        navigateToHomePage();
      } else {
        final responseBody = jsonDecode(response.body);
        setState(() {
          _message = responseBody['message'];
        });
        showErrorSnackBar(_message);
      }
    } on Exception catch (e) {
      setState(() {
        _message = 'Error: ${e.toString()}';
      });
    }
  }

  bool areFieldsFilled() {
    return usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void updateUserProvider(dynamic userDetails) {
    Provider.of<UsernameProvider>(context, listen: false)
        .changename(details: userDetails);
  }

  void navigateToHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color.fromRGBO(0, 0, 0, 0.5),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(10),
    );
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 237, 237, 0.949),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo-no-background.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Salut , Bienvenue",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "sur ShopX",
                    style: Theme.of(context).textTheme.displayLarge,
                  )
                ],
              ),
            ),
            /***************************************************** */
            const Spacer(),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Connecter à votre compte",
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        size: 18,
                      ),
                      hintText: "Username",
                      border: border,
                      focusedBorder: border,
                      enabledBorder: border,
                      hintStyle: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        size: 18,
                      ),
                      hintText: "Mot de passe",
                      border: border,
                      focusedBorder: border,
                      enabledBorder: border,
                      hintStyle: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (areFieldsFilled()) {
                        login();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Completer tous les information svp"),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greenColor,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "T'as pas un compte?",
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SingupPage()),
                    );
                  },
                  child: Text(
                    "Creer compte",
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: greenColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
