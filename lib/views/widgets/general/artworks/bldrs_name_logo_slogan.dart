import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class LogoSlogan extends StatelessWidget {
  final double sizeFactor;
  final bool showTagLine;
  final bool showSlogan;

  const LogoSlogan({
    this.sizeFactor = 1,
    this.showTagLine = false,
    this.showSlogan = false,
  });

  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeight(context);
    final double _logoWidth = _screenHeight * 22 * 0.016 * sizeFactor;
    final double _logoHeight = _screenHeight * 18 * 0.016 * sizeFactor;
    const String _slogan = 'Real Estate\nConstruction\nSupplies';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        SizedBox(height: _screenHeight * 0.005),

        /// NAME & LOGO
        Container(
          alignment: Alignment.center,
          width: _logoWidth,
          height: _logoHeight,
          margin: EdgeInsets.all(_logoWidth * 0.025),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: WebsafeSvg.asset(Iconz.BldrsNameEn,
                fit: BoxFit.fitWidth),
          ),
        ),

        if (showSlogan == true)
          Container(
            width: _logoWidth,
            child: SuperVerse(
              verse: _slogan.toUpperCase(),
              size: 3,
              shadow: true,
              weight: VerseWeight.black,
              color: Colorz.white255,
              centered: false,
              italic: true,
              scaleFactor: sizeFactor,
              maxLines: 3,
              margin: _logoWidth * 0.025,
            ),
          ),

        /// TAG LINE
        if (showTagLine == true)
          Container(
            width: _logoWidth,
            // height: _logoHeight * 0.7,
            child:
            SuperVerse(
              verse: Wordz.bldrsDescription(context),
              size: 3,
              weight: VerseWeight.thin,
              shadow: true,
              centered: false,
              italic: true,
              color: Colorz.white255,
              maxLines: 5,
              scaleFactor: sizeFactor,
              margin: _logoWidth * 0.025,
            ),


          ),

      ],
    );
  }
}
