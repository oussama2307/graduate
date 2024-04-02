import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoire/global_varibales.dart';
import 'package:memoire/principale_pages/addposts_page.dart';
import 'package:memoire/principale_pages/profile_page.dart';
import 'package:memoire/secondary_pages/confidence_page.dart';
import 'package:memoire/secondary_pages/contact_rigths_page.dart';
import 'package:memoire/secondary_pages/my_posts_page.dart';

import 'package:memoire/widgets/appbar_widget.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 57),
        child: AppbarWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Parametres",
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            /*********************************************************** */
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height *
                              0.85, // Adjust this value to your desired height
                        ),
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return const ProfilePage();
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mon profile",
                          style: GoogleFonts.roboto(
                            color: const Color.fromRGBO(0, 0, 0, 0.5),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyPostsPage(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mes publications",
                          style: GoogleFonts.roboto(
                            color: const Color.fromRGBO(0, 0, 0, 0.5),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            /********************************************************************** */
            const SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height *
                              0.85, // Adjust this value to your desired height
                        ),
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return const ConfidencePage();
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Confidentialité",
                          style: GoogleFonts.roboto(
                            color: const Color.fromRGBO(0, 0, 0, 0.5),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const ContactRightPage();
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Contact et les droits de publication",
                          style: GoogleFonts.roboto(
                            color: const Color.fromRGBO(0, 0, 0, 0.5),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Deconnecter",
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
