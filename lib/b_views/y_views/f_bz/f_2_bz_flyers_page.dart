import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
import 'package:bldrs/c_controllers/f_my_bz_screen_controller.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:flutter/material.dart';

class BzFlyersPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzFlyersPage({
    @required this.bzModel,
    @required this.flyers,
    @required this.bzCountry,
    @required this.bzCity,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final List<FlyerModel> flyers;
  final CountryModel bzCountry;
  final CityModel bzCity;
  /// --------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    // blog('BzFlyersPage : building ${flyers.length} flyers');

    if (flyers != null){
      return FlyersGrid(
        key: const ValueKey<String>('BzFlyersPage_grid'),
        flyers: flyers,
        gridWidth: superScreenWidth(context),
        gridHeight: superScreenHeight(context),
        scrollController: null,
        numberOfColumns: 2,
        topPadding: 5,
        authorMode: true,
        onFlyerOptionsTap: (FlyerModel flyerModel) => onFlyerOptionsTap(
          context: context,
          flyer: flyerModel,
        ),
      );
    }
    else {
      return const SizedBox();
    }

  }
}
