import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:flutter/material.dart';

class SlideTapAreas extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideTapAreas({
    required this.onTapNext,
    required this.onTapBack,
    required this.onDoubleTap,
    required this.flyerBoxWidth,
    required this.flyerBoxHeight,
    required this.child,
    required this.canTap,
    this.splashColor = Colorz.white255,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Function? onTapNext;
  final Function? onTapBack;
  final Function? onDoubleTap;
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final Widget child;
  final bool canTap;
  final Color splashColor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (canTap == true){
      return Stack(
        children: <Widget>[

          child,

          Row(
            children: <Widget>[

              /// BACK
              BldrsBox(
                width: flyerBoxWidth * 0.25,
                height: flyerBoxHeight,
                bubble: false,
                corners: 0,
                onTap: onTapBack,
                onDoubleTap: onDoubleTap,
                splashColor: splashColor.withOpacity(0.2),
              ),

              /// NEXT
              BldrsBox(
                width: flyerBoxWidth * 0.75,
                height: flyerBoxHeight,
                bubble: false,
                corners: 0,
                onTap: onTapNext,
                onDoubleTap: onDoubleTap,
                splashColor: splashColor.withOpacity(0.2),
              ),

            ],
          ),

        ],
      );
    }

    else {
      return child;
    }

  }
  // -----------------------------------------------------------------------------
}
