import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class BubblesSeparator extends StatelessWidget {
  const BubblesSeparator({Key key}) : super(key: key);

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
