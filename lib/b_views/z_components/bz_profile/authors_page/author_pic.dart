import 'package:bldrs/b_views/j_flyer/z_components/a_structure/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class AuthorPicInBzPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthorPicInBzPage({
    this.isAddAuthorButton = false,
    this.width,
    this.authorPic,
    this.cornerOverride,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool isAddAuthorButton;
  final double width;
  final dynamic authorPic;
  final double cornerOverride;
  /// --------------------------------------------------------------------------
  void _tapAddAuthor(BuildContext context) {
    blog('should go to add new author screen');

    // Nav.goToNewScreen(context, AddAuthorScreen(tinyBz: tinyBz));
  }
  // --------------------
  static double getCornerValue(double flyerBoxWidth) {
    return flyerBoxWidth * FlyerDim.xFlyerAuthorPicCorner;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _authorImageHeight = width;
    final double _authorImageCorners = cornerOverride ??
        getCornerValue(width / FlyerDim.xFlyerAuthorPicWidth);
    // --------------------
    final BorderRadius _authorPicBorders = Borderers.superBorderOnly(
        context: context,
        enTopLeft: _authorImageCorners,
        enBottomLeft: 0,
        enBottomRight: _authorImageCorners,
        enTopRight: _authorImageCorners);
    // --------------------
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
          child: isAddAuthorButton == true ?

          /// WHEN IS ADD AUTHOR BUTTON
          GestureDetector(
            onTap: () => _tapAddAuthor(context),
            child: SizedBox(
              width: width,
              height: _authorImageHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  DreamBox(
                    width: width * 0.35,
                    height: _authorImageHeight * 0.35,
                    icon: Iconz.plus,
                    bubble: false,
                    onTap: () => _tapAddAuthor(context),
                  ),

                  const SuperVerse(
                    verse: Verse(
                      text: 'phid_add_author_to_the_team',
                      pseudo: 'Add new Author',
                      translate: true,
                    ),
                    size: 0,
                    maxLines: 2,
                  ),

                ],
              ),
            ),
          )

              :

          /// WHEN IS NORMAL AUTHOR BUTTON
          SuperImage(
              width: width,
              height: width,
              pic: authorPic
          ),

        ),

      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
