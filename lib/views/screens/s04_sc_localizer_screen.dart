import 'package:bldrs/main.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/appbar/ab_localizer.dart';
import 'package:bldrs/views/widgets/appbar/buttons/bx_flagbox.dart';
import 'package:bldrs/views/widgets/buttons/bt_main.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

import 's05_pg_countries_page.dart';
import 's06_pg_languages_page.dart';

class LocalizerScreen extends StatefulWidget {
  @override
  _LocalizerScreenState createState() => _LocalizerScreenState();
}


class _LocalizerScreenState extends State<LocalizerScreen> {

  var _btCountrySelected = true;
  String theChosenFlag = flagFileNameSelectedFromPGLanguageList;
  String theChosenCountryName = currentSelectedCountry;

  void _localizerPGSwitch(){
    setState(
        (){
          print(flagFileNameSelectedFromPGLanguageList);
             _btCountrySelected == true ?
             _btCountrySelected = false
             :
             _btCountrySelected =true ;
        }
    );
  // print('dongol');
}

  void flagSwitch(){
    setState(
        ()async{
          theChosenFlag = flagFileNameSelectedFromPGLanguageList;
          theChosenCountryName = currentSelectedCountry;
          Locale _temp = await setLocale(Wordz.languageCode(context));
          BldrsApp.setLocale(context, _temp);
        }
    );
    print(flagFileNameSelectedFromPGLanguageList);
  }

  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramids: Iconz.PyramidsGlass,
      layoutWidget: Column(
        children: <Widget>[

          // --- LOCALIZER APPBAR
          ABLocalizer(
            currentFlag: theChosenFlag,
            countryPageON: _btCountrySelected,
            tappingBTCountry: _localizerPGSwitch,
            tappingBTLanguage: _localizerPGSwitch,
          ),

          // --- COUNTRY OR LANGUAGE PAGE

          _btCountrySelected == true ?
          PGCountryList(
            tappingFlag: flagSwitch,
          )
              :
          PGLanguageList(),

          // --- TEST SUBJECT FOR LANGUAGE CHANGE
          BTMain(
            buttonVerse: 'Confirm $currentSelectedCountry',
            splashColor: Colorz.BlackBlack,
            buttonVerseShadow: true,
            buttonIcon: FlagBox(
              flag: theChosenFlag,
            ),
            buttonColor: Colorz.BlackSmoke,
            function: 'GoBackFucker',
            stretched: false,
          ),

        ],
      ),
    );
  }
}