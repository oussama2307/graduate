import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoire/authentication_pages/login_page.dart';
import 'package:memoire/generated/l10n.dart';
import 'package:memoire/global_varibales.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:memoire/welcoming_pages/first_page.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 58, 182, 122),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          children: [
            /***************************************************** */
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).third_page_text1,
                  style: GoogleFonts.roboto(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 13, 51, 82),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  S.of(context).third_page_text2,
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 13, 51, 82),
                  ),
                )
              ],
            ),
            /*********************************************************** */
            const Spacer(),
            Center(
              child: Image.asset(
                'assets/images/image3.png',
                colorBlendMode: BlendMode.dstATop, // Blend the colors
                fit: BoxFit.contain,
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            /************************************************************* */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Dot(currentindex: 1, index: 3),
                    Dot(currentindex: 2, index: 3),
                    Dot(currentindex: 3, index: 3)
                  ],
                ),
                CircularPercentIndicator(
                  radius: 27,
                  lineWidth: 3,
                  backgroundColor: const Color.fromRGBO(0, 0, 0, 0.3),
                  progressColor: greenColor,
                  circularStrokeCap: CircularStrokeCap.round,
                  percent: 3 / 3,
                  center: Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: greenColor,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 16,
                      ),
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
