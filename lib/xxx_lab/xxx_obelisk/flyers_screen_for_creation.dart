import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TheFlyerScreenForCreation extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TheFlyerScreenForCreation({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _gridZoneWidth = Scale.superScreenWidth(context);
    const double _spacingRatioToGridWidth = 0.03;
    const int _numberOfColumns = 3;
    final double _gridFlyerWidth = _gridZoneWidth / (_numberOfColumns + (_numberOfColumns * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);

    final double _gridSpacing = _gridFlyerWidth * _spacingRatioToGridWidth;

    final EdgeInsets _gridPadding = EdgeInsets.all(_gridSpacing);

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);

    final double _minWidthFactor =  _gridFlyerWidth / _gridZoneWidth;

    return MainLayout(
      historyButtonIsOn: false,
      pyramidsAreOn: true,
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      layoutWidget: FlyersGrid(
        gridWidth: Scale.superScreenWidth(context),
        gridHeight: Scale.superScreenHeight(context),
        flyers: _flyersProvider.savedFlyers,
      ),

    );
  }
}
