import 'package:bldrs/b_views/x_screens/h_zoning/aaa_select_country_screen_all_countries_view.dart';
import 'package:bldrs/b_views/x_screens/h_zoning/aaa_select_country_screen_search_view.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/d_providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCountryScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SelectCountryScreenView({
    @required this.onCountryTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<String> onCountryTap;
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Scroller(
      child: Selector<SearchProvider, bool>(
        selector: (_, SearchProvider searchProvider) => searchProvider.isSearchingCountry,
        builder: (BuildContext context, bool isSearchingCountry, Widget child){

          if (isSearchingCountry == true){

            return
              SelectCountryScreenSearchView(
                onCountryTap: (String countryID) => onCountryTap(countryID),
              );

          }

          else {

            return
              SelectCountryScreenAllCountriesView(
                onCountryTap: (String countryID) => onCountryTap(countryID),
              );

          }

        },
      ),
    );
  }
}
