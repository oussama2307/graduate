import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:memoire/global_varibales.dart';
import 'package:memoire/home_page.dart';
import 'package:memoire/providers/usename_provider.dart';
import 'package:provider/provider.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({super.key});

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();

  Future<void> registerUser(
      String name, String username, String password) async {
    if (username.contains(' ')) {
      showErrorSnackBar(
          "Votre nom d'utilisateur ne doit pas contenir d'espaces.");
      return;
    }
    final url = Uri.parse('$urlhttp/register');
    final response = await http.post(
      url,
      body: jsonEncode(
          {'name': name, 'username': username, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      updateUserProvider(responseBody['user']);
      navigateToHomePage();
    } else if (response.statusCode == 409) {
      final responseBody = jsonDecode(response.body);
      showErrorSnackBar(responseBody['message']);
    }
  }

  bool areFieldsFilled() {
    return usernameController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmpassController.text.isNotEmpty;
  }

  bool areSame() {
    return passwordController.text == confirmpassController.text;
  }

  void updateUserProvider(dynamic userDetails) {
    Provider.of<UsernameProvider>(context, listen: false)
        .changename(details: userDetails);
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void navigateToHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  bool passwordStrong() {
    return passwordController.text.length >= 8;
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
          child: ListView(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    child: const Icon(
                      Icons.arrow_back_outlined,
                      color: Color.fromARGB(255, 13, 51, 82),
                    ),
                  )
                ],
              ),
              Center(
                child: Image.asset(
                  'assets/images/logo-no-background.png',
                  width: 150,
                  height: 150,
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
                      "Creer votre propre compte",
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFIeld(
                      detail: "Nom",
                      icon: const Icon(
                        Icons.person,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        size: 16,
                      ),
                      target: nameController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFIeld(
                      detail: "Username",
                      icon: const Icon(
                        Icons.person,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        size: 16,
                      ),
                      target: usernameController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        hintText: "Mot de passe",
                        border: border,
                        focusedBorder: border,
                        enabledBorder: border,
                        hintStyle: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromRGBO(0, 0, 0, 0.5)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      obscureText: true,
                      controller: confirmpassController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        hintText: "Confirmer mot de passe",
                        border: border,
                        focusedBorder: border,
                        enabledBorder: border,
                        hintStyle: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: areSame()
                              ? const Color.fromRGBO(0, 0, 0, 0.5)
                              : Colors.red,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              /**************************************************** */
              ElevatedButton(
                onPressed: () {
                  if (areFieldsFilled()) {
                    if (passwordStrong()) {
                      if (areSame()) {
                        registerUser(
                          nameController.text,
                          usernameController.text,
                          passwordController.text,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Confirmer votre mot de passe correctement svp"),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Votre mot de passe doit contenir au moins 8 caractères."),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Completer tous les informations svp"),
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
                  "SignUp",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class TextFIeld extends StatefulWidget {
  final TextEditingController target;
  final String detail;
  final Icon icon;
  const TextFIeld({
    super.key,
    required this.detail,
    required this.icon,
    required this.target,
  });

  @override
  State<TextFIeld> createState() => _TextFIeldState();
}

class _TextFIeldState extends State<TextFIeld> {
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
    return TextField(
      controller: widget.target,
      decoration: InputDecoration(
        prefixIcon: widget.icon,
        hintText: widget.detail,
        border: border,
        focusedBorder: border,
        enabledBorder: border,
        hintStyle: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: const Color.fromRGBO(0, 0, 0, 0.5),
        ),
      ),
    );
  }
}
