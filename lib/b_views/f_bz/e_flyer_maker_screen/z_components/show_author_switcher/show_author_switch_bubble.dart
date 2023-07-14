import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/static_flyer/b_static_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/texting/bullet_points/bldrs_bullet_points.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class ShowAuthorSwitchBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ShowAuthorSwitchBubble({
    required this.draft,
    required this.onSwitch,
    required this.bzModel,
    super.key
  });
  /// --------------------------------------------------------------------------
  final DraftFlyer? draft;
  final ValueChanged<bool> onSwitch;
  final BzModel? bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Bubble(
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
          context: context,
          headlineVerse: const Verse(
            id: 'phid_show_author_on_flyer',
            translate: true,
          ),
          switchValue: draft?.showsAuthor,
          hasSwitch: true,
          onSwitchTap: onSwitch
      ),
      width: Bubble.bubbleWidth(context: context),
      columnChildren: <Widget>[

        /// BULLETS
        const BldrsBulletPoints(
          showBottomLine: false,
          bulletPoints: <Verse>[
            Verse(id: 'phid_you_can_hide_flyer_author', translate: true),
          ],
        ),

        /// HEADER PREVIEW
        StaticHeader(
          flyerBoxWidth: Bubble.clearWidth(context: context),
          bzModel: bzModel,
          showHeaderLabels: true,
          authorID: draft?.authorID,
          flyerShowsAuthor: draft?.showsAuthor,
          // onCallTap: (){
          //   blog('onCallTap');
          // },
          // onFollowTap: (){
          //   blog('onFollowTap');
          // },
          disabledButtons: true,
        ),

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
