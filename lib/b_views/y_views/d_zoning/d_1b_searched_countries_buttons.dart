import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/widgets/general/loading/loading.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_country_button.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchedCountriesButtons extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SearchedCountriesButtons({
    @required this.onCountryTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<String> onCountryTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const EdgeInsets _topMargin = EdgeInsets.only(top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2, bottom: Ratioz.horizon);

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: true);
    final List<CountryModel> _searchedCountries = _zoneProvider.searchedCountries;

    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: true);

    /// WHEN SEARCH RESULTS
    if (canLoopList(_searchedCountries)){

      return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: _searchedCountries.length,
          padding: _topMargin,
          shrinkWrap: true,
          itemBuilder: (_, int index) {

            final String _countryID = _searchedCountries[index].id;

            return WideCountryButton(
              countryID: _countryID,
              onTap: () => onCountryTap(_countryID),
            );

          }
          );

    }

    else if (_uiProvider.loading == true){

      return const LoadingFullScreenLayer();

    }

    /// WHEN RESULT IS EMPTY
    else {

      return Container(
        margin: _topMargin,
        child: const SuperVerse(
          verse: 'No Result found',
          labelColor: Colorz.white10,
          size: 3,
          weight: VerseWeight.thin,
          italic: true,
          color: Colorz.white200,
        ),
      );

    }

  }
}
