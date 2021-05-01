import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/layouts/listLayout.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart' show Sky;
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';

class SelectAreaScreen extends StatelessWidget {
  final String provinceID;
  final String countryID;

  SelectAreaScreen({
    @required this.provinceID,
    @required this.countryID,
  });

  @override
  Widget build(BuildContext context) {
    FlyersProvider _pro =  Provider.of<FlyersProvider>(context, listen: true);
// -----------------------------------------------------------------------------
    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    String _provinceName = _countryPro.getProvinceNameWithCurrentLanguageIfPossible(context, provinceID);
    List<Map<String, dynamic>> _areasMaps = _countryPro.getAreasNameMapsByProvinceID(context, provinceID);
// -----------------------------------------------------------------------------

    return  ListLayout(
      pyramids: Iconz.PyramidzYellow,
      pageTitle: _provinceName,
      icons: null,
      idValueMaps: _areasMaps,
      pageIcon: null,
      pageIconVerse: _provinceName,
      sky: Sky.Black,
      onItemTap: (areaID) async {
        print('areaID is $areaID');

        _countryPro.changeCountry(countryID);
        _countryPro.changeProvince(provinceID);
        _countryPro.changeArea(areaID);

        print('selected country id is : $countryID');
        print('selected province id is : $provinceID');
        print('selected city id is : $areaID');

        await _pro.fetchAndSetTinyFlyersBySectionType(context, _pro.getCurrentSection);

        Nav.goBackToHomeScreen(context);
      },
    );

  }
}
