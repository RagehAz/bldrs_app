import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/flyer_poster_creator/flyer_poster_creator_bubble.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/show_author_switcher/show_author_switch_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/editors_buttons/editor_swiping_buttons.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:flutter/material.dart';

class FlyerEditorPage5AuthorPoster extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerEditorPage5AuthorPoster({
    required this.draft,
    required this.onSwitchFlyerShowsAuthor,
    required this.canValidate,
    required this.canGoNext,
    required this.onNextTap,
    required this.onPreviousTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final DraftFlyer? draft;
  final bool canValidate;
  final bool canGoNext;
  final Function onNextTap;
  final Function onPreviousTap;
  final Function(bool show) onSwitchFlyerShowsAuthor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BldrsFloatingList(
      columnChildren: <Widget>[

        /// SHOW FLYER AUTHOR
        ShowAuthorSwitchBubble(
          draft: draft,
          bzModel: draft?.bzModel,
          onSwitch: onSwitchFlyerShowsAuthor,
        ),

        /// FLYER POSTER
        FlyerPosterCreatorBubble(
          draft: draft,
          bzModel: draft?.bzModel,
          onSwitch: (bool value){
            // blog('value of poster blah is : $value');
          },
        ),

        /// SWIPING BUTTONS
        EditorSwipingButtons(
          onNext: onNextTap,
          onPrevious: onPreviousTap,
          canGoNext: canGoNext,
        ),

      ],
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}