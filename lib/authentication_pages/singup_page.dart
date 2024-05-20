import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:memoire/constants/utils.dart';
import 'package:memoire/generated/l10n.dart';
import 'dart:convert';
import 'package:memoire/global_varibales.dart';

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
      Utils.showErrorSnackBar(
        context,
        "Votre nom d'utilisateur ne doit pas contenir d'espaces.",
      );
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

      Utils.updateUserProvider(context, responseBody['user']);
      Utils.navigateToHomePage(context);
    } else if (response.statusCode == 409) {
      final responseBody = jsonDecode(response.body);
      Utils.showErrorSnackBar(context, responseBody['message']);
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmpassController.dispose();
    super.dispose();
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
                  'assets/images/logo_3.png',
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
                      S.of(context).signup_page_text1,
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
                      detail: S.of(context).signup_page_nom,
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
                      detail: S.of(context).signup_page_Username,
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
                        hintText: S.of(context).signup_page_password,
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
                        hintText: S.of(context).signup_page_confirming,
                        border: border,
                        focusedBorder: border,
                        enabledBorder: border,
                        hintStyle: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Utils.areSame(
                                  passwordController, confirmpassController)
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
                  if (Utils.areFieldsFilledSignUp(
                      usernameController,
                      nameController,
                      passwordController,
                      confirmpassController)) {
                    if (Utils.passwordStrong(passwordController)) {
                      if (Utils.areSame(
                        passwordController,
                        confirmpassController,
                      )) {
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
                  S.of(context).signup_page_button,
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
