import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/images/bldrs_image.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class AuthorPic extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthorPic({
    required this.size,
    this.authorPic,
    this.isAddAuthorButton = false,
    this.cornerOverride,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double size;
  final bool isAddAuthorButton;
  final dynamic authorPic;
  final double? cornerOverride;
  /// --------------------------------------------------------------------------
  void _tapAddAuthor(BuildContext context) {
    blog('should go to add new author screen');
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BorderRadius _authorPicBorders = Borderers.superCorners(
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

                  BldrsBox(
                    width: size * 0.35,
                    height: size * 0.35,
                    icon: Iconz.plus,
                    bubble: false,
                    onTap: () => _tapAddAuthor(context),
                  ),

                  const BldrsText(
                    verse: Verse(
                      id: 'phid_add_author_to_the_team',
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
          BldrsImage(
            width: size,
            height: size,
            corners: _authorPicBorders,
            pic: authorPic,
          ),

        ),

      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
