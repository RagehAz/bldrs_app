import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
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
  // void _showOldFlyersOnTap(BuildContext context, BzModel bzModel) {
  //   Nav.goToNewScreen(context, DeactivatedFlyerScreen(bz: bzModel));
  // }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return FlyersGrid(
      flyers: flyers,
      gridWidth: superScreenWidth(context),
      gridHeight: superScreenHeight(context),
      scrollController: ScrollController(),
      numberOfColumns: 2,
      topPadding: 5,
      addFlyerButtonIsOn: true,
    );

  }
}
