import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoire/global_varibales.dart';

class ConfidencePage extends StatelessWidget {
  const ConfidencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20,
                ),
              ),
              Text(
                "Confidentialité",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const Text(
                "monrofile",
                style: TextStyle(color: greyColor),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Politique de confidentialité :",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: 19,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Principaltext(mytext: "Informations que nous collectons:"),
          const SizedBox(
            height: 10,
          ),
          const Secondarytext(
            mytext:
                "Lorsque vous utilisez notre application ou nos services, nous pouvons collecter les informations suivantes auprès de vous :Informations personnelles : cela inclut votre nom, votre adresse e-mail, votre numéro de téléphone et d'autres informations que vous nous fournissez lorsque vous vous inscrivez à nos services. Usage information: This includes information about how you use our website and services, including your IP address, browser type, and the pages you visit",
          ),
          const SizedBox(
            height: 20,
          ),
          const Principaltext(
              mytext: "Comment nous utilisons vos informations :"),
          const SizedBox(
            height: 10,
          ),
          const Secondarytext(
            mytext:
                "Nous utilisons vos informations personnelles pour vous fournir nos services, pour communiquer avec vous à propos de nos services et pour améliorer nos services. Nous pouvons également utiliser vos informations pour vous envoyer des communications marketing, si vous avez choisi de les recevoir. Nous utilisons les informations d'utilisation pour analyser la façon dont notre site Web et nos services sont utilisés, pour diagnostiquer les problèmes avec notre application et nos services, et pour améliorer notre application et nos services.",
          ),
          const SizedBox(
            height: 20,
          ),
          const Principaltext(
              mytext: "Comment nous protégeons vos informations :"),
          const SizedBox(
            height: 10,
          ),
          const Secondarytext(
            mytext:
                "Nous utilisons des mesures de sécurité raisonnables pour protéger vos informations personnelles contre tout accès, utilisation ou divulgation non autorisés. Cependant, aucune méthode de transmission sur Internet ou méthode de stockage électronique n'est sécurisée à 100 %, et nous ne pouvons garantir la sécurité absolue de vos informations personnelles.",
          ),
          const SizedBox(
            height: 20,
          ),
          const Principaltext(mytext: "Partage d'informations :"),
          const SizedBox(
            height: 10,
          ),
          const Secondarytext(
            mytext:
                "Nous ne vendons, ne louons ni ne partageons vos informations personnelles avec des tiers, sauf tel que décrit dans la présente politique de confidentialité. Nous pouvons partager vos informations personnelles avec nos fournisseurs de services qui ont besoin d'accéder à vos informations personnelles pour nous fournir des services. Nous pouvons également partager vos informations personnelles si nous pensons de bonne foi que la divulgation est nécessaire pour se conformer à la loi, à la réglementation, à la procédure judiciaire ou à la demande gouvernementale en vigueur.",
          ),
          const SizedBox(
            height: 20,
          ),
          const Principaltext(mytext: "Vos droits :"),
          const SizedBox(
            height: 10,
          ),
          const Secondarytext(
            mytext:
                "Vous avez le droit d'accéder, de corriger ou de supprimer vos informations personnelles que nous détenons à votre sujet. Vous pouvez également avoir le droit de vous opposer ou de restreindre le traitement de vos informations personnelles et de recevoir une copie de vos informations personnelles dans un format structuré et lisible par machine.",
          ),
          const SizedBox(
            height: 20,
          ),
          const Principaltext(mytext: "Modifications de cette politique"),
          const SizedBox(
            height: 10,
          ),
          const Secondarytext(
            mytext:
                "Nous pouvons mettre à jour cette politique de confidentialité de temps à autre. Si nous apportons des modifications importantes à cette politique de confidentialité, nous vous en informerons par e-mail ou en publiant un avis sur notre application.",
          ),
          const SizedBox(
            height: 20,
          ),
          const Principaltext(mytext: "Contactez-nous"),
          const Secondarytext(
            mytext:
                "Si vous avez des questions ou des préoccupations concernant cette politique de confidentialité, ou si vous souhaitez exercer vos droits concernant vos informations personnelles, veuillez nous contacter via ce site Web, l'application mobile ou les coordonnées ci-dessus.",
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class Principaltext extends StatelessWidget {
  final String mytext;
  const Principaltext({
    super.key,
    required this.mytext,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      mytext,
      style: GoogleFonts.roboto(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: greenColor,
      ),
    );
  }
}

class Secondarytext extends StatelessWidget {
  final String mytext;
  const Secondarytext({
    super.key,
    required this.mytext,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      mytext,
      style: GoogleFonts.roboto(
        fontSize: 16,
        color: const Color.fromRGBO(0, 0, 0, 0.4),
      ),
    );
  }
}
