import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      indicatorBackgroundColor:Colors.white,
      indicatorColor: Colors.redAccent,
      height: 300,
      autoPlayInterval: 3000,
      indicatorPadding: 4,
      isLoop: true,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset("images/slide1.jpg"),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset("images/slide1.jpg"),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset("images/slide1.jpg"),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset("images/slide1.jpg"),
        ),
      ],
    );
  }
}
