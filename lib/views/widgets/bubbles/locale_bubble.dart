import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/localization/localizer.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/providers/zones/zone_provider.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog/bottom_dialog_buttons.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LocaleBubble extends StatefulWidget {
  final Function changeCountry;
  final Function changeCity;
  final Function changeDistrict;
  final Zone currentZone;
  final String title;

  LocaleBubble({
    @required this.changeCountry,
    @required this.changeCity,
    @required this.changeDistrict,
    @required this.currentZone,
    this.title = 'Preferred Location',
});

  @override
  _LocaleBubbleState createState() => _LocaleBubbleState();
}

class _LocaleBubbleState extends State<LocaleBubble> {
  String _chosenCountryID;
  String _chosenCityID;
  String _chosenDistrictID;
  Zone _userZone;


  @override
  void initState() {
    _userZone = widget.currentZone;
    CountryProvider _countryPro = Provider.of<CountryProvider>(context, listen: false);
    _chosenCountryID = _userZone.countryID ;// == null ? _countryPro.currentCountryID : _userZone.countryID;
    _chosenCityID = _userZone.cityID ;// == null ? _countryPro.currentProvinceID : _userZone.provinceID;
    _chosenDistrictID = _userZone.districtID ;// == null ? _countryPro.currentDistrictID : _userZone.districtID;
    super.initState();
  }

// -----------------------------------------------------------------------------
  void _closeBottomSheet(){
    Navigator.of(context).pop();
  }
// -----------------------------------------------------------------------------
  void _tapCountryButton({BuildContext context, CountryProvider countryPro, List<Map<String, String>> flags}){
    Keyboarders.minimizeKeyboardOnTapOutSide(context);
    BottomDialog.slideBottomDialog(
      context: context,
      draggable: true,
      height: null,
      child: BottomDialogButtons(
        listOfMaps: flags,
        mapValueIs: MapValueIs.flag,
        alignment: Alignment.center,
        provider: countryPro,
        sheetType: BottomSheetType.BottomSheet,
        buttonTap: (countryID){
          setState(() {
            _chosenCountryID = countryID;
            _chosenCityID = null;
            _chosenDistrictID = null;
          });
          widget.changeCountry(countryID);
          print('_currentCountryID : $_chosenCountryID');
          _closeBottomSheet();
        },
      ),
    );
  }
// -----------------------------------------------------------------------------
  void _tapCityButton({BuildContext context, CountryProvider countryPro, List<Map<String, String>> cities}){
    Keyboarders.minimizeKeyboardOnTapOutSide(context);
    BottomDialog.slideBottomDialog(
      context: context,
      draggable: true,
      height: null,
      child: BottomDialogButtons(
        listOfMaps: cities,
        mapValueIs: MapValueIs.String,
        alignment: Alignment.center,
        provider: countryPro,
        sheetType: BottomSheetType.Province,
        buttonTap: (provinceID){
          setState(() {
            _chosenCityID = provinceID;
            _chosenDistrictID = null;
          });
          widget.changeCity(provinceID);
          print('_currentProvince : $_chosenCityID');
          _closeBottomSheet();
        },
      ),
    );
  }
// -----------------------------------------------------------------------------
  void _tapDistrictButton({BuildContext context, CountryProvider countryPro, List<Map<String, String>> districts}){
    Keyboarders.minimizeKeyboardOnTapOutSide(context);
    BottomDialog.slideBottomDialog(
      context: context,
      draggable: true,
      height: null,
      child: BottomDialogButtons(
        listOfMaps: districts,
        mapValueIs: MapValueIs.String,
        alignment: Alignment.center,
        provider: countryPro,
        sheetType: BottomSheetType.District,
        buttonTap: (districtID){
          setState(() {
            _chosenDistrictID = districtID;
          });
          widget.changeDistrict(districtID);
          print('_current districtID : $districtID');
          _closeBottomSheet();
        },
      ),
    );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);

    List<Map<String,String>> _flags = _countryPro.getAvailableCountries(context);
    List<Map<String,String>> _cities = _countryPro.getCitiesNamesMapsByIso3(context, _chosenCountryID);//_chosenCountry);
    List<Map<String,String>> _districts = _countryPro.getDistrictsNameMapsByCityID(context, _chosenCityID);//_chosenProvince);

    String _chosenCountryName = _chosenCountryID == null ? '...' : Localizer.translate(context, _chosenCountryID);
    String _chosenCountryFlag = _chosenCountryID == null ? '' : Flagz.getFlagByIso3(_chosenCountryID);
    String _chosenCityName = _chosenCityID == null ? '...' : _countryPro.getCityNameWithCurrentLanguageIfPossible(context, _chosenCityID);
    String _chosenDistrictName = _chosenDistrictID == null ? '...' : _countryPro.getDistrictNameWithCurrentLanguageIfPossible(context, _chosenDistrictID);


    // double _bubbleClearWidth = Scale.superBubbleClearWidth(context);
    // double _buttonsSpacing = Ratioz.ddAppBarMargin;
    // double _buttonWidth = (_bubbleClearWidth / 3)-((2*_buttonsSpacing)/3);

    return InPyramidsBubble(
      title: widget.title,
        redDot: true,
        columnChildren: <Widget>[

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              // --- COUNTRY BUTTON
              LocaleButton(
                  title: Wordz.country(context),
                  icon: _chosenCountryFlag, //geebCountryFlagByCountryName(context),
                  verse: _chosenCountryName,
                  onTap: () => _tapCountryButton(context: context, flags: _flags, countryPro: _countryPro ),
              ),

              // --- PROVINCE BUTTON
              LocaleButton(
                title: 'City', //Wordz.province(context),
                verse: _chosenCityName,
                onTap: () => _tapCityButton(context: context, cities: _cities, countryPro: _countryPro ),
              ),

              // --- AREA BUTTON
              LocaleButton(
                title: 'Area', //Wordz.area(context),
                verse: _chosenDistrictName,
                onTap: ()=>_tapDistrictButton(context: context, districts: _districts, countryPro: _countryPro),
              ),

            ],
          ),
        ]
    );
  }
}

class LocaleButton extends StatelessWidget {
  final String title;
  final String verse;
  final String icon;
  final Function onTap;

  LocaleButton({
    @required this.title,
    @required this.verse,
    this.icon,
    @required this.onTap,
});

  @override
  Widget build(BuildContext context) {

    double _bubbleClearWidth = Scale.superBubbleClearWidth(context);
    const double _buttonsSpacing = Ratioz.appBarPadding;
    double _buttonWidth = (_bubbleClearWidth / 3)-((2*_buttonsSpacing)/3);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _buttonsSpacing),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          // --- TITLE
          Container(
            width: _buttonWidth,
            child: SuperVerse(
              verse: title,
              centered: false,
              italic: true,
              weight: VerseWeight.thin,
              size: 2,
              color: Colorz.White80,
            ),
          ),

          // --- BUTTON CONTENTS
          DreamBox(
            height: 40,
            // width: _buttonWidth,
            verseScaleFactor: 0.8,
            iconSizeFactor: 0.8,
            icon: icon == null ? null : icon,
            bubble: false,
            verse: verse == null ? '' : '$verse    ',
            verseMaxLines: 2,
            color: Colorz.White10,
            onTap: onTap,
          ),

        ],
      ),
    );
  }
}
