import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';

class AuthorPic extends StatelessWidget {
  final double flyerZoneWidth;
  final String authorPic;

  AuthorPic({
    @required this.flyerZoneWidth,
    @required this.authorPic,
});

  @override
  Widget build(BuildContext context) {

    // === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
    // --- A.IMAGE --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- A.IMAGE
    double authorImageWidth = flyerZoneWidth * Ratioz.xxflyerAuthorPicWidth;
    double authorImageHeight = authorImageWidth;
    double authorImageCorners = flyerZoneWidth * Ratioz.xxflyerAuthorPicCorner;
    // === === === === === === === === === === === === === === === === === === === === === === === === === === === ===

    return
      Container(
        height: authorImageHeight,
        width: authorImageWidth,
        decoration: BoxDecoration(
          color: Colorz.WhiteAir,
            image:
            authorPic == null ? null :
            DecorationImage(
                image: AssetImage(authorPic),
                fit: BoxFit.fill
            ),
            borderRadius: getTranslated(context, 'Text_Direction') == 'rtl' ?
            BorderRadius.only(
              topLeft: Radius.circular(authorImageCorners),
              topRight: Radius.circular(authorImageCorners),
              bottomLeft: Radius.circular(authorImageCorners),
              bottomRight: Radius.circular(0),
            )
                :
            BorderRadius.only(
              topLeft: Radius.circular(authorImageCorners),
              topRight: Radius.circular(authorImageCorners),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(authorImageCorners),
            )
        ),
      )
    ;
  }
}
