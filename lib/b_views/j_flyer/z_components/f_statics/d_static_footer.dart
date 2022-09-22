import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/b_footer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/c_footer_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/a_info_button_structure/a_info_button_starter.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/animators.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
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
  EdgeInsets getButtonEnMargins({
    @required BuildContext context,
    @required int buttonNumber,
  }){
    final double _buttonSize = FooterButton.buttonSize(
        context: context,
        flyerBoxWidth: flyerBoxWidth
    );

    final double _spacing = FooterButton.buttonMargin(flyerBoxWidth: flyerBoxWidth,);

    final double _rightEnMarginValue =  ((_buttonSize + _spacing) * (buttonNumber - 1)) + _spacing;

    return Scale.superInsets(
      context: context,
      top: _spacing,
      bottom: _spacing,
      enLeft: _spacing,
      enRight: Animators.limitTweenImpact(
        minDouble: _spacing,
        maxDouble: _rightEnMarginValue,
        tweenValue: flightTweenValue,
      ),
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Align(
      key: const ValueKey<String>('StaticFooter'),
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: flyerBoxWidth,
        height: FooterBox.collapsedHeight(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
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
                  width: InfoButtonStarter.getWidth(
                    context: context,
                    flyerBoxWidth: flyerBoxWidth,
                    tinyMode: false,
                    isExpanded: false,
                    infoButtonType: InfoButtonType.info,
                  ),
                  height: InfoButtonStarter.getHeight(
                    context: context,
                    flyerBoxWidth: flyerBoxWidth,
                    tinyMode: false,
                    isExpanded: false,
                  ),
                  decoration: BoxDecoration(
                    color: Colorz.black255,
                    borderRadius: InfoButtonStarter.getBorders(
                        context: context,
                        flyerBoxWidth: flyerBoxWidth,
                        tinyMode: false,
                        isExpanded: false
                    ),
                  ),
                  margin: InfoButtonStarter.getMargin(
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
                padding: getButtonEnMargins(
                  buttonNumber: 3,
                  context: context,
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
                padding: getButtonEnMargins(
                  buttonNumber: 2,
                  context: context,
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
              padding: getButtonEnMargins(
                buttonNumber: 1,
                context: context,
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
