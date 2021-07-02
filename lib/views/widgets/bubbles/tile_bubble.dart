import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
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
  final bool switchIsOn;
  final Function switching;
  final bool iconIsBubble;
  final bool insideDialog;
  final Function moreBtOnTap;

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
    this.iconIsBubble = true,
    this.insideDialog = false,
    this.moreBtOnTap,
  });

  @override
  Widget build(BuildContext context) {

    const double iconBoxWidth = 30;
    double iconWidth = (iconSizeFactor * iconBoxWidth);
    double iconBoxPadding = iconBoxWidth - iconWidth;

    double _switchButtonWidth = switchIsOn == null && moreBtOnTap == null ? 0 : 50;

    double _verseWidth =
        insideDialog == true ?
        Scale.superDialogWidth(context) - 30 - 50 - _switchButtonWidth
            :
        Scale.superBubbleClearWidth(context) - iconBoxWidth - 50 - _switchButtonWidth
    ;

    return InPyramidsBubble(
      bubbleOnTap: btOnTap,
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
              margins: const EdgeInsets.symmetric(horizontal: 0),
              bubble: iconIsBubble,
            )
                :
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Container(
                width: iconBoxWidth,
                height: iconBoxWidth,
                padding: EdgeInsets.all(iconBoxPadding),
                child: icon,
              ),
            ),

            // --- MAIN TEXT
            Container(
              width: _verseWidth,
              padding: const EdgeInsets.symmetric(horizontal: 5),
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
                    size: 2,
                    scaleFactor: 0.75,
                    italic: true,
                    shadow: false,
                    maxLines: 10,
                    centered: false,
                    weight: VerseWeight.thin,
                    margin: 5,
                  ),

                ],
              ),
            ),

            Expanded(child: Container(),),

            if (switchIsOn != null)
            Container(
              width: _switchButtonWidth,
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

            if(moreBtOnTap != null)
              DreamBox(
                height: 35,
                width: 35,
                icon: Iconz.More,
                iconSizeFactor: 0.6,
                boxFunction: moreBtOnTap,
              )

          ],
        ),

      ],
    );
  }
}
