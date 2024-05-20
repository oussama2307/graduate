import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memoire/generated/l10n.dart';
import 'package:memoire/global_varibales.dart';
import 'package:http/http.dart' as http;
import 'package:memoire/providers/posts_provider.dart';
import 'package:memoire/providers/usename_provider.dart';
import 'package:memoire/widgets/appbar_widget.dart';
import 'package:memoire/widgets/smoth_slides_widget.dart';
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

  List<XFile>? selectedimage;
  Future pickimage() async {
    final pickedimage = await ImagePicker().pickMultiImage();

    if (pickedimage == null) {
      return;
    }
    setState(() {
      selectedimage = pickedimage;
    });

    setState(() {
      _pages = List.generate(
        selectedimage!.length,
        (index) => ImagePlaceholder(
          path: File(selectedimage![index].path),
        ),
      );
    });
  }

  late List<Widget> _pages;

  bool isfieldsfilled() {
    return typeController.text.isNotEmpty &&
        serviceController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        priceController.text.isNotEmpty;
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> submitPost() async {
    if (isfieldsfilled()) {
      final type = typeController.text;
      final service = serviceController.text;
      final description = descriptionController.text;
      final price = priceController.text;

      final uri = Uri.parse('$urlhttp/api/posts');
      final request = http.MultipartRequest('POST', uri);
      request.fields['userID'] =
          '${Provider.of<UsernameProvider>(context, listen: false).user['userID']}';
      request.fields['type'] = type;
      request.fields['service'] = service;
      request.fields['description'] = description;
      request.fields['price'] = price.toString();

      if (selectedimage != null) {
        for (final image in selectedimage!) {
          final imageFile =
              await http.MultipartFile.fromPath('images[]', image.path);
          request.files.add(imageFile);
        }
      } else {
        // Add an empty image file to the request
        final emptyImage = await http.MultipartFile.fromString('images[]', '');
        request.files.add(emptyImage);
      }

      final response = await request.send();
      if (response.statusCode == 200) {
        print("post created successfully");
      } else {
        print("post failed");
      }
    } else {
      showErrorSnackBar("Completer les information necissaires");
    }
  }

  void updatePostsProvider(dynamic postDetails) {
    Provider.of<PostsProvider>(context, listen: false)
        .addtoposts(postDetails: postDetails);
  }

  @override
  void dispose() {
    typeController.dispose();
    serviceController.dispose();
    descriptionController.dispose();
    priceController.dispose();
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
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: const Color.fromRGBO(0, 0, 0, 0.5),
                    child: Provider.of<UsernameProvider>(context, listen: false)
                                .user['profile_picture'] !=
                            null
                        ? CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(urlhttp +
                                Provider.of<UsernameProvider>(context,
                                        listen: false)
                                    .user["profile_picture"]),
                          )
                        : CircleAvatar(
                            radius: 20,
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.brown,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  Provider.of<UsernameProvider>(context)
                                      .user['name'][0],
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
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
                S.of(context).add_text1,
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
                hintText: S.of(context).add_case1,
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
                S.of(context).add_text2,
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
                child: DropdownMenu(
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
                  hintText: S.of(context).add_case2,
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
                S.of(context).add_text3,
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
                  hintText: S.of(context).add_case3,
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
                S.of(context).add_text4,
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
                  hintText: S.of(context).add_case4,
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
                S.of(context).add_text5,
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
                        S.of(context).add_button1,
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
              const SizedBox(
                height: 30,
              ),
              /************************************************* */
              selectedimage != null
                  ? SlidesWidget(pages: _pages)
                  : const Text(""),
              /*************************************************** */
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () async {
                  await submitPost();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenColor,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  S.of(context).add_button2,
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

class ImagePlaceholder extends StatelessWidget {
  final File path;
  const ImagePlaceholder({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.file(
        path,
        fit: BoxFit.cover,
      ),
    );
  }
}
