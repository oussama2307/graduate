import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memoire/constants/field.dart';
import 'package:memoire/constants/utils.dart';
import 'package:memoire/generated/l10n.dart';
import 'package:memoire/global_varibales.dart';
import 'package:memoire/providers/usename_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get the user's current name from the provider and set it as the initial value of the TextEditingController
    nameController.text = context.read<UsernameProvider>().user["name"];
  }

  @override
  void dispose() {
    confirmpasswordController.dispose();
    passwordController.dispose();
    nameController.dispose();
    cityController.dispose();
    super.dispose();
  }

  String selectedOption = '';

  void showOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Selectioner votre Wilaya',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: algeriaCities.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(algeriaCities[index]),
                  onTap: () {
                    setState(() {
                      selectedOption = algeriaCities[index];
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

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

  String? profilePictureUrl;
  Future<void> uploadpfp() async {
    if (selectedimage != null) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$urlhttp/upload-profile-picture'),
      );

      // Attach the image file to the request
      request.files.add(
        http.MultipartFile(
          'profilePicture', // Field name for the uploaded file
          selectedimage!.readAsBytes().asStream(),
          selectedimage!.lengthSync(),
          filename: path
              .basename(selectedimage!.path), // Provide the original file name
        ),
      );

      // Optional: Add additional fields to the request if needed
      request.fields['userId'] =
          '${Provider.of<UsernameProvider>(context, listen: false).user["userID"]}';

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Profile picture uploaded successfully');
        // Update the UI with the new profile picture URL
        String profilepictureUrl = await response.stream.bytesToString();
        setState(() {
          profilePictureUrl = profilepictureUrl;
        });
        print(profilePictureUrl);
        Provider.of<UsernameProvider>(context, listen: false).changepfp(
          url: profilePictureUrl,
        );
        selectedimage = null;
        // ...
      } else {
        print('Error uploading profile picture');
      }
    } else {
      print("no image selected");
    }
  }

  bool truepassword() {
    return passwordController.text ==
        Provider.of<UsernameProvider>(context, listen: false).user["password"];
  }

  String message = '';
  Future<void> updateuser() async {
    try {
      final id =
          '${Provider.of<UsernameProvider>(context, listen: false).user["userID"]}';
      final name = nameController.text;
      final newpassword = confirmpasswordController.text.isEmpty
          ? '${Provider.of<UsernameProvider>(context, listen: false).user["password"]}'
          : confirmpasswordController.text;
      final city = selectedOption.isEmpty
          ? '${Provider.of<UsernameProvider>(context, listen: false).user["city"]}'
          : selectedOption;
      final response = await http.post(
        Uri.parse('$urlhttp/update'), // Replace with your server URL
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'id': id,
          'Name': name,
          'password': newpassword,
          'city': city,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        setState(() {
          message = responseBody['message'];
        });
        updateUser(
          name: responseBody["user"]["name"],
          password: responseBody["user"]["password"],
          city: responseBody["user"]["city"],
        );
        print(responseBody);
      } else {
        final responseBody = jsonDecode(response.body);
        setState(() {
          message = responseBody['message'];
        });

        print(responseBody);
        Utils.showFlushbar(context, message);
      }
    } on Exception catch (e) {
      setState(() {
        message = 'error $e';
      });
    }
  }

  void updateUser(
      {required String name, required String password, required String city}) {
    Provider.of<UsernameProvider>(context, listen: false).updatetheuser(
      name: name,
      password: password,
      city: city,
    );
  }

  void logique(BuildContext context) {
    if (passwordController.text.isNotEmpty) {
      if (truepassword()) {
        if (confirmpasswordController.text.isNotEmpty) {
          if (Utils.passwordStrong(confirmpasswordController)) {
            updateuser();
            Utils.showFlushbar(context, "Mettre à jour");
          } else {
            Utils.showFlushbar(context,
                "Votre mot de passe faut contenir au moins 8 carachteres",
                color: Colors.red);
          }
        } else {
          updateuser();
          Utils.showFlushbar(context, "Mettre à jour");
        }
      } else {
        Utils.showFlushbar(context,
            "Pour changer le mot de passe il faut valider l'ancien mot de passe correctement",
            color: Colors.red);
      }
    } else {
      if (confirmpasswordController.text.isEmpty) {
        updateuser();
      } else {
        Utils.showFlushbar(context,
            "Pour changer le mot de passe if faut valider l'ancien mot de passe correctement",
            color: Colors.red);
      }
    }
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
    return Container(
      decoration: const BoxDecoration(
        color: greyColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.all(15),
      child: Center(
        child: ListView(
          children: [
            Column(
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
                      S.of(context).profile_title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 5,
                        fontSize: 20,
                      ),
                    ),
                    const Text(
                      "monrofile",
                      style: TextStyle(color: greyColor),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.brown,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: selectedimage == null
                            ? Utils.oneofthem(context)
                            : ClipOval(
                                child: Image.file(
                                  selectedimage!,
                                  width: 100, // Set the desired width
                                  height: 100, // Set the desired height
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    Positioned(
                      left: 69,
                      top: 70,
                      child: GestureDetector(
                        onTap: pickimage,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Colors.yellow,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            size: 20,
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                /***************************************** */
                const SizedBox(
                  height: 20,
                ),
                /***************************************** */
                MyFields(
                  controller: nameController,
                  icon: const Icon(Icons.person),
                  hint: S.of(context).profile_case1,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyFields(
                  controller: passwordController,
                  icon: const Icon(Icons.lock),
                  hint: S.of(context).profile_case2,
                  ispassword: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyFields(
                  controller: confirmpasswordController,
                  icon: const Icon(Icons.lock),
                  hint: S.of(context).profile_case3,
                  ispassword: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputDecorator(
                  decoration: InputDecoration(
                    hintText: S.of(context).profile_case4,
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                    suffixIcon: const Icon(Icons.location_city),
                  ),
                  child: GestureDetector(
                    onTap: showOptionsDialog,
                    child: Text(
                      selectedOption.isNotEmpty
                          ? selectedOption
                          : S.of(context).profile_case4,
                      style: TextStyle(
                        color: selectedOption.isNotEmpty
                            ? Colors.black
                            : Colors.grey,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await uploadpfp();
                    logique(context);
                    /////////////////////////////////////////
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenColor,
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    S.of(context).profile_button,
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
