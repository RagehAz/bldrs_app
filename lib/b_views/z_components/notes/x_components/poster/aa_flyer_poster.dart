import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/deck/flyer_deck.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/poster/x_note_poster_box.dart';
import 'package:flutter/material.dart';

class FlyerPoster extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const FlyerPoster({
    @required this.width,
    @required this.flyerModel,
    @required this.flyerBzModel,
    @required this.screenName,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final double width;
  final FlyerModel flyerModel;
  final BzModel flyerBzModel;
  final String screenName;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return NotePosterBox(
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
                  deckHeight: NotePosterBox.getClearHeight(width),
                  flyerModel: flyerModel,
                  expansion: 0.5,
                  minSlideHeightFactor: 0.85,
                  screenName: screenName,
                )
          // ;
      //   },
      // )
    );

  }
  // -----------------------------------------------------------------------------
}
