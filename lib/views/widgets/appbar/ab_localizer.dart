import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:flutter/material.dart';
import 'buttons/ab_loc_bt.dart';

class ABLocalizer extends StatelessWidget {
  final bool countryPageON;
  final Function tappingBTCountry;
  final Function tappingBTLanguage;
  final String currentFlag;

  ABLocalizer({
    @required this.countryPageON,
    @required this.tappingBTCountry,
    @required this.tappingBTLanguage,
    @required this.currentFlag,
  });

  // we could have gone to the multiple constructor approach in max lesson # 41

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 50,
      alignment: Alignment.center,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(Ratioz.ddAppBarCorner)
          ),
          color: Colorz.WhiteAir),

      // --- CONTENTS INSIDE THE APP BAR
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // ---  COUNTRY BUTTON
          ABLocalizerBT(
            buttonVerse: Wordz.country(context),
            buttonIcon: currentFlag,
            buttonTap: tappingBTLanguage,
            buttonOn: countryPageON == true ? true : false,
          ),

          // BTLocalizerCountry(
          //   buttonFlag: currentFlag,
          //   buttonTap: tappingBTLanguage,
          //   buttonON: countryPageON == true ? true : false
          // ),

          SizedBox(
            width: 5,
          ),

          // --- LANGUAGE BUTTON
          ABLocalizerBT(
            buttonVerse: Wordz.language(context),
            buttonIcon: '',
            buttonTap: tappingBTLanguage,
            buttonOn: countryPageON == true ? false : true,
          ),

         //  BTLocalizerLanguage(
         //   buttonTap: tappingBTLanguage,
         //   buttonON: countryPageON == true ? false : true
         // ),

        ],
      ),
    );
}
}
