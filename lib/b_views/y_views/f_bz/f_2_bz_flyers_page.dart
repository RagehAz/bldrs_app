import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/flyer_maker_screen.dart/flyer_maker_screen.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
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
  Future<void> _onDeleteFlyer({
    @required FlyerModel flyer,
    @required BuildContext context,
  }) async {

    blog('SHOULD DELETE THIS FLYER');
    blog('if flyer is only 48 hours old');

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // blog('BzFlyersPage : building ${flyers.length} flyers');

    if (canLoopList(flyers) == true){
      return FlyersGrid(
        key: const ValueKey<String>('BzFlyersPage_grid'),
        flyers: flyers,
        gridWidth: superScreenWidth(context),
        gridHeight: superScreenHeight(context),
        scrollController: null,
        numberOfColumns: 2,
        topPadding: 5,
        authorMode: true,
        onDeleteFlyer: (FlyerModel flyerModel) => _onDeleteFlyer(
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
