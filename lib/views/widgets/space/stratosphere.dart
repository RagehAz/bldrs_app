import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';

class Stratosphere extends StatelessWidget {

  static const EdgeInsets stratosphereInsets = EdgeInsets.only(top: Ratioz.stratosphere);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: 70,
    );
  }
}
