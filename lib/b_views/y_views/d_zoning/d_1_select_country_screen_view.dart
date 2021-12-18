import 'package:bldrs/b_views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/y_views/d_zoning/d_1a_all_countries_buttons.dart';
import 'package:bldrs/b_views/y_views/d_zoning/d_1b_searched_countries_buttons.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
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

    return MaxBounceNavigator(
      child: Scroller(
        child: Selector<UiProvider, bool>(
          selector: (_, UiProvider uiProvider) => uiProvider.isSearchingCountry,
          builder: (BuildContext context, bool isSearchingCountry, Widget child){

            if (isSearchingCountry == true){

              return
                SearchedCountriesButtons(
                  onCountryTap: (String countryID) => onCountryTap(countryID),
                );

            }

            else {

              return
                AllCountriesButtons(
                  onCountryTap: (String countryID) => onCountryTap(countryID),
                );

            }

          },
        ),
      ),
    );
  }
}
