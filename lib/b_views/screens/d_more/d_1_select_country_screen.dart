import 'dart:async';

import 'package:bldrs/a_models/zone/continent_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/screens/d_more/d_2_select_city_screen.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/b_views/widgets/general/layouts/swiper_layout_screen.dart';
import 'package:bldrs/b_views/widgets/specific/zone/zones_page.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// PLAN : this screen should be in version two
/// but will put a sketch because i already did while thinking this through

class SelectCountryScreen extends StatefulWidget {
  const SelectCountryScreen({Key key}) : super(key: key);

  @override
  _SelectCountryScreenState createState() => _SelectCountryScreenState();
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
        final List<Continent> _continents =
            await _zoneProvider.fetchContinents(context: context);

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

    final CountryModel _country = await _zoneProvider.fetchCountryByID(
        context: context, countryID: countryID);

    await Nav.goToNewScreen(context, SelectCityScreen(country: _country));
  }

// -----------------------------------------------------------------------------
  List<Continent> _allContinents = <Continent>[];
  List<Map<String, dynamic>> _generatePages() {
    final List<Map<String, dynamic>> _pages = <Map<String, dynamic>>[];

    final double _screenHeight =
        Scale.superScreenHeightWithoutSafeArea(context);
    final double _pageHeight = _screenHeight - Ratioz.stratosphere;

    for (final Continent continent in _allContinents) {
      final List<String> _countriesIDs =
          CountryModel.getCountriesIDsOfContinent(continent);
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
  @override
  Widget build(BuildContext context) {
    return SwiperLayoutScreen(
      sky: SkyType.black,
      swiperPages: Mapper.canLoopList(_allContinents)
          ? _generatePages()
          : <Map<String, dynamic>>[
              <String, dynamic>{'title': '...', 'widget': Container()}
            ],
    );
  }
}
