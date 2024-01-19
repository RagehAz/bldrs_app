import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/components/bubbles/model/bubble_header_vm.dart';
import 'package:flutter/material.dart';
import 'b_expanding_tile.dart';

class NonCollapsableTile extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NonCollapsableTile({
    required this.child,
    required this.width,
    required this.sideBox,
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
  final Widget sideBox;
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
      bubbleColor: ExpandingTile.getExpandedColor(expansionColor: expansionColor),
      bubbleHeaderVM: const BubbleHeaderVM(
        // headlineText: firstHeadline,
        // leadingIcon: icon,
        // leadingIconSizeFactor: iconSizeFactor,

      ),
      corners: ExpandingTile.getCorners(corners: corners),
      margin: ExpandingTile.getMargins(margin: margin),
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
