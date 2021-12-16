import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_country_button.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class AllCountriesButtons extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AllCountriesButtons({
    @required this.onCountryTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<String> onCountryTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<String> _allCountriesIDs = CountryModel.getAllCountriesIDs();

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _allCountriesIDs.length,
      padding: const EdgeInsets.only(top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2, bottom: Ratioz.horizon),
      shrinkWrap: true,
      itemBuilder: (_, int index) {

        final String _countryID = _allCountriesIDs[index];

        return WideCountryButton(
          countryID: _countryID,
          onTap: () => onCountryTap(_countryID),
        );

      },
    );
  }
}
