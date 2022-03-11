import 'dart:async';
import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog_buttons.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ZoneSelectionBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ZoneSelectionBubble({
    @required this.currentZone,
    @required this.onZoneChanged,
    this.title = 'Preferred Location',
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ZoneModel currentZone;
  final ValueChanged<ZoneModel> onZoneChanged;
  final String title;
  /// --------------------------------------------------------------------------
  @override
  _ZoneSelectionBubbleState createState() => _ZoneSelectionBubbleState();
  /// --------------------------------------------------------------------------
}

class _ZoneSelectionBubbleState extends State<ZoneSelectionBubble> {
// -----------------------------------------------------------------------------
  final ValueNotifier<CountryModel> _selectedCountry = ValueNotifier(null);
  final ValueNotifier<List<CityModel>> _selectedCountryCities = ValueNotifier(null);
// ------------------------------------------
  final ValueNotifier<CityModel> _selectedCity = ValueNotifier(null);
// ------------------------------------------
  final ValueNotifier<DistrictModel> _selectedDistrict = ValueNotifier(null);
// ------------------------------------------
  ZoneModel _selectedZone;
  ZoneProvider _zoneProvider;
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(true);
// -----------------------------------
  Future<void> _triggerLoading({@required setTo}) async {
    _loading.value = setTo;
    blogLoading(loading: _loading.value);
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _selectedZone = widget.currentZone;
    _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {
// -----------------------------------------------------------------
        _selectedCountry.value = await _zoneProvider.fetchCountryByID(
          context: context,
          countryID: _selectedZone.countryID,
        );

        _selectedCity.value = await _zoneProvider.fetchCityByID(
          context: context,
          cityID: _selectedZone.cityID,
        );

        _selectedDistrict.value = DistrictModel.getDistrictFromDistricts(
            districts: _selectedCity.value.districts,
            districtID: _selectedZone.districtID,
        );

// -----------------------------------------------------------------
        await _triggerLoading(setTo: false);
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  Future<void> _onShowCountriesTap({
    @required BuildContext context
  }) async {

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    final List<MapModel> _countriesMapModels = CountryModel.getAllCountriesNamesMapModels(context);

    await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      child: BottomDialogButtons(
        mapsModels: _countriesMapModels,
        alignment: Alignment.center,
        buttonTap: _onSelectCountry,
      ),
    );

  }
// ----------------------------------------
  Future<void> _onSelectCountry(String countryID) async {

    _selectedCountry.value = await _zoneProvider.fetchCountryByID(
      context: context,
      countryID: countryID,
    );

    _selectedCountryCities.value = await _zoneProvider.fetchCitiesByIDs(
      context: context,
      citiesIDs: _selectedCountry.value.citiesIDs,
    );

    _selectedZone.countryID = countryID;
    _selectedZone.cityID = null;
    _selectedZone.districtID = null;

    widget.onZoneChanged(_selectedZone);

    Nav.goBack(context);
  }
// -----------------------------------------------------------------------------
  Future<void> _onShowCitiesTap({
    @required BuildContext context
  }) async {

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    final List<MapModel> _citiesMapModels = CityModel.getCitiesNamesMapModels(
      context: context,
      cities: _selectedCountryCities.value,
    );

    await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      child: BottomDialogButtons(
        mapsModels: _citiesMapModels,
        alignment: Alignment.center,
        bottomDialogType: BottomDialogType.cities,
        buttonTap: _noSelectCity,
      ),
    );
  }
// ----------------------------------------
  Future<void> _noSelectCity(String cityID) async {

    _selectedCity.value = await _zoneProvider.fetchCityByID(
        context: context,
        cityID: cityID
    );

    _selectedZone.cityID = cityID;
    _selectedZone.districtID = null;

    widget.onZoneChanged(_selectedZone);

    Nav.goBack(context);

  }
// -----------------------------------------------------------------------------
  Future<void> _onShowDistricts({
    @required BuildContext context,
  }) async {

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    final List<MapModel> _districtsMapModels = DistrictModel.getDistrictsNamesMapModels(
      context: context,
      districts: _selectedCity.value.districts,
    );

    await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      child: BottomDialogButtons(
        mapsModels: _districtsMapModels,
        alignment: Alignment.center,
        bottomDialogType: BottomDialogType.districts,
        buttonTap: _onSelectDistrict,
      ),
    );

  }
// ----------------------------------------
  void _onSelectDistrict(String districtID) {

    final DistrictModel _district = DistrictModel.getDistrictFromDistricts(
        districts: _selectedCity.value.districts,
        districtID: districtID
    );

    _selectedDistrict.value = _district;

    _selectedZone.districtID = districtID;

    widget.onZoneChanged(_selectedZone);

    Nav.goBack(context);

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Bubble(
        title: widget.title,
        redDot: true,
        columnChildren: <Widget>[

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// COUNTRY BUTTON
              ValueListenableBuilder(
                  valueListenable: _selectedCountry,
                  builder: (_, CountryModel selectedCountry, Widget child){

                    final String _countryName = CountryModel.getTranslatedCountryNameByID(
                      context: context,
                      countryID: selectedCountry?.id,
                    );

                    final String _countryFlag =
                    selectedCountry == null ? ''
                        :
                    Flag.getFlagIconByCountryID(selectedCountry?.id);

                    return ZoneSelectionButton(
                      title: Wordz.country(context),
                      icon: _countryFlag,
                      verse: _countryName,
                      onTap: () => _onShowCountriesTap(context: context),
                    );

                  }
              ),

              /// City BUTTON
              ValueListenableBuilder(
                valueListenable: _selectedCity,
                builder: (_, CityModel selectedCity, Widget child){

                  final String _cityName =
                  selectedCity?.cityID == null ? '...'
                      :
                  CityModel.getTranslatedCityNameFromCity(
                    context: context,
                    city: selectedCity,
                  );

                  return ZoneSelectionButton(
                    title: 'City',
                    verse: _cityName,
                    onTap: () => _onShowCitiesTap(context: context),
                  );

                },
              ),

              /// AREA BUTTON
              ValueListenableBuilder(
                  valueListenable: _selectedDistrict,
                  builder: (_, DistrictModel district, Widget child){

                    final String _districtName =
                    district?.districtID == null ? '...'
                        :
                    DistrictModel.getTranslatedDistrictNameFromDistrict(
                      context: context,
                      district: district,
                    );

                    return ZoneSelectionButton(
                      title: 'District',
                      verse: _districtName,
                      onTap: () => _onShowDistricts(context: context),
                    );

                  }
                  ),

            ],
          ),
        ]
    );
  }
}

class ZoneSelectionButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ZoneSelectionButton({
    @required this.title,
    @required this.verse,
    @required this.onTap,
    this.icon,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String title;
  final String verse;
  final String icon;
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleClearWidth = Bubble.clearWidth(context);
    const double _buttonsSpacing = Ratioz.appBarPadding;
    final double _buttonWidth = (_bubbleClearWidth / 3) - ((2 * _buttonsSpacing) / 3);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _buttonsSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// TITLE
          SizedBox(
            width: _buttonWidth,
            child: SuperVerse(
              verse: title,
              centered: false,
              italic: true,
              weight: VerseWeight.thin,
              color: Colorz.white80,
            ),
          ),

          /// BUTTON CONTENTS
          DreamBox(
            height: 40,
            // width: _buttonWidth,
            verseScaleFactor: 0.8,
            iconSizeFactor: 0.8,
            icon: icon,
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
