import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';


    class LogoSlogan extends StatelessWidget {
      final double sizeFactor;

      LogoSlogan({
        this.sizeFactor = 1,
    });

      @override
      Widget build(BuildContext context) {

        double screenHeight = MediaQuery.of(context).size.height;

        return Column(

          children: <Widget>[

            SizedBox(
              height: screenHeight * .005,
            ),

            // --- TAG LINE
            SuperVerse(
              verse: '${translate(context, 'Bldrs_Tag_Line')}',
              size: 4,
              designMode: false,
              shadow: true,
              weight: VerseWeight.bold,
              color: Colorz.White,
              centered: true,
              italic: true,
            ),

            SizedBox(
              height: screenHeight * .00,
            ),

            // --- NAME & LOGO
            Container(
              alignment: Alignment.center,
              width: screenHeight * 22 * 0.016 * sizeFactor,
              height: screenHeight * 18 * 0.016 * sizeFactor,
//              color: varza.BloodTest,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: WebsafeSvg.asset(Iconz.BldrsNameEn,
                    fit: BoxFit.fitWidth),
              ),
            ), // ---------------------------- NAME GRAPHIC

            SizedBox(
              height: screenHeight * 0.00,
            ),

            Container(
              width: screenHeight * 22 * 0.016 * 1.2 * sizeFactor * 1.2,
              height: screenHeight * 0.12 * sizeFactor,
//              color: varza.BloodTest,
              child:
              SuperVerse(
                verse: translate(context, 'Bldrs_Description'),
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
