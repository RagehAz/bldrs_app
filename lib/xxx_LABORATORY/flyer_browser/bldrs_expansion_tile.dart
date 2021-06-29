import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/filter_model.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:flutter/material.dart';

class BldrsExpansionTile extends StatefulWidget {
  final String icon;
  final double iconSizeFactor;
  final FilterModel filterModel;
  final double height;
  final Function onKeywordTap;
  final Function onGroupTap;
  final ValueChanged<bool> onExpansionChanged;
  final bool initiallyExpanded;
  final List<KeywordModel> selectedKeywords;

  const BldrsExpansionTile({
    Key key,
    this.icon,
    this.iconSizeFactor = 1,
    @required this.filterModel,
    @required this.selectedKeywords,
    this.height,
    @required this.onKeywordTap,
    @required this.onGroupTap,
    this.onExpansionChanged,
    this.initiallyExpanded: false,
  })
      : assert(initiallyExpanded != null),
        super(key: key);


  @override
  BldrsExpansionTileState createState() => new BldrsExpansionTileState();
}

class BldrsExpansionTileState extends State<BldrsExpansionTile> with SingleTickerProviderStateMixin {
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
  List<KeywordModel> _currentKeywordModels = new List();
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _groupsIDs = KeywordModel.getGroupsIDsFromFilterModel(widget.filterModel);

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
    _currentKeywordModels = KeywordModel.getKeywordModelsByGroupID(filterModel: widget.filterModel, groupID: groupID);
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

    _borderColor.end = Colorz.Green;

    _titleColorTween
      ..begin = Colorz.White
      ..end = Colorz.White;

    _tileColorTween
      ..begin = Colorz.WhiteAir
      ..end = Colorz.BabyBlueSmoke;

    _subtitleLabelColorTween
      ..begin = Colorz.WhiteAir
      ..end = Colorz.WhiteAir;

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
                      verse: widget.filterModel.filterID,
                      color: _titleColor,
                      centered: false,
                      shadow: false,
                    ),

                    /// FILTER SUBTITLE
                    subtitle: SuperVerse(
                      verse: widget.filterModel.filterID,
                      color: _isExpanded ? Colorz.WhiteLingerie : Colorz.WhitePlastic,
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
          color: Colorz.WhiteAir,
          borderRadius: _borderRadius.evaluate(_easeInAnimation), //Borderers.superBorderAll(context, Ratioz.ddAppBarCorner - 5),
        ),
        margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding, horizontal: 0),
        child: PageView(
          controller: _pageController,

          children: <Widget>[

            /// GROUPS LIST : first list page
            new ListView(
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
                        width: Scale.superScreenWidth(context) - Ratioz.appBarMargin * 4,
                        color: _groupIsSelected ? Colorz.Yellow : Colorz.Nothing,
                        verse: _groupID,
                        secondLine: _groupID,
                        verseColor: _groupIsSelected ? Colorz.BlackBlack : Colorz.White,
                        verseWeight: _groupIsSelected ? VerseWeight.bold : VerseWeight.thin,
                        verseItalic: false,
                        verseScaleFactor: 0.7,
                        // icon: KeywordModel.getImagePath(_groupsIDs[index]),
                        iconSizeFactor: 1,
                        iconColor: Colorz.BlackBlack,
                        boxMargins: const EdgeInsets.symmetric(horizontal: 0, vertical: _buttonVerticalPadding),
                        boxFunction: (){

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
                itemExtent: _buttonExtent,
                children: <Widget>[

                  ...List.generate(_currentKeywordModels.length, (index){

                    KeywordModel _keyword = _currentKeywordModels[index];
                    bool _keywordIsSelected = widget.selectedKeywords.contains(_keyword);

                    List<String> _subGroups = new List();

                    _currentKeywordModels.forEach((keyword) {
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
                            width: Scale.superScreenWidth(context) - Ratioz.appBarMargin * 4 - _buttonHeight - Ratioz.appBarMargin,
                            color: _keywordIsSelected ? Colorz.Yellow : Colorz.Nothing,
                            verse: _keyword.name,
                            secondLine: _keyword.id,
                            verseColor: _keywordIsSelected ? Colorz.BlackBlack : Colorz.White,
                            verseWeight: _keywordIsSelected ? VerseWeight.bold : VerseWeight.thin,
                            verseItalic: false,
                            verseScaleFactor: 0.7,
                            icon: KeywordModel.getImagePath(_keyword.id),
                            iconSizeFactor: 1,
                            iconColor: Colorz.BlackBlack,
                            boxMargins: const EdgeInsets.symmetric(horizontal: 0, vertical: _buttonVerticalPadding),
                            boxFunction: (){
                              widget.onKeywordTap(_currentKeywordModels[index]);
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