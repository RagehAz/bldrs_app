import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/screens/d_zoning/d_1_select_country_screen.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/text_directionerz.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ZoneButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ZoneButton({
    this.onTap,
    this.isOn = false,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final Function onTap;
  final bool isOn;

  /// --------------------------------------------------------------------------
  Future<void> _zoneButtonOnTap(BuildContext context) async {
    await Nav.goToNewScreen(context, const SelectCountryScreen()

        //   /// but now we go to Egypt cities directly
        // SelectCityScreen(countryID: 'egy',)

        );
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final ZoneProvider _zoneProvider =
        Provider.of<ZoneProvider>(context, listen: true);

    final ZoneModel _currentZone = _zoneProvider.currentZone;
    final CountryModel _currentCountry = _zoneProvider.currentCountry;
    final CityModel _currentCity = _zoneProvider.currentCity;

    final String _countryName = CountryModel.getTranslatedCountryNameByID(
        context: context, countryID: _currentCountry?.id);
    final String _countryFlag =
        Flag.getFlagIconByCountryID(_currentCountry?.id);

    final String _cityName = CityModel.getTranslatedCityNameFromCity(
      context: context,
      city: _currentCity,
    );

    final String _districtName =
        DistrictModel.getTranslatedDistrictNameFromCity(
            context: context,
            city: _currentCity,
            districtID: _currentZone?.districtID);

    final String _countryAndCityNames = appIsLeftToRight(context)
        ? '$_cityName - $_countryName'
        : '$_countryName - $_cityName';

    final String _firstRow = _currentZone == null
        ? ' '
        : _currentZone?.districtID == null
            ? _countryName
            : _countryAndCityNames;

    final String _secondRow = _currentZone == null
        ? ' '
        : _currentZone?.districtID == null
            ? _cityName
            : _districtName;

    const double _flagHorizontalMargins = 2;

    return GestureDetector(
      onTap: () => _zoneButtonOnTap(context),
      child: Container(
        // width: 40,
        height: 40,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(Ratioz.appBarMargin * 0.5),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
                Radius.circular(Ratioz.appBarButtonCorner)),
            color: isOn ? Colorz.yellow255 : Colorz.white10),
        child: ChangeNotifierProvider<ZoneProvider>.value(
          value: _zoneProvider,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              /// --- COUNTRY & DISTRICTS NAMES
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.5),
                child: FittedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SuperVerse(
                        verse: _firstRow,
                        size: 1,
                        color: isOn ? Colorz.black230 : Colorz.white255,
                      ),
                      SuperVerse(
                        verse: _secondRow,
                        size: 1,
                        scaleFactor: 0.8,
                        color: isOn ? Colorz.black230 : Colorz.white255,
                      ),
                    ],
                  ),
                ),
              ),

              /// --- FLAG
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  /// --- FAKE FOOTPRINT to occupy space for flag while loading
                  Container(
                    width: 30,
                    height: 30,
                    margin: const EdgeInsets.symmetric(
                        horizontal: _flagHorizontalMargins),
                  ),

                  Center(
                    child: DreamBox(
                      width: 30,
                      height: 30,
                      icon: _countryFlag,
                      corners: Ratioz.boxCorner8,
                      margins: const EdgeInsets.symmetric(
                          horizontal: _flagHorizontalMargins),
                      onTap: onTap,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
