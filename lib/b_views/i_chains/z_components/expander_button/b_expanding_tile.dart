import 'package:bldrs/b_views/i_chains/z_components/expander_button/bb_collapsed_tile.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ExpandingTile extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ExpandingTile({
    @required this.firstHeadline,
    @required this.secondHeadline,
    @required this.child,
    this.width,
    this.collapsedHeight,
    this.maxHeight,
    this.scrollable = true,
    this.icon,
    this.iconSizeFactor = 1,
    this.onTap,
    this.initiallyExpanded = false,
    this.initialColor = Colorz.white10,
    this.expansionColor,
    this.corners,
    this.isDisabled = false,
    this.margin,
    this.searchText,
    this.onLongPress,
    this.onDoubleTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final double collapsedHeight;
  final double maxHeight;
  final bool scrollable;
  final String icon;
  final double iconSizeFactor;
  final ValueChanged<bool> onTap;
  final bool initiallyExpanded;
  final Verse firstHeadline;
  final Verse secondHeadline;
  final Color initialColor;
  final Color expansionColor;
  final double corners;
  final Widget child;
  final bool isDisabled;
  final EdgeInsets margin;
  final ValueNotifier<dynamic> searchText;
  final Function onLongPress;
  final Function onDoubleTap;
  /// --------------------------------------------------------------------------
  static const double collapsedTileHeight = 50;
  static const double buttonVerticalPadding = Ratioz.appBarPadding;
  static const double titleBoxHeight = 25;
  static const double arrowBoxSize = collapsedTileHeight;
  static const double collapsedGroupHeight =
      ((Ratioz.appBarCorner + Ratioz.appBarMargin) * 2)
          +
          Ratioz.appBarMargin;
  static const double cornersValue = Ratioz.appBarCorner;
  static const Color collapsedColor = Colorz.white10;
  static const Color expandedColor = Colorz.white30;
  // --------------------
  static BorderRadius borders(BuildContext context) {
    return Borderers.superBorderAll(context, cornersValue);
  }
  // --------------------
  static double calculateButtonExtent() {
    return collapsedTileHeight + buttonVerticalPadding;
  }
  // --------------------
  static double calculateTitleIconSize({
    @required String icon,
    @required double collapsedHeight
  }) {
    final double _iconSize = icon == null ?
    0
        :
    collapsedHeight ?? collapsedGroupHeight;

    return _iconSize;
  }
  // --------------------
  static double calculateTitleBoxWidth({
    @required double tileWidth,
    @required String icon,
    @required double collapsedHeight,
  }) {

    final double _iconSize = calculateTitleIconSize(
      icon: icon,
      collapsedHeight: collapsedHeight,
    );

    /// arrow size is button height but differs between groupTile and subGroupTile
    final double _titleZoneWidth = tileWidth - _iconSize - collapsedHeight;

    return _titleZoneWidth;
  }
  // --------------------
  static int numberOfButtons({
    @required List<String> keywordsIDs,
  }) {
    return keywordsIDs.length;
  }
  // --------------------
  static double calculateMaxHeight({
    @required List<String> keywordsIDs,
  }) {

    final int _totalNumberOfButtons = numberOfButtons(
      keywordsIDs: keywordsIDs,
    );

    final double _maxHeight =

    /// keywords heights
    ((collapsedTileHeight + buttonVerticalPadding) *
        _totalNumberOfButtons) +

        /// subGroups titles boxes heights
        titleBoxHeight +

        /// bottom padding
        0;

    return _maxHeight;
  }
  // --------------------
  static double calculateButtonsTotalHeight({
    @required List<String> keywordsIDs,
  }) {
    final double _totalButtonsHeight =
        (collapsedTileHeight + buttonVerticalPadding)
            *
            numberOfButtons(keywordsIDs: keywordsIDs);

    return _totalButtonsHeight;
  }
  // -----------------------------------------------------------------------------
  @override
  ExpandingTileState createState() => ExpandingTileState();
// -----------------------------------------------------------------------------
}

