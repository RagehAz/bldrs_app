import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/wordz.dart' as Wordz;
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class LogoSlogan extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LogoSlogan({
    this.sizeFactor = 1,
    this.showTagLine = false,
    this.showSlogan = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double sizeFactor;
  final bool showTagLine;
  final bool showSlogan;
  /// --------------------------------------------------------------------------
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
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: WebsafeSvg.asset(Iconz.bldrsNameEn,
                fit: BoxFit.fitWidth),
          ),
        ),

        if (showSlogan == true)
          SizedBox(
            width: _logoWidth,
            child: SuperVerse(
              verse: _slogan.toUpperCase(),
              size: 3,
              shadow: true,
              weight: VerseWeight.black,
              centered: false,
              italic: true,
              scaleFactor: sizeFactor,
              maxLines: 3,
              margin: _logoWidth * 0.025,
            ),
          ),

        /// TAG LINE
        if (showTagLine == true)
          SizedBox(
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
              maxLines: 5,
              scaleFactor: sizeFactor,
              margin: _logoWidth * 0.025,
            ),


          ),

      ],
    );
  }
}
