import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/localization/localizer.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/providers/zones/old_zone_provider.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog_buttons.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocaleBubble extends StatefulWidget {
  final Function changeCountry;
  final Function changeCity;
  final Function changeDistrict;
  final Zone currentZone;
  final String title;

  const LocaleBubble({
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
    super.initState();
    _userZone = widget.currentZone;
    // CountryProvider _countryPro = Provider.of<CountryProvider>(context, listen: false);
    _chosenCountryID = _userZone.countryID ;// == null ? _countryPro.currentCountryID : _userZone.countryID;
    _chosenCityID = _userZone.cityID ;// == null ? _countryPro.currentProvinceID : _userZone.provinceID;
    _chosenDistrictID = _userZone.districtID ;// == null ? _countryPro.currentDistrictID : _userZone.districtID;
  }

// -----------------------------------------------------------------------------
  void _closeBottomSheet(){
    Navigator.of(context).pop();
  }
// -----------------------------------------------------------------------------
  Future<void> _tapCountryButton({BuildContext context, OldCountryProvider countryPro, List<Map<String, String>> flags}) async {

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    await BottomDialog.showBottomDialog(
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
  Future<void> _tapCityButton({BuildContext context, OldCountryProvider countryPro, List<Map<String, String>> cities}) async {

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    await BottomDialog.showBottomDialog(
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
  Future<void> _tapDistrictButton({BuildContext context, OldCountryProvider countryPro, List<Map<String, String>> districts}) async {

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    await BottomDialog.showBottomDialog(
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
    final OldCountryProvider _countryPro =  Provider.of<OldCountryProvider>(context, listen: true);

    final List<Map<String,String>> _flags = _countryPro.getAvailableCountries(context);
    final List<Map<String,String>> _cities = _countryPro.getCitiesNamesMapsByIso3(context, _chosenCountryID);//_chosenCountry);
    final List<Map<String,String>> _districts = _countryPro.getDistrictsNameMapsByCityID(context, _chosenCityID);//_chosenProvince);

    final String _chosenCountryName = _chosenCountryID == null ? '...' : Localizer.translate(context, _chosenCountryID);
    final String _chosenCountryFlag = _chosenCountryID == null ? '' : Flagz.getFlagByCountryID(_chosenCountryID);
    final String _chosenCityName = _chosenCityID == null ? '...' : _countryPro.getCityNameWithCurrentLanguageIfPossible(context, _chosenCityID);
    final String _chosenDistrictName = _chosenDistrictID == null ? '...' : _countryPro.getDistrictNameWithCurrentLanguageIfPossible(context, _chosenDistrictID);


    // double _bubbleClearWidth = Scale.superBubbleClearWidth(context);
    // double _buttonsSpacing = Ratioz.ddAppBarMargin;
    // double _buttonWidth = (_bubbleClearWidth / 3)-((2*_buttonsSpacing)/3);

    return Bubble(
      title: widget.title,
        redDot: true,
        columnChildren: <Widget>[

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// COUNTRY BUTTON
              LocaleButton(
                  title: Wordz.country(context),
                  icon: _chosenCountryFlag, //geebCountryFlagByCountryName(context),
                  verse: _chosenCountryName,
                  onTap: () => _tapCountryButton(context: context, flags: _flags, countryPro: _countryPro ),
              ),

              /// PROVINCE BUTTON
              LocaleButton(
                title: 'City', //Wordz.province(context),
                verse: _chosenCityName,
                onTap: () => _tapCityButton(context: context, cities: _cities, countryPro: _countryPro ),
              ),

              /// AREA BUTTON
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

    final double _bubbleClearWidth = Bubble.clearWidth(context);
    const double _buttonsSpacing = Ratioz.appBarPadding;
    final double _buttonWidth = (_bubbleClearWidth / 3)-((2*_buttonsSpacing)/3);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _buttonsSpacing),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// TITLE
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

          /// BUTTON CONTENTS
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
