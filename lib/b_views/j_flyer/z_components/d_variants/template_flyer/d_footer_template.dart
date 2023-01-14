import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/f_footer_button_spacer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class FooterTemplate extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FooterTemplate({
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Widget _spacer = FooterButtonSpacer(
        flyerBoxWidth: flyerBoxWidth,
    );

    return Opacity(
      key: const ValueKey<String>('StaticFooter'),
      opacity: 0.5,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: flyerBoxWidth,
          height: FlyerDim.footerBoxHeight(
            context: context,
            flyerBoxWidth: flyerBoxWidth,
            infoButtonExpanded: false,
          ),
          child: Container(
            color: Colorz.white20,
            child: Row(
              children: <Widget>[

                /// INFO BUTTON
                Container(
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

                const Expander(),

                _spacer,

                /// SHARE
                FooterButton(
                  flyerBoxWidth: flyerBoxWidth,
                  icon: null, // Iconz.share,
                  phid:  '', // superPhrase(context, 'phid_send'),
                  isOn: false,
                  canTap: true,
                  onTap: (){},
                  count: null,
                ),

                _spacer,

                /// COMMENT
                FooterButton(
                  flyerBoxWidth: flyerBoxWidth,
                  icon: null, // Iconz.utPlanning,
                  phid:  '', // superPhrase(context, 'phid_comment'),
                  isOn: false,
                  canTap: false,
                  onTap: (){},
                  count: null,
                ),

                _spacer,

                /// SAVE BUTTON
                FooterButton(
                  flyerBoxWidth: flyerBoxWidth,
                  icon: null,
                  phid:  '', // superPhrase(context, 'phid_save'),
                  isOn: false,
                  canTap: false,
                  onTap: null,
                  count: null,
                ),

                _spacer,


              ],
            ),
          ),
        ),
      ),
    );

  }
/// --------------------------------------------------------------------------
}
