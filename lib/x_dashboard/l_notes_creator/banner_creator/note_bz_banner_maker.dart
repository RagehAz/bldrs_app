import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/flyer_deck.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/b_static_header.dart';
import 'package:bldrs/b_views/z_components/notes/banner/note_banner_box.dart';
import 'package:bldrs/b_views/z_components/sizing/super_positioned.dart';
import 'package:flutter/material.dart';

class NoteBzBannerMaker extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const NoteBzBannerMaker({
    @required this.width,
    @required this.bzModel,
    @required this.bzSlidesInOneFlyer,
    Key key
  }) : super(key: key);
  // --------------------
  final double width;
  final BzModel bzModel;
  final FlyerModel bzSlidesInOneFlyer;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bannerHeight = NoteBannerBox.getBoxHeight(width);
    final double _bannerPaddingValue = NoteBannerBox.getPaddingValue(width);

    final double _clearWidth = width - (_bannerPaddingValue * 2);

    return NoteBannerBox(
      width: width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[

          /// HEADER
          Container(
            width: _clearWidth,
            height: _bannerHeight,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: _bannerPaddingValue),
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
            child: FlyerDeck(
              bzModel: bzModel,
              maxPossibleWidth: _clearWidth * 0.9,
              deckHeight: width * 0.25,
              flyerModel: bzSlidesInOneFlyer,
              expansion: 0.7,
              minSlideHeightFactor: 0.85,
            ),
          ),

        ],
      )

    );

  }
  // -----------------------------------------------------------------------------
}
