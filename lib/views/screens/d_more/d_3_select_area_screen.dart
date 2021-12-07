import 'package:bldrs/controllers/router/navigators.dart' as Nav;
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/models/secondary_models/map_model.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/district_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/providers/general_provider.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/widgets/general/layouts/list_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectAreaScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SelectAreaScreen({
    @required this.city,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final CityModel city;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: true);
    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: true);
// -----------------------------------------------------------------------------
    final ZoneProvider _zoneProvider =  Provider.of<ZoneProvider>(context, listen: true);
    final String _cityName = Name.getNameByCurrentLingoFromNames(context, city.names);
    final List<MapModel> _districtsMapModel = DistrictModel.getDistrictsNamesMapModels(
      context: context,
      districts: city.districts,
    );
// -----------------------------------------------------------------------------
    return  ListLayout(
      pyramids: Iconz.pyramidzYellow,
      pageTitle: _cityName,
      mapModels: _districtsMapModel,
      pageIconVerse: _cityName,
      sky: SkyType.black,
      onItemTap: (String districtID) async {
        print('districtID is $districtID');

        final ZoneModel _zone = ZoneModel(
          countryID: city.countryID,
          cityID: city.cityID,
          districtID: districtID,
        );

        _zone.printZone(methodName: 'SELECTED ZONE');

        await _zoneProvider.getsetCurrentZoneAndCountryAndCity(context: context, zone: _zone);

        await _flyersProvider.getsetWallFlyersBySection(
            context: context,
            section: _generalProvider.currentSection
        );

        Nav.goBackToHomeScreen(context);
      },
    );

  }
}
