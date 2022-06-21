import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_district_button.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchedDistrictsButtons extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SearchedDistrictsButtons({
    @required this.onDistrictTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<String> onDistrictTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const EdgeInsets _topMargin = EdgeInsets.only(top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2, bottom: Ratioz.horizon);

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: true);
    final List<DistrictModel> _searchedDistricts = _zoneProvider.searchedDistricts;

    /// WHEN SEARCH RESULTS
    if (Mapper.checkCanLoopList(_searchedDistricts)){

      return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: _searchedDistricts.length,
          padding: _topMargin,
          shrinkWrap: true,
          itemBuilder: (_, int index) {

            final DistrictModel input = _searchedDistricts[index];

            return WideDistrictButton(
              district: input,
              onTap: onDistrictTap,
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
