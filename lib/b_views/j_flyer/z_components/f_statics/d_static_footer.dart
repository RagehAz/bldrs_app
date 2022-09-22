import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/b_footer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/c_footer_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class StaticFooter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StaticFooter({
    @required this.flyerBoxWidth,
    this.isSaved = false,
    this.opacity = 1,
    this.onMoreTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool isSaved;
  final double opacity;
  final Function onMoreTap;
  /// --------------------------------------------------------------------------
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
          alignment: Alignment.bottomCenter,
          children: <Widget>[

            /// BOTTOM SHADOW
            FooterShadow(
              key: const ValueKey<String>('FooterShadow'),
              flyerBoxWidth: flyerBoxWidth,
            ),

            Align(
              alignment: Aligners.superInverseBottomAlignment(context),
              child: Padding(
                padding: EdgeInsets.all(FooterButton.buttonMargin(flyerBoxWidth: flyerBoxWidth,)),
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
            ),

          ],
        ),
      ),
    );

  }
/// --------------------------------------------------------------------------
}
