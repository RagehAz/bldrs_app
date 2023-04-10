import 'dart:async';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/b_heroic_flyer_hero.dart';
import 'package:layouts/layouts.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:mediators/mediators.dart';
import 'package:scale/scale.dart';

class HeroicFlyerBigView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeroicFlyerBigView({
    @required this.flyerBoxWidth,
    @required this.renderedFlyer,
    @required this.heroPath,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel renderedFlyer;
  final double flyerBoxWidth;
  final String heroPath;
  /// --------------------------------------------------------------------------
  Future<void> _onDismiss(BuildContext context) async {

    unawaited(Sounder.playSound(
      mp3Asset: BldrsThemeSounds.whip_long,
      wavAssetForAndroid: BldrsThemeSounds.whip_long_wav,
    ));

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
          renderedFlyer: renderedFlyer,
          flyerBoxWidth: Scale.screenWidth(context),
          canBuildBigFlyer: true,
          invoker: 'FlyerBigView',
        ),

      ),
    );

  }
  // -----------------------------------------------------------------------------
}
