import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoire/generated/l10n.dart';
import 'package:memoire/global_varibales.dart';
import 'package:memoire/principale_pages/sending_page.dart';
import 'package:memoire/providers/usename_provider.dart';
import 'package:memoire/secondary_pages/updating_product_page.dart';
import 'package:memoire/services/admin_services.dart';
import 'package:memoire/widgets/carousel_slider.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final dynamic product;
  const ProductDetails({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetails> createState() => ProductDetailsState();
}

class ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    void confirmation(String message) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              S.of(context).delete_dialogue_title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            content: Text(
              message,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      S.of(context).delete_dialogue_no,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ApiService.deletePost(
                        widget.product["post_id"],
                        Provider.of<UsernameProvider>(context, listen: false)
                            .user["userID"],
                        context,
                      );
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      S.of(context).delete_dialogue_yes,
                      style: const TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: greyColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: greenColor,
        title: Text(
          S.of(context).details_title,
          style: GoogleFonts.roboto(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    S.of(context).details_text1,
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      widget.product['description'],
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: greenColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    S.of(context).details_text2,
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      widget.product['price'],
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: greenColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  /************************************************************ */
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).details_text3,
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DottedBorder(
                          borderType: BorderType.RRect,
                          color: greenColor,
                          radius: const Radius.circular(10),
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: const BoxDecoration(
                                //color: greyColor,
                                ),
                            child: Center(
                              child: Text(
                                widget.product['type'],
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromRGBO(0, 0, 0, 0.6)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  /*********************************************************** */
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).details_text4,
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DottedBorder(
                          borderType: BorderType.RRect,
                          color: greenColor,
                          radius: const Radius.circular(10),
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: const BoxDecoration(
                                //color: greyColor,
                                ),
                            child: Center(
                              child: Text(
                                widget.product['service'],
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromRGBO(0, 0, 0, 0.6)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  /********************************************************* */
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).details_text5,
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DottedBorder(
                          borderType: BorderType.RRect,
                          color: greenColor,
                          radius: const Radius.circular(10),
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: const BoxDecoration(
                                //color: greyColor,
                                ),
                            child: Center(
                              child: Text(
                                (widget.product['created_at'])
                                        .substring(0, 10) +
                                    " à " +
                                    (widget.product['created_at'])
                                        .substring(11, 19),
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromRGBO(0, 0, 0, 0.6)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  /***************************************************************** */
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).details_text6,
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DottedBorder(
                          borderType: BorderType.RRect,
                          color: greenColor,
                          radius: const Radius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: widget.product["disponibilité"] ==
                                      "Disponible"
                                  ? const Color.fromARGB(255, 102, 231, 106)
                                  : Colors.red,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                widget.product["disponibilité"],
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromRGBO(0, 0, 0, 0.6)),
                              ),
                            ),
                          ),
                        ),
                        /**************************************************** */
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              widget.product['userProfilePicture'] == null
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
                                            widget.product['userName'][0],
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundImage: NetworkImage(urlhttp +
                                          widget.product['userProfilePicture']),
                                      radius: 18,
                                    ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  widget.product['userName'],
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: greenColor,
                          ),
                        ],
                        /************************************************************* */
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      S.of(context).details_text7,
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  widget.product['images'][0] == null ||
                          widget.product['images'].isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Text(
                            S.of(context).details_noimages,
                            style: GoogleFonts.roboto(
                              color: const Color.fromRGBO(0, 0, 0, 0.5),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        )
                      : CarouselSliderWidget(
                          images: List<String>.from(widget.product['images']),
                        ),
                ],
              ),
            ),
            /*************************************************** */
            const SizedBox(
              height: 20,
            ),
            widget.product['userName'] !=
                    Provider.of<UsernameProvider>(context, listen: false)
                        .user['name']
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => IndividualChatPage(
                            otherUserName: widget.product['userName'],
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greenColor,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      S.of(context).details_sendmessage,
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              confirmation(
                                  S.of(context).delete_dialogue_content);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: const Size(double.infinity, 50)),
                            child: Text(
                              S.of(context).details_delete,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UpadatePage(product: widget.product),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: greenColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: const Size(double.infinity, 50)),
                            child: Text(
                              S.of(context).details_modify,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
        /******************************************** */
      ),
    );
  }
}
