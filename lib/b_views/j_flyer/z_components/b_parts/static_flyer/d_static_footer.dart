import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StaticFooter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StaticFooter({
    required this.flyerBoxWidth,
    required this.flyerID,
    this.optionsButtonIsOn,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool optionsButtonIsOn;
  final String flyerID;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final EdgeInsets _saveButtonPadding = FlyerDim.footerButtonEnRightMargin(
      buttonNumber: 1,
      context: context,
      flightTweenValue: 1,
      flyerBoxWidth: flyerBoxWidth,
    );

    // blog('building StaticFooter : flightTweenValue : $flightTweenValue');

    return Align(
      key: const ValueKey<String>('StaticFooter'),
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: flyerBoxWidth,
        height: FlyerDim.footerBoxHeight(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
          infoButtonExpanded: false,
          hasLink: false,
        ),
        child: Stack(
          alignment: BldrsAligners.superInverseBottomAlignment(context),
          children: <Widget>[

            /// WORKS PERFECT : BUT NO NEED : KEPT FOR REFERENCE
            // /// INFO BUTTON
            // Align(
            //   alignment: Aligners.superBottomAlignment(context),
            //   child: Container(
            //     // key: const ValueKey<String>('InfoButtonStarter_animated_container'),
            //     width: FlyerDim.infoButtonWidth(
            //       context: context,
            //       flyerBoxWidth: flyerBoxWidth,
            //       tinyMode: false,
            //       isExpanded: false,
            //       infoButtonType: InfoButtonType.info,
            //     ),
            //     height: FlyerDim.infoButtonHeight(
            //       context: context,
            //       flyerBoxWidth: flyerBoxWidth,
            //       tinyMode: false,
            //       isExpanded: false,
            //     ),
            //     decoration: BoxDecoration(
            //       color: Colorz.black255,
            //       borderRadius: FlyerDim.infoButtonCorners(
            //           context: context,
            //           flyerBoxWidth: flyerBoxWidth,
            //           tinyMode: false,
            //           isExpanded: false
            //       ),
            //     ),
            //     margin: FlyerDim.infoButtonMargins(
            //       context: context,
            //       flyerBoxWidth: flyerBoxWidth,
            //       tinyMode: false,
            //       isExpanded: false,
            //     ),
            //     alignment: Alignment.center,
            //   ),
            // ),
            //
            // /// SHARE
            // Padding(
            //   padding: FlyerDim.footerButtonEnRightMargin(
            //     buttonNumber: 3,
            //     context: context,
            //     flyerBoxWidth: flyerBoxWidth,
            //     flightTweenValue: 1,
            //   ),
            //   child: FooterButton(
            //     flyerBoxWidth: flyerBoxWidth,
            //     count: null,
            //     icon: Iconz.share,
            //     phid: 'phid_share',
            //     isOn: false,
            //     canTap: false,
            //     onTap: null,
            //   ),
            // ),
            //
            // /// REVIEWS
            // Padding(
            //   padding: FlyerDim.footerButtonEnRightMargin(
            //     buttonNumber: 2,
            //     context: context,
            //     flyerBoxWidth: flyerBoxWidth,
            //     flightTweenValue: 1,
            //   ),
            //   child: FooterButton(
            //     count: null,
            //     flyerBoxWidth: flyerBoxWidth,
            //     icon: Iconz.balloonSpeaking,
            //     phid: 'phid_review',
            //     isOn: false,
            //     canTap: false,
            //     onTap: null,
            //   ),
            // ),

            /// SAVE BUTTON
            if (optionsButtonIsOn == false)
              Selector<UsersProvider, UserModel>(
                selector: (_, UsersProvider userProvider) => userProvider.myUserModel,
                builder: (_, UserModel userModel, Widget? child) {

                  return Padding(
                    padding: _saveButtonPadding,
                    child: FooterButton(
                      flyerBoxWidth: flyerBoxWidth,
                      icon: Iconz.save,
                      phid: 'phid_save',
                      isOn: UserModel.checkFlyerIsSaved(
                        userModel: userModel,
                        flyerID: flyerID,
                      ),
                      onTap: null,
                      count: null,
                      canTap: optionsButtonIsOn == null,
                    ),
                  );

                },
              ),

          ],
        ),
      ),
    );

  }
/// --------------------------------------------------------------------------
}
