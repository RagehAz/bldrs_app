import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/b_views/c_main_search/super_search_screen.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';

class FilterMultiButtonTile extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const FilterMultiButtonTile({
    @required this.icon,
    @required this.verse,
    @required this.switchValue,
    @required this.onSwitchTap,
    @required this.items,
    @required this.selectedItem,
    @required this.itemVerse,
    @required this.onItemTap,
    this.itemIcon,
    this.iconIsBig,
    this.bubbleColor = Colorz.white10,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final String icon;
  final bool iconIsBig;
  final Verse verse;
  final bool switchValue;
  final Function(bool value) onSwitchTap;
  final List<dynamic> items;
  final dynamic selectedItem;
  final Verse Function(dynamic item) itemVerse;
  final String Function(dynamic item) itemIcon;
  final Function(dynamic item) onItemTap;
  final Color bubbleColor;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _tileWidth = SuperSearchScreen.getFilterTileWidth(context);

    return TileBubble(
      bubbleWidth: _tileWidth,
      bubbleColor: bubbleColor,
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
        leadingIcon: icon,
        leadingIconSizeFactor: iconIsBig == true ? 1 : 0.7,
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
              // width: 40,
              verse: itemVerse(item),
              verseScaleFactor: 0.7,
              icon: itemIcon == null ? null : itemIcon(item),
              color: _isSelected == true ? Colorz.yellow255 : Colorz.white20,
              iconColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
              verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
              margins: const EdgeInsets.all(5),
              onTap: () => onItemTap(item),
            );
          }),
        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
