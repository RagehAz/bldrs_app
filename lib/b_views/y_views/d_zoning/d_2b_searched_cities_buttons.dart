import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_city_button.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchedCitiesButtons extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SearchedCitiesButtons({
    @required this.onCityTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<String> onCityTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const EdgeInsets _topMargin = EdgeInsets.only(top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2, bottom: Ratioz.horizon);

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: true);
    final List<CityModel> _searchedCities = _zoneProvider.searchedCities;

    /// WHEN SEARCH RESULTS
    if (canLoopList(_searchedCities)){

      return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: _searchedCities.length,
          padding: _topMargin,
          shrinkWrap: true,
          itemBuilder: (_, int index) {

            final CityModel input = _searchedCities[index];

            return WideCityButton(
              city: input,
              onTap: onCityTap,
            );

          }
      );

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
