import 'package:bldrs/view_brains/drafters/texters.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/screens/s12_saved_flyers_screen.dart';
import 'package:bldrs/views/widgets/bottom_menu/bottom_bar.dart' show BarType;
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BarButton extends StatelessWidget {
  final String text;
  final String icon;
  final double iconSizeFactor;
  final Widget clipperWidget;
  final BarType barType;

  BarButton({
    @required this.text,
    @required this.icon,
    @required this.iconSizeFactor,
    this.clipperWidget,
    this.barType = BarType.maxWithText,
  });


  @override
  Widget build(BuildContext context) {

    double _circleWidth = 45;
    double _buttonCircleCorner = _circleWidth * 0.5;
    double _paddings = Ratioz.ddAppBarPadding * 1.5;

    double _textScaleFactor = 0.95;
    int _textSize = 1;
    double _textBoxHeight = superVerseRealHeight(context, _textSize, _textScaleFactor, null);

    double _buttonHeight = _circleWidth + ( 2 * _paddings ) + _textBoxHeight;
    double _buttonWidth = _circleWidth * 1.5;

    // Color _designModeColor = Colorz.BloodTest;
    bool _designMode = false;

    return
      Container(
        height: _buttonHeight,
        width: _buttonWidth,
        // color: _designModeColor,
        padding: EdgeInsets.symmetric(horizontal: _paddings * 0.25),
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
              boxFunction: ()=> goToNewScreen(context, SavedFlyersScreen()),
            )
                :
            clipperWidget
            ,

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
      );
  }
}
