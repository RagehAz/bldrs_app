import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_country_button.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCountryScreenSearchView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SelectCountryScreenSearchView({
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
    final List<Phrase> _searchedCountries = _zoneProvider.searchedCountries;

    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: true);

    /// WHEN SEARCH RESULTS
    if (Mapper.checkCanLoopList(_searchedCountries)){

      return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: _searchedCountries.length,
          padding: _topMargin,
          shrinkWrap: true,
          itemBuilder: (_, int index) {

            final Phrase _countryPhrase = _searchedCountries[index];

            return WideCountryButton(
              countryID: _countryPhrase.id,
              onTap: () => onCountryTap(_countryPhrase.id),
            );

          }
          );

    }

    else if (_uiProvider.isLoading == true){

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
