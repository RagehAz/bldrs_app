import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/groups.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:flutter/material.dart';

class BldrsExpansionTile extends StatefulWidget {
  final String icon;
  final double iconSizeFactor;
  final Group group;
  final double height;
  final double tileWidth;
  final Function onKeywordTap;
  final Function onGroupTap;
  final ValueChanged<bool> onExpansionChanged;
  final bool initiallyExpanded;
  final List<Keyword> selectedKeywords;

  const BldrsExpansionTile({
    this.icon,
    this.tileWidth,
    this.iconSizeFactor = 1,
    @required this.group,
    @required this.selectedKeywords,
    this.height,
    @required this.onKeywordTap,
    @required this.onGroupTap,
    this.onExpansionChanged,
    this.initiallyExpanded: false,
    Key key,
  })
      : assert(initiallyExpanded != null),
        super(key: key);


  @override
  BldrsExpansionTileState createState() => new BldrsExpansionTileState();
}

class BldrsExpansionTileState extends State<BldrsExpansionTile> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  // CurvedAnimation _easeOutAnimation;
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
  List<String> _groupsIDs = [];
  String _currentGroupID;
  List<Keyword> _currentKeywords = [];
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _groupsIDs = Keyword.getGroupsIDsFromGroup(widget.group);

    _controller = new AnimationController(duration: _kExpand, vsync: this);
    // _easeOutAnimation = new CurvedAnimation(parent: _controller, curve: Curves.easeOut);
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
    _currentKeywords = Keyword.getKeywordsByGroupIDFomGroup(group: widget.group, groupID: groupID);
    });
  }
