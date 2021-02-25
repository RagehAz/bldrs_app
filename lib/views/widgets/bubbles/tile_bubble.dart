import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/texters.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class TileBubble extends StatelessWidget {
  final String verse;
  final dynamic icon;
  final Color iconBoxColor;
  final double iconSizeFactor;
  final Color verseColor;
  final Function btOnTap;
  final String secondLine;
  bool switchIsOn;
  final Function switching;

  TileBubble({
    @required this.verse,
    @required this.icon,
    this.iconBoxColor = Colorz.Nothing,
    this.iconSizeFactor = 0.6,
    this.verseColor = Colorz.White,
    this.btOnTap,
    this.secondLine,
    this.switchIsOn,
    this.switching,
  });

  @override
  Widget build(BuildContext context) {

    double iconBoxWidth = 30;
    double iconWidth = (iconSizeFactor * iconBoxWidth);
    double iconBoxPadding = iconBoxWidth - iconWidth;

    return Material(
      color: Colorz.Nothing,
      child: InkWell(
        onTap: btOnTap,
        splashColor: Colorz.WhiteSmoke,
        child: InPyramidsBubble(

          bubbleColor: Colorz.WhiteGlass,
          columnChildren: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                // --- LEADING ICON
                icon.runtimeType == String ?
                DreamBox(
                  width: iconBoxWidth,
                  height: iconBoxWidth,
                  icon: icon,
                  iconSizeFactor: iconSizeFactor,
                  color: iconBoxColor,
                  iconRounded: false,
                  boxMargins: EdgeInsets.symmetric(horizontal: 0),
                )
                    :
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Container(
                    width: iconBoxWidth,
                    height: iconBoxWidth,
                    padding: EdgeInsets.all(iconBoxPadding),
                    child: icon,
                  ),
                ),

                // --- MAIN TEXT
                Container(
                  width: superBubbleClearWidth(context) - 30 - 50,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      SuperVerse(
                        verse: verse,
                        margin: 5,
                        color: verseColor,
                        maxLines: 2,
                        centered: false,
                      ),

                      if (secondLine != null)
                      SuperVerse(
                        verse: secondLine,
                        color: Colorz.WhiteLingerie,
                        size: 1,
                        italic: true,
                        shadow: false,
                        maxLines: 10,
                        centered: false,
                        weight: VerseWeight.thin,
                      ),

                    ],
                  ),
                ),

                if (switchIsOn != null)
                Container(
                  width: 50,
                  height: 35,
                  child: Switch(
                    activeColor: Colorz.Yellow,
                    activeTrackColor: Colorz.YellowSmoke,
                    focusColor: Colorz.DarkBlue,
                    inactiveThumbColor: Colorz.Grey,
                    inactiveTrackColor: Colorz.GreySmoke,
                    value: switchIsOn,
                    onChanged: (val) => switching(val),
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}

class BubbleTitle extends StatelessWidget {
  final String verse;

  BubbleTitle({
    @required this.verse,
  });
  @override
  Widget build(BuildContext context) {

    double spacings = 10;

    return Padding(
      padding: EdgeInsets.only(bottom: spacings),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: spacings * 0.5),
              child: SuperVerse(
                verse: verse,
                size: 2,
                scaleFactor: 0.85,
                maxLines: 2,
                centered: false,

              ),
            ),
          ),

          Container(
            width: spacings,
            height: 30,
          ),

          // DreamBox(
          //   height: 30,
          //   icon: Iconz.Plus,
          //   iconSizeFactor: 0.6,
          //   verse: 'Add',
          //   boxFunction: (){Navigator.pushNamed(context, Routez.AddBz);},
          // )

        ],
      ),
    );
  }
}

