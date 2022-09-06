import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
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
  final String firstLine;
  final String secondLine;
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
            // verse: bzModel?.name,
            size: 5,
            shadow: true,
            maxLines: 2,
            // softWrap: true,
          ),

          /// BUSINESS LOCALE
          SuperVerse(
            verse: secondLine,
            // verse: TextGen.countryStringerByZoneModel(
            //   context: context,
            //   zone: bzZone,
            // ),
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
