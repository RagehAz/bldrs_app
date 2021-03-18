import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/localization/language_class.dart';
import 'package:bldrs/controllers/localization/localization_constants.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/views/widgets/buttons/bt_list.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../main.dart';
import 'ab_strip.dart';
import 'buttons/bt_localizer.dart';
enum LocalizerPage {
  Country,
  Province,
  Area,
  Language,
  BottomSheet,
}

class ABLocalizer extends StatefulWidget {
  final Function triggerLocalizer;

  ABLocalizer({
    this.triggerLocalizer,
  });

  @override
  _ABLocalizerState createState() => _ABLocalizerState();
}

class _ABLocalizerState extends State<ABLocalizer> {
  LocalizerPage _localizerPage;
  String _chosenCountryID;
  String _chosenProvinceID;
  String _chosenAreaID;
// ---------------------------------------------------------------------------
  @override
  void initState() {
    _localizerPage = LocalizerPage.Country;
    super.initState();
  }
// ---------------------------------------------------------------------------
  void _exitLocalizer(){
      widget.triggerLocalizer();
  }
// ---------------------------------------------------------------------------
  void _tapLocalizerButton(){
    _localizerPage != LocalizerPage.Country?
    setState(() {
      _localizerPage = LocalizerPage.Country;
    }):
    _exitLocalizer();
  }
// ---------------------------------------------------------------------------
  void _tapLanguageButton(){
    _localizerPage != LocalizerPage.Language?
    setState(() {
      _localizerPage = LocalizerPage.Language;
    }):
    _exitLocalizer();
  }
// ---------------------------------------------------------------------------
  void _tapCountry(String countryID, CountryProvider _countryPro){
    setState(() {
      _chosenCountryID = countryID;
      _localizerPage = LocalizerPage.Province;
    });
    _countryPro.changeCountry(countryID);
    _countryPro.changeProvince('...');
    _countryPro.changeArea('...');
    print('selected country id is : $countryID');
  }
// ---------------------------------------------------------------------------
  void _tapProvince(String provinceID, CountryProvider _countryPro){
    setState(() {
      _localizerPage = LocalizerPage.Area;
      _chosenProvinceID = provinceID;
    });
    _countryPro.changeProvince(provinceID);
    print('selected province id is : $provinceID');

  }
// ---------------------------------------------------------------------------
  void _tapArea(String areaID, CountryProvider _countryPro){
    setState(() {
      _chosenAreaID = areaID;
    });
    print('selected city id is : $areaID');
    _countryPro.changeArea(areaID);
    _exitLocalizer();
  }
// ---------------------------------------------------------------------------
void _tapLanguage(String languageCode) async {
    print(languageCode);
    Locale _temp = await setLocale(languageCode);
    BldrsApp.setLocale(context, _temp);
}
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);

    List<Map<String,String>> _flags = _countryPro.getAvailableCountries(context);
    List<Map<String,String>> _provinces = _countryPro.getProvincesNamesByIso3(context, _chosenCountryID);//_chosenCountry);
    List<Map<String,String>> _areas = _countryPro.getAreasNamesByProvinceID(context, _chosenProvinceID);//_chosenProvince);

    List<LanguageClass> _languagesModels = LanguageClass.languageList();
    List<Map<String,String>> _languages = geebMapsOfLanguagesFromLanguageClassList(_languagesModels);

    double _abPadding =  Ratioz.ddAppBarPadding;
    double _inBarClearWidth = superScreenWidth(context)
        - (Ratioz.ddAppBarMargin * 2)
        - (_abPadding * 2);
    /// standard is Ratioz.ddAppBarHeight;
    double _abHeight = superScreenHeight(context) - Ratioz.ddPyramidsHeight;
    // double _listHeight = _abHeight - Ratioz.ddAppBarHeight - (_abPadding) ;
    // double _listCorner = Ratioz.ddAppBarCorner - _abPadding;
    double _languageButtonHeight = Ratioz.ddAppBarHeight - (_abPadding *2);

    // double _countryNameButtonWidth = _inBarClearWidth - _abPadding*3 - 35;

    double _confirmButtonWidth = _inBarClearWidth * 0.6;
    EdgeInsets _confirmButtonMargins = appIsLeftToRight(context) ? EdgeInsets.only(top: 5, right: _inBarClearWidth-_confirmButtonWidth) : EdgeInsets.only(top: 5);

    String _localizerTitle =
    _localizerPage == LocalizerPage.Country ? 'Choose Country' :
    _localizerPage == LocalizerPage.Province ? 'Choose Province' :
    _localizerPage == LocalizerPage.Area ? 'Choose Area' :
    _localizerPage == LocalizerPage.Area ? 'Select app language' :
        'Choose';

    return ABStrip(
      abHeight: _abHeight,
      scrollable: false,
      appBarType: AppBarType.Localizer,
      rowWidgets: <Widget>[
        Container(
          width: _inBarClearWidth + _abPadding + _abPadding,
          padding: EdgeInsets.all(_abPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[

              // --- APPBAR BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Align(
                    alignment: Alignment.centerRight,
                    child: DreamBox(
                      height: _languageButtonHeight,
                      width: _languageButtonHeight,
                      icon: superBackIcon(context),
                      iconSizeFactor: 1,
                      bubble: true,
                      color: Colorz.WhiteAir,
                      textDirection: superInverseTextDirection(context),
                      boxFunction: () => _exitLocalizer(),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      height: _languageButtonHeight,
                      width: 20,
                      // color: Colorz.BloodRedZircon,
                    ),
                  ),

                  // --- LANGUAGE BUTTON
                  DreamBox(
                    height: _languageButtonHeight,
                    icon: Iconz.Language,
                    iconSizeFactor: 0.6,
                    boxMargins: EdgeInsets.symmetric(horizontal: _abPadding),
                    bubble: false,
                    color: _localizerPage == LocalizerPage.Language ? Colorz.Yellow : Colorz.WhiteAir,
                    verse: Wordz.languageName(context),
                    textDirection: superInverseTextDirection(context),
                    boxFunction: _tapLanguageButton,
                  ),

                  // --- LOCALIZER BUTTON
                  LocalizerButton(
                    onTap: _tapLocalizerButton,
                    isOn: _localizerPage == LocalizerPage.Language ? false : true,
                  ),

                ],
              ),

              // --- PAGE TITLE
              DreamBox(
                height: 34,
                width: _inBarClearWidth,
                boxMargins: EdgeInsets.only(top: 5),
                verse: _localizerTitle,
                verseScaleFactor: 0.9,
                bubble: false,
              ),

              // --- PAGE TAG LINE
              Container(
                width: _inBarClearWidth,
                child: SuperVerse(
                  maxLines: 2,
                  verse: 'To browse the builders of specific cities and areas',
                  size: 1,
                  color: Colorz.WhiteLingerie,
                  weight: VerseWeight.thin,
                  italic: true,
                ),
              ),

              // --- PAGES
              _localizerPage == LocalizerPage.Country ?
              ButtonsList(
                listOfMaps: _flags,
                mapValueIs: MapValueIs.flag,
                alignment: superInverseCenterAlignment(context),
                provider: _countryPro,
                localizerPage: LocalizerPage.Country,
                buttonTap: (id) => _tapCountry(id, _countryPro),
              )
                  :
              _localizerPage == LocalizerPage.Province ?
              ButtonsList(
                listOfMaps: _provinces,
                mapValueIs: MapValueIs.String,
                alignment: Alignment.center,
                provider: _countryPro,
                localizerPage: LocalizerPage.Province,
                buttonTap: (id) => _tapProvince(id, _countryPro),
              )
                  :
              _localizerPage == LocalizerPage.Area ?
              ButtonsList(
                listOfMaps: _areas,
                mapValueIs: MapValueIs.String,
                alignment: Alignment.center,
                provider: _countryPro,
                localizerPage: LocalizerPage.Area,
                buttonTap: (id) => _tapArea(id, _countryPro),
              )
                  :
              _localizerPage == LocalizerPage.Language ?
              ButtonsList(
                listOfMaps: _languages,
                mapValueIs: MapValueIs.String,
                alignment: Alignment.center,
                provider: _countryPro,
                localizerPage: LocalizerPage.Language,
                buttonTap: (value) => _tapLanguage(value),
              )
                  :
              Container(),

              // --- CONFIRM BUTTON
              DreamBox(
                width: _confirmButtonWidth,
                height: 50,
                color: Colorz.WhiteGlass,
                verse: '${Wordz.confirm(context)}',
                verseColor: Colorz.White,
                verseWeight: VerseWeight.black,
                verseScaleFactor: 0.7,
                boxMargins: _confirmButtonMargins,
                boxFunction: _exitLocalizer,
              ),

            ],
          ),
        ),
      ],
    );
}
}

