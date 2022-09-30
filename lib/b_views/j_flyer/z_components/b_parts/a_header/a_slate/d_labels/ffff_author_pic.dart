import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class AuthorPic extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthorPic({
    @required this.size,
    this.authorPic,
    this.isAddAuthorButton = false,
    this.cornerOverride,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double size;
  final bool isAddAuthorButton;
  final dynamic authorPic;
  final double cornerOverride;
  /// --------------------------------------------------------------------------
  void _tapAddAuthor(BuildContext context) {
    blog('should go to add new author screen');
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BorderRadius _authorPicBorders = Borderers.superCorners(
      context: context,
      corners: cornerOverride ?? FlyerDim.authorPicCornersByPicSize(
        context: context,
        picSize: size,
      ),
    );
    // --------------------
    return Center(
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
            color: Colorz.white10,
            borderRadius: _authorPicBorders,
            image: ObjectCheck.objectIsJPGorPNG(authorPic) == true ?
            DecorationImage(
                image: AssetImage(authorPic),
                fit: BoxFit.cover
            )
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
              width: size,
              height: size,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  DreamBox(
                    width: size * 0.35,
                    height: size * 0.35,
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
              width: size,
              height: size,
              corners: _authorPicBorders,
              pic: authorPic
          ),

        ),

      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
