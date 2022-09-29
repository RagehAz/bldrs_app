import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:flutter/material.dart';

class BzLabel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzLabel({
    @required this.flyerBoxWidth,
    @required this.bzModel,
    @required this.flyerShowsAuthor,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
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
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    return SizedBox(
      height: FlyerDim.bzLabelHeight(
        flyerBoxWidth: flyerBoxWidth,
        flyerShowsAuthor: flyerShowsAuthor,
      ),
      width: _bzLabelWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// BZ NAME
          Container(
            width: _bzLabelWidth,
            padding: _bzLabelPaddings,
            child: SuperVerse(
              verse: Verse(
                text: bzModel?.name,
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
            ),
          ),

          /// BZ LOCALE
          Container(
            width: _bzLabelWidth,
            padding: _bzLabelPaddings,
            child: SuperVerse(
              verse: ZoneModel.translateZoneString(
                context: context,
                zoneModel: bzModel?.zone,
              ),
              size: FlyerVerses.bzLabelLocaleSize(
                flyerShowsAuthor: flyerShowsAuthor,
              ),
              weight: VerseWeight.regular,
              centered: false,
              italic: true,
              scaleFactor: _versesScaleFactor,
            ),
          ),

        ],
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}