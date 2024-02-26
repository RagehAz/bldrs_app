part of map_tree;

class _MapTreeStrip extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _MapTreeStrip({
    required this.width,
    required this.level,
    required this.nodeKey,
    required this.nodeValue,
    required this.onTriggerExpansion,
    required this.searchValue,
    required this.isTop,
    required this.isBottom,
    required this.onLastNodeTap,
    required this.onExpandableNodeTap,
    required this.isSelected,
    required this.myParentIsLastNode,
    required this.myGranpaIsLastNode,
    required this.keywordsMap,
    required this.path,
    this.keyWidth,
    this.expanded,
  });
  /// --------------------------------------------------------------------------
  final double width;
  final double? keyWidth;
  final int level;
  final String nodeKey;
  final dynamic nodeValue;
  final Function? onTriggerExpansion;
  final Function onLastNodeTap;
  final Function onExpandableNodeTap;
  final bool? expanded;
  final ValueNotifier<dynamic>? searchValue;
  final bool isTop;
  final bool isBottom;
  final bool isSelected;
  final bool myParentIsLastNode;
  final bool myGranpaIsLastNode;
  final Map<String, dynamic>? keywordsMap;
  final String path;
  /// --------------------------------------------------------------------------
  static const double stripHeight = 40;
  // -----------------------------------------------------------------------------
  /*
  static const Color expandedColor = Colorz.nothing;
  static const Color collapsedColor = Colorz.nothing;
   */
  // -------------------------
  /*
  static Color getStripColor({
    required bool hasSons,
    required bool expanded,
    required bool forceCollapsedColor,
    required int level,
  }){

    if (forceCollapsedColor == true){
      return collapsedColor;
    }
    else {

      if (hasSons == true){

        if (expanded == true || level  > 1){
          return expandedColor;
        }

        else {
          return collapsedColor;
        }

      }

      else {

        if (level  > 1){
          return expandedColor;
        }
        else {
          return collapsedColor;
        }

      }

    }

  }
  // -------------------------
  static Color getStripLevelledColor({
    required Color stripColor,
    required int level,
  }){

    const int numberOfSteps = 7;
    const double _step = 100 / numberOfSteps;
    double _ratio = 100 - (_step * level);
    _ratio = _ratio < 0 ? 0 : _ratio;
    _ratio = _ratio * 0.5;

    return Color.fromRGBO(
      stripColor.red,
      stripColor.green,
      stripColor.blue,
      _ratio / 100,
      // (100 - (15 * level)) * 0.8 / 100,
    );

  }
   */
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkLineIsBlank({
    required Map<String, dynamic>? keywordsMap,
    required int level,
    required String path,
    required int index,
  }){

    final bool _isFirstLevel = index == 0;
    final bool _isLastLevel = index + 1 == level - 1;
    final bool _isMiddleLine = _isFirstLevel == false &&  _isLastLevel == false;

    bool _condition = false;

    if (level == 4){
      final bool _a = MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(
          map: keywordsMap,
          path: path
      ) && _isFirstLevel;

      final bool _b = MapPathing.checkMyParentIsLastKeyAmongUncles(
          map: keywordsMap,
          path: path
      ) && _isMiddleLine;

      _condition = _a || _b;
    }

    if (level == 3){
      final bool _a = MapPathing.checkMyParentIsLastKeyAmongUncles(
          map: keywordsMap,
          path: path
      ) && _isFirstLevel;
      _condition = _a;
    }

    return _condition;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    /// --------------------
    // final Color _stripColor = getStripColor(
    //   expanded: Mapper.boolIsTrue(expanded),
    //   forceCollapsedColor: onTriggerExpansion == null,
    //   hasSons: _hasSons,
    //   level: level,
    // );
    /// --------------------
    final bool _hasSons = MapPathing.checkNodeHasSons(
      nodeValue: nodeValue,
    );
    // --------------------
    /// LEVELLER SPACE
    const double _levelSpacing = stripHeight * 0.5;
    final double _levellerBoxWidth = _levelSpacing * level;
    // --------------------
    /// KEYWORD BUTTON SPACE
    final double _keyButtonMaxWidth = width - _levellerBoxWidth;
    // const double _textMarginValue = stripHeight * 0.2;
    // final double _textMaxWidth = _keyButtonMaxWidth - stripHeight - _levelSpacing - (_textMarginValue * 2);
    // --------------------
    final bool _appIsLTR = UiProvider.checkAppIsLeftToRight();
    // --------------------
    final bool _isLastNode = _hasSons == false || onTriggerExpansion == null;
    final bool showArrow = !_isLastNode;
    // --------------------
    return SizedBox(
      key: const ValueKey<String>('keyword_map_tree_strip'),
      width: width,
      height: stripHeight,
      // color: getStripLevelledColor(
      //   level: level,
      //   stripColor: _stripColor,
      // ),
      // margin: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: <Widget>[

          /// LEVEL PADDING + ARROW BOX
          GestureDetector(
            onTap: () => onTriggerExpansion?.call(),
            child: Container(
              width: _levellerBoxWidth,
              height: stripHeight,
              alignment: BldrsAligners.superInverseCenterAlignment(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                  ...List.generate(level - 1, (index){

                    final bool _isLastLevel = index + 1 == level - 1;

                    final bool _lineIsBlank = checkLineIsBlank(
                      path: path,
                      keywordsMap: keywordsMap,
                      level: level,
                      index: index,
                    );

                    return SizedBox(
                      width: _levelSpacing,
                      height: stripHeight,
                      // color: _lineIsBlank == true ? Colorz.bloodTest : Colorz.nothing,
                      child: _TreeLine(
                        isBlank: _lineIsBlank,
                        width: _levelSpacing,
                        // height: stripHeight,
                        isBottom: isBottom,
                        isTop: isTop,
                        horizontalLineTopMarginRatioOfHeight: 0.5,
                        verticalLineSideMarginRatioOfWidth: 0.5,
                        onlyVertical: _isLastLevel == false,
                        lineThickness: 1,
                        isLTR: _appIsLTR,
                        lineColor: Colorz.white50,
                      ),
                    );
                  }),

                  /// ARROW
                  if (showArrow == true)
                    Container(
                      width: stripHeight * 0.5,
                      height: stripHeight,
                      alignment: Alignment.center,
                      // color: Colorz.white20,
                      child: BldrsBox(
                        width: stripHeight*0.5,
                        height: stripHeight*0.5,
                        // color: Colorz.white20,
                        icon: Mapper.boolIsTrue(expanded) == true ?
                        Iconz.arrowDown
                            :
                        Iconizer.superArrowENRight(context),
                        iconSizeFactor: stripHeight * 0.012,
                        bubble: false,
                      ),
                    ),

                  /// DOT
                  if (showArrow == false)
                    const BldrsBox(
                      width: stripHeight * 0.5,
                      height: stripHeight * 0.5,
                      icon: Iconz.circleDot,
                      iconColor: Colorz.white30,
                      iconSizeFactor: 0.8,
                      bubble: false,
                    ),

                ],
              ),
            ),
          ),

          /// KEYWORD
          Builder(
            builder: (context) {

              const double _buttonHeight = stripHeight * 0.9;
              final double _width = _keyButtonMaxWidth - 10;
              final Color _buttonColor = isSelected == true ?
              Colorz.yellow125
                  :
              _isLastNode == true ?
              Colorz.white30
                  :
              Colorz.white20
              ;

              /// MIDDLE NODE
              if (_isLastNode == false){
                return BldrsBox(
                  maxWidth: _width,
                  height: _buttonHeight,
                  corners: Borderers.constantCornersAll10,
                  verse: Verse.plain(nodeKey),
                  bubble: false,
                  verseScaleFactor: _buttonHeight * (0.027 - (0.0015 * level)),
                  verseWeight: _isLastNode == true ? VerseWeight.thin : VerseWeight.bold,
                  verseItalic: !_isLastNode,
                  color: _buttonColor,
                  verseHighlight: searchValue,
                  onTap: onExpandableNodeTap,
                );
              }

              /// LAST NODE
              else {
                return DataStrip(
                  dataKey: nodeKey,
                  dataValue: nodeValue,
                  width: _width,
                  height: _buttonHeight,
                  color: _buttonColor,
                  onKeyTap: onLastNodeTap,
                  onValueTap: onLastNodeTap,
                  highlightText: searchValue,
                );
              }

            }
          ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
