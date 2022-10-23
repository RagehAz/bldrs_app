import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_color.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_verse.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/d_labels/ffff_author_pic.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:flutter/material.dart';

class AuthorLabel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthorLabel({
    @required this.flyerBoxWidth,
    @required this.authorID,
    @required this.bzModel,
    @required this.showLabel,
    @required this.authorGalleryCount,
    @required this.onTap,
    this.labelIsOn = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final String authorID;
  /// why not pass authorModel => because I need to know bzGalleryCount from bzModel
  final BzModel bzModel;
  final int authorGalleryCount;
  /// TASK : OPTIMIZE THIS : whats the difference between this and [labelIsOn]
  final bool showLabel;
  final bool labelIsOn;
  final ValueChanged<String> onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final AuthorModel _author = AuthorModel.getAuthorFromBzByAuthorID(
      bz: bzModel,
      authorID: authorID,
    );
    // --------------------
    final double _versesScaleFactor = FlyerVerses.authorLabelVersesScaleFactor(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    final double _authorLabelVersesWidth = FlyerDim.authorLabelVersesWidth(flyerBoxWidth);
    // --------------------
    return GestureDetector(
      onTap: showLabel == true ? () => onTap(authorID) : null,
      child: Container(
        height: FlyerDim.authorLabelBoxHeight(
          flyerBoxWidth: flyerBoxWidth,
        ),
        width: FlyerDim.authorLabelBoxWidth(
          flyerBoxWidth: flyerBoxWidth,
          labelIsOn: labelIsOn,
        ),
        // margin: showLabel == true ? EdgeInsets.symmetric(horizontal : flyerBoxWidth * 0.01) : const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: FlyerColors.authorLabelColor(
              showLabel: showLabel,
          ),
          borderRadius: FlyerDim.authorPicCornersByFlyerBoxWidth(
            context: context,
            flyerBoxWidth: flyerBoxWidth,
          ),
        ),

        child: Row(
          children: <Widget>[

            /// AUTHOR IMAGE
            AuthorPic(
              size: FlyerDim.authorPicSizeBFlyerBoxWidth(flyerBoxWidth),
              authorPic: _author?.pic,
              // tinyBz:
            ),

            /// AUTHOR LABEL : NAME, TITLE, FOLLOWERS COUNTER
            if (labelIsOn == true)
              Container(
                width: _authorLabelVersesWidth,
                padding: FlyerDim.authorLabelVersesPadding(flyerBoxWidth),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    /// AUTHOR NAME
                    SizedBox(
                      width: _authorLabelVersesWidth,
                      child: SuperVerse(
                        verse: Verse(
                          text: _author?.name,
                          translate: false,
                        ),
                        centered: false,
                        scaleFactor: _versesScaleFactor,
                      ),
                    ),

                    /// AUTHOR TITLE
                    SizedBox(
                      width: _authorLabelVersesWidth,
                      child: SuperVerse(
                        verse: Verse(
                          text: _author?.title,
                          translate: false,
                        ),
                        size: 1,
                        weight: VerseWeight.regular,
                        centered: false,
                        italic: true,
                        scaleFactor: _versesScaleFactor,
                      ),
                    ),

                    /// FOLLOWERS COUNTER
                    SizedBox(
                      width: _authorLabelVersesWidth,
                      child: SuperVerse(
                        verse: FlyerVerses.followersCounters(
                          context: context,
                          followersCount: 0,
                          authorGalleryCount: authorGalleryCount,
                          bzGalleryCount: bzModel?.flyersIDs?.length ?? 0,
                          showLabel: showLabel,
                        ),
                        italic: true,
                        centered: false,
                        weight: VerseWeight.regular,
                        size: 0,
                        scaleFactor: _versesScaleFactor,
                      ),
                    ),

                  ],
                ),
              ),

          ],
        ),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
