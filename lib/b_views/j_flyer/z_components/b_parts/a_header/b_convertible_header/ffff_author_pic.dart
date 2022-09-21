import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class AuthorPic extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthorPic({
    this.width,
    this.authorPic,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final dynamic authorPic;
  /// --------------------------------------------------------------------------
  static double getCornerValue(double flyerBoxWidth) {
    return flyerBoxWidth * Ratioz.xxflyerAuthorPicCorner;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _authorImageHeight = width;
    final double _authorImageCorners =
    getCornerValue(width / Ratioz.xxflyerAuthorPicWidth);
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
        width: width,
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
              width: width,
              height: width,
              pic: authorPic
          ),

        ),

      ),
    );
  }
// -----------------------------------------------------------------------------
}
