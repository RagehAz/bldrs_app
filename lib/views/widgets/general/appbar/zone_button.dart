import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/district_model.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/screens/d_more/d_2_select_city_screen.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ZoneButton extends StatelessWidget {
  final Function onTap;
  final bool isOn;

  const ZoneButton({
    this.onTap,
    this.isOn = false,
  });
// -----------------------------------------------------------------------------
  void _zoneButtonOnTap(BuildContext context){
    // print('zone tapped');
    Nav.goToNewScreen(context, SelectCityScreen());
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final ZoneProvider _zoneProvider =  Provider.of<ZoneProvider>(context, listen: true);

    final Zone _currentZone = _zoneProvider.currentZone;
    final Country _currentCountry = _zoneProvider.currentCountry;

    final String _countryName = Country.getTranslatedCountryNameByID(context: context, countryID: _currentCountry?.countryID);
    final String _lastCountryFlag = Flag.getFlagIconByCountryID(_currentCountry?.countryID);

    final String _cityName = City.getTranslatedCityNameFromCountry(
        context: context,
        country: _currentCountry,
        cityID: _currentZone?.cityID,
    );

    final String _districtName = District.getTranslatedDistrictNameFromCountry(
        context: context,
        country: _currentCountry,
        cityID: _currentZone?.cityID,
        districtID: _currentZone?.districtID,
    );

    // print('country ID : $_lastCountryID, provinceID : $_cityID, '
    //     'districtID : $_lastDistrictID, CountryName : $_countryName,'
    //     ' ProvinceName : $_cityName, DistrictName : $_districtName');

    final String _countryAndProvinceNames =
        appIsLeftToRight(context) ? '$_cityName - $_countryName'
    : '$_countryName - $_cityName';

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
            borderRadius: BorderRadius.all(
                Radius.circular(Ratioz.appBarButtonCorner)),
            color: isOn ? Colorz.Yellow255 : Colorz.White10
        ),
        child: ChangeNotifierProvider.value(
          value: _zoneProvider,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              /// --- COUNTRY & DISTRICTS NAMES
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.5),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SuperVerse(
                        verse: _countryAndProvinceNames,
                        size: 1,
                        color: isOn? Colorz.Black230 : Colorz.White255,
                      ),
                      SuperVerse(
                        verse: _districtName,
                        size: 1,
                        scaleFactor: 0.8,
                        color: isOn? Colorz.Black230 : Colorz.White255,
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
                    margin: const EdgeInsets.symmetric(horizontal: _flagHorizontalMargins),
                  ),

                  Center(
                    child: DreamBox(
                      width: 30,
                      height: 30,
                      icon: _lastCountryFlag,
                      corners: Ratioz.boxCorner8,
                      margins: const EdgeInsets.symmetric(horizontal: _flagHorizontalMargins),
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
