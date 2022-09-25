import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/c_footer_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class StaticFooter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StaticFooter({
    @required this.flyerBoxWidth,
    this.isSaved = false,
    this.flightTweenValue = 1,
    this.onMoreTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool isSaved;
  final double flightTweenValue;
  final Function onMoreTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Align(
      key: const ValueKey<String>('StaticFooter'),
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: flyerBoxWidth,
        height: FlyerDim.footerBoxHeight(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
          infoButtonExpanded: false,
        ),
        child: Stack(
          alignment: Aligners.superInverseBottomAlignment(context),
          children: <Widget>[

            /// BOTTOM SHADOW
            FooterShadow(
              key: const ValueKey<String>('FooterShadow'),
              flyerBoxWidth: flyerBoxWidth,
            ),

            /// INFO BUTTON
            Opacity(
              opacity: flightTweenValue,
              child: Align(
                alignment: Aligners.superBottomAlignment(context),
                child: Container(
                  // key: const ValueKey<String>('InfoButtonStarter_animated_container'),
                  width: FlyerDim.infoButtonWidth(
                    context: context,
                    flyerBoxWidth: flyerBoxWidth,
                    tinyMode: false,
                    isExpanded: false,
                    infoButtonType: InfoButtonType.info,
                  ),
                  height: FlyerDim.infoButtonHeight(
                    context: context,
                    flyerBoxWidth: flyerBoxWidth,
                    tinyMode: false,
                    isExpanded: false,
                  ),
                  decoration: BoxDecoration(
                    color: Colorz.black255,
                    borderRadius: FlyerDim.infoButtonCorners(
                        context: context,
                        flyerBoxWidth: flyerBoxWidth,
                        tinyMode: false,
                        isExpanded: false
                    ),
                  ),
                  margin: FlyerDim.infoButtonMargins(
                    context: context,
                    flyerBoxWidth: flyerBoxWidth,
                    tinyMode: false,
                    isExpanded: false,
                  ),
                  alignment: Alignment.center,
                ),
              ),
            ),

            /// SHARE
            Opacity(
              opacity: flightTweenValue,
              child: Padding(
                padding: FlyerDim.footerButtonEnRightMargin(
                  buttonNumber: 3,
                  context: context,
                  flyerBoxWidth: flyerBoxWidth,
                  flightTweenValue: flightTweenValue,
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
            ),

            /// REVIEWS
            Opacity(
              opacity: flightTweenValue,
              child: Padding(
                padding: FlyerDim.footerButtonEnRightMargin(
                  buttonNumber: 2,
                  context: context,
                  flyerBoxWidth: flyerBoxWidth,
                  flightTweenValue: flightTweenValue,
                ),
                child: FooterButton(
                  count: null,
                  flyerBoxWidth: flyerBoxWidth,
                  icon: Iconz.utPlanning,
                  phid: 'phid_review',
                  isOn: false,
                  canTap: false,
                  onTap: null,
                ),
              ),
            ),

            /// SAVE BUTTON
            Padding(
              padding: FlyerDim.footerButtonEnRightMargin(
                buttonNumber: 1,
                context: context,
                flightTweenValue: flightTweenValue,
                flyerBoxWidth: flyerBoxWidth,
              ),
              child: FooterButton(
                flyerBoxWidth: flyerBoxWidth,
                icon: onMoreTap != null ? Iconz.more : isSaved == true ? Iconz.save : null,
                phid:  '', // superPhrase(context, 'phid_save'),
                isOn: isSaved,
                canTap: onMoreTap != null,
                onTap: onMoreTap,
                count: null,
              ),
            ),

          ],
        ),
      ),
    );

  }
/// --------------------------------------------------------------------------
}
