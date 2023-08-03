import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class LogoSlogan extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LogoSlogan({
    this.showTagLine = false,
    this.showSlogan = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final bool showTagLine;
  final bool showSlogan;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _code = UiProvider.proGetCurrentLangCode(context: context, listen: true);
    blog(' XXX---------> current lang is : x$_code : ${Localizer.getCurrentLangCode()} : ${Localizer.of(context)?.locale}');
    // --------------------
    final double _shortest = Scale.screenShortestSide(context);
    final double _logoWidth = _shortest * 0.5;//_screenHeight * 22 * 0.016 * sizeFactor;
    final double _logoHeight = _logoWidth * 0.8;//_screenHeight * 18 * 0.016 * sizeFactor;
    // --------------------
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        /// NAME & LOGO
        Container(
          alignment: Alignment.center,
          width: _logoWidth,
          height: _logoHeight,
          margin: EdgeInsets.all(_logoWidth * 0.025),
          child: SizedBox(
            child: WebsafeSvg.asset(Iconz.bldrsNameEn,
              fit: BoxFit.fitWidth,
              width: _logoWidth,
              height: _logoHeight,
              // package: Iconz.bldrsTheme,
            ),
          ),
        ),

        /// SLOGAN
        if (showSlogan == true)
          BldrsText(
            width: _logoWidth,
            verse: getVerse('phid_bldrsTagLine', casing: Casing.upperCase),
            size: 3,
            shadow: true,
            weight: VerseWeight.black,
            italic: true,
            scaleFactor: _logoWidth * 0.004,
            maxLines: 10,
            margin: _logoWidth * 0.025,
          ),

        /// TAG LINE
        if (showTagLine == true)
          BldrsText(
            width: _logoWidth,
            verse: getVerse('phid_bldrsDescription'),
            size: 3,
            weight: VerseWeight.thin,
            shadow: true,
            italic: true,
            maxLines: 10,
            scaleFactor: _logoWidth * 0.003,
            margin: _logoWidth * 0.025,
          ),

      ],
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
