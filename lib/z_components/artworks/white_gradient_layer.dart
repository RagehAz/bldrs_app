import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/z_components/images/bldrs_image.dart';
import 'package:flutter/material.dart';

class GradientLayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const GradientLayer({
    required this.width,
    required this.height,
    required this.isWhite,
    this.color,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double width;
  final double height;
  final bool isWhite;
  final Color? color;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final String _gradient =
    isWhite == true ?
    Iconz.whiteGradient
        :
    Iconz.blackGradient;
    // --------------------
    return SizedBox(
      width: width,
      height: height,
      // color: Colorz.BloodTest,
      child: BldrsImage(
        pic: _gradient,
        width: width,
        height: height,
        // boxFit: BoxFit.cover,
        iconColor: color,
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
