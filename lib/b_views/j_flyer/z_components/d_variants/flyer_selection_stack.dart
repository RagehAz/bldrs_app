import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/a_heroic_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/e_extra_layers/flyer_selection_layer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/e_extra_layers/flyer_verification_layer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/sizing/super_positioned.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class FlyerSelectionStack extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerSelectionStack({
    @required this.flyerModel,
    @required this.onSelectFlyer,
    @required this.onFlyerOptionsTap,
    @required this.flyerBoxWidth,
    @required this.screenName,
    @required this.isSelected,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onSelectFlyer;
  final Function onFlyerOptionsTap;
  final FlyerModel flyerModel;
  final double flyerBoxWidth;
  final String screenName;
  final bool isSelected;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(
      flyerBoxWidth: flyerBoxWidth,
      forceMaxHeight: false,
    );
    final BorderRadius _corners = FlyerDim.flyerCorners(context, flyerBoxWidth);
    final bool _isSelectionMode = onSelectFlyer != null;
    // --------------------
    final bool _tinyMode = FlyerDim.isTinyMode(context, flyerBoxWidth);
    // --------------------
    return Stack(
      key: const ValueKey<String>('flyerSelectionStack'),
      // alignment: Alignment.center,
      children: <Widget>[

        /// FLYER
        if (flyerModel != null)
        AbsorbPointer(
          absorbing: _isSelectionMode,
          child: HeroicFlyer(
            // key: ValueKey<String>('FlyerSelectionStack${flyerModel.id}'),
            flyerModel: flyerModel,
            flyerBoxWidth: flyerBoxWidth,
            screenName: screenName,
          ),
        ),

        /// WAITING VERIFICATION LAYER
        if (flyerModel != null && _tinyMode == true)
          FlyerVerificationLayer(
            flyerBoxWidth: flyerBoxWidth,
            auditState: flyerModel?.auditState,
          ),

        /// IS-SELECTED GRAPHIC LAYER
        if (flyerModel != null && isSelected == true)
          FlyerSelectionLayer(
            flyerBoxWidth: flyerBoxWidth,
          ),

        /// TAP LAYER
        if (flyerModel != null && _isSelectionMode == true)
          DreamBox(
            height: _flyerBoxHeight,
            width: flyerBoxWidth,
            corners: _corners,
            bubble: false,
            splashColor: Colorz.yellow125,
            onTap: onSelectFlyer,
          ),

        /// FLYER OPTIONS BUTTON
        if (onFlyerOptionsTap != null)
          SuperPositioned(
            enAlignment: Alignment.bottomRight,
            verticalOffset: FlyerDim.footerButtonMarginValue(flyerBoxWidth,),
            horizontalOffset: FlyerDim.footerButtonMarginValue(flyerBoxWidth,),
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
              count: null,
            ),

          ),

      ],
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
