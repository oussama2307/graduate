import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoire/generated/l10n.dart';
import 'package:memoire/global_varibales.dart';
import 'package:memoire/providers/favorite_provider.dart';
import 'package:provider/provider.dart';

class CardDetail extends StatefulWidget {
  final String type;
  final String soustype;
  final imageUrl;
  final String description;
  final String userName;
  final pfp;
  final liked;
  const CardDetail({
    super.key,
    required this.type,
    required this.soustype,
    this.imageUrl = null,
    required this.description,
    required this.userName,
    this.pfp = null,
    this.liked = false,
  });

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
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
            widget.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      urlhttp + widget.imageUrl,
                      fit: BoxFit.fill,
                    ),
                  )
                : const Text(""),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).card_description,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: greenColor,
                    border: Border.all(
                      color: greenColor,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    widget.description,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
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
                    widget.pfp == null
                        ? CircleAvatar(
                            radius: 18,
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.brown,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  widget.userName[0],
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(urlhttp + widget.pfp),
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
                    setState(() {});
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
                    color: widget.liked
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
