import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:flutter/material.dart';

class BubblesSeparator extends StatelessWidget {

  const BubblesSeparator();

  @override
  Widget build(BuildContext context) {

    final double screenWidth = Scale.superScreenWidth(context);

    return Container(
      width: screenWidth,
      height: 15,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: 5,
        height: 5,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colorz.grey80,
        ),
      ),
    );
  }
}
