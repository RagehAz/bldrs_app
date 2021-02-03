import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/view_brains/drafters/aligners.dart';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/iconizers.dart';
import 'package:bldrs/view_brains/drafters/localizers.dart';
import 'package:bldrs/view_brains/drafters/mappers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/localization/language_class.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../main.dart';
import 'ab_strip.dart';
import 'buttons/bt_localizer.dart';
import 'buttons/flagbox.dart';

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
  String _chosenCountry;
  String _chosenProvince;
  String _chosenArea;
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
  void _tapCountry(String iso3){
    print(iso3);
    setState(() {
      _localizerPage = LocalizerPage.Province;
      _chosenCountry = iso3;
    });
  }
// ---------------------------------------------------------------------------
  void _tapProvince(String provinceID){
    print(provinceID);
    setState(() {
      _localizerPage = LocalizerPage.Area;
      _chosenProvince = provinceID;
    });
  }
// ---------------------------------------------------------------------------
  void _tapArea(String areaID){
    print(areaID);
    setState(() {
      _chosenArea = areaID;
    });
    // _exitLocalizer();
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
    List<Map<String,String>> _flags = _countryPro.getAvailableCountries();
    List<Map<String,String>> _provinces = _countryPro.getProvincesNames(context, _chosenCountry);//_chosenCountry);
    List<Map<String,String>> _areas = _countryPro.getAreasNames(context, _chosenProvince);//_chosenProvince);
    List<LanguageClass> _languagesModels = LanguageClass.languageList();
    List<Map<String,String>> _languages = geebMapsOfLanguagesFromLanguageClassList(_languagesModels);

    double _abPadding =  Ratioz.ddAppBarPadding;
    double _inBarClearWidth = superScreenWidth(context)
        - (Ratioz.ddAppBarMargin * 2)
        - (_abPadding * 2);
    /// standard is Ratioz.ddAppBarHeight;
    double _abHeight = superScreenHeight(context) - Ratioz.ddPyramidsHeight;
    double _listHeight = _abHeight - Ratioz.ddAppBarHeight - (_abPadding) ;
    double _listCorner = Ratioz.ddAppBarCorner - _abPadding;
    double _languageButtonHeight = Ratioz.ddAppBarHeight - (_abPadding *2);

    double _countryNameButtonWidth = _inBarClearWidth - _abPadding*3 - 35;

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
                    icon:Iconz.Language,
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

              DreamBox(
                height: 34,
                width: _inBarClearWidth,
                boxMargins: EdgeInsets.only(top: 5),
                verse: _localizerTitle,
                verseScaleFactor: 0.9,
                bubble: false,
              ),

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

              _localizerPage == LocalizerPage.Country ?
              ButtonsList(
                mapFirstValues: geebListOfFirstValuesFromMaps(_flags),
                mapSecondValues: geebListOfSecondValuesFromMaps(_flags),
                provider: _countryPro,
                localizerPage: LocalizerPage.Country,
                buttonTap: (value){
                  print('value issss : $value');
                  _tapCountry(value);
                  },
              )
                  :
              _localizerPage == LocalizerPage.Province ?
              ButtonsList(
                mapFirstValues: geebListOfFirstValuesFromMaps(_provinces),
                mapSecondValues: geebListOfSecondValuesFromMaps(_provinces),
                provider: _countryPro,
                localizerPage: LocalizerPage.Province,
                buttonTap: (value){
                  print('value issss : $value');
                  _tapProvince(value);
                  },
              )
                  :
              _localizerPage == LocalizerPage.Area ?
              ButtonsList(
                mapFirstValues: geebListOfFirstValuesFromMaps(_areas),
                mapSecondValues: geebListOfSecondValuesFromMaps(_areas),
                provider: _countryPro,
                localizerPage: LocalizerPage.Area,
                buttonTap: (value){
                  print('value issss : $value');
                  _tapArea(value);
                  _exitLocalizer();
                  },
              )
                  :
              _localizerPage == LocalizerPage.Language ?
              ButtonsList(
                mapFirstValues: geebListOfFirstValuesFromMaps(_languages),
                mapSecondValues: geebListOfSecondValuesFromMaps(_languages),
                provider: _countryPro,
                localizerPage: LocalizerPage.Language,
                buttonTap: (value){
                  print('value issss : $value');
                  _tapLanguage(value);
                },
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


class ButtonsList extends StatelessWidget {
  final List<String> mapFirstValues;
  final List<String> mapSecondValues;
  final Function buttonTap;
  final CountryProvider provider;
  final LocalizerPage localizerPage;

  ButtonsList({
    @required this.mapFirstValues,
    @required this.mapSecondValues,
    @required this.buttonTap,
    @required this.provider,
    this.localizerPage = LocalizerPage.Country,
});

  @override
  Widget build(BuildContext context) {

    double _abPadding =  Ratioz.ddAppBarPadding;
    double _inBarClearWidth = superScreenWidth(context)
        - (Ratioz.ddAppBarMargin * 2)
        - (_abPadding * 2);
    /// standard is Ratioz.ddAppBarHeight;
    double _abHeight = superScreenHeight(context) - Ratioz.ddPyramidsHeight;
    double _listHeight = _abHeight - Ratioz.ddAppBarHeight - (_abPadding) - 55 - 55; // each 55 is for confirm button & title, 50 +5 margin
    double _listCorner = Ratioz.ddAppBarCorner - _abPadding;
    double _languageButtonHeight = Ratioz.ddAppBarHeight - (_abPadding *2);

    double _countryNameButtonWidth = _inBarClearWidth - _abPadding*3 - 35;


    return Container(
      height: _listHeight,
      width: _inBarClearWidth,
      margin: EdgeInsets.only(top: _abPadding),
      decoration: BoxDecoration(
        color: Colorz.WhiteAir,
        borderRadius: superBorderAll(context, _listCorner),
      ),
      child: ListView.builder(
        itemCount: mapFirstValues.length,

        itemBuilder: (context, index){

          return
            ChangeNotifierProvider.value(
              value: provider,
              child: Align(
                alignment:
                localizerPage == LocalizerPage.Language ? Alignment.center :
                localizerPage == LocalizerPage.BottomSheet? Alignment.center :
                superInverseCenterAlignment(context),
                child: DreamBox(
                  height: 35,
                  icon: localizerPage == LocalizerPage.Country || localizerPage == LocalizerPage.BottomSheet ? mapSecondValues[index] : null,
                  iconSizeFactor: 0.8,
                  verse:
                  localizerPage == LocalizerPage.Country || localizerPage == LocalizerPage.BottomSheet?
                  provider.superCountryName(context, mapFirstValues[index]) :
                  mapSecondValues[index],
                  bubble: false,
                  boxMargins: EdgeInsets.all(5),
                  verseScaleFactor: 0.8,
                  color: Colorz.WhiteAir,
                  textDirection: localizerPage == LocalizerPage.BottomSheet? superTextDirection(context) : superInverseTextDirection(context),
                  boxFunction: (){
                    if (localizerPage == LocalizerPage.Country){
                      String _newCountry = mapFirstValues[index];
                      provider.changeCountry(_newCountry);
                      provider.changeArea('...');
                      buttonTap(mapFirstValues[index]);
                    }
                    else if (localizerPage == LocalizerPage.Province)
                    {
                      String _newProvince = mapSecondValues[index];
                      // String _newAreaName
                      provider.changeProvince(_newProvince);
                      buttonTap(mapFirstValues[index]);
                    }
                    else if (localizerPage == LocalizerPage.Area)
                    {
                      String _newArea = mapSecondValues[index];
                      // String _newAreaName
                      provider.changeArea(_newArea);
                    }
                    else if (localizerPage == LocalizerPage.Language)
                    {
                      buttonTap(mapFirstValues[index]);
                    }
                    else if (localizerPage == LocalizerPage.BottomSheet)
                    {
                      buttonTap(mapFirstValues[index]);
                    }
                    else {
                      buttonTap(mapFirstValues[index]);
                    }

                  }

                ),
              ),
            );
        },
      ),

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


