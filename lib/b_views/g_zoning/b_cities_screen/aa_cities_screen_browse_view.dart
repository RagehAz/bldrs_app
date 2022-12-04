import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/city_tile_button.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class CitiesScreenBrowseView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CitiesScreenBrowseView({
    @required this.countryCities,
    @required this.onCityTap,
    @required this.shownCitiesIDs,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<List<CityModel>> countryCities;
  final Function(String cityID) onCityTap;
  final List<String> shownCitiesIDs;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      key: const ValueKey<String>('CitiesScreenBrowseView'),
      valueListenable: countryCities,
      builder: (_, List<CityModel> cities, Widget child){

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: cities.length,
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2, bottom: Ratioz.horizon),
          itemBuilder: (BuildContext context, int index) {

            final CityModel _city = cities[index];
            final bool _isActive = Stringer.checkStringsContainString(
                strings: shownCitiesIDs,
                string: _city.cityID,
            );

            return WideCityButton(
              city: _city,
              isActive: _isActive,
              onSingleTap: () => onCityTap(_city.cityID),
            );

          },
        );

      },
    );

  }
// -----------------------------------------------------------------------------
}
