import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BzPageHeadline extends StatelessWidget {
  final double flyerBoxWidth;
  final bool bzPageIsOn;
  final TinyBz tinyBz;

  const BzPageHeadline({
    @required this.flyerBoxWidth,
    @required this.bzPageIsOn,
    @required this.tinyBz,
});

  @override
  Widget build(BuildContext context) {
    return
      bzPageIsOn == false ? Container() :
      Container(
        height: (flyerBoxWidth * 0.3),
        width: flyerBoxWidth,
        color: Colorz.Nothing,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /// BUSINESS NAME
            SuperVerse(
              verse: tinyBz.bzName,
              size: 5,
              shadow: true,
              centered: true,
              maxLines: 2,
              // softWrap: true,
            ),
            /// BUSINESS LOCALE
            SuperVerse(
              verse: TextGenerator.zoneStringer(
                context: context,
                zone: tinyBz.bzZone,
              ),
              size: 2,
              centered: true,
              italic: true,
              maxLines: 1,
              // softWrap: true,
              shadow: false,
              weight: VerseWeight.regular,
              color: Colorz.White200,
            ),
          ],
        ),
      )
    ;
  }
}
