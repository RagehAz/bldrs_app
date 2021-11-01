import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/secondary_models/map_model.dart';
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
  final ZoneModel currentZone;
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
  List<CityModel> _countryCities;
  CityModel _selectedCity;
  ZoneModel _selectedZone;
  ZoneProvider _zoneProvider;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if(mounted){

      if (function == null){
        setState(() {
          _loading = !_loading;
        });
      }

      else {
        setState(() {
          _loading = !_loading;
          function();
        });
      }

    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _selectedZone = widget.currentZone;
    _zoneProvider =  Provider.of<ZoneProvider>(context, listen: false);

    _selectedCountry = _zoneProvider.userCountryModel;
  }

// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      if (_selectedZone.isNotEmpty()){

        _triggerLoading().then((_) async{

          final CountryModel _country = await _zoneProvider.fetchCountryByID(context: context, countryID: _selectedZone.countryID);
          final CityModel _city = await _zoneProvider.fetchCityByID(context: context, cityID: _selectedZone.cityID);

          _triggerLoading(
              function: (){
                _selectedCountry = _country;
                _selectedCity = _city;
              }
          );
        });


      }

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
//   @override
//   void didUpdateWidget(covariant LocaleBubble oldBubble) {
//     if(oldBubble.currentZone != widget.currentZone){
//       setState(() {
//
//       });
//
//       // _isInit = true;
//       // didChangeDependencies();
//     }
//     super.didUpdateWidget(oldBubble);
//   }
// // -----------------------------------------------------------------------------

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
        buttonTap: (String countryID) async {

          final CountryModel _country = await _zoneProvider.fetchCountryByID(context: context, countryID: countryID);
          final List<CityModel> _cities = await _zoneProvider.fetchCitiesByIDs(context: context, citiesIDs: _country.citiesIDs);

          setState(() {
            _selectedCountry = _country;
            _countryCities = _cities;
            _selectedZone.cityID = null;
            _selectedZone.districtID = null;
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
        cities: _countryCities,
    );

    await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      height: null,
      child: BottomDialogButtons(
        mapsModels: _citiesMapModels,
        alignment: Alignment.center,
        bottomDialogType: BottomDialogType.cities,
        buttonTap: (String cityID) async {

          final CityModel _city = await _zoneProvider.fetchCityByID(context: context, cityID: cityID);

          setState(() {
            _selectedZone.cityID = cityID;
            _selectedCity = _city;
            _selectedZone.districtID = null;
          });

          widget.changeCity(cityID);
          print('_currentProvince : ${_selectedZone.cityID }');
          _closeBottomSheet();
        },
      ),
    );
  }
// -----------------------------------------------------------------------------
  Future<void> _tapDistrictButton({@required BuildContext context}) async {

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    List<DistrictModel> _selectedCityDistricts = _selectedCity.districts;

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
        buttonTap: (String districtID){

          setState(() {
            _selectedZone.districtID = districtID;
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
    final String _selectedCityName = _selectedZone?.cityID == null ?
    '...'
        :
    CityModel.getTranslatedCityNameFromCity(
        context: context,
        city: _selectedCity,
    );

    return _selectedCityName;
  }
// -----------------------------------------------------------------------------
  String _getSelectedDistrictName(){
    final String _selectedDistrictName = _selectedZone?.districtID == null ?
    '...'
        :
    DistrictModel.getTranslatedDistrictNameFromCity(
      context: context,
      city: _selectedCity,
      districtID: _selectedZone.districtID,
    );

    return _selectedDistrictName;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _selectedCountryName = CountryModel.getTranslatedCountryNameByID(context: context, countryID: _selectedCountry?.id);
    final String _selectedCountryFlag = _selectedCountry == null ? '' : Flag.getFlagIconByCountryID(_selectedCountry?.id);

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
              color: Colorz.white80,
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
            color: Colorz.white10,
            onTap: onTap,
          ),

        ],
      ),
    );
  }
}
