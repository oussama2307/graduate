import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoire/widgets/appbar_widget.dart';
import 'package:memoire/widgets/card_details.dart';
import 'package:memoire/global_varibales.dart';
import 'package:memoire/widgets/filter_widget.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  final TextStyle mystyle = GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 237, 237, 0.949),
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 57),
        child: AppbarWidget(),
      ),
      /******************************************************** */
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Publications à explorer",
                  style: mystyle,
                ),
                Column(
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: greenColor,
                        minimumSize: const Size(30, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Icon(
                        Icons.search_outlined,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                    Text(
                      "Filtre",
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                      ),
                    )
                  ],
                )
              ],
            ),
            /********************************************************** */
            const SizedBox(
              height: 10,
            ),
            /********************************************************** */
            SizedBox(
              height: 90,
              child: FilterWidget(
                filters: filters,
              ),
            ),
            /********************************************** */
            const SizedBox(
              height: 10,
            ),
            /**************************************************+*** */
            Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: CardDetail(
                      type: (post['type'] as String),
                      soustype: (post['soustype'] as String),
                      imageUrl: (post['imageurl'] as String),
                      description: (post['description'] as String),
                      userName: (post['username'] as String),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
