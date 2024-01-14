import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:flutter/material.dart';

import 'b_expanding_tile.dart';
import 'e_collapsed_tile.dart';

class CollapsableTile extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CollapsableTile({
    required this.child,
    required this.width,
    required this.collapsedHeight,
    required this.maxHeight,
    required this.scrollable,
    required this.sideBox,
    required this.onTileTap,
    required this.initiallyExpanded,
    required this.initialColor,
    required this.expansionColor,
    required this.corners,
    required this.isDisabled,
    required this.margin,
    required this.searchText,
    required this.onTileLongTap,
    required this.onTileDoubleTap,
    required this.tileBox,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double width;
  final double? collapsedHeight;
  final double? maxHeight;
  final bool scrollable;
  final Widget sideBox;
  final bool? initiallyExpanded;
  final Color? initialColor;
  final Color? expansionColor;
  final double? corners;
  final Widget child;
  final bool isDisabled;
  final EdgeInsets? margin;
  final ValueNotifier<dynamic>? searchText;
  final ValueChanged<bool>? onTileTap;
  final Function? onTileLongTap;
  final Function? onTileDoubleTap;
  final Widget tileBox;
  /// --------------------------------------------------------------------------
  @override
  CollapsableTileState createState() => CollapsableTileState();
// -----------------------------------------------------------------------------
}

class CollapsableTileState extends State<CollapsableTile> with SingleTickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  AnimationController? _controller;
  CurvedAnimation? _easeInAnimation;
  ColorTween? _borderColor;
  ColorTween? _tileColorTween;
  // ColorTween _subtitleLabelColorTween;
  // BorderRadiusTween _borderRadius;
  Animation<double>? _arrowTurns;
  // --------------------
  final ValueNotifier<bool> _isExpanded = ValueNotifier<bool>(false);
  // --------------------
  static const Duration _expansionDuration = Duration(milliseconds: 200);
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    // ---
    _controller = AnimationController(
      duration: _expansionDuration,
      vsync: this,
    );
    // ---
    _easeInAnimation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeIn,
    );
    // ---
    _borderColor = ColorTween();
    _borderColor!.end = Colorz.green255;

    // ---
    _tileColorTween = ExpandingTile.getTileColorTween(
      collapsedColor: widget.initialColor,
      expansionColor: widget.expansionColor,
    );
    // ---
    /*
     _subtitleLabelColorTween = ColorTween(
       begin: Colorz.white10,
       end: Colorz.white10,
     );
     _borderRadius = BorderRadiusTween();
     */
    // ---
    _arrowTurns = Tween<double>(begin: 0, end: 0.5).animate(_easeInAnimation!);
    // ---
    final dynamic _stored = PageStorage.of(context).readState(context, identifier: 'expansion');
    final bool _storedExpanded = Mapper.boolIsTrue(_stored);

    setNotifier(
        notifier: _isExpanded,
        mounted: mounted,
        value: widget.initiallyExpanded ?? _storedExpanded,
    );
    // ---
    if (_isExpanded.value  == true) {
      _controller!.value  = 1.0;
    }
    // ---
  }
  // --------------------
  @override
  void dispose() {
    _controller?.dispose();
    _easeInAnimation?.dispose();

    // blog('ExpandingTile : ${widget.firstHeadline} : DISPOOOOSING');
    _isExpanded.dispose();

    super.dispose();
  }
  // --------------------
  @override
  void didUpdateWidget(covariant CollapsableTile oldWidget) {

    if (
        oldWidget.width != widget.width ||
        oldWidget.collapsedHeight != widget.collapsedHeight ||
        oldWidget.maxHeight != widget.maxHeight ||
        oldWidget.scrollable != widget.scrollable ||
        oldWidget.initiallyExpanded != widget.initiallyExpanded ||
        oldWidget.initialColor != widget.initialColor ||
        oldWidget.expansionColor != widget.expansionColor ||
        oldWidget.corners != widget.corners ||
        // oldWidget.child != widget.child ||
        oldWidget.isDisabled != widget.isDisabled ||
        oldWidget.margin != widget.margin
    // oldWidget.searchText != widget.searchText
    ){
      if (
      oldWidget.initialColor != widget.initialColor ||
          oldWidget.expansionColor != widget.expansionColor
      ){
        _tileColorTween = ColorTween(
          begin: widget.initialColor ?? ExpandingTile.collapsedColor,
          end: widget.expansionColor ?? ExpandingTile.expandedColor,
        );
      }

      setState(() {});
    }

    super.didUpdateWidget(oldWidget);
  }
  // -----------------------------------------------------------------------------
  void _toggleExpansion() {


    /// WHEN CAN EXPAND
    if (widget.isDisabled == false) {
      _setExpanded(!_isExpanded.value);
    }

    /// WHEN CAN NOT EXPAND IN INACTIVE MODE
    else {
      if (widget.onTileTap != null) {
        widget.onTileTap?.call(_isExpanded.value);
      }
    }

  }
  // --------------------
  void _setExpanded(bool isExpanded) {

    setNotifier(
      notifier: _isExpanded,
      mounted: mounted,
      value: isExpanded,
      onFinish: () async {

        /// SAVE STATE
        if (mounted == true){
          PageStorage.of(context).writeState(context, _isExpanded.value, identifier: 'expansion');
        }

        /// PASS ON TILE TAP
        if (widget.onTileTap != null) {
          widget.onTileTap?.call(_isExpanded.value);
        }

        /// ANIMATE FORWARD
        if (isExpanded == true) {
          await _controller?.forward();
        }
        /// ANIMATE BACKWARDS
        else {
          await _controller?.reverse().then<void>((dynamic value) {});
        }

      },
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    ///------------------------------------------------------------o
    // _borderRadius = BorderRadiusTween(
    //   begin: BorderRadius.circular(Ratioz.appBarCorner - 5),
    //   end: BorderRadius.circular(Ratioz.appBarCorner - 5),
    // );
    ///------------------------------------------------------------o
    // final double _iconSize = SubGroupTile.calculateTitleIconSize(icon: widget.icon);

    final double _collapsedHeight = ExpandingTile.getCollapsedHeight(
        collapsedHeight: widget.collapsedHeight,
    );

    // final double _bottomStripHeight = _collapsedHeight * 0.5;
    ///------------------------------------------------------------o
    return Center(
      child: Container(
        key: widget.key,
        // height: widget.height,
        width: widget.width,
        alignment: Alignment.topCenter,
        margin: ExpandingTile.getMargins(margin: widget.margin),
        // color: Colorz.bloodTest,
        child: AnimatedBuilder(
          key: const ValueKey<String>('ExpandingTile_AnimatedBuilder'),
          animation: _controller!.view,
          builder: (BuildContext context, Widget? expansionColumn) {

            final Color? _tileColor = _tileColorTween?.evaluate(_easeInAnimation!);

            return CollapsedTile(
              tileWidth: widget.width,
              marginIsOn: false,
              collapsedHeight: _collapsedHeight,
              tileColor: _tileColor,
              corners: ExpandingTile.getCorners(corners: widget.corners),
              arrowColor: Colorz.white255,
              arrowTurns: _arrowTurns,
              expandableHeightFactorAnimationValue: _easeInAnimation?.value,
              iconCorners: ExpandingTile.cornersValue,
              searchText: widget.searchText,
              onTileTap: _toggleExpansion,
              onTileLongTap: widget.onTileLongTap,
              onTileDoubleTap: widget.onTileDoubleTap,
              tileBox: widget.tileBox,
              sideBox: widget.sideBox,
              child: expansionColumn,
            );
          },

          /// EXPANSION COLUMN
          child: ValueListenableBuilder(
            key: const ValueKey<String>('ExpandingTile_expansion_column'),
            valueListenable: _isExpanded,
            builder: (_, bool isExpanded, Widget? columnAndChildren){

              final bool _closed = isExpanded == false && Mapper.boolIsTrue(_controller?.isDismissed) == true;

              /// NOTHING WHEN COLLAPSED
              if (_closed == true){
                return const SizedBox();
              }

              /// CHILDREN WHEN EXPANDED
              else {

                /// COLUMN AND CHILDREN
                return columnAndChildren!;
              }

            },
            child: Column(
              key: const ValueKey<String>('ExpandingTile_columnAndChildren'),
              children: <Widget>[

                /// EXTERNAL CHILD
                SizedBox(
                  width: widget.width,
                  child: widget.child,
                ),

                // /// BOTTOM ARROW
                // GestureDetector(
                //   key: const ValueKey<String>('ExpandingTile_bottom_arrow'),
                //   onTap: _toggleExpansion,
                //   child: Container(
                //     width: widget.width,
                //     height: _bottomStripHeight,
                //     alignment: Alignment.center,
                //     child: TalkBox(
                //       width: _bottomStripHeight,
                //       height: _bottomStripHeight,
                //       icon: Iconz.arrowUp,
                //       iconSizeFactor: _bottomStripHeight / 50,
                //       bubble: false,
                //     ),
                //   ),
                // ),

              ],
            ),
          ),

        ),
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
