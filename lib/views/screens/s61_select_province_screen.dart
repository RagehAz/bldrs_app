import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/views/screens/s62_select_area_screen.dart';
import 'package:bldrs/views/widgets/layouts/listLayout.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart' show Sky;
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';

class SelectProvinceScreen extends StatelessWidget {
  final String countryID;

  SelectProvinceScreen({
    this.countryID,
  });

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    String _countryName = _countryPro.getCountryNameInCurrentLanguageByIso3(context, countryID);
    List<Map<String, dynamic>> _provincesMaps = _countryPro.getProvincesNameMapsByIso3(context, countryID);
    String _countryFlag = Flagz.getFlagByIso3(countryID);
// -----------------------------------------------------------------------------

    return  ListLayout(
      pyramids: Iconz.PyramidzYellow,
      pageTitle: _countryName,
      icons: null,
      idValueMaps: _provincesMaps,
      pageIcon: _countryFlag,
      pageIconVerse: _countryName,
      sky: Sky.Black,
      onItemTap: (value){
        print('value is $value');
        Nav.goToNewScreen(context,
            SelectAreaScreen(
              provinceID : value,
              countryID: countryID,
            )
        );
      },
    );

  }
}
