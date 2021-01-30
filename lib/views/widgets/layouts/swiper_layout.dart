import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperLayout extends StatelessWidget {
  final int pagesLength;
  final Function itemBuilder;
  final Function onIndexChanged;
  SwiperLayout({
    this.pagesLength,
    this.itemBuilder,
    this.onIndexChanged,
});

  @override
  Widget build(BuildContext context) {

    // List<Widget> listWidgetsBuilder(List<Widget> listWidgets, int index){
    //   List<Widget> widgets = new List();
    //
    //   return widgets;
    // }

    // int index;

    return Swiper(
      autoplay: false,
      onIndexChanged: onIndexChanged,
      pagination: new SwiperPagination(
        builder: DotSwiperPaginationBuilder(
          color: Colorz.White,
          activeColor: Colorz.Yellow,
          activeSize: 8,
          size: 5,
          space: 2,
        ),
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 54, right: 25),
      ),

      // control: new SwiperControl(),

      viewportFraction: 1,
      scale: 0.6,
      itemCount: pagesLength,
      itemBuilder: itemBuilder,
    );
  }
}
