import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class SlidesWidget extends StatefulWidget {
  final List<Widget> pages;
  const SlidesWidget({
    super.key,
    required this.pages,
  });

  @override
  State<SlidesWidget> createState() => _SlidesWidgetState();
}

class _SlidesWidgetState extends State<SlidesWidget> {
  late int imageon;
  @override
  void initState() {
    super.initState();
    imageon = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            width: double.infinity,
            height: 300,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  imageon = value;
                });
              },
              itemCount: widget.pages.length,
              itemBuilder: (context, index) {
                return widget.pages[index];
              },
            ),
          ),
        ),
        /////////////////////////////////////
        Positioned(
          bottom: 280,
          right: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 0, 0, 0.5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              '${imageon + 1} / ${widget.pages.length}',
              style: GoogleFonts.roboto(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
