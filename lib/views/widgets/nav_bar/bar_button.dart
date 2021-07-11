import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

import 'nav_bar.dart' show BarType;

class BarButton extends StatelessWidget {
  final String text;
  final String icon;
  final double iconSizeFactor;
  final Widget clipperWidget;
  final BarType barType;
  final Function onTap;
  final double width;
  final double corners;

  BarButton({
    @required this.text,
    this.icon,
    this.iconSizeFactor,
    this.clipperWidget,
    this.barType = BarType.maxWithText,
    this.onTap,
    @required this.width,
    this.corners,
  });


  @override
  Widget build(BuildContext context) {

    const double _circleWidth = 40;
    double _buttonCircleCorner = corners == null ? _circleWidth * 0.5 : corners;
    const double _paddings = Ratioz.appBarPadding * 1.5;

    const double _textScaleFactor = 0.95;
    const int _textSize = 1;

    double _textBoxHeight =
    barType == BarType.maxWithText || barType == BarType.minWithText ?
    superVerseRealHeight(context, _textSize, _textScaleFactor, null)
        :
    0
    ;

    double _buttonHeight = _circleWidth + ( 2 * _paddings ) + _textBoxHeight;
    double _buttonWidth = width;

    // Color _designModeColor = Colorz.BloodTest;
    const bool _designMode = false;

    return
      GestureDetector(
        onTap: (){
          onTap();
          print('tapped');
        },
        child: Container(
          height: _buttonHeight,
          width: _buttonWidth,
          // color: _designModeColor,
          padding: const EdgeInsets.symmetric(horizontal: _paddings * 0.25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              SizedBox(
                height: _paddings,
              ),

              clipperWidget == null ?
              DreamBox(
                width: _circleWidth,
                height: _circleWidth,
                icon: icon,
                iconSizeFactor: iconSizeFactor,
                bubble: true,
                color: Colorz.Nothing,
                corners: _buttonCircleCorner,
                designMode: _designMode,
                onTap: onTap,
              )
                  :
              Container(
                width: _circleWidth,
                  height: _circleWidth,
                  child: clipperWidget
              ),

              if (barType == BarType.maxWithText || barType == BarType.minWithText)
              Container(
                width: _buttonWidth,
                height: _textBoxHeight,
                // color: Colorz.YellowLingerie,
                alignment: Alignment.center,
                child: SuperVerse(
                  verse: text,
                  maxLines: 2,
                  size: _textSize,
                  weight: VerseWeight.thin,
                  shadow: true,
                  scaleFactor: _textScaleFactor,
                  designMode: _designMode,
                ),
              ),

            ],
          ),
        ),
      );
  }
}
