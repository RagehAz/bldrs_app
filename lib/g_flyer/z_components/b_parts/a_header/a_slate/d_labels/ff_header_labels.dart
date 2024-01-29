import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header/a_slate/d_labels/fff_author_label.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header/a_slate/d_labels/fff_bz_label.dart';
import 'package:flutter/material.dart';

class HeaderLabels extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeaderLabels({
    required this.flyerBoxWidth,
    required this.bzModel,
    required this.flyerShowsAuthor,
    required this.headerIsExpanded,
    required this.authorID,
    required this.showHeaderLabels,
    this.authorImage,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final BzModel? bzModel;
  final bool flyerShowsAuthor;
  final bool headerIsExpanded;
  final String? authorID;
  final bool showHeaderLabels;
  final dynamic authorImage;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SizedBox(
        height: FlyerDim.headerLabelsHeight(flyerBoxWidth),
        width: FlyerDim.headerLabelsWidth(flyerBoxWidth),
        child: Column(
          mainAxisAlignment: flyerShowsAuthor == true ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// BUSINESS LABEL : BZ.NAME & BZ.LOCALE
            if (showHeaderLabels == true)
            BzLabel(
              flyerBoxWidth: flyerBoxWidth,
              bzModel: bzModel,
              flyerShowsAuthor: flyerShowsAuthor,
            ),

            /// AUTHOR LABEL : AUTHOR.IMAGE, AUTHOR.NAME, AUTHOR.TITLE, BZ.FOLLOWERS
            if (flyerShowsAuthor == true && showHeaderLabels == true && headerIsExpanded == false)
              AuthorLabel(
                flyerBoxWidth: flyerBoxWidth,
                authorID: authorID,
                bzModel: bzModel,
                onlyShowAuthorImage: false,
                authorImage: authorImage,
              ),

          ],
        ));
    // --------------------
  }
// -----------------------------------------------------------------------------
}
