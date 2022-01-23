import 'package:bldrs/b_views/widgets/general/images/super_image.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class GradientLayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const GradientLayer({
    @required this.width,
    @required this.height,
    @required this.isWhite,
    this.color,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final double height;
  final bool isWhite;
  final Color color;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final String _gradient =
        isWhite == true ? Iconz.whiteGradient : Iconz.blackGradient;

    return SizedBox(
      width: width,
      height: height,
      // color: Colorz.BloodTest,
      child: SuperImage(
        pic: _gradient,
        width: width,
        height: height,
        fit: BoxFit.cover,
        iconColor: color,
      ),
    );
  }
}
