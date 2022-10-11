import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/b_static_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:flutter/material.dart';

class ShowAuthorSwitchBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ShowAuthorSwitchBubble({
    @required this.draft,
    @required this.onSwitch,
    @required this.bzModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final DraftFlyerModel draft;
  final ValueChanged<bool> onSwitch;
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Bubble(
      headerViewModel: BubbleHeaderVM(
          headlineVerse: const Verse(
            text: 'phid_show_author_on_flyer',
            translate: true,
          ),
          switchValue: draft.showsAuthor,
          hasSwitch: true,
          onSwitchTap: onSwitch
      ),
      width: Bubble.bubbleWidth(context),
      columnChildren: <Widget>[

        StaticHeader(
          flyerBoxWidth: Bubble.clearWidth(context),
          bzModel: bzModel,
          authorID: draft.authorID,
          flyerShowsAuthor: draft.showsAuthor,
        ),

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
