import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';

    class LogoSlogan extends StatelessWidget {
      final double sizeFactor;

      LogoSlogan({
        this.sizeFactor = 1,
    });

      @override
      Widget build(BuildContext context) {

        double _screenHeight = superScreenHeight(context);

        return Column(

          children: <Widget>[

            SizedBox(
              height: _screenHeight * .005,
            ),

            // --- TAG LINE
            SuperVerse(
              verse: Wordz.bldrsTagLine(context),
              size: 4,
              designMode: false,
              shadow: true,
              weight: VerseWeight.bold,
              color: Colorz.White,
              centered: true,
              italic: true,
            ),

            SizedBox(
              height: _screenHeight * .00,
            ),

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
            ), // ---------------------------- NAME GRAPHIC

            SizedBox(
              height: _screenHeight * 0.00,
            ),

            Container(
              width: _screenHeight * 22 * 0.016 * 1.2 * sizeFactor * 1.2,
              height: _screenHeight * 0.12 * sizeFactor,
//              color: varza.BloodTest,
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


            ), // ---------------------------- DESCRIPTION

          ],
        );
      }
    }
