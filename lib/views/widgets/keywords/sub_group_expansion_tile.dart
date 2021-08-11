import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/localization/localizer.dart';
import 'package:bldrs/controllers/localization/lingo.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/groups.dart';
import 'package:bldrs/models/secondary_models/namez_model.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
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
  static const double buttonHeight = 50;
  static const double buttonVerticalPadding = Ratioz.appBarPadding;
  static const double titleHeight = 25;
  static const double collapsedTileHeight = buttonHeight;

// -----------------------------------------------------------------------------
  static double calculateButtonExtent(){
    return buttonHeight + buttonVerticalPadding;
  }

  static double calculateTitleIconSize({String subGroupIcon}){
     final double _iconSize = subGroupIcon == null ? 0 : 40;
     return _iconSize;
  }
// -----------------------------------------------------------------------------
  static double calculateTitleBoxWidth({double tileWidth, String subGroupIcon}){
    final double _iconSize = calculateTitleIconSize(subGroupIcon: subGroupIcon);
    final double _titleZoneWidth = tileWidth - _iconSize - SubGroupTile.collapsedTileHeight;
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
    ( ( buttonHeight + buttonVerticalPadding ) * _totalNumberOfButtons)
        +
        /// subGroups titles boxes heights
        (titleHeight)
        +
        /// bottom padding
        0;

    return _maxHeight;
  }
