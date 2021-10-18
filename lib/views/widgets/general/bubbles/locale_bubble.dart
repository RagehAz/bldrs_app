import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/helpers/map_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/district_model.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/providers/zone_provider.dart';
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
  CountryModel _selectedCountry;
  String _selectedCityID;
  String _selectedDistrictID;
  Zone _userZone;
  ZoneProvider _zoneProvider;

  @override
  void initState() {
    super.initState();
    _userZone = widget.currentZone;
    _zoneProvider =  Provider.of<ZoneProvider>(context, listen: false);

    _selectedCountry = _zoneProvider.userCountryModel;
    _selectedCityID = _userZone.cityID;
    _selectedDistrictID = _userZone.districtID;
  }

// -----------------------------------------------------------------------------
  Future<void> _closeBottomSheet() async {
    await Navigator.of(context).pop();
  }
// -----------------------------------------------------------------------------
  Future<void> _tapCountryButton({@required BuildContext context}) async {

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    List<MapModel> _countriesMapModels = CountryModel.getAllCountriesNamesMapModels(context);

    await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      height: null,
      child: BottomDialogButtons(
        mapsModels: _countriesMapModels,
        alignment: Alignment.center,
        bottomDialogType: BottomDialogType.countries,
        buttonTap: (countryID){

          setState(() {
            _selectedCountry = countryID;
            _selectedCityID = null;
            _selectedDistrictID = null;
          });

          widget.changeCountry(countryID);
          print('_currentCountryID : $_selectedCountry');

          _closeBottomSheet();
        },
      ),
    );
  }
// -----------------------------------------------------------------------------
  Future<void> _tapCityButton({@required BuildContext context}) async {

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    final List<MapModel> _citiesMapModels = CityModel.getCitiesNamesMapModels(
        context : context,
        cities: _selectedCountry.cities
    );

    await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      height: null,
      child: BottomDialogButtons(
        mapsModels: _citiesMapModels,
        alignment: Alignment.center,
        bottomDialogType: BottomDialogType.cities,
        buttonTap: (provinceID){
          setState(() {
            _selectedCityID = provinceID;
            _selectedDistrictID = null;
          });
          widget.changeCity(provinceID);
          print('_currentProvince : $_selectedCityID');
          _closeBottomSheet();
        },
      ),
    );
  }
// -----------------------------------------------------------------------------
  Future<void> _tapDistrictButton({@required BuildContext context}) async {

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    List<DistrictModel> _selectedCityDistricts = DistrictModel.getDistrictsFromCountryModel(
      country: _selectedCountry,
      cityID: _selectedCityID,
    );

    List<MapModel> _districtsMapModels = DistrictModel.getDistrictsNamesMapModels(
      context: context,
      districts: _selectedCityDistricts,
    );

    await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      height: null,
      child: BottomDialogButtons(
        mapsModels: _districtsMapModels,
        alignment: Alignment.center,
        bottomDialogType: BottomDialogType.districts,
        buttonTap: (districtID){

          setState(() {
            _selectedDistrictID = districtID;
          });

          widget.changeDistrict(districtID);
          print('_current districtID : $districtID');

          _closeBottomSheet();
        },
      ),
    );
  }
// -----------------------------------------------------------------------------
  String _getSelectedCityName(){
    final String _selectedCityName = _selectedCityID == null ?
    '...'
        :
    CityModel.getTranslatedCityNameFromCountry(
        context: context,
        country: _selectedCountry,
        cityID: _selectedCityID
    );

    return _selectedCityName;
  }
// -----------------------------------------------------------------------------
  String _getSelectedDistrictName(){
    final String _selectedDistrictName = _selectedDistrictID == null ?
    '...'
        :
    DistrictModel.getTranslatedDistrictNameFromCountry(
      context: context,
      country: _selectedCountry,
      cityID: _selectedCityID,
      districtID: _selectedDistrictID,
    );

    return _selectedDistrictName;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _selectedCountryName = CountryModel.getTranslatedCountryNameByID(context: context, countryID: _selectedCountry.countryID);
    final String _selectedCountryFlag = _selectedCountry == null ? '' : Flag.getFlagIconByCountryID(_selectedCountry.countryID);

    final String _selectedCityName = _getSelectedCityName();
    final String _selectedDistrictName = _getSelectedDistrictName();


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
                  icon: _selectedCountryFlag, //geebCountryFlagByCountryName(context),
                  verse: _selectedCountryName,
                  onTap: () => _tapCountryButton(context: context),
              ),

              /// PROVINCE BUTTON
              LocaleButton(
                title: 'City', //Wordz.province(context),
                verse: _selectedCityName,
                onTap: () => _tapCityButton(context: context),
              ),

              /// AREA BUTTON
              LocaleButton(
                title: 'Area', //Wordz.area(context),
                verse: _selectedDistrictName,
                onTap: () => _tapDistrictButton(context: context),
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
