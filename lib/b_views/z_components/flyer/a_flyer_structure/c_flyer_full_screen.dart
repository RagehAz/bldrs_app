import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/c_flyer_hero.dart';
import 'package:bldrs/c_controllers/i_flyer_controller.dart';
import 'package:bldrs/d_providers/active_flyer_provider.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlyerFullScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerFullScreen({
    @required this.minWidthFactor,
    @required this.flyerModel,
    @required this.bzModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final double minWidthFactor;
  /// --------------------------------------------------------------------------
  void _onDismiss(BuildContext context){

    final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: false);
    final bool _canDismissFlyer = _activeFlyerProvider.canDismissFlyer;

    if (_canDismissFlyer == true){
      onCloseFullScreenFlyer(context);
    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DismissiblePage(
      onDismiss: () => _onDismiss(context),
      isFullScreen: false,
      dragSensitivity: .4,
      maxTransformValue: 4,
      // direction: DismissDirection.horizontal,
      reverseDuration: Ratioz.duration150ms,

      child: Material(
        color: Colors.transparent,
        type: MaterialType.transparency,

        child: FlyerHero(
          flyerModel: flyerModel,
          bzModel: bzModel,
          isFullScreen: true,
          minWidthFactor: minWidthFactor,
        ),

      ),
    );
  }
}
