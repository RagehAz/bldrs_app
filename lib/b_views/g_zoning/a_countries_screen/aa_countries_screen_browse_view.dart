import 'package:bldrs/b_views/z_components/buttons/tile_buttons/country_tile_button.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/general_provider.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class CountriesScreenBrowseView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CountriesScreenBrowseView({
    @required this.onCountryTap,
    this.padding,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<String> onCountryTap;
  final EdgeInsets padding;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final List<String> _activeCountriesIDs = getActiveCountriesIDs(context);
    // --------------------
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _activeCountriesIDs.length,
      padding: padding ?? const EdgeInsets.only(
          top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2,
          bottom: Ratioz.horizon
      ),
      shrinkWrap: true,
      itemBuilder: (_, int index) {

        final String _countryID = _activeCountriesIDs[index];

        return CountryTileButton(
          countryID: _countryID,
          onTap: () => onCountryTap(_countryID),
        );

      },
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
