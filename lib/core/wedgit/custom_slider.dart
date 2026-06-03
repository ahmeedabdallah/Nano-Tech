import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({super.key,required this.carouselList , this.onPageChange});
  final List<Widget> carouselList;
  final dynamic Function(int)? onPageChange;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: carouselList,
      options: CarouselOptions(
        autoPlay: true,


        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration( seconds: 3),
        enlargeCenterPage: true,
        viewportFraction: 1,
        enlargeFactor: 0.5,
        onPageChanged: (int index , reason){
          if (onPageChange != null){
            onPageChange!(index);
          }
        }
      ) ,
    );
  }
}
