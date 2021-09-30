import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/providers/zones/zone_provider.dart';
import 'package:bldrs/views/screens/d_more/d_3_select_area_screen.dart';
import 'package:bldrs/views/widgets/general/layouts/listLayout.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart' show Sky;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCityScreen extends StatelessWidget {
  final String countryID;

  SelectCityScreen({
    this.countryID = 'egy',
  });

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    final String _countryName = _countryPro.getCountryNameInCurrentLanguageByIso3(context, countryID);
    final List<Map<String, dynamic>> _citiesMaps = _countryPro.getCitiesNamesMapsByIso3(context, countryID);
    final String _countryFlag = Flagz.getFlagByIso3(countryID);
// -----------------------------------------------------------------------------

    return  ListLayout(
      pyramids: Iconz.PyramidzYellow,
      pageTitle: _countryName,
      icons: null,
      idValueMaps: _citiesMaps,
      pageIcon: _countryFlag,
      pageIconVerse: _countryName,
      sky: Sky.Black,
      onItemTap: (value){
        print('value is $value');
        Nav.goToNewScreen(context,
            SelectAreaScreen(
              cityID : value,
              countryID: countryID,
            )
        );
      },
    );

  }
}
