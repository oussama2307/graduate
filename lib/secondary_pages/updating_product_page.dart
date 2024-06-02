import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoire/constants/utils.dart';
import 'package:memoire/generated/l10n.dart';
import 'package:memoire/global_varibales.dart';
import 'package:http/http.dart' as http;

class UpadatePage extends StatefulWidget {
  final dynamic product;
  const UpadatePage({
    super.key,
    required this.product,
  });

  @override
  State<UpadatePage> createState() => _UpadatePageState();
}

class _UpadatePageState extends State<UpadatePage> {
  TextEditingController typeController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  TextEditingController disponibleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  List<String> types = ["Vente", "Location", "Chercher", "Autre"];
  List<String> soustype = ["Equipement", "Surface", "Information", "Autre"];
  List<String> disponibilite = ["Disponible", "Indisponible"];
  String? selected;
  String? selected2;
  String? selected3;

  Future<void> updatepost({
    required id,
    required type,
    required service,
    required description,
    required price,
    required disponibilite,
  }) async {
    final response = await http.post(
      Uri.parse('$urlhttp/update_post'), // Replace with your server URL
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'post_id': id,
        'type': type,
        'service': service,
        'description': description,
        'price': price,
        'disponibilité': disponibilite,
      }),
    );
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print(responseBody['message']);
      Utils.showErrorSnackBar(context, responseBody['message']);
    } else {
      final responseBody = jsonDecode(response.body);
      print(responseBody['message']);
    }
  }

  @override
  void initState() {
    super.initState();
    selected = widget.product["type"];
    selected2 = widget.product["service"];
    selected3 = widget.product["disponibilité"];
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
      backgroundColor: greyColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: greenColor,
        title: Text(
          S.of(context).update_tilte,
          style: GoogleFonts.roboto(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    S.of(context).update_text1,
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DropdownMenu(
                    controller: typeController,
                    inputDecorationTheme: InputDecorationTheme(
                      hintStyle: GoogleFonts.roboto(
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      border: border,
                      focusedBorder: border,
                      enabledBorder: border,
                    ),
                    width: 370,
                    textStyle: GoogleFonts.roboto(
                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    dropdownMenuEntries: types
                        .map(
                          (e) => DropdownMenuEntry(value: e, label: e),
                        )
                        .toList(),
                    hintText: S.of(context).update_text1,
                    onSelected: (value) {
                      setState(() {
                        selected = value;
                      });
                    },
                  ),
                  /********************************************************* */
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    S.of(context).update_text2,
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DropdownMenu(
                    controller: serviceController,
                    inputDecorationTheme: InputDecorationTheme(
                      hintStyle: GoogleFonts.roboto(
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      border: border,
                      focusedBorder: border,
                      enabledBorder: border,
                    ),
                    width: 370,
                    textStyle: GoogleFonts.roboto(
                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    dropdownMenuEntries: soustype
                        .map(
                          (e) => DropdownMenuEntry(value: e, label: e),
                        )
                        .toList(),
                    hintText: S.of(context).update_text2,
                    onSelected: (value) {
                      setState(() {
                        selected2 = value;
                      });
                    },
                  ),
                  /************************************************************ */
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    S.of(context).update_text3,
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DropdownMenu(
                    controller: disponibleController,
                    inputDecorationTheme: InputDecorationTheme(
                      hintStyle: GoogleFonts.roboto(
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      border: border,
                      focusedBorder: border,
                      enabledBorder: border,
                    ),
                    width: 370,
                    textStyle: GoogleFonts.roboto(
                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    dropdownMenuEntries: disponibilite
                        .map(
                          (e) => DropdownMenuEntry(value: e, label: e),
                        )
                        .toList(),
                    hintText: S.of(context).update_text3,
                    onSelected: (value) {
                      setState(() {
                        selected3 = value;
                      });
                    },
                  ),
                  /*************************************************** */
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    S.of(context).update_text4,
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: S.of(context).update_text4,
                      hintStyle: GoogleFonts.roboto(
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      border: border,
                      focusedBorder: border,
                      enabledBorder: border,
                    ),
                  ),
                  /**************************************************** */
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    S.of(context).update_text5,
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                      hintText: S.of(context).update_text5,
                      hintStyle: GoogleFonts.roboto(
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      border: border,
                      focusedBorder: border,
                      enabledBorder: border,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                updatepost(
                  id: widget.product['post_id'],
                  type: typeController.text.isNotEmpty
                      ? typeController.text
                      : widget.product['type'],
                  service: serviceController.text.isNotEmpty
                      ? serviceController.text
                      : widget.product['service'],
                  description: descriptionController.text.isNotEmpty
                      ? descriptionController.text
                      : widget.product['description'],
                  price: priceController.text.isNotEmpty
                      ? priceController.text
                      : widget.product['price'],
                  disponibilite: disponibleController.text.isNotEmpty
                      ? disponibleController.text
                      : widget.product['disponibilité'],
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: greenColor,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                S.of(context).update_button,
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
