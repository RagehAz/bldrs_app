import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

    class LogoSlogan extends StatelessWidget {
      final double sizeFactor;
      final bool onlyLogo;

      LogoSlogan({
        this.sizeFactor = 1,
        this.onlyLogo = false,
    });

      @override
      Widget build(BuildContext context) {

        double _screenHeight = superScreenHeight(context);

        SuperVerse _slogan = SuperVerse(
          verse: Wordz.bldrsTagLine(context),
          size: 4,
          designMode: false,
          shadow: true,
          weight: VerseWeight.bold,
          color: Colorz.White,
          centered: true,
          italic: true,
        );

        SizedBox _spacer = SizedBox(height: _screenHeight * 0.005);

        return Column(

          children: <Widget>[

            _spacer,

            // --- SLOGAN
            if (!onlyLogo)
            _slogan,

            // --- NAME & LOGO
            Container(
              alignment: Alignment.center,
              width: _screenHeight * 22 * 0.016 * sizeFactor,
              height: _screenHeight * 18 * 0.016 * sizeFactor,
//              color: varza.BloodTest,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: WebsafeSvg.asset(Iconz.BldrsNameEn,
                    fit: BoxFit.fitWidth),
              ),
            ),

            if (onlyLogo)
              _slogan,

            // --- TAG LINE
            if (!onlyLogo)
            Container(
              width: _screenHeight * 22 * 0.016 * 1.2 * sizeFactor * 1.2,
              height: _screenHeight * 0.12 * sizeFactor,
              child:
              SuperVerse(
                verse: Wordz.bldrsDescription(context),
                size: 2,
                weight: VerseWeight.thin,
                designMode: false,
                shadow: true,
                centered: true,
                italic: true,
                color: Colorz.White,
                maxLines: 5,
                scaleFactor: sizeFactor,

              ),


            ),

          ],
        );
      }
    }
