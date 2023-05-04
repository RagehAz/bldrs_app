import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class LineBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LineBubble({
    @required this.child,
    this.width,
    this.alignment,
    this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final double width;
  final Alignment alignment;
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? BldrsAppBar.width(context),
        alignment: alignment ?? Alignment.center,
        decoration: const BoxDecoration(
          color: Colorz.white20,
          borderRadius: Borderers.constantCornersAll10,
        ),
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        margin: const EdgeInsets.only(bottom: 5),
        child: child,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
