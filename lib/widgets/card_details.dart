import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoire/global_varibales.dart';
import 'package:memoire/providers/favorite_provider.dart';
import 'package:provider/provider.dart';

class CardDetail extends StatefulWidget {
  final String type;
  final String soustype;
  final String imageUrl;
  final String description;
  final String userName;
  const CardDetail({
    super.key,
    required this.type,
    required this.soustype,
    required this.imageUrl,
    required this.description,
    required this.userName,
  });

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.type,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  widget.soustype,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                widget.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description :",
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    widget.description,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: const Color.fromRGBO(0, 0, 0, 0.7),
                    ),
                  ),
                )
              ],
            ),
            /***************************************************** */
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/pfp.png'),
                      radius: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        widget.userName,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      pressed = true;
                    });
                    Provider.of<FavoriteProvider>(context, listen: false)
                        .addtofavorite(
                      details: {
                        "type": widget.type,
                        "soustype": widget.soustype,
                        "imageurl": widget.imageUrl,
                        "description": widget.description,
                        "username": widget.userName,
                      },
                    );
                  },
                  child: Icon(
                    Icons.favorite,
                    color: pressed
                        ? Colors.red
                        : const Color.fromRGBO(0, 0, 0, 0.3),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
