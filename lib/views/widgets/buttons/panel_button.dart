import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class PanelButton extends StatelessWidget {
  final double size;
  final String icon;
  final String verse;
  final Function onTap;
  final double iconSizeFactor;
  final bool blackAndWhite;

  PanelButton({
    this.size,
    this.icon,
    this.verse,
    @required this.onTap,
    this.iconSizeFactor,
    this.blackAndWhite,
  });

  @override
  Widget build(BuildContext context) {

    double _iconSizeFactor = iconSizeFactor == null ? 0.6 : iconSizeFactor;
    bool _blackAndWhite = blackAndWhite == null ? false : blackAndWhite;

    return Column(
      children: <Widget>[

        DreamBox(
          height: size,
          width: size,
          verseWeight: VerseWeight.thin,
          verseScaleFactor: 0.8,
          icon: icon,
          iconSizeFactor: _iconSizeFactor,
          margins: 5,
          blackAndWhite: _blackAndWhite,
          onTap: onTap,
        ),

        Container(
          width: size,
          child: SuperVerse(
            verse: verse,
            size: 1,
            maxLines: 2,
          ),
        ),

      ],
    );;
  }
}
