import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/g_flyer/z_components/c_groups/deck/flyer_deck.dart';
import 'package:bldrs/z_components/poster/structure/x_note_poster_box.dart';
import 'package:flutter/material.dart';

class FlyerPoster extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const FlyerPoster({
    required this.width,
    required this.flyerModel,
    required this.screenName,
    this.draft,
    super.key
  });
  // -----------------------------------------------------------------------------
  final double width;
  final FlyerModel? flyerModel;
  final String? screenName;
  final DraftFlyer? draft;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return NotePosterBox(
      width: width,
      child: FlyerDeck(
        maxPossibleWidth: width,
        deckHeight: NotePosterBox.getClearHeight(width),
        flyerModel: flyerModel,
        draft: draft,
        expansion: 0.5,
        minSlideHeightFactor: 0.85,
        screenName: screenName,
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
