import 'package:basics/helpers/widgets/drawing/super_positioned.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/static_flyer/b_static_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/deck/flyer_deck.dart';
import 'package:bldrs/z_components/poster/structure/x_note_poster_box.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class BzPoster extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const BzPoster({
    required this.width,
    required this.bzModel,
    required this.bzSlidesInOneFlyer,
    required this.screenName,
    super.key
  });
  // --------------------
  final double width;
  final BzModel bzModel;
  final FlyerModel? bzSlidesInOneFlyer;
  final String? screenName;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _posterHeight = NotePosterBox.getBoxHeight(width);
    final double _posterPaddingValue = NotePosterBox.getPaddingValue(width);

    final double _clearWidth = width - (_posterPaddingValue * 2);

    return NotePosterBox(
      width: width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[

          /// HEADER
          Container(
            width: _clearWidth,
            height: _posterHeight,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: _posterPaddingValue),
            // color: Colorz.blue255,
            child: StaticHeader(
              flyerBoxWidth: _clearWidth,
              bzModel: bzModel,
              authorID: 'x',
              flyerShowsAuthor: false,
              // flightTweenValue: 1,
              showHeaderLabels: true,
            ),
          ),

          /// SLIDES IN ONE FLYER
          SuperPositioned(
            enAlignment: Alignment.bottomRight,
            verticalOffset: width * 0.04,
            horizontalOffset: width * 0.08,
            appIsLTR: UiProvider.checkAppIsLeftToRight(),
            child: FlyerDeck(
              maxPossibleWidth: _clearWidth * 0.9,
              deckHeight: width * 0.25,
              flyerModel: bzSlidesInOneFlyer,
              expansion: 0.7,
              minSlideHeightFactor: 0.85,
              screenName: screenName,
            ),
          ),

        ],
      )

    );

  }
  // -----------------------------------------------------------------------------
}
