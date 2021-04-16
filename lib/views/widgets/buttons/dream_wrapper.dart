import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'dream_box.dart';

class DreamWrapper extends StatelessWidget {
  final List<String> verses;
  final List<String> icons;
  final double spacing;
  final double buttonHeight;
  final Function onTap;
  final EdgeInsets margins;
  final double boxWidth;
  final double boxHeight;

  DreamWrapper({
    this.verses,
    this.icons,
    this.spacing = Ratioz.ddAppBarPadding,
    this.buttonHeight = 35,
    this.onTap,
    this.margins,
    this.boxWidth,
    this.boxHeight,
});

  @override
  Widget build(BuildContext context) {

    print(verses);
    print(icons);

    int _listLength =
        verses == null && icons == null ? 0 :
        verses == null ? icons.length :
        icons == null ? verses.length : verses.length;


    return Container(
      width: boxWidth,
      // height: boxHeight,
      decoration: BoxDecoration(
        color: Colorz.BloodTest,
        borderRadius: Borderers.superBorderAll(context, 10),
      ),
      child: Wrap(
        spacing: spacing,
        children: <Widget>[

          ...List<Widget>.generate(
              _listLength,
                  (index){

                String _verse = verses[index];

                return
                  DreamBox(
                      height: buttonHeight,
                      icon: icons[index],
                      boxMargins: margins,
                      verse: _verse,
                      verseColor: Colorz.White,
                      verseWeight: VerseWeight.thin,
                      verseItalic: false,
                      iconSizeFactor: 0.6,
                      boxFunction: () => onTap(_verse)
                  );
              }
          ),

        ],
      ),
    );
  }
}
