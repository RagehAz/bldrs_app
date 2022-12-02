import 'package:bldrs/b_views/z_components/buttons/tile_buttons/country_tile_button.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class CountriesScreenBrowseView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CountriesScreenBrowseView({
    @required this.onCountryTap,
    @required this.shownCountriesIDs,
    @required this.notShownCountriesIDs,
    this.padding,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<String> onCountryTap;
  final EdgeInsets padding;
  final List<String> shownCountriesIDs;
  final List<String> notShownCountriesIDs;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final List<String> _countriesList = <String>[...?shownCountriesIDs, ...?notShownCountriesIDs];
    // --------------------
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _countriesList.length,
      padding: padding ?? const EdgeInsets.only(
          top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2,
          bottom: Ratioz.horizon
      ),
      shrinkWrap: true,
      itemBuilder: (_, int index) {

        final String _countryID = _countriesList[index];

        return CountryTileButton(
          countryID: _countryID,
          isActive: Stringer.checkStringsContainString(strings: shownCountriesIDs, string: _countryID),
          onTap: () => onCountryTap(_countryID),
        );

      },
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
