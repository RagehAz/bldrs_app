import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/b_footer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/f_footer_button_spacer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/a_info_button_structure/a_info_button_starter.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
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
          height: FooterBox.collapsedHeight(
            context: context,
            flyerBoxWidth: flyerBoxWidth,
          ),
          child: Container(
            color: Colorz.white20,
            child: Row(
              children: <Widget>[

                /// INFO BUTTON
                Container(
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