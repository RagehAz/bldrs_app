import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:basics/components/super_box/super_box.dart';
import 'package:flutter/material.dart';
import 'b_expanding_tile.dart';

class CollapsedTile extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CollapsedTile({
    required this.onTileTap,
    required this.tileWidth,
    required this.collapsedHeight,
    required this.sideBox,
    required this.child,
    required this.arrowTurns,
    required this.arrowColor,
    required this.expandableHeightFactorAnimationValue,
    required this.tileColor,
    required this.corners,
    required this.tileBox,
    this.iconCorners,
    this.marginIsOn = true,
    this.searchText,
    this.onTileLongTap,
    this.onTileDoubleTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Function? onTileTap;
  final double tileWidth;
  final double collapsedHeight;
  final Widget? sideBox;
  final Widget? child;
  final Animation<double>? arrowTurns;
  final Color arrowColor;
  final double? expandableHeightFactorAnimationValue;
  final Color? tileColor;
  final double corners;
  final double? iconCorners;
  final bool marginIsOn;
  final ValueNotifier<dynamic>? searchText;
  final Function? onTileLongTap;
  final Function? onTileDoubleTap;
  final Widget tileBox;
  /// --------------------------------------------------------------------------
  static const double collapsedGroupHeight = ((Ratioz.appBarCorner + Ratioz.appBarMargin) * 2) + Ratioz.appBarMargin;
  static const double arrowBoxSize = ExpandingTile.arrowBoxSize;
  static const double cornersValue = Ratioz.appBarCorner;
  static const Color collapsedColor = Colorz.white10;
  static const Color expandedColor = Colorz.blue80;
  // --------------------
  static Widget arrow({
    required double? collapsedHeight,
    required Color? arrowColor,
    required FontWeight textWeight,
    required bool appIsLTR,
    required TextDirection textDirection,
    bool arrowDown = true,
  }) {

    final double _arrowBoxSize = collapsedHeight ?? collapsedGroupHeight;

    return SuperBox(
      height: _arrowBoxSize,
      width: _arrowBoxSize,
      bubble: false,
      icon: arrowDown ? Iconz.arrowDown : Iconz.arrowUp,
      iconSizeFactor: 0.2,
      iconColor: arrowColor ?? Colorz.white255,
      textWeight: textWeight,
      textDirection: textDirection,
      appIsLTR: appIsLTR,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // const double _titlePadding = Ratioz.appBarMargin;

    return Container(
      // key: const ValueKey<String>('CollapsedTile'),
      // height: collapsedHeight, // this block expansion
      width: tileWidth,
      margin: marginIsOn == true ?
      const EdgeInsets.symmetric(
          vertical: Ratioz.appBarPadding,
          horizontal: Ratioz.appBarMargin
      )
          :
      null,
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: Borderers.cornerAll(corners),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          /// COLLAPSED ZONE
          GestureDetector(
            key: const ValueKey<String>('CollapsedTile_collapsed_zone'),
            onTap: () => onTileTap?.call(),
            onLongPress: () => onTileLongTap?.call(),
            onDoubleTap: () => onTileDoubleTap?.call(),
            child: Container(
              width: tileWidth,
              color: Colorz.nothing,

              /// do no delete this,, it adjusts GestureDetector tapping area
              child: Row(
                children: <Widget>[

                  /// Icon
                  if (sideBox != null)
                    sideBox!,

                  /// Tile title
                  tileBox,

                  /// Arrow
                  // RotationTransition(
                  //   turns: arrowTurns,
                  //   child: arrow(
                  //     collapsedHeight: collapsedHeight,
                  //     arrowColor: arrowColor,
                  //   ),
                  // ),

                ],
              ),
            ),
          ),

          /// EXPANDABLE ZONE
          ClipRRect(
            key: const ValueKey<String>('CollapsedTile_expandable_zone'),
            child: Align(
              heightFactor: expandableHeightFactorAnimationValue,
              child: child,
            ),
          ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
