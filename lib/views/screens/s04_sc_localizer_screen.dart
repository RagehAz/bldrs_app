import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/appbar/ab_localizer.dart';
import 'package:bldrs/views/widgets/buttons/bt_main.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 's05_pg_countries_page.dart';
import 's06_pg_languages_page.dart';

enum LocalizerPage {
  Country,
  City,
  Language,
}

class LocalizerScreen extends StatefulWidget {
  @override
  _LocalizerScreenState createState() => _LocalizerScreenState();
}

class _LocalizerScreenState extends State<LocalizerScreen> {
  LocalizerPage _currentPage;
// ---------------------------------------------------------------------------
  @override
  void initState() {
    _currentPage = LocalizerPage.Country;
    super.initState();
  }
// ---------------------------------------------------------------------------
  void _openCountriesList(){
    setState((){_currentPage = LocalizerPage.Country;});
}
// ---------------------------------------------------------------------------
  void _openLanguagesList(){
    setState(() {_currentPage = LocalizerPage.Language;});
  }
// ---------------------------------------------------------------------------
//   void flagSwitch() async {
//     Locale _temp = await setLocale(Wordz.languageCode(context));
//     BldrsApp.setLocale(context, _temp);
//     setState(() {
//       theChosenFlag = flagFileNameSelectedFromPGLanguageList;
//       theChosenCountryName = currentSelectedCountry;
//     });
//     print(flagFileNameSelectedFromPGLanguageList);
//   }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramids: Iconz.PyramidsGlass,
      appBarType: AppBarType.Localizer,
      tappingRageh: (){
        // superFlag('egy');
      },

      layoutWidget: Column(
        children: <Widget>[

          // --- LOCALIZER APPBAR
          ABLocalizer(
            currentPage: _currentPage,
          ),

          // --- COUNTRY OR LANGUAGE PAGE
          _currentPage == LocalizerPage.Country ?
          PGCountryList()
              :
          PGLanguageList(),

          // --- TEST SUBJECT FOR LANGUAGE CHANGE
          BTMain(
            buttonVerse: '${Wordz.confirm(context)}',
            splashColor: Colorz.BlackBlack,
            buttonVerseShadow: true,
            buttonIcon: Iconz.DvDonaldDuck,
            buttonColor: Colorz.BlackSmoke,
            function: 'GoBackFucker',
            stretched: false,
          ),

        ],
      ),
    );
  }
}