import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/b_views/c_main_search/super_search_screen.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';

class FilterBoolTile extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const FilterBoolTile({
    @required this.verse,
    @required this.icon,
    @required this.onSwitchTap,
    @required this.switchValue,
    this.iconIsBig = true,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final Verse verse;
  final String icon;
  final bool iconIsBig;
  final bool switchValue;
  final Function(bool value) onSwitchTap;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _tileWidth = SuperSearchScreen.getFilterTileWidth(context);

    return TileBubble(
          bubbleWidth: _tileWidth,
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            context: context,
            leadingIcon: icon,
            leadingIconSizeFactor: iconIsBig == true ? 1 : 0.7,
            headerWidth: _tileWidth,
            headlineVerse: verse,
            hasSwitch: true,
            switchValue: switchValue,
            onSwitchTap: onSwitchTap,
          ),
        );

  }
  // -----------------------------------------------------------------------------
}
