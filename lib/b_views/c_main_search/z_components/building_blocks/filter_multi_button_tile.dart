import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bubbles/tile_bubble/tile_bubble.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs/b_views/c_main_search/super_search_screen.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class FilterMultiButtonTile extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const FilterMultiButtonTile({
    required this.icon,
    required this.verse,
    required this.switchValue,
    required this.onSwitchTap,
    required this.items,
    required this.selectedItem,
    required this.itemVerse,
    required this.onItemTap,
    this.itemIcon,
    this.iconIsBig,
    this.bubbleColor = Colorz.white10,
    super.key
  });
  // -----------------------------------------------------------------------------
  final String icon;
  final bool? iconIsBig;
  final Verse verse;
  final bool switchValue;
  final Function(bool value)? onSwitchTap;
  final List<dynamic> items;
  final dynamic selectedItem;
  final Verse Function(dynamic item) itemVerse;
  final String? Function(dynamic item)? itemIcon;
  final Function(dynamic item) onItemTap;
  final Color bubbleColor;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _tileWidth = SuperSearchScreen.getFilterTileWidth(context);
    final double _childWidth = TileBubble.childWidth(
      context: context,
      bubbleWidthOverride: _tileWidth,
    );

    return TileBubble(
      bubbleWidth: _tileWidth,
      bubbleColor: bubbleColor,
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      textDirection: UiProvider.getAppTextDir(),
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
        leadingIcon: icon,
        leadingIconSizeFactor: Mapper.boolIsTrue(iconIsBig) == true ? 1 : 0.7,
        headerWidth: _tileWidth,
        headlineVerse: verse,
        hasSwitch: onSwitchTap != null,
        switchValue: switchValue,
        onSwitchTap: onSwitchTap,
      ),
      child: Wrap(
        children: <Widget>[

          if (Mapper.checkCanLoopList(items) == true)
          ...List.generate(items.length, (index){

            final dynamic item = items[index];
            final bool _isSelected = selectedItem == item;

            return BldrsBox(
              height: 40,
              maxWidth: _childWidth - 5,
              verse: itemVerse(item),
              verseScaleFactor: 0.7 / 0.6,
              iconSizeFactor: 0.7,
              icon: itemIcon == null ? null : itemIcon!.call(item),
              color: _isSelected == true ? Colorz.yellow255 : Colorz.white20,
              iconColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
              verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
              margins: Scale.superInsets(
                context: context,
                appIsLTR: UiProvider.checkAppIsLeftToRight(),
                bottom: 5,
                enRight: 5,
              ),
              onTap: () => onItemTap(item),
              textDirection: UiProvider.getAppTextDir(),
              verseCentered: false,
            );

          }),
        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
