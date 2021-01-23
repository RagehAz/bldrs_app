import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:flutter/material.dart';

class BubblesSeparator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    double screenWidth = superScreenWidth(context);

    return Container(
      width: screenWidth,
      height: 15,
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 10),
      child: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colorz.GreySmoke,
        ),
      ),
    );
  }
}
