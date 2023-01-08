
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
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTapNext;
  final Function onTapBack;
  final Function onDoubleTap;
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget>[

        /// BACK
        GestureDetector(
          onTap: onTapBack,
          onDoubleTap: onDoubleTap,
          child: Container(
            width: flyerBoxWidth * 0.25,
            height: flyerBoxHeight,
            color: Colorz.nothing,
          ),
        ),

        /// NEXT
        GestureDetector(
          onTap: onTapNext,
          onDoubleTap: onDoubleTap,
          child: Container(
            width: flyerBoxWidth * 0.75,
            height: flyerBoxHeight,
            color: Colorz.nothing,
          ),
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
