import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
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
    final double _screenHeight = Scale.superScreenHeight(context);
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
            child: WebsafeSvg.asset(Iconz.bldrsNameEn, fit: BoxFit.fitWidth),
          ),
        ),

        /// SLOGAN
        if (showSlogan == true)
          SizedBox(
            width: _logoWidth,
            child: SuperVerse(
              verse: const Verse(
                text: 'phid_bldrs_tagline',
                pseudo: "The Builder's Network\nReal Estate\nConstruction\nSupplies",
                translate: true,
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
            child: SuperVerse(
              verse: const Verse(
                pseudo: 'Connect with\nArchitects,\nInterior designers, Contractors\nAnd Artisans',
                translate: true,
                text: 'phid_bldrsDescription',
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