// -----------------------------------------------------------------------------
  void _selectGroup(String groupID){
    setState(() {
      _currentGroupID = groupID;
    });
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

    return new AnimatedBuilder(
      animation: _controller.view,

      /// Collapsed Tile
      builder: (context, child){

        // final Color borderSideColor = _borderColor.evaluate(_easeOutAnimation) ?? Colors.transparent;
        final double _iconSize = 40;
        final Color _titleColor = _titleColorTween.evaluate(_easeInAnimation);
        final Color _tileColor = _tileColorTween.evaluate(_easeInAnimation);
        final Color _subTitleLabelColor = _subtitleLabelColorTween.evaluate(_easeInAnimation);

        return

          Container(
            margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
            decoration: BoxDecoration(
              color: _tileColor,
              borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner),
            ),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                IconTheme.merge(
                  data: new IconThemeData(color: _tileColorTween.evaluate(_easeInAnimation)),
                  child: new ListTile(
                    onTap: toggle,
                    leading: widget.icon == null ? null : DreamBox(
                      height: _iconSize,
                      width: _iconSize,
                      icon: widget.icon,
                      iconSizeFactor: widget.iconSizeFactor,
                    ),

                    /// FILTER TITLE
                    title: SuperVerse(
                      verse: widget.group.groupID,
                      color: _titleColor,
                      centered: false,
                      shadow: false,
                    ),

                    /// FILTER SUBTITLE
                    subtitle: SuperVerse(
                      verse: widget.group.groupID,
                      color: _isExpanded ? Colorz.White200 : Colorz.White125,
                      weight: VerseWeight.thin,
                      italic: true,
                      size: 2,
                      centered: false,
                      labelColor: _subTitleLabelColor,
                    ),
                    trailing: new RotationTransition(
                      turns: _iconTurns,
                      child: DreamBox(
                        height: _iconSize,
                        width: _iconSize,
                        bubble: false,
                        icon: Iconz.ArrowDown,
                        iconSizeFactor: 0.3,
                        iconColor: _titleColor,
                      ),
                    ),
                  ),
                ),

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
        height: widget.height == null ? (_buttonExtent * _groupsIDs.length).toDouble() : widget.height,
        decoration: BoxDecoration(
          color: Colorz.White10,
          borderRadius: _borderRadius.evaluate(_easeInAnimation), //Borderers.superBorderAll(context, Ratioz.ddAppBarCorner - 5),
        ),
        margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding, horizontal: 0),
        child: PageView(
          physics: const BouncingScrollPhysics(),
          controller: _pageController,

          children: <Widget>[

            /// GROUPS LIST : first list page
            new ListView(
              physics: const BouncingScrollPhysics(),
              itemExtent: _buttonExtent,

              children: <Widget>[

                ...List.generate(_groupsIDs.length, (index){

                  String _groupID = _groupsIDs[index];
                  bool _groupIsSelected = _currentGroupID == _groupID;

                  return
                    Align(
                      alignment: Alignment.center,
                      child: DreamBox(
                        height: _buttonHeight,
                        width: widget.tileWidth, //Scale.superScreenWidth(context) - Ratioz.appBarMargin * 4,
                        color: _groupIsSelected ? Colorz.Yellow255 : Colorz.Nothing,
                        verse: _groupID,
                        secondLine: _groupID,
                        verseColor: _groupIsSelected ? Colorz.Black230 : Colorz.White255,
                        verseWeight: _groupIsSelected ? VerseWeight.bold : VerseWeight.thin,
                        verseItalic: false,
                        verseScaleFactor: 0.7,
                        // icon: KeywordModel.getImagePath(_groupsIDs[index]),
                        iconSizeFactor: 1,
                        iconColor: Colorz.Black230,
                        margins: const EdgeInsets.symmetric(horizontal: 0, vertical: _buttonVerticalPadding),
                        onTap: (){

                          if (_groupIsSelected){
                            // do nothing
                          } else {

                            _selectGroup(_groupID);

                            _setKeywords(_groupID);

                            _pageController.nextPage(duration: _kExpand, curve: Curves.easeIn);
                          }

                          // _expansionTileKey.currentState.collapse();
                        },
                      ),
                    );
                }
                ),

              ],
            ),

            /// KEYWORDS LIST : SECOND LIST PAGE
            Container(
              decoration: BoxDecoration(
                borderRadius: _borderRadius.evaluate(_easeInAnimation),
                // color: Colorz.BloodTest,
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                itemExtent: _buttonExtent,
                children: <Widget>[

                  ...List.generate(_currentKeywords.length, (index){

                    Keyword _keyword = _currentKeywords[index];
                    bool _keywordIsSelected = widget.selectedKeywords.contains(_keyword);

                    List<String> _subGroups = [];

                    _currentKeywords.forEach((keyword) {
                      if(!_subGroups.contains(keyword.groupID)){
                        _subGroups.add(keyword.groupID);
                      }
                    });


                    return


                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          /// SUB GROUP TITLE
                          Container(
                            width: _buttonHeight,
                            height: _buttonHeight,
                            color: Colorz.BloodTest,
                          ),

                          /// SPACER
                          SizedBox(
                            width: Ratioz.appBarMargin,
                          ),

                          /// KEYWORDS
                          DreamBox(
                            height: _buttonHeight,
                            width: widget.tileWidth * 0.4,//Scale.superScreenWidth(context) - Ratioz.appBarMargin * 4 - _buttonHeight - Ratioz.appBarMargin,
                            color: _keywordIsSelected ? Colorz.Yellow255 : Colorz.Nothing,
                            verse: _keyword.keywordID,
                            secondLine: _keyword.keywordID,
                            verseColor: _keywordIsSelected ? Colorz.Black230 : Colorz.White255,
                            verseWeight: _keywordIsSelected ? VerseWeight.bold : VerseWeight.thin,
                            verseItalic: false,
                            verseScaleFactor: 0.7,
                            icon: Keyword.getImagePath(_keyword),
                            iconSizeFactor: 1,
                            iconColor: Colorz.Black230,
                            margins: const EdgeInsets.symmetric(horizontal: 0, vertical: _buttonVerticalPadding),
                            onTap: (){
                              widget.onKeywordTap(_currentKeywords[index]);
                            },
                          ),
                        ],
                      );
                  }
                  ),

                ],
              ),
            ),

          ],
        ),
      ),

    );

  }
}