import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoire/global_varibales.dart';
import 'package:memoire/welcoming_pages/third_page.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:memoire/welcoming_pages/first_page.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 189, 79),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          children: [
            /***************************************************** */
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Explorer",
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
                  "Explorer des nouveaux affaires ou d'equipements pour ameliorer votre projet et gonfler votre profit",
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
                'assets/images/lagom-9.png',
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
                    Dot(currentindex: 2, index: 1),
                    Dot(currentindex: 2, index: 2),
                    Dot(currentindex: 2, index: 3)
                  ],
                ),
                CircularPercentIndicator(
                  radius: 27,
                  lineWidth: 3,
                  backgroundColor: const Color.fromRGBO(0, 0, 0, 0.3),
                  progressColor: greenColor,
                  circularStrokeCap: CircularStrokeCap.round,
                  percent: 2 / 3,
                  center: Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ThirdPage()),
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
