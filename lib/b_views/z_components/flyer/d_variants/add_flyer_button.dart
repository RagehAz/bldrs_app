import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/x_screens/g_bz/e_flyer_maker/a_flyer_maker_screen.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/d_variants/abstract_header.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFlyerButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AddFlyerButton({
    @required this.flyerBoxWidth,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  Future<void> _goToFlyerMaker({
    @required BuildContext context,
    @required BzModel bzModel,
  }) async {

    blog('going to create new flyer keda');

    await Future<void>.delayed(Ratioz.durationFading200, () async {

      final dynamic _result = await Nav.goToNewScreen(
          context: context,
          screen: const FlyerMakerScreen(),
      );

      if (_result.runtimeType == FlyerModel) {
        blog('_goToFlyerEditor : adding published flyer model to bzPage screen gallery');
        // addPublishedFlyerToGallery(_result);
      } else {
        blog('_goToFlyerEditor : did not publish the new draft flyer');
      }
    });
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    
    final double _flyerSizeFactor = FlyerBox.sizeFactorByWidth(context, flyerBoxWidth);
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    final BzModel _bzModel = _bzzProvider.myActiveBz;

    return GestureDetector(
      onTap: () => _goToFlyerMaker(
        context: context,
        bzModel: _bzModel,
      ),
      child: FlyerBox(
        flyerBoxWidth: flyerBoxWidth,
        stackWidgets: <Widget>[

          AbstractMiniHeader(
            flyerBoxWidth: flyerBoxWidth,
            bzModel: _bzModel,
          ),

          /// ADD FLYER BUTTON
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              /// --- FAKE HEADER FOOTPRINT
              SizedBox(
                height: FlyerBox.headerBoxHeight(
                    // bzPageIsOn: false,
                    flyerBoxWidth: flyerBoxWidth
                ),
              ),

              DreamBox(
                height: flyerBoxWidth * 0.4,
                width: flyerBoxWidth * 0.4,
                icon: Iconz.plus,
                iconColor: Colorz.white200,
                iconSizeFactor: 0.6,
                bubble: false,
                // onTap: () async {
                //   await _goToFlyerEditor(context);
                // },
              ),

              SuperVerse(
                verse: '##Add\nNew\nFlyer',
                maxLines: 5,
                scaleFactor: _flyerSizeFactor * 5,
                color: Colorz.white200,
              ),
            ],
          ),

        ],
      ),
    );
  }
}
