import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart' show Expander;

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
  final Widget child;

  const TileBubble({
    @required this.verse,
    @required this.icon,
    this.iconBoxColor = Colorz.nothing,
    this.iconSizeFactor = 0.6,
    this.verseColor = Colorz.white255,
    this.btOnTap,
    this.secondLine,
    this.switchIsOn,
    this.switching,
    this.iconIsBubble = true,
    this.insideDialog = false,
    this.moreBtOnTap,
    this.child,
  });
// -----------------------------------------------------------------------------
  static const double iconBoxWidth = 30;
// -----------------------------------------------------------------------------
  static double childWidth(BuildContext context){
    return Bubble.bubbleWidth(context: context, stretchy: false) - iconBoxWidth;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double iconWidth = (iconSizeFactor * iconBoxWidth);
    final double iconBoxPadding = iconBoxWidth - iconWidth;

    final double _switchButtonWidth = switchIsOn == null && moreBtOnTap == null ? 0 : 50;

    final double _verseWidth =
        insideDialog == true ?
        CenterDialog.dialogWidth(context: context) - 30 - 50 - _switchButtonWidth
            :
        Bubble.clearWidth(context) - iconBoxWidth - 50 - _switchButtonWidth;

    return Bubble(
      bubbleOnTap: btOnTap,
      bubbleColor: Colorz.white20,
      columnChildren: <Widget>[

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// --- LEADING ICON
            icon.runtimeType == String ?
            DreamBox(
              width: iconBoxWidth,
              height: iconBoxWidth,
              icon: icon,
              // iconColor: Colorz.Green255,
              iconSizeFactor: iconSizeFactor,
              color: iconBoxColor,
              iconRounded: true,
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

            /// --- MAIN TEXT
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
                    color: Colorz.white200,
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

            const Expander(),

            if (switchIsOn != null)
            Container(
              width: _switchButtonWidth,
              height: 35,
              child: Switch(
                activeColor: Colorz.yellow255,
                activeTrackColor: Colorz.yellow80,
                focusColor: Colorz.darkBlue,
                inactiveThumbColor: Colorz.grey225,
                inactiveTrackColor: Colorz.grey80,
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
                onTap: moreBtOnTap,
              ),

          ],
        ),

        if (child != null)
        Container(
          width: Bubble.bubbleWidth(context: context, stretchy: false),
          // height: 200,
          // padding: const EdgeInsets.symmetric(horizontal: 5),
          // color: Colorz.Yellow255,
          child: Row(
            children: <Widget>[

              /// under leading icon area
              Container(
                width: iconBoxWidth,
                // height: 1,
                // color: Colorz.BloodTest,
              ),

              /// child
              Container(
                width: childWidth(context),
                // height: 200,
                decoration: BoxDecoration(
                  color: Colorz.white10,
                  borderRadius: Borderers.superBorderAll(context, Bubble.clearCornersValue)
                ),
                alignment: Alignment.center,
                child: child,
              ),

            ],
          ),
        ),

      ],
    );
  }
}
