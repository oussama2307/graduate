import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoire/global_varibales.dart';
import 'package:memoire/welcoming_pages/second_page.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../generated/l10n.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 237, 237, 0.949),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          children: [
            /***************************************************** */
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).first_page_text1,
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
                  S.of(context).first_page_text2,
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
                'assets/images/image2.png',
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
                    Dot(currentindex: 1, index: 1),
                    Dot(currentindex: 1, index: 2),
                    Dot(currentindex: 1, index: 3)
                  ],
                ),
                CircularPercentIndicator(
                  radius: 27,
                  lineWidth: 3,
                  backgroundColor: const Color.fromRGBO(0, 0, 0, 0.3),
                  progressColor: greenColor,
                  circularStrokeCap: CircularStrokeCap.round,
                  percent: 1 / 3,
                  center: Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SecondPage()),
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

class Dot extends StatelessWidget {
  final int currentindex;
  final int index;
  const Dot({
    super.key,
    required this.currentindex,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      child: AnimatedContainer(
        duration: const Duration(
          seconds: 1,
        ),
        width: currentindex == index ? 20 : 5,
        height: 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
          color: currentindex == index
              ? greenColor
              : const Color.fromRGBO(0, 0, 0, 0.3),
        ),
      ),
    );
  }
}
