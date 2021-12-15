import 'dart:async';

import 'package:bldrs/a_models/zone/continent_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/b_views/widgets/specific/zone/zones_page.dart';
import 'package:bldrs/b_views/x_screens/d_zoning/d_2_select_city_screen.dart';
import 'package:bldrs/b_views/y_views/d_zoning/d_1_select_country_screen_view.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCountryScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SelectCountryScreen({
    this.selectCountryIDOnly = false,
    this.selectCountryAndDistrictOnly = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool selectCountryIDOnly;
  final bool selectCountryAndDistrictOnly;
  /// --------------------------------------------------------------------------
  @override
  _SelectCountryScreenState createState() => _SelectCountryScreenState();
  /// --------------------------------------------------------------------------
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  ZoneProvider _zoneProvider;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future<void> _triggerLoading({Function function}) async {
    if (function == null) {
      setState(() {
        _loading = !_loading;
      });
    } else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true
        ? blog('LOADING--------------------------------------')
        : blog('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async {

        final List<Continent> _continents = await _zoneProvider.fetchContinents(context: context);

        unawaited(_triggerLoading(function: () {
          _allContinents = _continents;
        }));
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

// -----------------------------------------------------------------------------
  Future<void> _onCountryTap({@required String countryID}) async {
    blog('countryID is : $countryID');


    if (widget.selectCountryIDOnly){

      final ZoneModel _zone = ZoneModel(
        countryID: countryID,
      );

      Nav.goBack(context, argument: _zone);

    }
    else {

      if (widget.selectCountryAndDistrictOnly) {

        final CountryModel _country = await _zoneProvider.fetchCountryByID(context: context, countryID: countryID);
        final String _cityID = await Nav.goToNewScreen(context, SelectCityScreen(
          country: _country,
          selectCountryAndDistrictOnly: widget.selectCountryAndDistrictOnly,
        ));

        if (_cityID != null){

          final ZoneModel _zone = ZoneModel(
            countryID: countryID,
            cityID: _cityID,
          );

          Nav.goBack(context, argument: _zone);

        }

      }

      else {

        final CountryModel _country = await _zoneProvider.fetchCountryByID(context: context, countryID: countryID);
        await Nav.goToNewScreen(context, SelectCityScreen(country: _country));
      }

    }

  }

// -----------------------------------------------------------------------------
  List<Continent> _allContinents = <Continent>[];
  List<Map<String, dynamic>> _generatePages() {
    final List<Map<String, dynamic>> _pages = <Map<String, dynamic>>[];

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    final double _pageHeight = _screenHeight - Ratioz.stratosphere;

    for (final Continent continent in _allContinents) {
      final List<String> _countriesIDs = CountryModel.getCountriesIDsOfContinent(continent);
      final String _continentIcon = Iconizer.getContinentIcon(continent);

      _pages.add(
        <String, dynamic>{
          'title': continent.name,
          'widget': SafeArea(
            child: ZonesPage(
              title: continent.name,
              continentIcon: _continentIcon,
              countriesIDs: _countriesIDs,
              pageHeight: _pageHeight,
              buttonTap: (String countryID) =>
                  _onCountryTap(countryID: countryID),
            ),
          ),
        },
      );
    }

    return _pages;
  }

// -----------------------------------------------------------------------------
  Future<void> _onSearchSubmit(String val) async {
    blog(val);
  }
// -----------------------------------------------------------------------------
  void _onSearchChanged(String val){
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  _uiProvider.triggerIsSearchingAfterTextLengthIsAt(text: val,);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
// -----------------------------------------------------------------------------
    const double _continentIconHeight = 50;
    const double _verseHeight = 25; //superVerseRealHeight(context, 2, 1, Colorz.White10);

    final double _boxHeight = _screenHeight - Ratioz.stratosphere - _continentIconHeight - _verseHeight - (2 * Ratioz.appBarMargin) - 50;

    // final double _pageHeight = pageHeight; //_screenHeight - Ratioz.stratosphere;
    // final double _bubbleZoneHeight = _pageHeight - _continentIconHeight - _verseHeight;


    return MainLayout(
        skyType: SkyType.black,
        appBarType: AppBarType.search,
        historyButtonIsOn: false,
        sectionButtonIsOn: false,
        zoneButtonIsOn: false,

        onSearchSubmit: _onSearchSubmit,
        onSearchChanged: (String val) => _onSearchChanged(val),

        pageTitle: 'Select a Country',
        pyramids: Iconz.dvBlankSVG,
        layoutWidget: Selector<UiProvider, bool>(
          selector: (_, UiProvider uiProvider) => uiProvider.isSearching,
          builder: (BuildContext context, bool isSearching, Widget child){

            if (isSearching == true){

              return Container();

            }

            else {

              return SelectCountryScreenView(
                onCountryTap: (String countryID) => _onCountryTap(countryID: countryID),
              );

            }

          },
        ),
    );

  }

}
