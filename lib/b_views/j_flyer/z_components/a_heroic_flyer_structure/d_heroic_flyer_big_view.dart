import 'dart:async';

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/b_heroic_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_grid/z_grid.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

class HeroicFlyerBigView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeroicFlyerBigView({
    required this.flyerBoxWidth,
    required this.renderedFlyer,
    required this.heroPath,
    super.key
  });
  /// --------------------------------------------------------------------------
  final FlyerModel? renderedFlyer;
  final double flyerBoxWidth;
  final String heroPath;
  /// --------------------------------------------------------------------------
  Future<void> _onDismiss(BuildContext context) async {

    // unawaited(Sounder.playSound(
    //   mp3Asset: BldrsThemeSounds.whip_long,
    //   wavAssetForAndroid: BldrsThemeSounds.whip_long_wav,
    // ));

    await Nav.goBack(
      context: context,
      invoker: 'FlyerFullScreen._onDismiss',
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);

    return DismissiblePage(
      key: const ValueKey<String>('FullScreenFlyer_DismissiblePage'),
      onDismissed: () => _onDismiss(context),
      isFullScreen: false,
      dragSensitivity: .4,
      maxTransformValue: 4,
      reverseDuration: Ratioz.duration150ms,
      backgroundColor: Colorz.black0,
      direction: DismissiblePageDismissDirection.down,
      child: Material(
        color: Colorz.bloodTest,
        type: MaterialType.transparency,

        child: FlyerHero(
          heroPath: heroPath,
          renderedFlyer: renderedFlyer,
          flyerBoxWidth: ZGridScale.getBigItemWidth(
              gridWidth: _screenWidth,
              gridHeight: _screenHeight,
              itemAspectRatio: FlyerDim.flyerAspectRatio(),
          ),
          canBuildBigFlyer: true,
          invoker: 'FlyerBigView',
          gridWidth: _screenWidth,
          gridHeight: _screenHeight,
        ),

      ),
    );

  }
  // -----------------------------------------------------------------------------
}
