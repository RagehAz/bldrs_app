import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class BubbleBulletPoints extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BubbleBulletPoints({
    @required this.bulletPoints,
    @required this.translateBullets,
    this.bubbleWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<String> bulletPoints;
  final double bubbleWidth;
  final bool translateBullets;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Mapper.checkCanLoopList(bulletPoints) == false){
      return const SizedBox();
    }

    else {

      final double _bubbleWidth = bubbleWidth ?? Bubble.clearWidth(context);

      return Column(
        children: <Widget>[

          ...List.generate(bulletPoints.length, (index){

            return SizedBox(
              width: _bubbleWidth,
              child: SuperVerse(
                verse: bulletPoints[index],
                translate: translateBullets,
                margin: 0,
                // size: 2,
                maxLines: 10,
                centered: false,
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