// -----------------------------------------------------------------------------
  static double calculateButtonsTotalHeight({List<Keyword> keywords}){
    final double _totalButtonsHeight = (buttonHeight + buttonVerticalPadding) * numberOfButtons(keywords: keywords);
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
  Animation<double> _iconTurns;
  bool _isExpanded = false;
  static const Duration _kExpand = const Duration(milliseconds: 200);
  PageController _pageController;
  List<String> _groupsIDs = new List();
  String _currentGroupID;
  List<Keyword> _currentKeywordModels = new List();
// -----------------------------------------------------------------------------
  @override
  void initState() {
    // _groupsIDs = Keyword.getGroupsIDsFromGroup(widget.group);

    super.initState();
    _controller = new AnimationController(duration: _kExpand, vsync: this);
    _easeOutAnimation = new CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _easeInAnimation = new CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _borderColor = new ColorTween();
    _titleColorTween = new ColorTween();
    _tileColorTween = new ColorTween();
    _subtitleLabelColorTween = new ColorTween();
    _iconTurns = new Tween<double>(begin: 0.0, end: 0.5).animate(_easeInAnimation);
    _borderRadius = BorderRadiusTween();
    _pageController = PageController();
    _isExpanded = PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded)
      _controller.value = 1.0;
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
//   void _setKeywords(String groupID){
//     setState(() {
//       _currentKeywordModels = Keyword.getKeywordsByGroupIDFomGroup(group: widget.group, groupID: groupID);
//     });
//   }
// -----------------------------------------------------------------------------
  void _selectGroup(String groupID){
    setState(() {
      _currentGroupID = groupID;
    });
  }
// -----------------------------------------------------------------------------
//   List<String> _getSubGroupsIDs(){
//     List<String> _subGroupsIDs = new List();
//
//     for (Keyword keyword in widget.group.keywords){
//       if(!_subGroupsIDs.contains(keyword.subGroupID)){
//         _subGroupsIDs.add(keyword.subGroupID);
//       }
//     }
//
//     return _subGroupsIDs;
//   }
// -----------------------------------------------------------------------------
//   List<Keyword> _getKeywordBySubGroup(String subGroupID){
//     List<Keyword> _keywords = new List();
//
//     for (Keyword keyword in widget.group.keywords){
//       if(keyword.subGroupID == subGroupID){
//         _keywords.add(keyword);
//       }
//     }
//
//     return _keywords;
//   }
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
    final double _iconSize = SubGroupTile.calculateTitleIconSize(subGroupIcon: widget.subGroupIcon);
    final double _titleBoxWidth = SubGroupTile.calculateTitleBoxWidth(
        tileWidth: widget.tileWidth,
        subGroupIcon: widget.subGroupIcon
    );
    //------------------------------------------------------------o
    return new AnimatedBuilder(
      animation: _controller.view,
      /// Collapsed Tile
      builder: (context, child){

        // final Color borderSideColor = _borderColor.evaluate(_easeOutAnimation) ?? Colors.transparent;
        final Color _titleColor = _titleColorTween.evaluate(_easeInAnimation);
        final Color _tileColor = _tileColorTween.evaluate(_easeInAnimation);
        final Color _subTitleLabelColor = _subtitleLabelColorTween.evaluate(_easeInAnimation);

        return

          Container(
            width: widget.tileWidth,
            margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding, horizontal: Ratioz.appBarMargin),
            decoration: BoxDecoration(
              color: _tileColor,
              borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                /// COLLAPSED ZONE
                GestureDetector(
                  onTap: toggle,
                  child: Container(
                    width: widget.tileWidth,
                    // height: _tileMinHeight,
                    // color: Colorz.Yellow200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        /// Icon
                        if (widget.subGroupIcon != null)
                          DreamBox(
                            height: SubGroupTile.collapsedTileHeight,
                            width: _iconSize,
                            icon: widget.subGroupIcon,
                          ),

                        /// Tile title
                        Container(
                          width: _titleBoxWidth,
                          height: SubGroupTile.collapsedTileHeight,
                          color: Colorz.Nothing,
                          padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin * 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              SuperVerse(
                                verse: widget.subGroupName,
                                weight: VerseWeight.bold,
                                italic: false,
                                size: 2,
                              ),

                              SuperVerse(
                                verse: widget.subGroupSecondName,
                                weight: VerseWeight.thin,
                                italic: true,
                                size: 1,
                                color: Colorz.White125,
                              ),

                            ],
                          ),
                        ),

                        /// Arrow
                        new RotationTransition(
                          turns: _iconTurns,
                          child: DreamBox(
                            height: SubGroupTile.collapsedTileHeight,
                            width: SubGroupTile.collapsedTileHeight,
                            bubble: false,
                            icon: Iconz.ArrowDown,
                            iconSizeFactor: 0.3,
                            iconColor: _titleColor,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                /// EXPANDABLE ZONE
                ClipRRect(
                  // borderRadius: _borderRadius.evaluate(_easeInAnimation),
                  child: new Align(
                    heightFactor: _easeInAnimation.value,
                    child: child,
                  ),
                ),

              ],
            ),
          );

      },

      /// SUB GROUP KEYWORDS : Expanded tile children
      child:
      closed == true ? null
          :
      Container(
        width: widget.tileWidth,
        margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding, horizontal: 0),
        child: Column(
          children: <Widget>[

            /// subGroup keywords
            Container(
              width: widget.tileWidth,
              height: SubGroupTile.calculateButtonsTotalHeight(keywords: widget.keywords),
              // color: Colorz.BloodTest,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.keywords.length,
                itemExtent: SubGroupTile.buttonHeight + Ratioz.appBarPadding,
                shrinkWrap: true,
                itemBuilder: (ctx, keyIndex){

                  Keyword _keyword = widget.keywords[keyIndex];
                  String _keywordID = _keyword.keywordID;
                  String _icon = Keyword.getImagePath(_keyword);
                  String _keywordName = Keyword.getKeywordNameByKeywordID(context, _keywordID);
                  String _keywordNameArabic = Keyword.getKeywordArabicName(_keyword);

                  return

                  DreamBox(
                      height: SubGroupTile.buttonHeight,
                      width: widget.tileWidth - (Ratioz.appBarMargin * 2),
                      icon: _icon,
                      verse: _keywordName,
                      secondLine: '$_keywordNameArabic',
                      verseScaleFactor: 0.7,
                      verseCentered: false,
                      bubble: false,
                      color: Colorz.White20,
                      margins: const EdgeInsets.only(bottom: SubGroupTile.buttonVerticalPadding),
                      onTap: () async {await widget.onKeywordTap(_keyword);},
                    );
                },
              ),
            ),

          ],
        ),
      ),

    );

  }
}