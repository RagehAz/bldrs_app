import 'package:bldrs/controllers/localization/localizer.dart';
import 'package:bldrs/controllers/localization/lingo.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/groups.dart';
import 'package:bldrs/models/secondary_models/namez_model.dart';
import 'package:bldrs/views/widgets/keywords/collapsed_tile.dart';
import 'package:bldrs/views/widgets/keywords/keywords_buttons_list.dart';
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

  static const double collapsedGroupHeight = ((Ratioz.appBarCorner + Ratioz.appBarMargin) * 2) + Ratioz.appBarMargin;
  static const double arrowBoxSize = SubGroupTile.arrowBoxSize;

  @override
  GroupTileState createState() => new GroupTileState();
}

class GroupTileState extends State<GroupTile> with SingleTickerProviderStateMixin {
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
      if (widget.onGroupTap != null) {
        widget.onGroupTap(_isExpanded);
      }
    }
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    //--------------------------------o
    _borderColor.end = Colorz.Green255;
    _headlineColorTween
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
    final bool _closed = _isExpanded == false && _controller.isDismissed == true;
    //------------------------------------------------------------o
    final double _iconSize = SubGroupTile.calculateTitleIconSize(icon: widget.icon);
    //------------------------------------------------------------o
    final String _groupID = widget.group.groupID;
    List<String> _subGroupsIDs = Keyword.getSubGroupsIDsFromKeywords(keywords: widget.group.keywords);
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
    final bool _appIsArabic = Localizer.appIsArabic(context);
    final String _groupFirstName = _appIsArabic == true ? _groupArabicName : _groupEnglishName;
    final String _groupSecondName = _appIsArabic == true ? _groupEnglishName : _groupArabicName;
    //------------------------------------------------------------o
    return new AnimatedBuilder(
      animation: _controller.view,
      builder: (context, child){

        /// final Color borderSideColor = _borderColor.evaluate(_easeOutAnimation) ?? Colors.transparent;
        /// final Color _subTitleLabelColor = _subtitleLabelColorTween.evaluate(_easeInAnimation);
        final Color _headlineColor = _headlineColorTween.evaluate(_easeInAnimation);
        final Color _tileColor = _tileColorTween.evaluate(_easeInAnimation);

        return

          CollapsedTile(
            tileWidth: widget.tileWidth,
            collapsedHeight: GroupTile.collapsedGroupHeight,
            tileColor: _tileColor,
            corners: Ratioz.appBarCorner + Ratioz.appBarMargin,
            firstHeadline: _groupFirstName,
            secondHeadline: _groupSecondName,
            icon: widget.icon,
            arrowColor: _headlineColor,
            arrowTurns: _arrowTurns,
            toggleExpansion: toggle,
            expandableHeightFactorAnimationValue: _easeInAnimation.value,
            child: child,
          );

      },

      /// SUB - GROUPS & KEYWORDS : Expanded tile children
      child: _closed == true ? null
          :
      Container(
        width: widget.tileWidth,
        child: ListView.builder(
            padding: const EdgeInsets.only(bottom: Ratioz.appBarPadding),
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

              List<Keyword> _subGroupKeywords = Keyword.getKeywordsBySubGroupIDFromKeywords(keywords: widget.group.keywords, subGroupID: _subGroupID);

              return
              _subGroupID == '' ?

                  KeywordsButtonsList(
                      buttonWidth: widget.tileWidth - (Ratioz.appBarMargin * 2),
                      keywords: _subGroupKeywords,
                      onKeywordTap: widget.onKeywordTap,
                  )

                  :

                SubGroupTile(
                  tileWidth: widget.tileWidth - (Ratioz.appBarMargin * 2),
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

    );

  }
}