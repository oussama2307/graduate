import 'package:flutter/material.dart';

const greenColor = Color.fromARGB(255, 34, 112, 36);
const greyColor = Color.fromRGBO(241, 237, 237, 0.949);
List<String> algeriaCities = [
  'Adrar',
  'Chlef',
  'Laghouat',
  'Oum El Bouaghi',
  'Batna',
  'Béjaïa',
  'Biskra',
  'Béchar',
  'Blida',
  'Bouira',
  'Tamanrasset',
  'Tébessa',
  'Tlemcen',
  'Tiaret',
  'Tizi Ouzou',
  'Algiers',
  'Djelfa',
  'Jijel',
  'Sétif',
  'Saïda',
  'Skikda',
  'Sidi Bel Abbès',
  'Annaba',
  'Guelma',
  'Constantine',
  'Médéa',
  'Mostaganem',
  'M\'Sila',
  'Mascara',
  'Ouargla',
  'Oran',
  'El Bayadh',
  'Illizi',
  'Bordj Bou Arreridj',
  'Boumerdès',
  'El Tarf',
  'Tindouf',
  'Tissemsilt',
  'El Oued',
  'Khenchela',
  'Souk Ahras',
  'Tipaza',
  'Mila',
  'Aïn Defla',
  'Naâma',
  'Aïn Témouchent',
  'Ghardaïa',
  'Relizane',
];
final posts = [
  {
    "id": 1,
    "type": "Location",
    "imageurl": "assets/images/tractor1.jpg",
    "soustype": "Equipement",
    "description": "jamais utiliser , etat 9/10",
    "username": "Oussama",
  },
  {
    "id": 1,
    "type": "Location",
    "imageurl": "assets/images/tractor1.jpg",
    "soustype": "Equipement",
    "description": "jamais utiliser , etat 9/10",
    "username": "Oussama",
  },
  {
    "id": 1,
    "type": "Location",
    "imageurl": "assets/images/tractor1.jpg",
    "soustype": "Equipement",
    "description": "jamais utiliser , etat 9/10",
    "username": "Oussama",
  },
];

final Filters = [
  {
    "name": "Vente",
    "icon": const Icon(Icons.shopping_cart),
  },
  {
    "name": "Location",
    "icon": const Icon(Icons.home),
  },
  {
    "name": "Chercher",
    "icon": const Icon(Icons.search_outlined),
  },
  {
    "name": "Tout",
    "icon": const Icon(Icons.play_arrow),
  },
];

const List<String> languages = ["fr", "ar", "en"];
const String urlhttp = 'http://192.168.1.38:3000';
