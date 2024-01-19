import 'package:basics/components/bubbles/tile_bubble/tile_bubble.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/zz_archives/old_screens/c_main_search/super_search_screen.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';

import 'package:flutter/material.dart';

class FilterBoolTile extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const FilterBoolTile({
    required this.verse,
    required this.icon,
    required this.onSwitchTap,
    required this.switchValue,
    this.iconIsBig = true,
    super.key
  });
  // -----------------------------------------------------------------------------
  final Verse verse;
  final String icon;
  final bool iconIsBig;
  final bool? switchValue;
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
      textDirection: UiProvider.getAppTextDir(),
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
    );

  }
  // -----------------------------------------------------------------------------
}
