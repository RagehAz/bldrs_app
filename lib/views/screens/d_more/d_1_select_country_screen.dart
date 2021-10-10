import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/providers/zones/old_zone_provider.dart';
import 'package:bldrs/views/screens/d_more/d_2_select_city_screen.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/swiper_layout_screen.dart';
import 'package:bldrs/views/widgets/specific/zone/zones_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// PLAN : this screen should be in version two
/// but will put a sketch because i already did while thinking this through

class SelectCountryScreen extends StatefulWidget {
  @override
  _SelectCountryScreenState createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
    OldCountryProvider _countryPro;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _countryPro =  Provider.of<OldCountryProvider>(context, listen: false);

  }
// -----------------------------------------------------------------------------
  List<Map<String, dynamic>> _generatePages(){
    final List<Map<String, dynamic>> _pages = <Map<String, dynamic>>[];

    Iconizer.continentsMaps.forEach((cont) {

      final List<String> _countriesIDs = _countryPro.getCountriesIDsByContinent(
        context: context,
        continent: cont['name'],
      );

      _pages.add(

        {

          'title' : cont['name'],

          'widget' :
          ZonesPage(
            title: cont['name'],
            continentIcon: cont['icon'],
            countriesIDs: _countriesIDs,
            buttonTap: (countryID) async {

              print('countryID is : $countryID');

              Nav.goToNewScreen(context, SelectCityScreen(countryID: countryID,));

            },
          ),

        },

      );
    });

    return _pages;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SwiperLayoutScreen(
      sky: Sky.Black,
      swiperPages: _generatePages(),
    );

  }

}
