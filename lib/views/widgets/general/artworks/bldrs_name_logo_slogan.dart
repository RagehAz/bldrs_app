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

    final bool _designMode = false;
    final double _screenHeight = Scale.superScreenHeight(context);

    final  double _logoWidth = _screenHeight * 22 * 0.016 * sizeFactor;
    final  double _logoHeight = _screenHeight * 18 * 0.016 * sizeFactor;

    final SuperVerse _slogan = SuperVerse(
      verse: Wordz.bldrsTagLine(context),
      size: 4,
      designMode: _designMode,
      shadow: true,
      weight: VerseWeight.bold,
      color: Colorz.White255,
      centered: true,
      italic: true,
      scaleFactor: sizeFactor,
    );

    final SizedBox _spacer = SizedBox(height: _screenHeight * 0.005);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        _spacer,

        /// SLOGAN
        if (showTagLine == true && showSlogan == true)
          _slogan,

        /// NAME & LOGO
        Container(
          alignment: Alignment.center,
          width: _logoWidth,
          height: _logoHeight,
          color: _designMode ? Colorz.BloodTest : null,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: WebsafeSvg.asset(Iconz.BldrsNameEn,
                fit: BoxFit.fitWidth),
          ),
        ),

        if (showTagLine == false && showSlogan == true)
          _slogan,

        /// TAG LINE
        if (showTagLine == true)
          Container(
            width: _logoWidth,
            height: _logoHeight * 0.7,
            color: _designMode ? Colorz.BloodTest : null,
            child:
            SuperVerse(
              verse: Wordz.bldrsDescription(context),
              size: 3,
              weight: VerseWeight.thin,
              designMode: _designMode,
              shadow: true,
              centered: true,
              italic: true,
              color: Colorz.White255,
              maxLines: 5,
              scaleFactor: sizeFactor,

            ),


          ),

      ],
    );
  }
}
