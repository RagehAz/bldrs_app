import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
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
import 'bldrs_appbar.dart';
import 'buttons/bt_localizer.dart';
import 'buttons/bx_flagbox.dart';

enum LocalizerPage {
  Country,
  City,
  Language,
}

class ABLocalizer extends StatefulWidget {
  final Function tappingLocalizer;

  ABLocalizer({
    this.tappingLocalizer,
  });

  @override
  _ABLocalizerState createState() => _ABLocalizerState();
}

class _ABLocalizerState extends State<ABLocalizer> {
  LocalizerPage _localizerPage;
// ---------------------------------------------------------------------------
  @override
  void initState() {
    _localizerPage = LocalizerPage.Country;
    super.initState();
  }
// ---------------------------------------------------------------------------
  void _openLanguageList(){
    setState(() {
      _localizerPage = LocalizerPage.Language;
    });
  }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    List<Map<String,String>> _flags = _countryPro.flagsMaps;

    double _abPadding =  Ratioz.ddAppBarPadding;
    double _inBarClearWidth = superScreenWidth(context)
        - (Ratioz.ddAppBarMargin * 2)
        - (_abPadding * 2);
    /// standard is Ratioz.ddAppBarHeight;
    double _abHeight = superScreenHeight(context) - Ratioz.ddPyramidsHeight;
    double _listHeight = _abHeight - Ratioz.ddAppBarHeight - (_abPadding) ;
    double _listCorner = Ratioz.ddAppBarCorner - _abPadding;
    double _languageButtonWidth = Ratioz.ddAppBarHeight - (_abPadding *2);

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
                    height: _languageButtonWidth,
                    icon:Iconz.Language,
                    iconSizeFactor: 0.6,
                    boxMargins: EdgeInsets.symmetric(horizontal: _abPadding),
                    bubble: false,
                    color: _localizerPage == LocalizerPage.Language ? Colorz.Yellow : Colorz.WhiteAir,
                    verse: Wordz.languageName(context),
                    textDirection: superInverseTextDirection(context),
                    boxFunction: _openLanguageList,
                  ),

                  // --- LOCALIZER BUTTON
                  LocalizerButton(
                    onTap: widget.tappingLocalizer,
                    isOn: _localizerPage == LocalizerPage.Country ? true : false
                  ),

                ],
              ),

              // --- COUNTRIES, CITIES & LANGUAGES LISTS
              _localizerPage == LocalizerPage.Country ?
              ClipRRect(
                borderRadius: superBorderAll(context, _listCorner),
                child: Container(
                  height: _listHeight,
                  width: _inBarClearWidth,
                  margin: EdgeInsets.only(top: _abPadding),
                  decoration: BoxDecoration(
                  color: Colorz.WhiteAir,
                    borderRadius: superBorderAll(context, _listCorner),
                  ),
                  alignment: Alignment.centerRight,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List<Widget>.generate(
                        _flags.length, (index){

                        void _selectCountry(){
                          String _newCountry = _flags[index]["iso3"];
                          _countryPro.changeCountry(_flags[index]["iso3"]);
                          widget.tappingLocalizer();
                          print('country is : $_newCountry');
                        }

                          return
                              ChangeNotifierProvider.value(
                                value: _countryPro,
                                child: Row(
                                  children: <Widget>[

                                    FlagBox(
                                      flag: _countryPro.superFlag(_flags[index]["iso3"]),
                                      onTap: _selectCountry,
                                    ),

                                    DreamBox(
                                      height: 40,
                                      bubble: false,
                                      color: Colorz.WhiteAir,
                                      verseScaleFactor: 0.6,
                                      boxMargins: EdgeInsets.all(_abPadding),
                                      // icon: _countryPro.superFlag(_flags[index]["iso3"]),
                                      verse: translate(context, _flags[index]["iso3"]),
                                      boxFunction: _selectCountry,
                                    ),

                                  ],
                                ),
                              );
                      }
                      ),
                    ),
                  ),

                ),
              )
                  :
              _localizerPage == LocalizerPage.Language ?
              ClipRRect(
                borderRadius: superBorderAll(context, _listCorner),
                child: Container(
                  height: _listHeight,
                  width: _inBarClearWidth,
                  margin: EdgeInsets.only(top: _abPadding),
                  decoration: BoxDecoration(
                    color: Colorz.WhiteAir,
                    borderRadius: superBorderAll(context, _listCorner),
                  ),
                  alignment: Alignment.centerRight,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
