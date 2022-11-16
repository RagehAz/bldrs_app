import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/b_flyer_hero.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/sounder.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

class FlyerBigView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerBigView({
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    @required this.bzModel,
    @required this.heroTag,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final double flyerBoxWidth;
  final String heroTag;
  /// --------------------------------------------------------------------------
  Future<void> _onDismiss(BuildContext context) async {

    unawaited(Sounder.playAssetSound(Sounder.whip_long));

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
          heroTag: heroTag,
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
