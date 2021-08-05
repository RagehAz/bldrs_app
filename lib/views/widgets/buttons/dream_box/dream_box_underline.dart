import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class DreamBoxUnderLine extends StatelessWidget {
  final double width;
  final double height;
  final String underLine;
  final String icon;
  final Color underLineColor;
  final int verseSize;
  final double scaleFactor;
  final bool underLineShadowIsOn;

  const DreamBoxUnderLine({
    @required this.width,
    @required this.height,
    @required this.underLine,
    @required this.icon,
    @required this.underLineColor,
    @required this.verseSize,
    @required this.scaleFactor,
    @required this.underLineShadowIsOn,
  });

  @override
  Widget build(BuildContext context) {


    double _iconBoxHeight = width ?? 0;

    double _underLineHeight = height?? 0 - _iconBoxHeight;

    double _underLineTopMargin = underLine == null ? 0 :
    ObjectChecker.objectIsSVG(icon) ? (width - (_underLineHeight * 0.1)) * 1 : // (width - ((width - _graphicWidth)/2)) * 0.0 :
    width;

    double _underlineHeightXXX = underLine == null ? 0 : height - _underLineTopMargin;

    return Container(
      width: underLine == null ? height : width,
      height: underLine == null ? height : height,
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// ICON footprint
          Container(
            width: width,
            height: _underLineTopMargin,
            // color: Colorz.BloodTest,
          ),
          /// --- THE UnderLine
          if (underLine != null)
            Container(
              width: width,
              height: _underlineHeightXXX,
              color: Colorz.Black10,
              child: SuperVerse(
                verse: underLine,
                color: underLineColor,
                size: verseSize,
                scaleFactor: scaleFactor,
                maxLines: 2,
                shadow: underLineShadowIsOn,
              ),
            ),
        ],
      ),
    );
  }
}
