import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/super_box/src/f_super_box_tap_layer/x_tap_layer.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/f_bz/f_bz_preview_screen/b_bz_flyers_preview_screen.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

class MoreFlyersSlide extends StatelessWidget {
  // --------------------------------------------------------------------------
  const MoreFlyersSlide({
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
    final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(
      flyerBoxWidth: _flyerBoxWidth,
    );
    final BorderRadius _flyerCorners = FlyerDim.flyerCorners(_flyerBoxWidth);
    // --------------------
    final List<String> _allPublishedFlyersIDs = bzModel?.publication.published ?? [];
    final bool _hasMoreThanTwoFlyers = _allPublishedFlyersIDs.length > 2;
    // --------------------
    final List<String> _showFlyers = _hasMoreThanTwoFlyers == true ?
    _allPublishedFlyersIDs.sublist(0, 2)
        :
    _allPublishedFlyersIDs;
    // --------------------
    final int _remainingFlyersCount = _allPublishedFlyersIDs.length - _showFlyers.length;
    // --------------------
    return TapLayer(
      width: _flyerBoxWidth,
      height: _flyerBoxHeight,
      corners: _flyerCorners,
      boxColor: Colorz.white20,
      onTap: () => BzFlyersPreviewScreen.openBzFlyersPage(bzModel: bzModel),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          BldrsText(
            verse: const Verse(
              id: 'phid_more',
              translate: true,
            ),
            width: _flyerBoxWidth,
            scaleFactor: _flyerBoxWidth * 0.01,
          ),

          BldrsText(
            verse: Verse(
                id: '+ $_remainingFlyersCount ${getWord('phid_flyers')}',
                translate: false
            ),
            width: _flyerBoxWidth,
            scaleFactor: _flyerBoxWidth * 0.005,
            weight: VerseWeight.thin,
            italic: true,
          ),

        ],
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
