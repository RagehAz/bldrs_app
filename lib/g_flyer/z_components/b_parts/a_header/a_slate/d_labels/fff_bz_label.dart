import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header/a_slate/d_labels/ffff_follows_flyers_count_line.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class BzLabel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzLabel({
    required this.flyerBoxWidth,
    required this.bzModel,
    required this.flyerShowsAuthor,
    super.key
  });
  /// ------------------------
  final BzModel? bzModel;
  final double flyerBoxWidth;
  final bool flyerShowsAuthor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bzLabelWidth = FlyerDim.headerLabelsWidth(flyerBoxWidth);
    final EdgeInsets _bzLabelPaddings = FlyerDim.bzLabelPaddings(flyerBoxWidth);
    // --------------------
    final double _versesScaleFactor = FlyerVerses.bzLabelVersesScaleFactor(
      flyerBoxWidth: flyerBoxWidth,
      flyerShowsAuthor: flyerShowsAuthor,
    );
    // --------------------
    final TextDirection _textDirection =  UiProvider.getAppTextDir();
    // --------------------
    return SizedBox(
      height: FlyerDim.bzLabelHeight(
        flyerBoxWidth: flyerBoxWidth,
        flyerShowsAuthor: flyerShowsAuthor,
      ),
      width: _bzLabelWidth,
      // color: Colorz.bloodTest,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          /// BZ NAME
          BldrsText(
            width: _bzLabelWidth,
            margin: _bzLabelPaddings,
            verse: Verse(
              id: bzModel?.name,
              translate: false,
            ),
            centered: false,
            size: FlyerVerses.bzLabelNameSize(
              flyerShowsAuthor: flyerShowsAuthor,
            ),
            scaleFactor: _versesScaleFactor,
            maxLines: FlyerVerses.bzLabelNameMaxLines(
              flyerShowsAuthor: flyerShowsAuthor,
            ),
            textDirection: _textDirection,
          ),

          /// BZ LOCALE
          BldrsText(
            width: _bzLabelWidth,
            verse: ZoneModel.generateInZoneVerse(
              zoneModel: bzModel?.zone,
            ),
            margin: _bzLabelPaddings,
            size: FlyerVerses.bzLabelLocaleSize(
              flyerShowsAuthor: flyerShowsAuthor,
            ),
            weight: VerseWeight.regular,
            centered: false,
            italic: true,
            scaleFactor: _versesScaleFactor,
            textDirection: _textDirection,
          ),

          /// BZ COUNTER LINE
          if (flyerShowsAuthor == false)
            FollowsFlyersCountLine(
              bzModel: bzModel,
              versesScaleFactor: FlyerVerses.authorLabelVersesScaleFactor(
                flyerBoxWidth: flyerBoxWidth,
              ),
              margin: _bzLabelPaddings,
              width: _bzLabelWidth,
            ),

        ],
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