// Widget countryFlags ({
//   BuildContext context,
//   CountryProvider countryPro,
//   List<Map<String,String>> flags,
//   Function tapCountry,
//   double countryNameButtonWidth,
// }){
//
//   double _abPadding = Ratioz.ddAppBarPadding;
//   return
//     ListView.builder(
//         itemCount: flags.length,
//         itemBuilder: (context, index){
//
//           String _newCountry = flags[index]["iso3"];
//
//           void _selectCountry(String iso3){
//             countryPro.changeCountry(iso3);
//             countryPro.changeArea('...');
//             print('country is : $_newCountry');
//           }
//
//           return ChangeNotifierProvider.value(
//             value: countryPro,
//             child: Row(
//               textDirection: superInverseTextDirection(context),
//               children: <Widget>[
//
//                 SizedBox(
//                   width: (Ratioz.ddAppBarPadding),
//                 ),
//
//                 FlagBox(
//                   flag: countryPro.superFlag(_newCountry),
//                   onTap: (){
//                     tapCountry(_newCountry);
//                     _selectCountry(_newCountry);
//                   },
//                 ),
//
//                 DreamBox(
//                   height: 40,
//                   width: countryNameButtonWidth,
//                   bubble: false,
//                   color: Colorz.WhiteAir,
//                   verseScaleFactor: 0.6,
//                   boxMargins: EdgeInsets.all(_abPadding),
//                   verse: translate(context, _newCountry),
//                   boxFunction: (){
//                     tapCountry(_newCountry);
//                     _selectCountry(_newCountry);
//                   },
//                   textDirection: superInverseTextDirection(context),
//
//                 ),
//
//               ],
//             ),
//           );
//         }
//     );
// }

