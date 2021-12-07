import 'package:bldrs/controllers/drafters/tracers.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/nav_bar/nav_bar.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';


class BarButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BarButton({
    @required this.text,
    @required this.width,
    this.icon,
    this.iconSizeFactor,
    this.clipperWidget,
    this.barType = BarType.maxWithText,
    this.onTap,
    this.corners,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String text;
  final String icon;
  final double iconSizeFactor;
  final Widget clipperWidget;
  final BarType barType;
  final Function onTap;
  final double width;
  final double corners;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _circleWidth = 40;
    final double _buttonCircleCorner = corners ?? _circleWidth * 0.5;
    const double _paddings = Ratioz.appBarPadding * 1.5;

    const double _textScaleFactor = 0.95;
    const int _textSize = 1;

    final double _textBoxHeight =
    barType == BarType.maxWithText || barType == BarType.minWithText ?
    SuperVerse.superVerseRealHeight(context, _textSize, _textScaleFactor, null)
        :
    0
    ;

    final double _buttonHeight = _circleWidth + ( 2 * _paddings ) + _textBoxHeight;
    final double _buttonWidth = width;

    return
      GestureDetector(
        onTap: (){
          onTap();
          blog('tapped');
        },
        child: Container(
          height: _buttonHeight,
          width: _buttonWidth,
          padding: const EdgeInsets.symmetric(horizontal: _paddings * 0.25),
          child: Column(
            children: <Widget>[

              const SizedBox(
                height: _paddings,
              ),

              if (clipperWidget == null)
              DreamBox(
                width: _circleWidth,
                height: _circleWidth,
                icon: icon,
                iconSizeFactor: iconSizeFactor,
                corners: _buttonCircleCorner,
                onTap: onTap,
              ),

              if (clipperWidget != null)
              SizedBox(
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
                ),
              ),

            ],
          ),
        ),
      );
  }
}
