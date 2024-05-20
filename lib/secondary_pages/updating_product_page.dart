import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoire/global_varibales.dart';

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

  List<String> types = ["Vente", "Location", "Chercher", "Autre"];
  List<String> soustype = ["Equipement", "Surface", "Information", "Autre"];
  String? selected;
  String? selected2;

  @override
  void initState() {
    super.initState();
    selected = widget.product["type"];
    selected2 = widget.product["service"];
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
        automaticallyImplyLeading: true,
        backgroundColor: greenColor,
        title: Text(
          "Mise à jour",
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
        child: ListView(
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              "Type",
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
                width: double.infinity,
                child: DropdownButton<String>(
                  onChanged: (String? newvalue) {
                    setState(() {
                      selected = newvalue;
                    });
                  },
                  value: selected,
                  items: types.map(
                    (e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
