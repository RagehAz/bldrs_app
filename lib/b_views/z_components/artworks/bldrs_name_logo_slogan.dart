import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:scale/scale.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
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
    // --------------------
    final double _screenHeight = Scale.screenHeight(context);
    final double _logoWidth = _screenHeight * 22 * 0.016 * sizeFactor;
    final double _logoHeight = _screenHeight * 18 * 0.016 * sizeFactor;
    // --------------------
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        /// TOP SPACER
        SizedBox(
          height: _screenHeight * 0.005,
        ),

        /// NAME & LOGO
        Container(
          alignment: Alignment.center,
          width: _logoWidth,
          height: _logoHeight,
          margin: EdgeInsets.all(_logoWidth * 0.025),
          child: SizedBox.expand(
            child: WebsafeSvg.asset(Iconz.bldrsNameEn,
              fit: BoxFit.fitWidth,
              // package: Iconz.bldrsTheme,
            ),
          ),
        ),

        /// SLOGAN
        if (showSlogan == true)
          SizedBox(
            width: _logoWidth,
            child: BldrsText(
              verse: Verse(
                id: Words.bldrsTagLine(context),
                pseudo: "The Builder's Network\nReal Estate\nConstruction\nSupplies",
                translate: false,
                casing: Casing.upperCase,
              ),
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
            child: BldrsText(
              verse: Verse(
                pseudo: 'Connect with\nArchitects,\nInterior designers, Contractors\nAnd Artisans',
                translate: false,
                id: Words.bldrsDescription(context),
              ),
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
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
