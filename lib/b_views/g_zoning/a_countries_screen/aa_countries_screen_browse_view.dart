import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/country_tile_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:stringer/stringer.dart';
import 'package:flutter/material.dart';

class CountriesScreenBrowseView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CountriesScreenBrowseView({
    @required this.onCountryTap,
    @required this.onDeactivatedCountryTap,
    @required this.shownCountriesIDs,
    @required this.notShownCountriesIDs,
    @required this.countriesCensus,
    this.padding,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<String> onCountryTap;
  final ValueChanged<String> onDeactivatedCountryTap;
  final EdgeInsets padding;
  final List<String> shownCountriesIDs;
  final List<String> notShownCountriesIDs;
  final List<CensusModel> countriesCensus;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final List<String> _countriesList = <String>[...?shownCountriesIDs, ...?notShownCountriesIDs];
    // --------------------
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _countriesList.length,
      padding: padding ?? Stratosphere.getStratosphereSandwich(context: context, appBarType: AppBarType.search),
      itemBuilder: (_, int index) {

        final String _countryID = _countriesList[index];

        final CensusModel _census = CensusModel.getCensusFromCensusesByID(
          censuses: countriesCensus,
          censusID: _countryID,
        );

        return CountryTileButton(
          countryID: _countryID,
          isActive: Stringer.checkStringsContainString(strings: shownCountriesIDs, string: _countryID),
          censusModel: _census,
          onTap: () => onCountryTap(_countryID),
          onDeactivatedTap: () => onDeactivatedCountryTap(_countryID),
        );

      },
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
