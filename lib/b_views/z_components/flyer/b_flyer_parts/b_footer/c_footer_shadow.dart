import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/b_footer_box.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class FooterShadow extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FooterShadow({
    @required this.flyerBoxWidth,
    @required this.tinyMode,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool tinyMode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _flyerBottomCorners = FooterBox.boxCornersValue(flyerBoxWidth);

    final double _footerHeight = FooterBox.collapsedHeight(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: tinyMode,
    );

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: flyerBoxWidth,
        height: _footerHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(_flyerBottomCorners),
            bottomRight: Radius.circular(_flyerBottomCorners),
          ),
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colorz.black0, Colorz.black125, Colorz.black230],
              stops: <double>[0.35, 0.85, 1]
          ),

        ),
      ),
    );
  }
}
