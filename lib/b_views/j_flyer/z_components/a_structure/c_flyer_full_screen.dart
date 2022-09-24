import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/c_flyer_hero.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

class FlyerScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerScreen({
    @required this.minWidthFactor,
    @required this.flyerModel,
    @required this.bzModel,
    @required this.flyerZone,
    @required this.heroTag,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final ZoneModel flyerZone;
  final double minWidthFactor;
  final String heroTag;
  /// --------------------------------------------------------------------------
  Future<void> _onDismiss(BuildContext context) async {
    await Nav.goBack(
      context: context,
      invoker: 'FlyerFullScreen._onDismiss',
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DismissiblePage(
      key: const ValueKey<String>('FullScreenFlyer_DismissiblePage'),
      onDismissed: () => _onDismiss(context),
      isFullScreen: false,
      dragSensitivity: .4,
      maxTransformValue: 4,
      reverseDuration: Ratioz.duration150ms,
      child: Material(
        color: Colors.transparent,
        type: MaterialType.transparency,

        child: FlyerHero(
          flyerModel: flyerModel,
          bzModel: bzModel,
          flyerZone: flyerZone,
          isFullScreen: true,
          minWidthFactor: minWidthFactor,
          heroTag: heroTag,
        ),

      ),
    );

  }
  // -----------------------------------------------------------------------------
}
