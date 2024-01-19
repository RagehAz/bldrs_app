import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:bldrs/flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/phids_wrapper.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class BzScopeBubble extends StatelessWidget {
  // --------------------------------------------------------------------------
  const BzScopeBubble({
    required this.headline,
    required this.phids,
    this.onPhidTap,
    this.onPhidLongTap,
    super.key
  });
  // --------------------
  final List<String> phids;
  final Verse headline;
  final Function(String phid)? onPhidTap;
  final Function(String phid)? onPhidLongTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Bubble(
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
        headlineVerse: const Verse(
          id: 'phid_scopeOfServices',
          translate: true,
        ),
      ),
      columnChildren: <Widget>[

        PhidsWrapper(
          width: Bubble.bubbleWidth(context: context),
          phids: phids,
          onPhidTap: onPhidTap,
          onPhidLongTap: onPhidLongTap,
        ),

      ],
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