class ExpandingTileState extends State<ExpandingTile> with SingleTickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  AnimationController _controller;
  CurvedAnimation _easeInAnimation;
  ColorTween _borderColor;
  ColorTween _headlineColorTween;
  ColorTween _tileColorTween;
  ColorTween _subtitleLabelColorTween;
  BorderRadiusTween _borderRadius;
  Animation<double> _arrowTurns;
  // --------------------
  ValueNotifier<bool> _isExpanded;
  // --------------------
  static const Duration _kExpand = Duration(milliseconds: 200);
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: _kExpand,
      vsync: this,
    );

    _easeInAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _borderColor = ColorTween();
    _headlineColorTween = ColorTween();
    _tileColorTween = ColorTween();
    _subtitleLabelColorTween = ColorTween();
    _arrowTurns = Tween<double>(begin: 0, end: 0.5).animate(_easeInAnimation);
    _borderRadius = BorderRadiusTween();

    _isExpanded = PageStorage.of(context)?.readState(context) ??
        ValueNotifier(widget.initiallyExpanded);

    if (_isExpanded.value == true) {
      _controller.value = 1.0;
    }

  }
  // --------------------
  /// TASK : BUG HERE
  @override
  void dispose() {
    // blog('ExpandingTile : ${widget.firstHeadline} : DISPOOOOSING');
    _controller.dispose();
    _easeInAnimation.dispose();
    // _isExpanded.dispose(); /// TASK : BUG HERE
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  void expand() {
    _setExpanded(true);
  }
  // --------------------
  void collapse() {
    _setExpanded(false);
  }
  // --------------------
  void toggle() {

    /// WHEN CAN EXPAND
    if (widget.isDisabled == false) {
      _setExpanded(!_isExpanded.value);
    }

    /// WHEN CAN NOT EXPAND IN INACTIVE MODE
    else {
      if (widget.onTap != null) {
        widget.onTap(_isExpanded.value);
      }
    }

  }
  // --------------------
  void _setExpanded(bool isExpanded) {

    if (mounted == true){
      if (_isExpanded.value != isExpanded) {

        _isExpanded.value = isExpanded;

        if (_isExpanded.value == true) {
          _controller.forward();
        }

        else {
          _controller.reverse().then<void>((dynamic value) {
            // setState(() {
            //   // Rebuild without widget.children.
            // });
          });
        }

        PageStorage.of(context)?.writeState(context, _isExpanded);

        if (widget.onTap != null) {
          widget.onTap(_isExpanded.value);
        }
      }
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    ///--------------------------------o
    _borderColor.end = Colorz.green255;
    ///----------------o
    _headlineColorTween
      ..begin = Colorz.white255
      ..end = Colorz.white255;
    ///----------------o
    _tileColorTween
      ..begin = widget.initialColor ?? ExpandingTile.collapsedColor
      ..end = widget.expansionColor ?? ExpandingTile.expandedColor;
    ///----------------o
    _subtitleLabelColorTween
      ..begin = Colorz.white10
      ..end = Colorz.white10;
    ///----------------o
    _borderRadius
      ..begin = BorderRadius.circular(Ratioz.appBarCorner - 5)
      ..end = BorderRadius.circular(Ratioz.appBarCorner - 5);
    ///------------------------------------------------------------o
    // final double _iconSize = SubGroupTile.calculateTitleIconSize(icon: widget.icon);
    final double _bottomStripHeight =
    widget.collapsedHeight == null ?
    ExpandingTile.collapsedGroupHeight * 0.75
        :
    widget.collapsedHeight * 0.75;
    // --------------------
    return Container(
      // height: widget.height,
      key: widget.key,
      width: widget.width,
      alignment: Alignment.topCenter,
      margin: widget.margin,
      child: AnimatedBuilder(
        animation: _controller.view,
        builder: (BuildContext context, Widget child) {

          final Color _headlineColor = _headlineColorTween.evaluate(_easeInAnimation);
          final Color _tileColor = _tileColorTween.evaluate(_easeInAnimation);

          return CollapsedTile(
            tileWidth: widget.width,
            marginIsOn: false,
            collapsedHeight: widget.collapsedHeight ?? ExpandingTile.collapsedGroupHeight,
            tileColor: _tileColor,
            corners: widget.corners ?? ExpandingTile.cornersValue,
            firstHeadline: widget.firstHeadline,
            secondHeadline: widget.secondHeadline,
            icon: widget.icon,
            iconSizeFactor: widget.iconSizeFactor,
            arrowColor: _headlineColor,
            arrowTurns: _arrowTurns,
            toggleExpansion: toggle,
            expandableHeightFactorAnimationValue: _easeInAnimation.value,
            iconCorners: ExpandingTile.cornersValue,
            searchText: widget.searchText,
            onLongPress: widget.onLongPress,
            onDoubleTap: widget.onDoubleTap,
            child: child,
          );
        },

        /// SUB - GROUPS & KEYWORDS : Expanded tile children
        child: ValueListenableBuilder(
          valueListenable: _isExpanded,
          builder: (_, bool isExpanded, Widget child){

            final bool _closed =
                isExpanded == false
                    &&
                    _controller.isDismissed == true;


            return _closed == true ?
            const SizedBox()
                :
            Column(
              children: <Widget>[

                SizedBox(
                  width: widget.width,
                  child: widget.child,
                ),

                GestureDetector(
                  onTap: toggle,
                  child: Container(
                    width: widget.width,
                    height: _bottomStripHeight,
                    alignment: Alignment.center,
                    child: DreamBox(
                      width: _bottomStripHeight,
                      height: _bottomStripHeight,
                      icon: Iconz.arrowUp,
                      iconSizeFactor: _bottomStripHeight * 0.5 / 100,
                      bubble: false,
                    ),

                  ),
                ),

              ],
            );

          },
        ),
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
