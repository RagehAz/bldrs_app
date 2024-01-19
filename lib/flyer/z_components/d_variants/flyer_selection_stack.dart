import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/components/drawing/super_positioned.dart';
import 'package:basics/components/super_box/src/f_super_box_tap_layer/x_tap_layer.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/flyer/z_components/b_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/flyer/z_components/b_parts/e_extra_layers/flyer_audit_layer.dart';
import 'package:bldrs/flyer/z_components/b_parts/e_extra_layers/flyer_selection_layer.dart';
import 'package:bldrs/flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlyerSelectionStack extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerSelectionStack({
    required this.flyerModel,
    required this.onSelectFlyer,
    required this.onFlyerOptionsTap,
    required this.flyerBoxWidth,
    required this.flyerWidget,
    required this.selectionMode,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Function? onSelectFlyer;
  final Function? onFlyerOptionsTap;
  final FlyerModel? flyerModel;
  final double flyerBoxWidth;
  final Widget flyerWidget;
  final bool selectionMode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// SCORE_NUMBER_TESTING_WIDGET
    // return Stack(
    //   alignment: Alignment.center,
    //   children: [
    //     flyerWidget,
    //     BldrsText(
    //       verse: Verse.plain(flyerModel?.score?.toString() ?? 'x'),
    //       labelColor: Colorz.black255,
    //       weight: VerseWeight.black,
    //       size: 6,
    //       scaleFactor: 3,
    //     ),
    //   ],
    // );
    //

    final bool _showAuditLayer = FlyerAuditLayer.showAuditLayer(flyerModel?.publishState);
    final bool _showOptionsButton = onFlyerOptionsTap != null;

    final bool _canBuildSelectionStack =
         _showAuditLayer == true
             ||
         selectionMode == true
             ||
         _showOptionsButton == true;

    /// CAN NOT BUILD SELECTION STACK
    if (flyerModel == null || _canBuildSelectionStack == false){
      return flyerWidget;
    }

    /// CAN BUILD SELECTION STACK
    else {
      // --------------------
      final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(
        flyerBoxWidth: flyerBoxWidth,
      );
      // --------------------
      final bool _tinyMode = FlyerDim.isTinyMode(
        flyerBoxWidth: flyerBoxWidth,
        gridWidth: Scale.screenWidth(context),
        gridHeight: Scale.screenHeight(context),
      );
      // --------------------
      return Stack(
        key: const ValueKey<String>('flyerSelectionStack'),
        // alignment: Alignment.center,
        children: <Widget>[

          /// FLYER
            AbsorbPointer(
              absorbing: selectionMode,
              child: flyerWidget,
            ),

          /// WAITING VERIFICATION LAYER
          if (_showAuditLayer == true && _tinyMode == true)
            FlyerAuditLayer(
              flyerBoxWidth: flyerBoxWidth,
              publishState: flyerModel?.publishState,
            ),

          /// IS-SELECTED GRAPHIC LAYER
          if (selectionMode == true && onSelectFlyer != null)
            Consumer<FlyersProvider>(
              builder: (_, FlyersProvider flyersProvider, Widget? child){

                return FlyerSelectionLayer(
                  flyerBoxWidth: flyerBoxWidth,
                  isSelected: FlyerModel.flyersContainThisID(
                    flyers: flyersProvider.selectedFlyers,
                    flyerID: flyerModel?.id,
                  ),
                );

              },
            ),

          /// TAP LAYER
          if (selectionMode == true && onSelectFlyer != null)
            TapLayer(
              height: _flyerBoxHeight,
              width: flyerBoxWidth,
              corners: FlyerDim.flyerCorners(flyerBoxWidth),
              splashColor: flyerModel?.slides?[0].midColor?.withOpacity(0.8) ?? Colorz.yellow200,
              onTap: onSelectFlyer,
            ),

          /// FLYER OPTIONS BUTTON
          if (_showOptionsButton == true)
            Builder(
              builder: (context) {

                final bool _isOn = UserModel.checkFlyerIsSaved(
                  flyerID: flyerModel?.id,
                  userModel: UsersProvider.proGetMyUserModel(
                    context: context,
                    listen: true,
                  ),
                );

                return SuperPositioned(
                  enAlignment: Alignment.bottomRight,
                  verticalOffset: FlyerDim.footerButtonMarginValue(flyerBoxWidth,),
                  horizontalOffset: FlyerDim.footerButtonMarginValue(flyerBoxWidth,),
                  appIsLTR: UiProvider.checkAppIsLeftToRight(),
                  child: FooterButton(
                    icon: Iconz.more,
                    phid: _tinyMode == true ? '' : 'phid_more',
                    flyerBoxWidth: flyerBoxWidth,
                    onTap: onFlyerOptionsTap == null ? null : () => onFlyerOptionsTap!(),
                    isOn: _isOn,
                    canTap: true,
                    count: 0,
                  ),

                );
              }
            ),

        ],
      );
      // --------------------
    }

  }
  /// --------------------------------------------------------------------------
}
