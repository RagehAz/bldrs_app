import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:flutter/material.dart';

import 'c_non_collapsable_tile.dart';
import 'd_collapsable_tile.dart';

class ExpandingTile extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ExpandingTile({
    required this.child,
    required this.width,
    required this.sideBox,
    required this.tileBox,
    this.collapsedHeight,
    this.maxHeight,
    this.scrollable = true,
    this.onTileTap,
    this.initiallyExpanded = false,
    this.initialColor = Colorz.white10,
    this.expansionColor,
    this.corners,
    this.isDisabled = false,
    this.margin,
    this.searchText,
    this.onTileLongTap,
    this.onTileDoubleTap,
    this.isCollapsable = true,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double width;
  final double? collapsedHeight;
  final double? maxHeight;
  final bool scrollable;
  final Widget sideBox;
  final bool initiallyExpanded;
  final Color initialColor;
  final Color? expansionColor;
  final double? corners;
  final Widget child;
  final bool isDisabled;
  final EdgeInsets? margin;
  final ValueNotifier<dynamic>? searchText;
  final ValueChanged<bool>? onTileTap;
  final Function? onTileLongTap;
  final Function? onTileDoubleTap;
  final bool isCollapsable;
  final Widget tileBox;
  // -----------------------------------------------------------------------------

  /// COLORS

  // --------------------
  static const Color collapsedColor = Colorz.white10;
  static const Color expandedColor = Colorz.white30;
  // --------------------
  /// TESTED : WORKS PERFECT
  static ColorTween getTileColorTween({
    required Color? collapsedColor,
    required Color? expansionColor,
  }){
    return ColorTween(
      begin: getCollapsedColor(collapsedColor: collapsedColor),
      end: getExpandedColor(expansionColor: expansionColor),
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Color getExpandedColor({
    required Color? expansionColor,
  }){
    return expansionColor ?? ExpandingTile.expandedColor;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Color getCollapsedColor({
    required Color? collapsedColor,
  }){
    return collapsedColor ?? ExpandingTile.collapsedColor;
  }
  // -----------------------------------------------------------------------------

  /// ICONS - ARROWS

  // --------------------
  static const double arrowBoxSize = collapsedTileHeight;
  // --------------------
  /// TESTED : WORKS PERFECT
  static double calculateTitleIconSize({
    required double? collapsedHeight
  }) {
    final double _iconSize = collapsedHeight ?? collapsedGroupHeight;

    return _iconSize;
  }
  // -----------------------------------------------------------------------------

  /// WIDTH

  // --------------------
  /// TESTED : WORKS PERFECT
  static double calculateTitleBoxWidth({
    required double tileWidth,
    required double collapsedHeight,
  }) {

    final double _iconSize = calculateTitleIconSize(
      collapsedHeight: collapsedHeight,
    );

    /// arrow size is button height but differs between groupTile and subGroupTile
    final double _titleZoneWidth = tileWidth - _iconSize - collapsedHeight;

    return _titleZoneWidth;
  }
  // -----------------------------------------------------------------------------

  /// HEIGHT

  // --------------------
  static const double collapsedTileHeight = 40;
  static const double buttonVerticalPadding = Ratioz.appBarPadding;
  static const double titleBoxHeight = 25;
  static const double collapsedGroupHeight = (Ratioz.appBarCorner + Ratioz.appBarMargin) * 2;
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getCollapsedHeight({
    double? collapsedHeight,
  }){
    return collapsedHeight ?? ExpandingTile.collapsedGroupHeight;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double calculateMaxHeight({
    required List<String> keywordsIDs,
  }) {

    final int _totalNumberOfButtons = getNumberOfButtons(
      keywordsIDs: keywordsIDs,
    );

            /// keywords heights
    return  ((collapsedTileHeight + buttonVerticalPadding) * _totalNumberOfButtons) +
            /// subGroups titles boxes heights
            titleBoxHeight +
            /// bottom padding
            0;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double calculateButtonsTotalHeight({
    required List<String> phids,
  }) {

    if (Lister.checkCanLoop(phids) == true){
      return 0;
    }
    else {
      return  (collapsedTileHeight + buttonVerticalPadding)
              *
              getNumberOfButtons(keywordsIDs: phids);
    }

  }
  // -----------------------------------------------------------------------------

  /// CORNERS

  // --------------------
  static const double cornersValue = Ratioz.appBarCorner;
  static const BorderRadius borders = BorderRadius.all(Radius.circular(10));
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getCorners({
    double? corners,
  }){

    if (corners == null) {
      return ExpandingTile.cornersValue;
    }

    else {
      return corners;
    }

  }
  // -----------------------------------------------------------------------------

  /// MARGIN

  // --------------------
  /// TESTED : WORKS PERFECT
  static EdgeInsets getMargins({
    dynamic margin,
  }){

    if (margin == null){
      return const EdgeInsets.only(bottom: 10);
    }
    else {
      return Scale.superMargins(margin: margin);
    }

  }
  // -----------------------------------------------------------------------------

  /// COUNTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static int getNumberOfButtons({
    required List<String>? keywordsIDs,
  }) {
    return keywordsIDs?.length ?? 0;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double calculateButtonExtent() {
    return collapsedTileHeight + buttonVerticalPadding;
  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (isCollapsable == true){
      return CollapsableTile(
        key: const ValueKey('CollapsableTile'),
        width: width,
        collapsedHeight: collapsedHeight,
        maxHeight: maxHeight,
        scrollable: scrollable,
        onTileTap: onTileTap,
        initiallyExpanded: initiallyExpanded,
        initialColor: initialColor,
        expansionColor: expansionColor,
        corners: corners,
        isDisabled: isDisabled,
        margin: margin,
        searchText: searchText,
        onTileLongTap: onTileLongTap,
        onTileDoubleTap: onTileDoubleTap,
        sideBox: sideBox,
        tileBox: tileBox,
        child: child,
      );
    }

    else {
      return NonCollapsableTile(
        key: const ValueKey('NonCollapsableTile'),
        width: width,
        sideBox: sideBox,
        onTileTap: onTileTap,
        expansionColor: expansionColor,
        corners: corners,
        margin: margin,
        searchText: searchText,
        onTileLongTap: onTileLongTap,
        onTileDoubleTap: onTileDoubleTap,
        child: child,
      );
    }

  }
  /// --------------------------------------------------------------------------
}
