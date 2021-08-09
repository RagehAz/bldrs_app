import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/localization/localizer.dart';
import 'package:bldrs/controllers/localization/lingo.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/keys_set.dart';
import 'package:bldrs/models/secondary_models/namez_model.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:flutter/material.dart';

class OnePageExpansionTile extends StatefulWidget {
  final double tileWidth;
  final double tileMaxHeight;

  final String icon;
  final double iconSizeFactor;
  final KeysSet keysSet;
  final Function onKeywordTap;
  final Function onGroupTap;
  final ValueChanged<bool> onExpansionChanged;
  final bool initiallyExpanded;
  final List<Keyword> selectedKeywords;

  const OnePageExpansionTile({
    this.tileWidth,
    this.tileMaxHeight,

    this.icon,
    this.iconSizeFactor = 1,
    @required this.keysSet,
    @required this.selectedKeywords,
    @required this.onKeywordTap,
    @required this.onGroupTap,
    this.onExpansionChanged,
    this.initiallyExpanded: false,
    Key key,
  })
      : assert(initiallyExpanded != null),
        super(key: key);


  @override
  OnePageExpansionTileState createState() => new OnePageExpansionTileState();
}

class OnePageExpansionTileState extends State<OnePageExpansionTile> with SingleTickerProviderStateMixin {

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
    _groupsIDs = Keyword.getGroupsIDsFromKeysSet(widget.keysSet);

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
  void _setKeywords(String groupID){
    setState(() {
      _currentKeywordModels = Keyword.getKeywordsByGroupIDAndFilterModel(filterModel: widget.keysSet, groupID: groupID);
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

    for (Keyword keyword in widget.keysSet.keywords){
      if(!_subGroupsIDs.contains(keyword.subGroupID)){
        _subGroupsIDs.add(keyword.subGroupID);
      }
    }

    return _subGroupsIDs;
  }
// -----------------------------------------------------------------------------
  List<Keyword> _getKeywordBySubGroup(String subGroupID){
    List<Keyword> _keywords = new List();

    for (Keyword keyword in widget.keysSet.keywords){
      if(keyword.subGroupID == subGroupID){
        _keywords.add(keyword);
      }
    }

    return _keywords;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

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


    final bool closed = !_isExpanded && _controller.isDismissed;

    const double _buttonVerticalPadding = 5;
    const double _buttonHeight = 80;
    const double _buttonExtent = _buttonHeight + _buttonVerticalPadding * 2;

    List<String> _subGroupsIDs = _getSubGroupsIDs();

    return new AnimatedBuilder(
      animation: _controller.view,
      /// Collapsed Tile
      builder: (context, child){

        // final Color borderSideColor = _borderColor.evaluate(_easeOutAnimation) ?? Colors.transparent;
        final Color _titleColor = _titleColorTween.evaluate(_easeInAnimation);
        final Color _tileColor = _tileColorTween.evaluate(_easeInAnimation);
        final Color _subTitleLabelColor = _subtitleLabelColorTween.evaluate(_easeInAnimation);

        /// Collapsed parameters
        const double _tileMinHeight = 50;
        const double _tileOneMargin = Ratioz.appBarMargin;
        const double _tileOnePadding = Ratioz.appBarPadding;

        final double _iconSize = widget.icon == null ? 0 : 40;
        final double _arrowSize = _tileMinHeight;
        final double _titleZoneWidth = widget.tileWidth - _iconSize - _arrowSize;

        final String _groupID = widget.keysSet.groupID;
        final Namez _groupNamez = Keyword.getGroupNamezByGroupID(_groupID);

        final String _groupEnglishName = Name.getNameByLingoFromNames(
          context: context,
          names: _groupNamez.names,
          LingoCode: Lingo.English,
        );

        final String _groupArabicName = Name.getNameByLingoFromNames(
          context: context,
          names: _groupNamez.names,
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

                // Container(
                //   width: widget.tileWidth,
                //   color: Colorz.BloodTest,
                //   child: IconTheme.merge(
                //     data: new IconThemeData(color: _tileColorTween.evaluate(_easeInAnimation)),
                //     child: new ListTile(
                //
                //       onTap: toggle,
                //       leading: widget.icon == null ? null : DreamBox(
                //         height: _iconSize,
                //         width: _iconSize,
                //         icon: widget.icon,
                //         iconSizeFactor: widget.iconSizeFactor,
                //       ),
                //
                //       /// FILTER TITLE
                //       title: SuperVerse(
                //         verse: widget.keysSet.titleID,
                //         color: _titleColor,
                //         centered: false,
                //         shadow: false,
                //       ),
                //
                //       /// FILTER SUBTITLE
                //       subtitle: SuperVerse(
                //         verse: widget.keysSet.titleID,
                //         color: _isExpanded ? Colorz.White200 : Colorz.White125,
                //         weight: VerseWeight.thin,
                //         italic: true,
                //         size: 2,
                //         centered: false,
                //         labelColor: _subTitleLabelColor,
                //       ),
                //       trailing: new RotationTransition(
                //         turns: _iconTurns,
                //         child: DreamBox(
                //           height: _iconSize,
                //           width: _iconSize,
                //           bubble: false,
                //           icon: Iconz.ArrowDown,
                //           iconSizeFactor: 0.3,
                //           iconColor: _titleColor,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

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

      /// GROUPS & KEYWORDS : Expanded tile children
      child: closed ? null
          :
      Container(
        width: widget.tileWidth,
        height: widget.tileMaxHeight == null ? (_buttonExtent * _groupsIDs.length).toDouble() : widget.tileMaxHeight,
        decoration: BoxDecoration(
          color: Colorz.White10,
          borderRadius: _borderRadius.evaluate(_easeInAnimation), //Borderers.superBorderAll(context, Ratioz.ddAppBarCorner - 5),
        ),
        margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding, horizontal: 0),
        child: ListView.builder(
            padding: const EdgeInsets.only(top: Ratioz.appBarPadding),
            physics: const BouncingScrollPhysics(),
            itemCount: _subGroupsIDs.length,
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
                  Column(
                    children: <Widget>[

                      /// Sub group title
                      Container(
                        width: widget.tileWidth,
                        height: 25,
                        // color: Colorz.BloodTest,
                        padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
                        child: SuperVerse(
                          verse: _subGroupNameEN,
                          italic: true,
                          weight: VerseWeight.thin,
                          centered: false,
                          leadingDot: true,
                        ),
                      ),

                      /// subGroup keywords
                      Container(
                        width: widget.tileWidth,
                        height: (50 + Ratioz.appBarPadding) * _subGroupKeywords.length,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _subGroupKeywords.length,
                          itemExtent: 50 + Ratioz.appBarPadding,
                          itemBuilder: (ctx, keyIndex){

                            Keyword _keyword = _subGroupKeywords[keyIndex];
                            String _keywordID = _keyword.keywordID;
                            String _icon = Keyword.getImagePath(_keyword);
                            String _keywordName = Keyword.getKeywordNameByKeywordID(context, _keywordID);
                            String _keywordNameArabic = Keyword.getKeywordArabicName(_keyword);

                            return
                              DreamBox(
                                height: 50,
                                width: widget.tileWidth * 0.9,
                                icon: _icon,
                                verse: _keywordName,
                                secondLine: '$_keywordNameArabic',
                                verseScaleFactor: 0.7,
                                verseCentered: false,
                                bubble: false,
                                color: Colorz.White20,
                                margins: const EdgeInsets.only(bottom: Ratioz.appBarPadding),
                              );
                          },
                        ),
                      ),

                    ],
                  );
            }
        ),
      ),

    );

  }
}