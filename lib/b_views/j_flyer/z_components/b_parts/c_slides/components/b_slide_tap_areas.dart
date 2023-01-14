import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class SlideTapAreas extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideTapAreas({
    @required this.onTapNext,
    @required this.onTapBack,
    @required this.onDoubleTap,
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.child,
    @required this.canTap,
    this.splashColor = Colorz.white255,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTapNext;
  final Function onTapBack;
  final Function onDoubleTap;
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
              DreamBox(
                width: flyerBoxWidth * 0.25,
                height: flyerBoxHeight,
                bubble: false,
                corners: 0,
                onTap: onTapBack,
                onDoubleTap: onDoubleTap,
                splashColor: splashColor.withOpacity(0.2),
              ),

              /// NEXT
              DreamBox(
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
