import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/b_expanding_tile.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';

import 'package:flutter/material.dart';

class NonCollapsableTile extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NonCollapsableTile({
    required this.firstHeadline,
    required this.child,
    required this.width,
    required this.secondHeadline,
    required this.icon,
    required this.iconSizeFactor,
    required this.onTileTap,
    required this.expansionColor,
    required this.corners,
    required this.searchText,
    required this.onTileLongTap,
    required this.onTileDoubleTap,
    required this.margin,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double width;
  final String? icon;
  final double iconSizeFactor;
  final Verse? firstHeadline;
  final Verse? secondHeadline;
  final Color? expansionColor;
  final double? corners;
  final Widget child;
  final ValueNotifier<dynamic>? searchText;
  final ValueChanged<bool>? onTileTap;
  final Function? onTileLongTap;
  final Function? onTileDoubleTap;
  final dynamic margin;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Bubble(
      width: width,
      bubbleColor: BldrsExpandingButton.getExpandedColor(expansionColor: expansionColor),
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
        headlineVerse: Verse(
          id: firstHeadline?.id,
          translate: firstHeadline?.translate,
          notifier: searchText,
        ),
        leadingIcon: icon,
        leadingIconSizeFactor: iconSizeFactor,

      ),
      corners: BldrsExpandingButton.getCorners(corners: corners),
      margin: BldrsExpandingButton.getMargins(margin: margin),
      // onBubbleTap: null, //() => onTileTap(true),
      childrenCentered: true,
      // areTopCentered: true,
      columnChildren: <Widget>[

        /// EXTERNAL CHILD
        SizedBox(
          width: width,
          child: child,
        ),

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
