import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/b_heroic_flyer_hero.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/sounder.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

class HeroicFlyerBigView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeroicFlyerBigView({
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    @required this.bzModel,
    @required this.heroPath,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final double flyerBoxWidth;
  final String heroPath;
  /// --------------------------------------------------------------------------
  Future<void> _onDismiss(BuildContext context) async {

    unawaited(Sounder.playAssetSound(BldrsThemeSounds.whip_long));

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
          heroPath: heroPath,
          flyerModel: flyerModel,
          bzModel: bzModel,
          flyerBoxWidth: Scale.screenWidth(context),
          canBuildBigFlyer: true,
          invoker: 'FlyerBigView',
        ),

      ),
    );

  }
  // -----------------------------------------------------------------------------
}
