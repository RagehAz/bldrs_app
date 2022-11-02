import 'package:bldrs/b_views/z_components/images/super_image/a_super_image.dart';
import 'package:flutter/material.dart';

class DreamBoxIcon extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DreamBoxIcon({
    @required this.icon,
    @required this.loading,
    @required this.size,
    @required this.corners,
    @required this.iconMargin,
    @required this.greyscale,
    @required this.bubble,
    @required this.iconColor,
    @required this.iconSizeFactor,
    @required this.backgroundColor,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic icon;
  final bool loading;
  final double size;
  final BorderRadius corners;
  final double iconMargin;
  final bool greyscale;
  final bool bubble;
  final Color iconColor;
  final double iconSizeFactor;
  final Color backgroundColor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SuperImage(
      key: const ValueKey<String>('DreamBoxIcon'),
      width: size,
      height: size,
      pic: icon,
      // boxFit: BoxFit.cover,
      scale: iconSizeFactor,
      iconColor: iconColor,
      loading: loading,
      greyscale: greyscale,
      corners: corners,
      backgroundColor: backgroundColor,
    );

  }
  /// --------------------------------------------------------------------------
}
