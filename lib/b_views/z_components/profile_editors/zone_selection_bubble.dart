import 'dart:async';

import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/d_zoning/d_1_select_country_screen.dart';
import 'package:bldrs/b_views/x_screens/d_zoning/d_2_select_city_screen.dart';
import 'package:bldrs/b_views/x_screens/d_zoning/d_3_select_district_screen.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_notes.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ZoneSelectionBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ZoneSelectionBubble({
    @required this.currentZone,
    @required this.onZoneChanged,
    this.title = 'Preferred Location',
    this.notes,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ZoneModel currentZone;
  final ValueChanged<ZoneModel> onZoneChanged;
  final String title;
  final List<String> notes;
  /// --------------------------------------------------------------------------
  @override
  _ZoneSelectionBubbleState createState() => _ZoneSelectionBubbleState();
  /// --------------------------------------------------------------------------
}

class _ZoneSelectionBubbleState extends State<ZoneSelectionBubble> {
// -----------------------------------------------------------------------------
  final ValueNotifier<CountryModel> _selectedCountry = ValueNotifier(null); /// tamam disposed
  final ValueNotifier<List<CityModel>> _selectedCountryCities = ValueNotifier(null);/// tamam disposed
// ------------------------------------------
  final ValueNotifier<CityModel> _selectedCity = ValueNotifier(null);/// tamam disposed
// ------------------------------------------
  final ValueNotifier<DistrictModel> _selectedDistrict = ValueNotifier(null);/// tamam disposed
// ------------------------------------------
  ZoneModel _selectedZone;
  ZoneProvider _zoneProvider;
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _isLoadingCountries = ValueNotifier(false);/// tamam disposed
  final ValueNotifier<bool> _isLoadingCities = ValueNotifier(false);/// tamam disposed
  final ValueNotifier<bool> _isLoadingDistricts = ValueNotifier(false);/// tamam disposed
// -----------------------------------
  Future<void> _triggerAllLoading({@required setTo}) async {
    _isLoadingCountries.value = setTo;
    _isLoadingCities.value = setTo;
    _isLoadingDistricts.value = setTo;
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    _selectedZone = widget.currentZone ?? _zoneProvider.currentZone;
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerAllLoading(setTo: true).then((_) async {
// -----------------------------------------------------------------
        _selectedCountry.value = await _zoneProvider.fetchCountryByID(
          context: context,
          countryID: _selectedZone.countryID,
        );

        _selectedCountryCities.value = await _zoneProvider.fetchCitiesByIDs(
          context: context,
          citiesIDs: _selectedCountry.value?.citiesIDs,
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
        await _triggerAllLoading(setTo: false);
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose(){
    super.dispose();
    _selectedCountry.dispose();
    _selectedCountryCities.dispose();
    _selectedCity.dispose();
    _selectedDistrict.dispose();
    _isLoadingCountries.dispose();
    _isLoadingCities.dispose();
    _isLoadingDistricts.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> _onShowCountriesTap({
    @required BuildContext context
  }) async {

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    await Nav.goToNewScreen(context, SelectCountryScreen(
      onCountryTap: _onSelectCountry,
    )
    );

    // final List<MapModel> _countriesMapModels = CountryModel.getAllCountriesNamesMapModels(context);
    // await BottomDialog.showBottomDialog(
    //   context: context,
    //   draggable: true,
    //   title: 'Select a Country',
    //   child: BottomDialogButtons(
    //     mapsModels: _countriesMapModels,
    //     alignment: Alignment.center,
    //     buttonTap: _onSelectCountry,
    //   ),
    // );

  }
// ----------------------------------------
  Future<void> _onSelectCountry(String countryID) async {

    _isLoadingCities.value = true;

    _selectedCity.value = null;
    _selectedDistrict.value = null;
    _selectedZone.countryID = countryID;
    _selectedZone.cityID = null;
    _selectedZone.districtID = null;
    widget.onZoneChanged(_selectedZone);
    Nav.goBack(context);

    _selectedCountry.value = await _zoneProvider.fetchCountryByID(
      context: context,
      countryID: countryID,
    );

    _selectedCountryCities.value = await _zoneProvider.fetchCitiesByIDs(
      context: context,
      citiesIDs: _selectedCountry.value?.citiesIDs,
    );

    _isLoadingCities.value = false;

    await _onShowCitiesTap(context: context);
  }
// -----------------------------------------------------------------------------
  Future<void> _onShowCitiesTap({
    @required BuildContext context
  }) async {

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    await Nav.goToNewScreen(context, SelectCityScreen(
      country: _selectedCountry.value,
      settingCurrentZone: false,
      onCityTap: _onSelectCity,
    )
    );

    // final List<MapModel> _citiesMapModels = CityModel.getCitiesNamesMapModels(
    //   context: context,
    //   cities: _selectedCountryCities.value,
    // );
    // await BottomDialog.showBottomDialog(
    //   context: context,
    //   draggable: true,
    //   title: 'Select a City',
    //   child: BottomDialogButtons(
    //     mapsModels: _citiesMapModels,
    //     alignment: Alignment.center,
    //     bottomDialogType: BottomDialogType.cities,
    //     buttonTap: _onSelectCity,
    //   ),
    // );

  }
// ----------------------------------------
  Future<void> _onSelectCity(String cityID) async {

    _isLoadingDistricts.value = true;

    _selectedDistrict.value = null;
    _selectedZone.cityID = cityID;
    _selectedZone.districtID = null;
    widget.onZoneChanged(_selectedZone);
    Nav.goBack(context);

    _selectedCity.value = await _zoneProvider.fetchCityByID(
        context: context,
        cityID: cityID
    );

    _isLoadingDistricts.value = false;

    if (Mapper.canLoopList(_selectedCity.value?.districts) == true){
      await _onShowDistricts(context: context);
    }

  }
// -----------------------------------------------------------------------------
  Future<void> _onShowDistricts({
    @required BuildContext context,
  }) async {

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    await Nav.goToNewScreen(context, SelectDistrictScreen(
      country: _selectedCountry.value,
      city: _selectedCity.value,
      settingCurrentZone: false,
      onDistrictTap: _onSelectDistrict,
    )
    );

    // final List<MapModel> _districtsMapModels = DistrictModel.getDistrictsNamesMapModels(
    //   context: context,
    //   districts: _selectedCity.value.districts,
    // );
    // await BottomDialog.showBottomDialog(
    //   context: context,
    //   draggable: true,
    //   title: 'Select a district',
    //   child: BottomDialogButtons(
    //     mapsModels: _districtsMapModels,
    //     alignment: Alignment.center,
    //     bottomDialogType: BottomDialogType.districts,
    //     buttonTap: _onSelectDistrict,
    //   ),
    // );

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

          if (Mapper.canLoopList(widget.notes))
            BubbleNotes(
              notes: widget.notes,
            ),

          /// COUNTRY BUTTON
          ValueListenableBuilder(
              valueListenable: _selectedCountry,
              builder: (_, CountryModel selectedCountry, Widget child){

                final String _countryName = CountryModel.getTranslatedCountryName(
                  context: context,
                  countryID: selectedCountry?.id,
                );

                final String _countryFlag =
                selectedCountry == null ? ''
                    :
                Flag.getFlagIconByCountryID(selectedCountry?.id);

                return ValueListenableBuilder(
                    valueListenable: _isLoadingCountries,
                    builder: (_, bool loadingCountries, Widget child){

                      return ZoneSelectionButton(
                        title: superPhrase(context, 'phid_country'),
                        icon: _countryFlag,
                        verse: _countryName,
                        onTap: () => _onShowCountriesTap(context: context),
                        loading: loadingCountries,
                      );

                    }
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

              return ValueListenableBuilder(
                  valueListenable: _isLoadingCities,
                  builder: (_, bool _loadingCities, Widget child){

                    return ZoneSelectionButton(
                      title: 'City',
                      verse: _cityName,
                      onTap: () => _onShowCitiesTap(context: context),
                      loading: _loadingCities,
                    );

                  }
              );

            },
          ),

          /// DISTRICT BUTTON
          ValueListenableBuilder(
              valueListenable: _selectedCity,
              builder: (_, CityModel cityModel, Widget districtButton){

                final List<DistrictModel> _cityDistricts = cityModel?.districts;

                if (Mapper.canLoopList(_cityDistricts) == true){
                  return districtButton;
                }

                else {
                  return const SizedBox();
                }
              },

            child: ValueListenableBuilder(
                valueListenable: _selectedDistrict,
                builder: (_, DistrictModel district, Widget child){

                  final String _districtName =
                  district?.districtID == null ? '...'
                      :
                  DistrictModel.getTranslatedDistrictNameFromDistrict(
                    context: context,
                    district: district,
                  );

                  return ValueListenableBuilder(
                      valueListenable: _isLoadingDistricts,
                      builder: (_, bool loadingDistricts, Widget child){

                        return  ZoneSelectionButton(
                          title: 'District',
                          verse: _districtName,
                          onTap: () => _onShowDistricts(context: context),
                          loading: loadingDistricts,
                        );

                      }
                  );

                }
            ),

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
    this.icon = Iconz.circleDot,
    this.loading = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String title;
  final String verse;
  final String icon;
  final Function onTap;
  final bool loading;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final double _bubbleClearWidth = Bubble.clearWidth(context);
    // const double _buttonsSpacing = Ratioz.appBarPadding;

    final String _buttonVerse = loading ? 'Loading ...'
        :
    verse == null ? ''
        :
    ' $verse    ';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        /// TITLE
        SuperVerse(
          verse: title,
          centered: false,
          italic: true,
          weight: VerseWeight.thin,
          color: Colorz.white80,
          margin: 5,
        ),

        /// BUTTON CONTENTS
        DreamBox(
          height: 50,
          verseScaleFactor: 0.8,
          icon: icon,
          bubble: false,
          verse: _buttonVerse,
          verseMaxLines: 2,
          color: Colorz.white10,
          onTap: onTap,
          loading: loading,
        ),

      ],
    );
  }
}
