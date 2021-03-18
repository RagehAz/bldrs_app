import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BzPageHeadline extends StatelessWidget {
  final double flyerZoneWidth;
  final bool bzPageIsOn;
  final String bzName;
  final String bzLocale;

  BzPageHeadline({
    @required this.flyerZoneWidth,
    @required this.bzPageIsOn,
    @required this.bzName,
    @required this.bzLocale,
});

  @override
  Widget build(BuildContext context) {
    return
      bzPageIsOn == false ? Container() :
      Positioned(
        bottom: 0,
        child: Container(
          height: (flyerZoneWidth * 0.3),
          width: flyerZoneWidth,
          color: Colorz.Nothing,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // -- BUSINESS NAME
              SuperVerse(
                verse: bzName,
                size: 5,
                shadow: true,
                centered: true,
                maxLines: 2,
                // softWrap: true,
              ),
              // -- BUSINESS LOCALE
              SuperVerse(
                verse: bzLocale,
                size: 2,
                centered: true,
                italic: true,
                maxLines: 1,
                // softWrap: true,
                shadow: false,
                weight: VerseWeight.regular,
                color: Colorz.WhiteLingerie,
              ),
            ],
          ),
        ),
      )
    ;
  }
}
