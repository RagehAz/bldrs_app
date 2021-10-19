import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/specific/keywords/collapsed_tile.dart';
import 'package:bldrs/views/widgets/specific/keywords/sub_group_expansion_tile.dart';
import 'package:flutter/material.dart';

class ExpandingTile extends StatefulWidget {
  final double width;
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

  const ExpandingTile({
    this.width,
    this.maxHeight,

    this.scrollable = true,

    this.icon,
    this.iconSizeFactor = 1,
    this.onTap,
    this.initiallyExpanded: false,

    @required this.firstHeadline,
    @required this.secondHeadline,

    this.initialColor = Colorz.white10,
    this.expansionColor,
    this.corners,
    @required this.child,
  });

  static const double collapsedGroupHeight = ((Ratioz.appBarCorner + Ratioz.appBarMargin) * 2) + Ratioz.appBarMargin;
  static const double arrowBoxSize = SubGroupTile.arrowBoxSize;
  static const double cornersValue = Ratioz.appBarCorner + Ratioz.appBarPadding;
  static const Color collapsedColor = Colorz.white10;
  static const Color expandedColor = Colorz.blue80;

  static BorderRadius borders(BuildContext context){
    return Borderers.superBorderAll(context, cornersValue);
  }

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
  static const Duration _kExpand = const Duration(milliseconds: 200);
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
    _arrowTurns = new Tween<double>(begin: 0.0, end: 0.5).animate(_easeInAnimation);
    _borderRadius = new BorderRadiusTween();
    _isExpanded = PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) {_controller.value = 1.0;}
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
    _setExpanded(!_isExpanded);
  }
// -----------------------------------------------------------------------------
  void _setExpanded(bool isExpanded) {
    if (_isExpanded != isExpanded) {
      setState(() {
        _isExpanded = isExpanded;
        if (_isExpanded)
          _controller.forward();
        else
          _controller.reverse().then<void>((dynamic value) {
            setState(() {
              // Rebuild without widget.children.
            });
          });
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
    //------------------------------------------------------------o
    return Container(
      width: widget.width,
      alignment: Alignment.topCenter,
      child: new AnimatedBuilder(
        animation: _controller.view,
        builder: (context, child){

          /// final Color borderSideColor = _borderColor.evaluate(_easeOutAnimation) ?? Colors.transparent;
          /// final Color _subTitleLabelColor = _subtitleLabelColorTween.evaluate(_easeInAnimation);
          final Color _headlineColor = _headlineColorTween.evaluate(_easeInAnimation);
          final Color _tileColor = _tileColorTween.evaluate(_easeInAnimation);

          return

            CollapsedTile(
              tileWidth: widget.width,
              collapsedHeight: ExpandingTile.collapsedGroupHeight,
              tileColor: _tileColor,
              corners: widget.corners ?? ExpandingTile.cornersValue,
              firstHeadline: widget.firstHeadline,
              secondHeadline: widget.secondHeadline,
              icon: widget.icon,
              arrowColor: _headlineColor,
              arrowTurns: _arrowTurns,
              toggleExpansion: toggle,
              expandableHeightFactorAnimationValue: _easeInAnimation.value,
              child: child,
              iconCorners: ExpandingTile.cornersValue,
            );

        },

        /// SUB - GROUPS & KEYWORDS : Expanded tile children
        child: _closed == true ? null
            :
        Container(
          width: widget.width,
          child: widget.child,
        ),

      ),
    );

  }
}