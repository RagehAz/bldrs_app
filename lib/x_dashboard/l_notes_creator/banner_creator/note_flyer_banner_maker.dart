import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/flyer_deck.dart';
import 'package:bldrs/b_views/z_components/notes/banner/note_banner_box.dart';
import 'package:flutter/material.dart';

class NoteFlyerBannerMaker extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const NoteFlyerBannerMaker({
    @required this.width,
    @required this.flyerModel,
    @required this.flyerBzModel,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final double width;
  final FlyerModel flyerModel;
  final BzModel flyerBzModel;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return NoteBannerBox(
      width: width,
      child:
      // WidgetFader(
      //   fadeType: FadeType.fadeIn,
      //   // min: 0,
      //   max: 0.5,
      //   duration: const Duration(milliseconds: 500),
      //   curve: Curves.easeOutCubic,
      //   builder: (double value, Widget child){
      //
      //     return
            FlyerDeck(
            bzModel: flyerBzModel,
            maxPossibleWidth: width,
            deckHeight: NoteBannerBox.getClearHeight(width),
            flyerModel: flyerModel,
            expansion: 0.5,
            minSlideHeightFactor: 0.85,
          )
          // ;
      //   },
      // )
    );

  }
  // -----------------------------------------------------------------------------
}
