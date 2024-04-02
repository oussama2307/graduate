import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoire/global_varibales.dart';
import 'package:memoire/widgets/appbar_widget.dart';

class ContactRightPage extends StatelessWidget {
  const ContactRightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: greyColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      height: 600,
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                "Tous les droits de développement et de publication sont réservés au développeur et à l'encadrant, Dr. Kherici.",
                style: GoogleFonts.roboto(
                  color: const Color.fromRGBO(0, 0, 0, 0.4),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Color.fromRGBO(0, 0, 0, 0.4),
              ),
              const SizedBox(
                height: 20,
              ),
              const Contact(
                icon: Ionicons.logo_instagram,
                username: "ouss_ama___",
              ),
              const SizedBox(
                height: 10,
              ),
              const Contact(
                icon: Ionicons.logo_facebook,
                username: "Oussama Souici",
              ),
              const SizedBox(
                height: 20,
              ),
              const Contact(
                icon: Ionicons.logo_github,
                username: "oussama2307",
              ),
              const SizedBox(
                height: 20,
              ),
              const Contact(
                icon: Icons.mail,
                username: "oussamasafouanesouici@gmail.com",
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Color.fromRGBO(0, 0, 0, 0.4),
              ),
              const SizedBox(
                height: 20,
              ),
              const Contact(
                icon: Icons.mail,
                username: "nada.kherici@hotmail.fr",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Contact extends StatelessWidget {
  final IconData icon;
  final String username;
  const Contact({
    super.key,
    required this.icon,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color.fromRGBO(0, 0, 0, 0.4),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
          child: Text(
            username,
            style: GoogleFonts.roboto(
              color: const Color.fromRGBO(0, 0, 0, 0.4),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