// // --- COUNTRIES LIST
// _localizerPage == LocalizerPage.Country ?
// Container(
//   height: _listHeight,
//   width: _inBarClearWidth,
//   margin: EdgeInsets.only(top: _abPadding),
//   decoration: BoxDecoration(
//   color: Colorz.WhiteAir,
//     borderRadius: superBorderAll(context, _listCorner),
//   ),
//   alignment: Alignment.centerRight,
//   child:
//
//   countryFlags(
//     context: context,
//     countryNameButtonWidth: _countryNameButtonWidth,
//     countryPro: _countryPro,
//     flags: _flags,
//     tapCountry: (iso3)=> _tapCountry(iso3),
//   ),
//
// )
//     :
// _localizerPage == LocalizerPage.Province ?
// Container(
//   height: _listHeight,
//   width: _inBarClearWidth,
//   margin: EdgeInsets.only(top: _abPadding),
//   decoration: BoxDecoration(
//     color: Colorz.WhiteAir,
//     borderRadius: superBorderAll(context, _listCorner),
//   ),
//   alignment: Alignment.centerRight,
//   child:
//   ListView.builder(
//     itemCount: _provinces.length,
//       itemBuilder: (context, index){
//       Map<String,String> _province = _provinces[index];
//       String _provinceID = _province['id'];
//       String _provinceName = _province['name'];
//
//       return
//           ChangeNotifierProvider.value(
//             value: _countryPro,
//             child: DreamBox(
//               height: 35,
//               verse: _provinceName,
//               bubble: false,
//               boxMargins: EdgeInsets.all(5),
//               verseScaleFactor: 0.7,
//               color: Colorz.WhiteAir,
//               boxFunction: () {
//
//                 _tapProvince(_provinceID);
//                 _countryPro.changeProvince(_provinceID);
//               }, // should be the id instead,, later
//             ),
//           );
//       },
//   ),
//
// )
//     :
// _localizerPage == LocalizerPage.Area ?
// Container(
//   height: _listHeight,
//   width: _inBarClearWidth,
//   margin: EdgeInsets.only(top: _abPadding),
//   decoration: BoxDecoration(
//     color: Colorz.WhiteAir,
//     borderRadius: superBorderAll(context, _listCorner),
//   ),
//   alignment: Alignment.centerRight,
//   child:
//   ListView.builder(
//     itemCount: _areas.length,
//     itemBuilder: (context, index){
//       Map<String,String> _area = _areas[index];
//       String _areaName = _area['id'];
//       String = _area['name'];
//
//       return
//         ChangeNotifierProvider.value(
//           value: _countryPro,
//           child: DreamBox(
//             height: 35,
//             verse: _provinceName,
//             bubble: false,
//             boxMargins: EdgeInsets.all(5),
//             verseScaleFactor: 0.7,
//             color: Colorz.WhiteAir,
//             boxFunction: () {
//
//               _tapProvince(_provinceID);
//               _countryPro.changeProvince(_provinceID);
//             }, // should be the id instead,, later
//           ),
//         );
//     },
//   ),
//
// )
//     :
//
// // --- LANGUAGES LIST
// _localizerPage == LocalizerPage.Language ?
// Container(
//   height: _listHeight,
//   width: _inBarClearWidth,
//   margin: EdgeInsets.only(top: _abPadding),
//   decoration: BoxDecoration(
//     color: Colorz.WhiteAir,
//     borderRadius: superBorderAll(context, _listCorner),
//   ),
//   alignment: Alignment.center,
//   child: SingleChildScrollView(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: List<Widget>.generate(
//           LanguageClass.languageList().length, (index){
//         return
//           DreamBox(
//             height: 40,
//             verseScaleFactor: 0.6,
//             boxMargins: EdgeInsets.all(_abPadding),
//             verse: LanguageClass.languageList()[index].langName,
//             boxFunction: () async {
//             },
//           );
//       }
//       ),
//     ),
//   ),
//
// )
//     :
// Container()


