import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/providers/zones/zone_provider.dart';
import 'package:bldrs/providers/flyers_and_bzz/flyers_provider.dart';
import 'package:bldrs/views/widgets/layouts/listLayout.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart' show Sky;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectAreaScreen extends StatelessWidget {
  final String cityID;
  final String countryID;

  SelectAreaScreen({
    @required this.cityID,
    @required this.countryID,
  });

  @override
  Widget build(BuildContext context) {
    FlyersProvider _pro =  Provider.of<FlyersProvider>(context, listen: true);
// -----------------------------------------------------------------------------
    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    String _cityName = _countryPro.getCityNameWithCurrentLanguageIfPossible(context, cityID);
    List<Map<String, dynamic>> _areasMaps = _countryPro.getDistrictsNameMapsByCityID(context, cityID);
// -----------------------------------------------------------------------------

    return  ListLayout(
      pyramids: Iconz.PyramidzYellow,
      pageTitle: _cityName,
      icons: null,
      idValueMaps: _areasMaps,
      pageIcon: null,
      pageIconVerse: _cityName,
      sky: Sky.Black,
      onItemTap: (districtID) async {
        print('districtID is $districtID');

        _countryPro.changeCountry(countryID);
        _countryPro.changeCity(cityID);
        _countryPro.changeDistrict(districtID);

        print('selected country id is : $countryID');
        print('selected city id is : $cityID');
        print('selected district id is : $districtID');

        await _pro.fetchAndSetTinyFlyersBySection(context, _pro.getCurrentSection);

        Nav.goBackToHomeScreen(context);
      },
    );

  }
}
