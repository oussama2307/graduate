import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memoire/global_varibales.dart';

import 'package:memoire/providers/usename_provider.dart';
import 'package:memoire/widgets/appbar_widget.dart';
import 'package:provider/provider.dart';

class MyPostPage extends StatefulWidget {
  const MyPostPage({
    super.key,
  });

  @override
  State<MyPostPage> createState() => _MyPostPageState();
}

class _MyPostPageState extends State<MyPostPage> {
  List<String> types = ["Vente", "Location", "Chercher", "Autre"];
  List<String> soustype = ["Equipement", "Surface", "Information", "Autre"];
  String? selected = "Vente";
  String? selected_2 = "Equipement";

  TextEditingController typeController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  File? selectedimage;
  Future pickimage() async {
    final pickedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedimage == null) {
      return;
    }
    setState(() {
      selectedimage = File(pickedimage.path);
    });
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
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 57),
        child: AppbarWidget(),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage("assets/images/pfp.png"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Text(
                      Provider.of<UsernameProvider>(context).user["name"],
                      style: GoogleFonts.roboto(
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              /********************************************************** */
              const SizedBox(
                height: 15,
              ),
              Text(
                "Type :",
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
                hintText: "Selectionner le type",
                onSelected: (value) {
                  setState(() {
                    selected = value;
                  });
                },
              ),
              /******************************************************** */
              const SizedBox(
                height: 25,
              ),
              Text(
                "Service :",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                child: DropdownMenu(
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
                  hintText: "Selectionner le service",
                  onSelected: (value) {
                    setState(() {
                      selected_2 = value;
                    });
                  },
                ),
              ),
              /************************************************************* */
              const SizedBox(
                height: 25,
              ),
              Text(
                "Description :",
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
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Description...",
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
              /*********************************************************** */
              const SizedBox(
                height: 25,
              ),
              Text(
                "Prix :",
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
                decoration: InputDecoration(
                  hintText: "Prix",
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
              /*************************************************************************** */
              const SizedBox(
                height: 25,
              ),
              Text(
                "Image :",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  pickimage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.image,
                      color: Colors.black,
                      size: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text(
                        "Inserer image",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              /************************************************* */
              selectedimage != null
                  ? Image.file(selectedimage!)
                  : const Text(""),
              /*************************************************** */
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenColor,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Publier",
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
