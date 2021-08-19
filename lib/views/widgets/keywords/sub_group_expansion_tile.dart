import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/keywords/collapsed_tile.dart';
import 'package:bldrs/views/widgets/keywords/keywords_buttons_list.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:flutter/material.dart';

class SubGroupTile extends StatefulWidget {
  final double tileWidth;
  final double tileMaxHeight;

  final String subGroupName;
  final String subGroupSecondName;

  final bool scrollable;

  final String subGroupIcon;
  final double iconSizeFactor;
  final Function onKeywordTap;

  final ValueChanged<bool> onExpansionChanged;
  final bool initiallyExpanded;

  final List<Keyword> keywords;
  // final List<Keyword> selectedKeywords;

  const SubGroupTile({
    this.tileWidth,
    this.tileMaxHeight,

    @required this.subGroupName,
    @required this.subGroupSecondName,

    this.scrollable = true,

    this.subGroupIcon,
    this.iconSizeFactor = 1,
    @required this.keywords,
    // @required this.selectedKeywords,
    @required this.onKeywordTap,
    this.onExpansionChanged,
    this.initiallyExpanded = false,
  });
// -----------------------------------------------------------------------------
  static const double collapsedTileHeight = 50;
  static const double buttonVerticalPadding = Ratioz.appBarPadding;
  static const double titleBoxHeight = 25;
  static const double arrowBoxSize = collapsedTileHeight;
// -----------------------------------------------------------------------------
  static double calculateButtonExtent(){
    return collapsedTileHeight + buttonVerticalPadding;
  }
// -----------------------------------------------------------------------------
  static double calculateTitleIconSize({String icon}){
     final double _iconSize = icon == null ? 0 : 40;
     return _iconSize;
  }
// -----------------------------------------------------------------------------
  static double calculateTitleBoxWidth({double tileWidth, String icon, double buttonHeight}){
    final double _iconSize = calculateTitleIconSize(icon: icon);
        /// arrow size is button height but differs between groupTile and subGroupTile
    final double _titleZoneWidth = tileWidth - _iconSize - buttonHeight;
    return _titleZoneWidth;
  }
// -----------------------------------------------------------------------------
  static int numberOfButtons({List<Keyword> keywords}){
    return keywords.length;
  }
// -----------------------------------------------------------------------------
  static double calculateMaxHeight({List<Keyword> keywords}){
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
  static double calculateButtonsTotalHeight({List<Keyword> keywords}){
    final double _totalButtonsHeight = (collapsedTileHeight + buttonVerticalPadding) * numberOfButtons(keywords: keywords);
    return _totalButtonsHeight;
  }
// -----------------------------------------------------------------------------
  @override
  SubGroupTileState createState() => new SubGroupTileState();
}

class SubGroupTileState extends State<SubGroupTile> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation _easeOutAnimation;
  CurvedAnimation _easeInAnimation;
  ColorTween _borderColor;
  ColorTween _titleColorTween;
  ColorTween _tileColorTween;
  ColorTween _subtitleLabelColorTween;
  BorderRadiusTween _borderRadius;
  Animation<double> _arrowTurns;
  bool _isExpanded = false;
  static const Duration _kExpand = const Duration(milliseconds: 200);
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _controller = new AnimationController(duration: _kExpand, vsync: this);
    _easeOutAnimation = new CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _easeInAnimation = new CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _borderColor = new ColorTween();
    _titleColorTween = new ColorTween();
    _tileColorTween = new ColorTween();
    _subtitleLabelColorTween = new ColorTween();
    _arrowTurns = new Tween<double>(begin: 0.0, end: 0.5).animate(_easeInAnimation);
    _borderRadius = BorderRadiusTween();
    _isExpanded = PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) {_controller.value = 1.0;}
    super.initState();
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
      if (widget.onExpansionChanged != null) {
        widget.onExpansionChanged(_isExpanded);
      }
    }
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    //--------------------------------o
    _borderColor.end = Colorz.Green255;
    _titleColorTween
      ..begin = Colorz.White255
      ..end = Colorz.White255;
    _tileColorTween
      ..begin = Colorz.White10
      ..end = Colorz.Blue80;
    _subtitleLabelColorTween
      ..begin = Colorz.White10
      ..end = Colorz.White10;
    _borderRadius
      ..begin = BorderRadius.circular(Ratioz.appBarCorner - 5)
      ..end = BorderRadius.circular(Ratioz.appBarCorner - 5);
    //------------------------------------------------------------o
    final bool closed = _isExpanded == false && _controller.isDismissed == true;
    //------------------------------------------------------------o
    return new AnimatedBuilder(
      animation: _controller.view,
      builder: (context, child){

        final Color _headlineColor = _titleColorTween.evaluate(_easeInAnimation);
        final Color _tileColor = _tileColorTween.evaluate(_easeInAnimation);

        return

          CollapsedTile(
            tileWidth: widget.tileWidth,
            collapsedHeight: SubGroupTile.collapsedTileHeight,
            tileColor: _tileColor,
            corners: Ratioz.appBarCorner,
            firstHeadline: widget.subGroupName,
            secondHeadline: widget.subGroupSecondName,
            icon: widget.subGroupIcon,
            arrowColor: _headlineColor,
            arrowTurns: _arrowTurns,
            toggleExpansion: toggle,
            expandableHeightFactorAnimationValue: _easeInAnimation.value,
            child: child,
          );

      },

      /// SUB GROUP KEYWORDS : Expanded tile children
      child:
      closed == true ? null
          :
      /// subGroup keywords
      KeywordsButtonsList(
          buttonWidth: widget.tileWidth,
          keywords:  widget.keywords,
          onKeywordTap: widget.onKeywordTap,
      ),

    );

  }
}