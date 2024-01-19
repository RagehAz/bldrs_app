import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/flyer/z_components/c_groups/flyers_shelf/flyers_shelf_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/bz_bubbles/bz_flyers_bubble/more_flyers_slide.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

class BzFlyersBubble extends StatelessWidget {
  // --------------------------------------------------------------------------
  const BzFlyersBubble({
    required this.bzModel,
    super.key
  });
  // --------------------
  final BzModel? bzModel;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _flyerBoxWidth = Scale.screenShortestSide(context) * 0.3;
    // --------------------
    final List<String> _allPublishedFlyersIDs = bzModel?.publication.published ?? [];
    final bool _hasMoreThanTwoFlyers = _allPublishedFlyersIDs.length > 2;
    // --------------------
    final List<String> _showFlyers = _hasMoreThanTwoFlyers == true ?
    _allPublishedFlyersIDs.sublist(0, 2)
        :
    _allPublishedFlyersIDs;
    // --------------------
    return FlyersShelfBubble(
      flyerBoxWidth: _flyerBoxWidth,
      titleIcon: Iconz.flyerGrid,
      titleVerse: Verse(
        id: '${getWord('phid_published_flyers_by')} ${bzModel?.name}',
        translate: false,
      ),
      flyersIDs: _showFlyers,
      lastSlideWidget: _hasMoreThanTwoFlyers == false ?
      null
          :
       MoreFlyersSlide(
        bzModel: bzModel,
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
