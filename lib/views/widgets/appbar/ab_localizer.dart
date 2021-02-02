import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/localizers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/localization/language_class.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../main.dart';
import 'ab_strip.dart';
import 'buttons/bt_localizer.dart';
import 'buttons/flagbox.dart';

enum LocalizerPage {
  Country,
  City,
  Language,
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
  void _triggerLanguageButton(){
      _localizerPage != LocalizerPage.Language ?
    setState(() {
      _localizerPage = LocalizerPage.Language;
    }):
      widget.triggerLocalizer();
  }
// ---------------------------------------------------------------------------
  void _triggerCountryButton(){
    _localizerPage != LocalizerPage.Country ?
    setState(() {
      _localizerPage = LocalizerPage.Country;
    }):
    widget.triggerLocalizer();
  }
// ---------------------------------------------------------------------------
  void _tapCountry(String iso3){
    print(iso3);
    setState(() {
      _localizerPage = LocalizerPage.City;
      _chosenCountry = iso3;
    });
  }
// ---------------------------------------------------------------------------
  void _tapProvince(String provinceID){
    print(provinceID);
    setState(() {
      _chosenProvince = provinceID;
    });
  }

  void _tapArea(String areaID){
    print(areaID);
    setState(() {
      _chosenArea = areaID;
    });
  }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    List<Map<String,String>> _flags = _countryPro.getAvailableCountries();
    List<Map<String,String>> _provinces = _countryPro.getProvincesNames(context, _chosenCountry);
    List<Map<String,String>> _areas = _countryPro.getAreasNames(context, _chosenProvince);

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

    return ABStrip(
      abHeight: _abHeight,
      scrollable: false,
      appBarType: AppBarType.Localizer,
      rowWidgets: <Widget>[
        Padding(
          padding: EdgeInsets.all(_abPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

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
                    boxFunction: _triggerLanguageButton,
                  ),

                  // --- LOCALIZER BUTTON
                  LocalizerButton(
                    onTap: _triggerCountryButton,
                    isOn: _localizerPage == LocalizerPage.Country ? true : false
                  ),

                ],
              ),

              // --- COUNTRIES LIST
              _localizerPage == LocalizerPage.Country ?
              Container(
                height: _listHeight,
                width: _inBarClearWidth,
                margin: EdgeInsets.only(top: _abPadding),
                decoration: BoxDecoration(
                color: Colorz.WhiteAir,
                  borderRadius: superBorderAll(context, _listCorner),
                ),
                alignment: Alignment.centerRight,
                child:

                countryFlags(
                  context: context,
                  countryNameButtonWidth: _countryNameButtonWidth,
                  countryPro: _countryPro,
                  flags: _flags,
                  tapCountry: (iso3)=> _tapCountry(iso3),
                ),

              )
                  :
              _localizerPage == LocalizerPage.City ?
              Container(
                height: _listHeight,
                width: _inBarClearWidth,
                margin: EdgeInsets.only(top: _abPadding),
                decoration: BoxDecoration(
                  color: Colorz.WhiteAir,
                  borderRadius: superBorderAll(context, _listCorner),
                ),
                alignment: Alignment.centerRight,
                child:
                ListView.builder(
                  itemCount: _provinces.length,
                    itemBuilder: (context, index){
                    Map<String,String> _province = _provinces[index];
                    String _provinceID = _province['id'];
                    String _provinceName = _province['name'];

                    return
                        ChangeNotifierProvider.value(
                          value: _countryPro,
                          child: DreamBox(
                            height: 35,
                            verse: _provinceName,
                            bubble: false,
                            boxMargins: EdgeInsets.all(5),
                            verseScaleFactor: 0.7,
                            color: Colorz.WhiteAir,
                            boxFunction: () {

                              _tapProvince(_provinceID);
                              _countryPro.changeArea(_provinceID);
                            }, // should be the id instead,, later
                          ),
                        );
                    },
                ),

              )
                  :
              // --- LANGUAGES LIST
              _localizerPage == LocalizerPage.Language ?
              Container(
                height: _listHeight,
                width: _inBarClearWidth,
                margin: EdgeInsets.only(top: _abPadding),
                decoration: BoxDecoration(
                  color: Colorz.WhiteAir,
                  borderRadius: superBorderAll(context, _listCorner),
                ),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List<Widget>.generate(
                        LanguageClass.languageList().length, (index){
                      return
                        DreamBox(
                          height: 40,
                          verseScaleFactor: 0.6,
                          boxMargins: EdgeInsets.all(_abPadding),
                          verse: LanguageClass.languageList()[index].langName,
                          boxFunction: () async {
                            Locale _temp = await setLocale(LanguageClass.languageList()[index].langCode);
                            BldrsApp.setLocale(context, _temp);
                          },
                        );
                    }
                    ),
                  ),
                ),

              )
                  :
              Container()
            ],
          ),
        ),
      ],
    );
}
}

Widget countryFlags ({
  BuildContext context,
  CountryProvider countryPro,
  List<Map<String,String>> flags,
  Function tapCountry,
  double countryNameButtonWidth,
}){

  double _abPadding = Ratioz.ddAppBarPadding;
  return
    ListView.builder(
        itemCount: flags.length,
        itemBuilder: (context, index){

          String _newCountry = flags[index]["iso3"];


          void _selectCountry(String iso3){
            countryPro.changeCountry(iso3);
            countryPro.changeArea('...');
            print('country is : $_newCountry');
          }

          return ChangeNotifierProvider.value(
            value: countryPro,
            child: Row(
              textDirection: superInverseTextDirection(context),
              children: <Widget>[

                SizedBox(
                  width: (Ratioz.ddAppBarPadding),
                ),

                FlagBox(
                  flag: countryPro.superFlag(_newCountry),
                  onTap: (){
                    tapCountry(_newCountry);
                    _selectCountry(_newCountry);
                    },
                ),

                DreamBox(
                  height: 40,
                  width: countryNameButtonWidth,
                  bubble: false,
                  color: Colorz.WhiteAir,
                  verseScaleFactor: 0.6,
                  boxMargins: EdgeInsets.all(_abPadding),
                  verse: translate(context, _newCountry),
                  boxFunction: (){
                    tapCountry(_newCountry);
                    _selectCountry(_newCountry);
                    },
                  textDirection: superInverseTextDirection(context),

                ),

              ],
            ),
          );
        }
        );
}