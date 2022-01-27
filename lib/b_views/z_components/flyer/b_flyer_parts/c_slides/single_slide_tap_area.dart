import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class SingleSlideTapAreas extends StatelessWidget {

  const SingleSlideTapAreas({
    @required this.onTapNext,
    @required this.onTapBack,
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    Key key
  }) : super(key: key);

  final Function onTapNext;
  final Function onTapBack;
  final double flyerBoxWidth;
  final double flyerBoxHeight;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget>[

        /// BACK
        GestureDetector(
          onTap: onTapBack,
          child: Container(
            width: flyerBoxWidth * 0.25,
            height: flyerBoxHeight,
            color: Colorz.nothing,
          ),
        ),

        /// NEXT
        GestureDetector(
          onTap: onTapNext,
          child: Container(
            width: flyerBoxWidth * 0.75,
            height: flyerBoxHeight,
            color: Colorz.nothing,
          ),
        ),

      ],
    );
  }
}
