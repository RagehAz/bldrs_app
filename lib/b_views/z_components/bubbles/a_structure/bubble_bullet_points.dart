import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';

import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class BulletPoints extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BulletPoints({
    @required this.bulletPoints,
    this.bubbleWidth,
    this.centered,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Verse> bulletPoints;
  final double bubbleWidth;
  final bool centered;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Mapper.checkCanLoopList(bulletPoints) == false){
      return const SizedBox();
    }

    else {

      final double _bubbleWidth = bubbleWidth ?? Bubble.clearWidth(context);

      return Column(
        crossAxisAlignment: centered == true ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: <Widget>[

          ...List.generate(bulletPoints.length, (index){

            return SizedBox(
              width: _bubbleWidth,
              child: SuperVerse(
                verse: bulletPoints[index],
                margin: 0,
                // size: 2,
                maxLines: 10,
                centered: centered,
                color: Colorz.blue255,
                italic: true,
                weight: VerseWeight.thin,
                leadingDot: true,
              ),
            );

          }),

          Container(
            width: _bubbleWidth - (Ratioz.appBarMargin * 2),
            height: 0.5,
            color: Colorz.blue125,
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),

        ],
      );
    }

  }
/// --------------------------------------------------------------------------
}
