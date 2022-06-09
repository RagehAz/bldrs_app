import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class ObeliskRow extends StatelessWidget {

  const ObeliskRow({
    @required this.verse,
    @required this.icon,
    @required this.onTap,
    Key key
  }) : super(key: key);

  final String verse;
  final String icon;
  final Function onTap;

  static double circleWidth = 50;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: circleWidth,
      // color: Colorz.white20,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          DreamBox(
            width: 50,
            height: 50,
            corners: 25,
            color: Colorz.black255,
            icon: icon,
            iconSizeFactor: 0.45,
            onTap: onTap,
          ),

          SuperVerse(
            verse: verse.toUpperCase(),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            italic: true,
            weight: VerseWeight.thin,
            labelColor: Colorz.nothing,
          ),

        ],
      ),
    );

  }
}
