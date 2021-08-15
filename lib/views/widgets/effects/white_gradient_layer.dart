import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:flutter/material.dart';

class GradientLayer extends StatelessWidget {
  final double width;
  final double height;
  final bool isWhite;
  final Color color;

  const GradientLayer({
    @required this.width,
    @required this.height,
    @required this.isWhite,
    this.color,
});

  @override
  Widget build(BuildContext context) {

    final String _gradient = isWhite == true ? Iconz.WhiteGradient : Iconz.BlackGradient;

    return Container(
      width: width,
      height: height,
      // color: Colorz.BloodTest,
      child: Imagers.superImageWidget(
        _gradient,
        width: width,
        height: height,
        fit: BoxFit.cover,
        scale: 1,
        iconColor: color,
      ),
    );

  }
}
