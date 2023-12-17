import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/c_non_collabsable_tile.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/d_collapsable_tile.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class BldrsExpandingButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsExpandingButton({
    required this.firstHeadline,
    required this.child,
    required this.width,
    this.secondHeadline,
    this.collapsedHeight,
    this.maxHeight,
    this.scrollable = true,
    this.icon,
    this.iconSizeFactor = 1,
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
  final String? icon;
  final double iconSizeFactor;
  final bool initiallyExpanded;
  final Verse firstHeadline;
  final Verse? secondHeadline;
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
  // -----------------------------------------------------------------------------

  /// COLORS

  // --------------------
  static const Color collapsedColor = Colorz.white10;
  static const Color expandedColor = Colorz.white30;
  // --------------------
  /// TESTED : WORKS PERFECT
  static ColorTween getTileColorTween({
    required Color collapsedColor,
    required Color expansionColor,
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
    return expansionColor ?? BldrsExpandingButton.expandedColor;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Color getCollapsedColor({
    required Color? collapsedColor,
  }){
    return collapsedColor ?? BldrsExpandingButton.collapsedColor;
  }
  // -----------------------------------------------------------------------------

  /// ICONS - ARROWS

  // --------------------
  static const double arrowBoxSize = collapsedTileHeight;
  // --------------------
  /// TESTED : WORKS PERFECT
  static double calculateTitleIconSize({
    required String? icon,
    required double? collapsedHeight
  }) {
    final double _iconSize = icon == null ?
    0
        :
    collapsedHeight ?? collapsedGroupHeight;

    return _iconSize;
  }
  // -----------------------------------------------------------------------------

  /// WIDTH

  // --------------------
  /// TESTED : WORKS PERFECT
  static double calculateTitleBoxWidth({
    required double tileWidth,
    required String? icon,
    required double collapsedHeight,
  }) {

    final double _iconSize = calculateTitleIconSize(
      icon: icon,
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
    return collapsedHeight ?? BldrsExpandingButton.collapsedGroupHeight;
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
  static BorderRadius borders = BldrsAppBar.corners;
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getCorners({
    double? corners,
  }){

    if (corners == null) {
      return BldrsExpandingButton.cornersValue;
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

    // if (margin == null){
      return const EdgeInsets.only(bottom: 5);
    // }
    // else {
    //   return Scale.superMargins(margin: margin);
    // }

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
        firstHeadline: firstHeadline,
        width: width,
        secondHeadline: secondHeadline,
        collapsedHeight: collapsedHeight,
        maxHeight: maxHeight,
        scrollable: scrollable,
        icon: icon,
        iconSizeFactor: iconSizeFactor,
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
        child: child,
      );
    }

    else {
      return NonCollapsableTile(
        key: const ValueKey('NonCollapsableTile'),
        firstHeadline: firstHeadline,
        width: width,
        secondHeadline: secondHeadline,
        icon: icon,
        iconSizeFactor: iconSizeFactor,
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
