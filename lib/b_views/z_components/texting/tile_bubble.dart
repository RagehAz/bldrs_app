import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class TileBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
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
    this.bulletPoints,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String verse;
  final dynamic icon;
  final Color iconBoxColor;
  final double iconSizeFactor;
  final Color verseColor;
  final Function btOnTap;
  final String secondLine;
  final bool switchIsOn;
  final ValueChanged<bool> switching;
  final bool iconIsBubble;
  final bool insideDialog;
  final Function moreBtOnTap;
  final Widget child;
  final List<String> bulletPoints;
  static const double iconBoxWidth = 30;
  /// --------------------------------------------------------------------------
  static double childWidth(BuildContext context) {
    return Bubble.bubbleWidth(context: context, stretchy: false) - iconBoxWidth;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double iconWidth = iconSizeFactor * iconBoxWidth;
    final double iconBoxPadding = iconBoxWidth - iconWidth;

    final double _switchButtonWidth = switchIsOn == null && moreBtOnTap == null ?
    0 : 50;

    final double _verseWidth = insideDialog == true ?
    CenterDialog.getWidth(context) - 30 - 50 - _switchButtonWidth
        :
    Bubble.clearWidth(context) - iconBoxWidth - 50 - _switchButtonWidth;

    return Bubble(
      onBubbleTap: btOnTap,
      columnChildren: <Widget>[

        /// HEADER ( LEADING ICON - TITLE - SWITCHER - MORE BUTTON )
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// --- LEADING ICON
            if (icon is String)
              DreamBox(
                width: iconBoxWidth,
                height: iconBoxWidth,
                icon: icon,
                // iconColor: Colorz.Green255,
                iconSizeFactor: iconSizeFactor,
                color: iconBoxColor,
                margins: EdgeInsets.zero,
                bubble: iconIsBubble,
              ),

            if (icon is String == false)
              Padding(
                padding: EdgeInsets.zero,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  SuperVerse(
                    verse: verse,
                    margin: 5,
                    color: verseColor,
                    maxLines: 2,
                    centered: false,
                  ),

                ],
              ),
            ),

            const Expander(),

            if (switchIsOn != null)
              SizedBox(
                width: _switchButtonWidth,
                height: 35,
                child: Switch(
                  activeColor: Colorz.yellow255,
                  activeTrackColor: Colorz.yellow80,
                  focusColor: Colorz.darkBlue,
                  inactiveThumbColor: Colorz.grey255,
                  inactiveTrackColor: Colorz.grey80,
                  value: switchIsOn,
                  onChanged: (bool val) => switching(val),
                ),
              ),

            if (moreBtOnTap != null)
              DreamBox(
                height: 35,
                width: 35,
                icon: Iconz.more,
                iconSizeFactor: 0.6,
                onTap: moreBtOnTap,
              ),

          ],
        ),

        /// BULLET POINTS
        Padding(
          padding: superInsets(context: context, enLeft: iconBoxWidth),
          child: BubbleBulletPoints(
              bulletPoints: bulletPoints,
          ),
        ),

        /// SECOND LINE
        if (secondLine != null)
          SizedBox(
            width: Bubble.bubbleWidth(context: context, stretchy: false),
            child: Row(
              children: <Widget>[

                /// UNDER LEADING ICON AREA
                const SizedBox(
                  width: iconBoxWidth,
                ),

                /// SECOND LINE
                SizedBox(
                  width: childWidth(context),
                  child: SuperVerse(
                    verse: secondLine,
                    color: Colorz.white200,
                    // scaleFactor: 1,
                    italic: true,
                    maxLines: 100,
                    centered: false,
                    weight: VerseWeight.thin,
                    margin: 5,
                  ),
                ),

              ],
            ),
          ),

        /// CHILD
        if (child != null)
          SizedBox(
            width: Bubble.bubbleWidth(context: context, stretchy: false),
            // height: 200,
            // padding: const EdgeInsets.symmetric(horizontal: 5),
            // color: Colorz.Yellow255,
            child: Row(
              children: <Widget>[

                /// UNDER LEADING ICON AREA
                const SizedBox(
                  width: iconBoxWidth,
                ),

                /// CHILD
                Container(
                  width: childWidth(context),
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
