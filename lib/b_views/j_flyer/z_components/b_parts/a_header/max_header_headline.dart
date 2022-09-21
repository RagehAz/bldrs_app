import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class MaxHeaderHeadline extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MaxHeaderHeadline({
    @required this.flyerBoxWidth,
    @required this.bzPageIsOn,
    @required this.firstLine,
    @required this.secondLine,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool bzPageIsOn;
  final Verse firstLine;
  final Verse secondLine;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return bzPageIsOn == false ?
    Container()
        :
    Container(
      height: flyerBoxWidth * 0.3,
      width: flyerBoxWidth,
      color: Colorz.nothing,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          /// BUSINESS NAME
          SuperVerse(
            verse: firstLine,
            size: 5,
            shadow: true,
            maxLines: 2,
          ),

          /// BUSINESS LOCALE
          SuperVerse(
            verse: secondLine,
            italic: true,
            weight: VerseWeight.regular,
            color: Colorz.white200,
          ),

        ],
      ),
    );

  }
/// --------------------------------------------------------------------------
}
