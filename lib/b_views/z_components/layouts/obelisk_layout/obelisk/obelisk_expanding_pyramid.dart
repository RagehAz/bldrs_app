import 'package:bldrs/b_views/z_components/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/images/super_image/a_super_image.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObeliskExpandingPyramid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskExpandingPyramid({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Positioned(
      bottom: Pyramids.verticalPositionFix,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.only(right: 17 * 0.7),
        child: Selector<UiProvider, bool>(
          selector: (_, UiProvider uiProvider) => uiProvider.pyramidsAreExpanded,
          builder: (_, bool expanded, Widget child) {


            return AnimatedScale(
              scale: expanded == true ? 8 : 1,
              duration: expanded == true ? const Duration(milliseconds: 250) : const Duration(milliseconds: 700),
              curve: expanded == true ?  Curves.easeOutQuart : Curves.easeInOutQuart,
              alignment: Alignment.bottomRight,
              child: child,
            );

          },

          /// THE BLACK EXPANDING TRIANGLE
          child: const BldrsImage(
            width: 143.1 * 0.7,
            height: 66.4 * 0.7,
            pic: Iconz.pyramid,
            fit: BoxFit.fitWidth,
            iconColor: Colorz.black230,
            // scale: 1,
          ),

        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
