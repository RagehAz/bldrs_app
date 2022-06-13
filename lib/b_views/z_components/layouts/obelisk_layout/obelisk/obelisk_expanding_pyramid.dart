import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class ObeliskExpandingPyramid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskExpandingPyramid({
    @required this.isExpanded,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> isExpanded;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Positioned(
      bottom: Pyramids.verticalPositionFix,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.only(right: 17 * 0.7),
        child: ValueListenableBuilder(
          valueListenable: isExpanded,
          child: const SuperImage(
            width: 143.1 * 0.7,
            height: 66.4 * 0.7,
            pic: Iconz.pyramid,
            boxFit: BoxFit.fitWidth,
            iconColor: Colorz.black230,
            // scale: 1,
          ),
          builder: (_, bool expanded, Widget child){

            return AnimatedScale(
              scale: expanded == true ? 8 : 1,
              duration: const Duration(milliseconds: 500),
              curve: expanded == true ?  Curves.easeOutQuart : Curves.easeOutQuart,
              alignment: Alignment.bottomRight,
              child: child,
            );

          },
        ),
      ),
    );

  }
}
