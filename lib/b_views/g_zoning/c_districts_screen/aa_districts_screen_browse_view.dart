import 'package:bldrs/a_models/d_zone/zz_old/district_model.dart';
import 'package:bldrs/b_views/z_components/buttons/tile_buttons/district_tile_button.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class DistrictsScreenBrowseView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DistrictsScreenBrowseView({
    @required this.districts,
    @required this.onDistrictChanged,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<DistrictModel> districts;
  final ValueChanged<String> onDistrictChanged;
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

        return WideDistrictButton(
          district: _district,
          onTap: onDistrictChanged,
        );

      },
    );

  }
  // -----------------------------------------------------------------------------
}
