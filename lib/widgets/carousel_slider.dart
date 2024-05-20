import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:memoire/global_varibales.dart';

class CarouselSliderWidget extends StatelessWidget {
  final List<String> images;

  const CarouselSliderWidget({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) => ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              urlhttp + imageUrl,
              fit: BoxFit.cover,
              height: 200,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 200,
      ),
    );
  }
}
