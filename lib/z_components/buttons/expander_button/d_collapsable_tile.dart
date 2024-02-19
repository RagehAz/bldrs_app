import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/z_components/buttons/expander_button/b_expanding_tile.dart';
import 'package:bldrs/z_components/buttons/expander_button/e_collapsed_tile.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';

class CollapsableTile extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CollapsableTile({
    required this.firstHeadline,
    required this.child,
    required this.width,
    required this.secondHeadline,
    required this.collapsedHeight,
    required this.maxHeight,
    required this.scrollable,
    required this.icon,
    required this.iconSizeFactor,
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
    super.key
  });
  /// --------------------------------------------------------------------------
  final double width;
  final double? collapsedHeight;
  final double? maxHeight;
  final bool scrollable;
  final String? icon;
  final double iconSizeFactor;
  final bool? initiallyExpanded;
  final Verse? firstHeadline;
  final Verse? secondHeadline;
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
  /// --------------------------------------------------------------------------
  @override
  CollapsableTileState createState() => CollapsableTileState();
// -----------------------------------------------------------------------------
}

class CollapsableTileState extends State<CollapsableTile> with SingleTickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  late AnimationController _controller;
  late CurvedAnimation _easeInAnimation;
  late ColorTween _borderColor;
  late ColorTween _tileColorTween;
  // ColorTween _subtitleLabelColorTween;
  // BorderRadiusTween _borderRadius;
  late Animation<double> _arrowTurns;
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
      parent: _controller,
      curve: Curves.easeIn,
    );
    // ---
    _borderColor = ColorTween();
    _borderColor.end = Colorz.green255;

    // ---
    _tileColorTween = BldrsExpandingButton.getTileColorTween(
      collapsedColor: widget.initialColor ?? Colorz.white10,
      expansionColor: widget.expansionColor ?? Colorz.white30,
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
    _arrowTurns = Tween<double>(begin: 0, end: 0.5).animate(_easeInAnimation);
    // ---
    final bool? _storedExpanded = PageStorage.of(context).readState(context, identifier: 'expansion') as bool? ?? false;
    setNotifier(
        notifier: _isExpanded,
        mounted: mounted,
        value: widget.initiallyExpanded ?? _storedExpanded,
    );
    // ---
    if (_isExpanded.value  == true) {
      _controller.value  = 1.0;
    }
    // ---
  }
  // --------------------
  @override
  void dispose() {
    _controller.dispose();
    _easeInAnimation.dispose();

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
        oldWidget.icon != widget.icon ||
        oldWidget.iconSizeFactor != widget.iconSizeFactor ||
        oldWidget.initiallyExpanded != widget.initiallyExpanded ||
        oldWidget.firstHeadline?.id != widget.firstHeadline?.id ||
        oldWidget.secondHeadline?.id != widget.secondHeadline?.id ||
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
          begin: widget.initialColor ?? BldrsExpandingButton.collapsedColor,
          end: widget.expansionColor ?? BldrsExpandingButton.expandedColor,
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
        widget.onTileTap!.call(_isExpanded.value);
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
          widget.onTileTap!.call(_isExpanded.value);
        }

        /// ANIMATE FORWARD
        if (isExpanded == true) {
          await _controller.forward();
        }
        /// ANIMATE BACKWARDS
        else {
          await _controller.reverse().then<void>((dynamic value) {});
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

    final double _collapsedHeight = BldrsExpandingButton.getCollapsedHeight(
        collapsedHeight: widget.collapsedHeight,
    );

    final double _bottomStripHeight = _collapsedHeight * 0.5;
    ///------------------------------------------------------------o
    return Center(
      child: Container(
        key: widget.key,
        // height: widget.height,
        width: widget.width,
        alignment: Alignment.topCenter,
        margin: BldrsExpandingButton.getMargins(margin: widget.margin),
        // color: Colorz.bloodTest,
        child: AnimatedBuilder(
          key: const ValueKey<String>('ExpandingTile_AnimatedBuilder'),
          animation: _controller.view,
          builder: (BuildContext context, Widget? expansionColumn) {

            final Color? _tileColor = _tileColorTween.evaluate(_easeInAnimation);

            return CollapsedTile(
              tileWidth: widget.width,
              marginIsOn: false,
              collapsedHeight: _collapsedHeight,
              tileColor: _tileColor,
              corners: BldrsExpandingButton.getCorners(corners: widget.corners),
              firstHeadline: widget.firstHeadline,
              secondHeadline: widget.secondHeadline,
              icon: widget.icon,
              iconSizeFactor: widget.iconSizeFactor,
              arrowColor: Colorz.white255,
              arrowTurns: _arrowTurns,
              expandableHeightFactorAnimationValue: _easeInAnimation.value,
              iconCorners: BldrsExpandingButton.cornersValue,
              searchText: widget.searchText,
              onTileTap: _toggleExpansion,
              onTileLongTap: widget.onTileLongTap,
              onTileDoubleTap: widget.onTileDoubleTap,
              child: expansionColumn!,
            );
          },

          /// EXPANSION COLUMN
          child: ValueListenableBuilder(
            key: const ValueKey<String>('ExpandingTile_expansion_column'),
            valueListenable: _isExpanded,
            builder: (_, bool isExpanded, Widget? columnAndChildren){

              final bool _closed = isExpanded == false && _controller.isDismissed == true;

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

                /// BOTTOM ARROW
                GestureDetector(
                  key: const ValueKey<String>('ExpandingTile_bottom_arrow'),
                  onTap: _toggleExpansion,
                  child: Container(
                    width: widget.width,
                    height: _bottomStripHeight,
                    alignment: Alignment.center,
                    child: BldrsBox(
                      width: _bottomStripHeight,
                      height: _bottomStripHeight,
                      icon: Iconz.arrowUp,
                      iconSizeFactor: _bottomStripHeight / 50,
                      bubble: false,
                    ),

                  ),
                ),

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
