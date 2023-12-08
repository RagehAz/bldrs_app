import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StaticFooter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StaticFooter({
    required this.flyerBoxWidth,
    required this.flyerID,
    this.optionsButtonIsOn,
    this.showAllButtons = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool? optionsButtonIsOn;
  final String? flyerID;
  final bool showAllButtons;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final EdgeInsets _saveButtonPadding = FlyerDim.footerButtonEnRightMargin(
      buttonNumber: 1,
      flightTweenValue: 1,
      flyerBoxWidth: flyerBoxWidth,
    );

    return Align(
      key: const ValueKey<String>('StaticFooter'),
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: flyerBoxWidth,
        height: FlyerDim.footerBoxHeight(
          flyerBoxWidth: flyerBoxWidth,
          infoButtonExpanded: false,
          showTopButton: false,
        ),
        child: Stack(
          alignment: BldrsAligners.superInverseBottomAlignment(context),
          children: <Widget>[

            /// INFO BUTTON
            if (showAllButtons == true)
            Align(
              alignment: BldrsAligners.superBottomAlignment(context),
              child: Container(
                // key: const ValueKey<String>('InfoButtonStarter_animated_container'),
                width: FlyerDim.infoButtonWidth(
                  flyerBoxWidth: flyerBoxWidth,
                  tinyMode: false,
                  isExpanded: false,
                  infoButtonType: InfoButtonType.info,
                ),
                height: FlyerDim.infoButtonHeight(
                  flyerBoxWidth: flyerBoxWidth,
                  tinyMode: false,
                  isExpanded: false,
                ),
                decoration: BoxDecoration(
                  color: Colorz.black255,
                  borderRadius: FlyerDim.infoButtonCorners(
                      flyerBoxWidth: flyerBoxWidth,
                      tinyMode: false,
                      isExpanded: false
                  ),
                ),
                margin: FlyerDim.infoButtonMargins(
                  flyerBoxWidth: flyerBoxWidth,
                  tinyMode: false,
                  isExpanded: false,
                ),
                alignment: Alignment.center,
              ),
            ),

            /// SHARE
            if (showAllButtons == true)
            Padding(
              padding: FlyerDim.footerButtonEnRightMargin(
                buttonNumber: 3,
                flyerBoxWidth: flyerBoxWidth,
                flightTweenValue: 1,
              ),
              child: FooterButton(
                flyerBoxWidth: flyerBoxWidth,
                count: null,
                icon: Iconz.share,
                phid: 'phid_share',
                isOn: false,
                canTap: false,
                onTap: null,
              ),
            ),

            /// REVIEWS
            if (showAllButtons == true)
            Padding(
              padding: FlyerDim.footerButtonEnRightMargin(
                buttonNumber: 2,
                flyerBoxWidth: flyerBoxWidth,
                flightTweenValue: 1,
              ),
              child: FooterButton(
                count: null,
                flyerBoxWidth: flyerBoxWidth,
                icon: Iconz.balloonSpeaking,
                phid: 'phid_review',
                isOn: false,
                canTap: false,
                onTap: null,
              ),
            ),

            /// SAVE BUTTON
            if (optionsButtonIsOn == false)
              Selector<UsersProvider, UserModel?>(
                selector: (_, UsersProvider userProvider) => userProvider.myUserModel,
                builder: (_, UserModel? userModel, Widget? child) {

                  final bool _isOn = UserModel.checkFlyerIsSaved(
                    userModel: userModel,
                    flyerID: flyerID,
                  );

                  if (_isOn == false){
                    return const SizedBox();
                  }

                  else {
                    return Padding(
                      padding: _saveButtonPadding,
                      child: FooterButton(
                        color: Colorz.yellow80,
                        flyerBoxWidth: flyerBoxWidth,
                        icon: Iconz.saveBlack,
                        phid: 'phid_save',
                        isOn: _isOn,
                        onTap: null,
                        count: null,
                        canTap: optionsButtonIsOn == null,
                      ),
                    );
                  }


                },
              ),

          ],
        ),
      ),
    );

  }
/// --------------------------------------------------------------------------
}
