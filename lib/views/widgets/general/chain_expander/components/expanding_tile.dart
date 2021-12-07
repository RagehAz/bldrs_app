import 'package:bldrs/controllers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/specific/keywords/collapsed_tile.dart';
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
    this.inActiveMode = false,
    this.margin,
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
  final String firstHeadline;
  final String secondHeadline;
  final Color initialColor;
  final Color expansionColor;
  final double corners;
  final Widget child;
  final bool inActiveMode;
  final EdgeInsets margin;
  /// --------------------------------------------------------------------------
  static const double collapsedTileHeight = 50;
  static const double buttonVerticalPadding = Ratioz.appBarPadding;
  static const double titleBoxHeight = 25;
  static const double arrowBoxSize = collapsedTileHeight;
  static const double collapsedGroupHeight = ((Ratioz.appBarCorner + Ratioz.appBarMargin) * 2) + Ratioz.appBarMargin;
  static const double cornersValue = Ratioz.appBarCorner;
  static const Color collapsedColor = Colorz.white10;
  static const Color expandedColor = Colorz.white30;
// -----------------------------------------------------------------------------
  static BorderRadius borders(BuildContext context){
    return Borderers.superBorderAll(context, cornersValue);
  }
// -----------------------------------------------------------------------------
  static double calculateButtonExtent(){
    return collapsedTileHeight + buttonVerticalPadding;
  }
// -----------------------------------------------------------------------------
  static double calculateTitleIconSize({@required String icon, @required double collapsedHeight}){
     final double _iconSize = icon == null ? 0 : collapsedHeight ?? collapsedGroupHeight;
     return _iconSize;
  }
// -----------------------------------------------------------------------------
  static double calculateTitleBoxWidth({@required double tileWidth, @required String icon, @required double collapsedHeight}){
    final double _iconSize = calculateTitleIconSize(icon: icon, collapsedHeight: collapsedHeight);
        /// arrow size is button height but differs between groupTile and subGroupTile
    final double _titleZoneWidth = tileWidth - _iconSize - collapsedHeight;
    return _titleZoneWidth;
  }
// -----------------------------------------------------------------------------
  static int numberOfButtons({List<KW> keywords}){
    return keywords.length;
  }
// -----------------------------------------------------------------------------
  static double calculateMaxHeight({List<KW> keywords}){
    final int _totalNumberOfButtons = numberOfButtons(keywords: keywords);

    final double _maxHeight =
    /// keywords heights
    ( ( collapsedTileHeight + buttonVerticalPadding ) * _totalNumberOfButtons)
        +
        /// subGroups titles boxes heights
        (titleBoxHeight)
        +
        /// bottom padding
        0;

    return _maxHeight;
  }
// -----------------------------------------------------------------------------
  static double calculateButtonsTotalHeight({List<KW> keywords}){
    final double _totalButtonsHeight = (collapsedTileHeight + buttonVerticalPadding) * numberOfButtons(keywords: keywords);
    return _totalButtonsHeight;
  }
// -----------------------------------------------------------------------------
  @override
  ExpandingTileState createState() => new ExpandingTileState();
}

class ExpandingTileState extends State<ExpandingTile> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  // CurvedAnimation _easeOutAnimation;
  CurvedAnimation _easeInAnimation;
  ColorTween _borderColor;
  ColorTween _headlineColorTween;
  ColorTween _tileColorTween;
  ColorTween _subtitleLabelColorTween;
  BorderRadiusTween _borderRadius;
  Animation<double> _arrowTurns;
  bool _isExpanded = false;
  static const Duration _kExpand = Duration(milliseconds: 200);
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(duration: _kExpand, vsync: this);
    // _easeOutAnimation = new CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _easeInAnimation = new CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _borderColor = new ColorTween();
    _headlineColorTween = new ColorTween();
    _tileColorTween = new ColorTween();
    _subtitleLabelColorTween = new ColorTween();
    _arrowTurns = new Tween<double>(begin: 0, end: 0.5).animate(_easeInAnimation);
    _borderRadius = new BorderRadiusTween();
    _isExpanded = PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;

    if (_isExpanded){
      _controller.value = 1.0;
    }

  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  void expand() {
    _setExpanded(true);
  }
// -----------------------------------------------------------------------------
  void collapse() {
    _setExpanded(false);
  }
// -----------------------------------------------------------------------------
  void toggle() {

    if (widget.inActiveMode == false){
      _setExpanded(!_isExpanded);
    }

    else {
      if (widget.onTap != null) {
        widget.onTap(_isExpanded);
      }
    }

  }
// -----------------------------------------------------------------------------
  void _setExpanded(bool isExpanded) {
    if (_isExpanded != isExpanded) {

      setState(() {

        _isExpanded = isExpanded;

        if (_isExpanded){
          _controller.forward();
        }

        else {
          _controller.reverse().then<void>((dynamic value) {
            setState(() {
              // Rebuild without widget.children.
            });
          });

        }
        PageStorage.of(context)?.writeState(context, _isExpanded);

      });

      if (widget.onTap != null) {
        widget.onTap(_isExpanded);
      }

    }
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    //--------------------------------o
    _borderColor.end = Colorz.green255;
    _headlineColorTween
      ..begin = Colorz.white255
      ..end = Colorz.white255;
    _tileColorTween
      ..begin = widget.initialColor ?? ExpandingTile.collapsedColor
      ..end = widget.expansionColor ?? ExpandingTile.expandedColor;
    _subtitleLabelColorTween
      ..begin = Colorz.white10
      ..end = Colorz.white10;
    _borderRadius
      ..begin = BorderRadius.circular(Ratioz.appBarCorner - 5)
      ..end = BorderRadius.circular(Ratioz.appBarCorner - 5);
    //------------------------------------------------------------o
    final bool _closed = _isExpanded == false && _controller.isDismissed == true;
    //------------------------------------------------------------o
    // final double _iconSize = SubGroupTile.calculateTitleIconSize(icon: widget.icon);
    final double _bottomStripHeight = widget.collapsedHeight == null ? ExpandingTile.collapsedGroupHeight * 0.75 : widget.collapsedHeight * 0.75;
    //------------------------------------------------------------o
    return Container(
      // height: widget.height,
      key: widget.key,
      width: widget.width,
      alignment: Alignment.topCenter,
      margin: widget.margin,
      child: new AnimatedBuilder(
        animation: _controller.view,
        builder: (BuildContext context, Widget child){

          /// final Color borderSideColor = _borderColor.evaluate(_easeOutAnimation) ?? Colors.transparent;
          /// final Color _subTitleLabelColor = _subtitleLabelColorTween.evaluate(_easeInAnimation);
          final Color _headlineColor = _headlineColorTween.evaluate(_easeInAnimation);
          final Color _tileColor = _tileColorTween.evaluate(_easeInAnimation);

          return

            CollapsedTile(
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
              child: child,
            );

        },

        /// SUB - GROUPS & KEYWORDS : Expanded tile children
        child: _closed == true ? null
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
        ),

      ),
    );

  }
}
