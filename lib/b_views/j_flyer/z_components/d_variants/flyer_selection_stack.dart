import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/e_extra_layers/flyer_audit_layer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/e_extra_layers/flyer_selection_layer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scale/scale.dart';

class FlyerSelectionStack extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerSelectionStack({
    @required this.flyerModel,
    @required this.onSelectFlyer,
    @required this.onFlyerOptionsTap,
    @required this.flyerBoxWidth,
    @required this.flyerWidget,
    @required this.selectionMode,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onSelectFlyer;
  final Function onFlyerOptionsTap;
  final FlyerModel flyerModel;
  final double flyerBoxWidth;
  final Widget flyerWidget;
  final bool selectionMode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _selectionMode = selectionMode ?? false;

    final bool _showAuditLayer = FlyerAuditLayer.showAuditLayer(flyerModel?.auditState);
    final bool _showOptionsButton = onFlyerOptionsTap != null;

    final bool _canBuildSelectionStack =
         _showAuditLayer == true
             ||
         _selectionMode == true
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
              absorbing: _selectionMode,
              child: flyerWidget,
            ),

          /// WAITING VERIFICATION LAYER
          if (_showAuditLayer == true && _tinyMode == true)
            FlyerAuditLayer(
              flyerBoxWidth: flyerBoxWidth,
              auditState: flyerModel?.auditState,
            ),

          /// IS-SELECTED GRAPHIC LAYER
          if (_selectionMode == true && onSelectFlyer != null)
            Consumer<FlyersProvider>(
              builder: (_, FlyersProvider flyersProvider, Widget child){

                return FlyerSelectionLayer(
                  flyerBoxWidth: flyerBoxWidth,
                  isSelected: FlyerModel.flyersContainThisID(
                    flyers: flyersProvider.selectedFlyers,
                    flyerID: flyerModel.id,
                  ),
                );

              },
            ),

          /// TAP LAYER
          if (_selectionMode == true && onSelectFlyer != null)
            BldrsBox(
              height: _flyerBoxHeight,
              width: flyerBoxWidth,
              corners: FlyerDim.flyerCorners(context, flyerBoxWidth),
              bubble: false,
              splashColor: Colorz.yellow125,
              onTap: onSelectFlyer,
            ),

          /// FLYER OPTIONS BUTTON
          if (_showOptionsButton == true)
            SuperPositioned(
              enAlignment: Alignment.bottomRight,
              verticalOffset: FlyerDim.footerButtonMarginValue(flyerBoxWidth,),
              horizontalOffset: FlyerDim.footerButtonMarginValue(flyerBoxWidth,),
              appIsLTR: UiProvider.checkAppIsLeftToRight(),
              child: FooterButton(
                icon: Iconz.more,
                phid: 'phid_more',
                flyerBoxWidth: flyerBoxWidth,
                onTap: onFlyerOptionsTap,
                isOn: UserModel.checkFlyerIsSaved(
                  flyerID: flyerModel?.id,
                  userModel: UsersProvider.proGetMyUserModel(
                    context: context,
                    listen: true,
                  ),
                ),
                canTap: true,
                count: 0,
              ),

            ),

        ],
      );
      // --------------------
    }

  }
  /// --------------------------------------------------------------------------
}
