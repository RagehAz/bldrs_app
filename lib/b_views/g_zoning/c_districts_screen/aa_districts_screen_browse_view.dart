import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/district_tile_button.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class DistrictsScreenBrowseView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DistrictsScreenBrowseView({
    @required this.districts,
    @required this.shownDistrictsIDs,
    @required this.onDistrictChanged,
    @required this.censusModels,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<DistrictModel> districts;
  final List<String> shownDistrictsIDs;
  final ValueChanged<String> onDistrictChanged;
  final List<CensusModel> censusModels;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: districts.length,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2, bottom: Ratioz.horizon),
      itemBuilder: (BuildContext context, int index) {

        final DistrictModel _district = districts[index];
        final CensusModel _census = CensusModel.getCensusFromCensusesByID(
          censuses: censusModels,
          censusID: _district.id,
        );

        final bool _isActive = Stringer.checkStringsContainString(
          strings: shownDistrictsIDs,
          string: _district.id,
        );

        return WideDistrictButton(
          district: _district,
          onTap: onDistrictChanged,
          censusModel: _census,
          isActive: _isActive,
        );

      },
    );

  }
  // -----------------------------------------------------------------------------
}
