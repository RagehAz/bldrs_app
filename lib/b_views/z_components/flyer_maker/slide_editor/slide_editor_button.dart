

import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SlideEditorButton extends StatelessWidget {

  const SlideEditorButton({
    @required this.size,
    @required this.icon,
    @required this.verse,
    @required this.onTap,
    Key key
  }) : super(key: key);

  final double size;
  final String icon;
  final String verse;
  final Function onTap;

  @override
  Widget build(BuildContext context) {

    final double _verseZoneHeight = size * 0.4;

    return SizedBox(
      width: size + (2 * Ratioz.appBarMargin),
      height: size + _verseZoneHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          DreamBox(
            width: size,
            height: size,
            icon: icon,
            iconSizeFactor: 0.6,
            margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
            onTap: onTap,
          ),

          SizedBox(
            width: size,
            height: _verseZoneHeight,
            child: SuperVerse(
              verse: verse,
              weight: VerseWeight.thin,
            ),
          ),

        ],
      ),
    );
  }
}
