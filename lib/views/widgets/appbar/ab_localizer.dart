import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/screens/s04_sc_localizer_screen.dart';
import 'package:flutter/material.dart';
import 'buttons/ab_loc_bt.dart';

class ABLocalizer extends StatelessWidget {
  final String pickedCountry;
  final String pickedCity;
  final String pickedLanguage;
  final Function pickCountry;
  final Function pickCity;
  final Function pickLanguage;

  ABLocalizer({
    @required this.pickedCountry,
    @required this.pickedCity,
    @required this.pickedLanguage,
    @required this.pickCountry,
    @required this.pickCity,
    @required this.pickLanguage,
  });

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
          // ABLocalizerBT(
          //   buttonVerse: Wordz.country(context),
          //   buttonIcon: currentFlag,
          //   buttonTap: tappingBTLanguage,
          //   buttonOn: currentPage == LocalizerPage.Country ? true : false,
          // ),

          // BTLocalizerCountry(
          //   buttonFlag: currentFlag,
          //   buttonTap: tappingBTLanguage,
          //   buttonON: countryPageIsOn == true ? true : false
          // ),

          SizedBox(
            width: 5,
          ),

          // --- LANGUAGE BUTTON
          // ABLocalizerBT(
          //   buttonVerse: Wordz.language(context),
          //   buttonIcon: '',
          //   buttonTap: tappingBTLanguage,
          //   buttonOn: currentPage == LocalizerPage.Language ? true : false,
          // ),

         //  BTLocalizerLanguage(
         //   buttonTap: tappingBTLanguage,
         //   buttonON: countryPageIsOn == true ? false : true
         // ),

        ],
      ),
    );
}
}
