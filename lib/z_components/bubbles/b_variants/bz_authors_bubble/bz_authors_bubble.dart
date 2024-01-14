import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/buttons/bz_buttons/authors_wrap.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class BzAuthorsBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzAuthorsBubble({
    required this.bzModel,
    super.key
  });
  /// --------------------------------------------------------------------------
  final BzModel? bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Bubble(
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
        headlineVerse: const Verse(
          id: 'phid_team',
          translate: true,
        ),
      ),
      columnChildren: <Widget>[

        AuthorsWrap(
          boxWidth: Bubble.clearWidth(context: context),
          bzModel: bzModel,
        ),

      ],
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
