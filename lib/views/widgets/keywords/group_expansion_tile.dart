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
import 'package:bldrs/views/widgets/keywords/sub_group_expansion_tile.dart';

class GroupTile extends StatefulWidget {
  final double tileWidth;
  final double tileMaxHeight;

  final bool scrollable;

  final String icon;
  final double iconSizeFactor;
  final Group group;
  final Function onKeywordTap;
  final ValueChanged<bool> onGroupTap;
  final bool initiallyExpanded;
  final List<Keyword> selectedKeywords;

  const GroupTile({
    this.tileWidth,
    this.tileMaxHeight,

    this.scrollable = true,

    this.icon,
    this.iconSizeFactor = 1,
    @required this.group,
    @required this.selectedKeywords,
    @required this.onKeywordTap,
    this.onGroupTap,
    this.initiallyExpanded: false,
  });


  @override
  GroupTileState createState() => new GroupTileState();
}

class GroupTileState extends State<GroupTile> with SingleTickerProviderStateMixin {

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
    _groupsIDs = Keyword.getGroupsIDsFromGroup(widget.group);

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
      if (widget.onGroupTap != null) {
        widget.onGroupTap(_isExpanded);
      }
    }
  }
// -----------------------------------------------------------------------------
  void _setKeywords(String groupID){
    setState(() {
      _currentKeywordModels = Keyword.getKeywordsByGroupIDFomGroup(group: widget.group, groupID: groupID);
    });
  }
// -----------------------------------------------------------------------------
  void _selectGroup(String groupID){
    setState(() {
      _currentGroupID = groupID;
    });
  }
// -----------------------------------------------------------------------------
  List<String> _getSubGroupsIDs(){
    List<String> _subGroupsIDs = new List();

    for (Keyword keyword in widget.group.keywords){
      if(!_subGroupsIDs.contains(keyword.subGroupID)){
        _subGroupsIDs.add(keyword.subGroupID);
      }
    }

    return _subGroupsIDs;
  }
// -----------------------------------------------------------------------------
  List<Keyword> _getKeywordBySubGroup(String subGroupID){
    List<Keyword> _keywords = new List();

    for (Keyword keyword in widget.group.keywords){
      if(keyword.subGroupID == subGroupID){
        _keywords.add(keyword);
      }
    }

    return _keywords;
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

    int _totalNumberOfButtons = widget.group.keywords.length;

    const double _buttonHeight = 50;
    const double _buttonVerticalPadding = Ratioz.appBarPadding;

    List<String> _subGroupsIDs = _getSubGroupsIDs();
    int _numberOfSubGroups = _subGroupsIDs.length;

    double _subGroupTitleHeight = 25;

    double _maxHeight =
    /// keywords heights
    ( ( _buttonHeight + (_buttonVerticalPadding) ) * _totalNumberOfButtons)
    +
    /// subGroups titles boxes heights
    (_subGroupTitleHeight * _numberOfSubGroups)
    +
    /// bottom padding
    Ratioz.appBarMargin
    ;
    //------------------------------------------------------------o
    return new AnimatedBuilder(
      animation: _controller.view,
      /// Collapsed Tile
      builder: (context, child){

        // final Color borderSideColor = _borderColor.evaluate(_easeOutAnimation) ?? Colors.transparent;
        final Color _titleColor = _titleColorTween.evaluate(_easeInAnimation);
        final Color _tileColor = _tileColorTween.evaluate(_easeInAnimation);
        final Color _subTitleLabelColor = _subtitleLabelColorTween.evaluate(_easeInAnimation);

        /// Collapsed parameters
        const double _tileMinHeight = _buttonHeight;
        const double _tileOneMargin = Ratioz.appBarMargin;
        const double _tileOnePadding = Ratioz.appBarPadding;

        final double _iconSize = widget.icon == null ? 0 : 40;
        final double _arrowSize = _tileMinHeight;
        final double _titleZoneWidth = widget.tileWidth - _iconSize - _arrowSize;

        final String _groupID = widget.group.groupID;
        final Namez _groupNamez = Keyword.getGroupNamezByGroupID(_groupID);

        final String _groupEnglishName = Name.getNameByLingoFromNames(
          context: context,
          names: _groupNamez?.names,
          LingoCode: Lingo.English,
        );

        final String _groupArabicName = Name.getNameByLingoFromNames(
          context: context,
          names: _groupNamez?.names,
          LingoCode: Lingo.Arabic,
        );//Lingo.getSecondL

        bool _appIsArabic = Localizer.appIsArabic(context);

        final String _groupFirstName = _appIsArabic == true ? _groupArabicName : _groupEnglishName;
        final String _groupSecondName = _appIsArabic == true ? _groupEnglishName : _groupArabicName;

        return

          Container(
            width: widget.tileWidth,
            // height: 70,
            margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding, horizontal: Ratioz.appBarMargin),
            decoration: BoxDecoration(
              color: _tileColor,
              borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner),
            ),
            child: new Column(
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
                        if (widget.icon != null)
                          DreamBox(
                            height: _tileMinHeight,
                            width: _iconSize,
                            icon: widget.icon,
                          ),

                        /// Tile title
                        Container(
                          width: _titleZoneWidth,
                          height: _tileMinHeight,
                          color: Colorz.Nothing,
                          padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin * 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              SuperVerse(
                                verse: _groupFirstName,
                                weight: VerseWeight.bold,
                                italic: false,
                                size: 2,
                              ),

                              SuperVerse(
                                verse: _groupSecondName,
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
                            height: _arrowSize,
                            width: _arrowSize,
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

      /// SUB - GROUPS & KEYWORDS : Expanded tile children
      child: closed == true ? null
          :
      Center(
        child: Container(
          width: widget.tileWidth,
          margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding, horizontal: 0),
          child: ListView.builder(
              padding: const EdgeInsets.only(top: Ratioz.appBarPadding),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _subGroupsIDs.length,
              shrinkWrap: true,
              itemBuilder: (xxx, _subIndex){

                String _subGroupID = _subGroupsIDs[_subIndex];
                String _subGroupNameEN = Keyword.getSubGroupNameBySubGroupIDAndLingoCode(
                  context: context,
                  subGroupID: _subGroupID,
                  lingoCode: Lingo.English,
                );
                String _subGroupNameAR = Keyword.getSubGroupNameBySubGroupIDAndLingoCode(
                  context: context,
                  subGroupID: _subGroupID,
                  lingoCode: Lingo.Arabic,
                );

                List<Keyword> _subGroupKeywords = _getKeywordBySubGroup(_subGroupID);

                return
                  SubGroupTile(
                    tileWidth: widget.tileWidth - (Ratioz.appBarMargin * 2),
                    // tileMaxHeight: ,
                    keywords: _subGroupKeywords,
                    onKeywordTap: widget.onKeywordTap,
                    subGroupName: _subGroupNameEN,
                    subGroupSecondName: _subGroupNameAR,
                    scrollable: false,
                    onExpansionChanged: null,
                  );

              }
          ),
        ),
      ),

    );

  }
}