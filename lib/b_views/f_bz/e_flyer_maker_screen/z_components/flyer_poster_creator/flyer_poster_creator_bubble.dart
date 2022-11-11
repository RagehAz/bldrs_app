import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/j_poster/poster_type.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/poster/structure/a_note_switcher.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class FlyerPosterCreatorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerPosterCreatorBubble({
    @required this.draft,
    @required this.onSwitch,
    @required this.bzModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final DraftFlyer draft;
  final ValueChanged<bool> onSwitch;
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Bubble(
      headerViewModel: const BubbleHeaderVM(
          headlineVerse: Verse(
            text: 'phid_flyer_url_poster',
            translate: true,
          ),
          // switchValue: true,//draft.showsAuthor,
          // hasSwitch: true,
          // onSwitchTap: onSwitch
      ),
      width: Bubble.bubbleWidth(context),
      columnChildren: <Widget>[

        Screenshot(
          controller: draft.posterController,
          child: PosterSwitcher(
            posterType: PosterType.flyer,
            width: Bubble.clearWidth(context),
            model: draft,
            modelHelper: draft.bzModel,
          ),
        ),

      ],
    );

  }
/// --------------------------------------------------------------------------
}
