import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterWidget extends StatefulWidget {
  final List<Map<String, Object>> filters;
  const FilterWidget({
    super.key,
    required this.filters,
  });

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.filters.length,
      itemBuilder: (context, index) {
        final filter = widget.filters[index];
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.all(3),
            width: 90,
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.5),
                blurRadius: 5,
              )
            ], borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                (filter["icon"] as Widget),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  (filter["name"] as String),
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
