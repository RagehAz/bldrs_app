import 'package:bldrs/b_views/j_flyer/z_components/a_structure/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class AuthorPic extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthorPic({
    this.size,
    this.authorPic,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double size;
  final dynamic authorPic;
  /// --------------------------------------------------------------------------
  static double getCornerValue(double flyerBoxWidth) {
    return flyerBoxWidth * FlyerDim.xFlyerAuthorPicCorner;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _authorImageHeight = size;
    final double _authorImageCorners = getCornerValue(size / FlyerDim.xFlyerAuthorPicWidth);
// -----------------------------------------------------------------------------
    final BorderRadius _authorPicBorders = Borderers.superBorderOnly(
        context: context,
        enTopLeft: _authorImageCorners,
        enBottomLeft: 0,
        enBottomRight: _authorImageCorners,
        enTopRight: _authorImageCorners);
// -----------------------------------------------------------------------------
    return Center(
      child: Container(
        height: _authorImageHeight,
        width: size,
        decoration: BoxDecoration(
            color: Colorz.white10,
            borderRadius: _authorPicBorders,
            image: authorPic == null ?
            null
                :
            ObjectCheck.objectIsJPGorPNG(authorPic) ?
            DecorationImage(image: AssetImage(authorPic), fit: BoxFit.cover)
                :
            null
        ),
        child: ClipRRect(
          borderRadius: _authorPicBorders,
          child: SuperImage(
              width: size,
              height: size,
              pic: authorPic
          ),

        ),

      ),
    );
  }
// -----------------------------------------------------------------------------
}
