import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:basics/helpers/widgets/drawing/expander.dart';
import 'package:basics/helpers/widgets/drawing/spacing.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/f_footer_button_spacer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';

class FooterTemplate extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FooterTemplate({
    required this.flyerBoxWidth,
    this.buttonColor = Colorz.black20,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final Color buttonColor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Widget _spacer = FooterButtonSpacer(
        flyerBoxWidth: flyerBoxWidth,
    );

    final Widget _bigButton = FooterButtonTemplate(
      color: buttonColor,
      size: FlyerDim.footerButtonSize(
        flyerBoxWidth: flyerBoxWidth,
      ),
    );

    final Widget _smallButton = FooterButtonTemplate(
      color: buttonColor,
      size: FlyerDim.infoButtonWidth(
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: false,
        isExpanded: false,
        infoButtonType: InfoButtonType.info,
      ),
    );

    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: flyerBoxWidth,
        height: FlyerDim.footerBoxHeight(
          flyerBoxWidth: flyerBoxWidth,
          infoButtonExpanded: false,
          showTopButton: false,
        ),
        child: Row(
          children: <Widget>[

            /// ---> BIG SPACING
            Spacing(
              size: FlyerDim.infoButtonMargins(
                flyerBoxWidth: flyerBoxWidth,
                tinyMode: false,
                isExpanded: false,
              ).left,
            ),

            /// INFO BUTTON
            _smallButton,

            const Expander(),

            /// ---> SPACING
            _spacer,

            /// SHARE
            _bigButton,

            /// ---> SPACING
            _spacer,

            /// COMMENT
            _bigButton,

            /// ---> SPACING
            _spacer,

            /// SAVE BUTTON
            _bigButton,

            /// ---> SPACING
            _spacer,

          ],
        ),
      ),
    );

  }
/// --------------------------------------------------------------------------
}

class FooterButtonTemplate extends StatelessWidget {

  const FooterButtonTemplate({
    required this.size,
    required this.color,
    this.child,
    super.key
  });

  final double size;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    // --------------------
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: Borderers.superCorners(
          corners: size * 0.5,
        ),
      ),
      child: child,
    );

  }

}
