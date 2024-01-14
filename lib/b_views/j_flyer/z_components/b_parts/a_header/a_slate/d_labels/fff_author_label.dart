import 'dart:ui' as ui;

import 'package:basics/super_box/src/f_super_box_tap_layer/x_tap_layer.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/d_labels/ffff_author_pic.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/d_labels/ffff_follows_flyers_count_line.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_color.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class AuthorLabel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthorLabel({
    required this.flyerBoxWidth,
    required this.authorID,
    required this.bzModel,
    required this.onlyShowAuthorImage,
    this.onLabelTap,
    this.authorImage,
    super.key
  });
  /// ------------------------
  final double flyerBoxWidth;
  final String? authorID;
  /// why not pass authorModel => because I need to know bzGalleryCount from bzModel
  final BzModel? bzModel;
  final bool onlyShowAuthorImage;
  final Function? onLabelTap;
  final ui.Image? authorImage;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final AuthorModel? _author = AuthorModel.getAuthorFromBzByAuthorID(
      bz: bzModel,
      authorID: authorID,
    );
    // --------------------
    final double _versesScaleFactor = FlyerVerses.authorLabelVersesScaleFactor(
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    final double _authorLabelVersesWidth = FlyerDim.authorLabelVersesWidth(flyerBoxWidth);
    // --------------------
    final TextDirection _textDirection = UiProvider.getAppTextDir();
    // --------------------
    return TapLayer(
      onTap: onLabelTap,
      height: FlyerDim.authorLabelBoxHeight(
        flyerBoxWidth: flyerBoxWidth,
      ),
      width: FlyerDim.authorLabelBoxWidth(
        flyerBoxWidth: flyerBoxWidth,
        onlyShowAuthorImage: onlyShowAuthorImage,
      ),
      corners: FlyerDim.authorPicCornersByFlyerBoxWidth(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
      ),
      boxColor: FlyerColors.authorLabelColor(
        showLabel: onlyShowAuthorImage,
      ),
      // margin: showLabel == true ? EdgeInsets.symmetric(horizontal : flyerBoxWidth * 0.01) : const EdgeInsets.all(0),
      child: Row(
        children: <Widget>[

          /// AUTHOR IMAGE
          AuthorPic(
            size: FlyerDim.authorPicSizeBFlyerBoxWidth(flyerBoxWidth),
            authorPic: authorImage ?? _author?.picPath,
            // tinyBz:
          ),

          /// AUTHOR LABEL : NAME, TITLE, FOLLOWERS COUNTER
          if (onlyShowAuthorImage == false)
            Container(
              width: _authorLabelVersesWidth,
              padding: FlyerDim.authorLabelVersesPadding(flyerBoxWidth),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    /// AUTHOR NAME
                    BldrsText(
                      width: _authorLabelVersesWidth,
                      verse: Verse(
                        id: _author?.name,
                        translate: false,
                      ),
                      centered: false,
                      scaleFactor: _versesScaleFactor,
                      textDirection: _textDirection,
                    ),

                    /// AUTHOR TITLE
                    SizedBox(
                      width: _authorLabelVersesWidth,
                      child: BldrsText(
                        verse: Verse(
                          id: _author?.title,
                          translate: false,
                        ),
                        size: 1,
                        weight: VerseWeight.regular,
                        centered: false,
                        italic: true,
                        scaleFactor: _versesScaleFactor,
                        textDirection: _textDirection,
                      ),
                    ),

                    /// BZ COUNTER LINE
                    FollowsFlyersCountLine(
                      width: _authorLabelVersesWidth,
                      margin: 0,
                      bzModel: bzModel,
                      versesScaleFactor: _versesScaleFactor,
                    ),

                  ],
                ),
              ),
            ),

        ],
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
