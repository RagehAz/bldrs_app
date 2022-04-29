import 'package:bldrs/b_views/z_components/keywords/keyword_button.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/text_directionerz.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SelectedKeywordsBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SelectedKeywordsBar({
    @required this.selectedKeywordsIDs,
    @required this.scrollController,
    @required this.itemPositionListener,
    @required this.highlightedKeywordID,
    @required this.removeKeyword,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<String> selectedKeywordsIDs;
  final ItemScrollController scrollController;
  final ItemPositionsListener itemPositionListener;
  final String highlightedKeywordID;
  final ValueChanged<String> removeKeyword;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    const double _selectedKeywordsZoneHeight = 80;

    final String _screenTitle = selectedKeywordsIDs.isEmpty ?
    'Select keywords'
        :
    selectedKeywordsIDs.length == 1 ?
    '1 Selected keyword'
        :
    '${selectedKeywordsIDs.length} Selected keywords';

    final EdgeInsets _barPadding = appIsLeftToRight(context) == true ?
    const EdgeInsets.only(
        left: Ratioz.appBarPadding,
        right: _selectedKeywordsZoneHeight
    )
        :
    const EdgeInsets.only(
        left: _selectedKeywordsZoneHeight,
        right: Ratioz.appBarPadding
    );

    const double _yellowLineHeight = 1;

    return Container(
      width: _screenWidth,
      height: _selectedKeywordsZoneHeight,
      color: Colorz.white10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// Selected keywords Title
          Container(
            width: _screenHeight,
            height: (_selectedKeywordsZoneHeight * 0.3) - _yellowLineHeight,
            padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
            child: SuperVerse(
              verse: _screenTitle,
              size: 1,
              centered: false,
            ),
          ),

          /// Selected keywords
          SizedBox(
            width: _screenWidth,
            height: _selectedKeywordsZoneHeight * 0.7,
            child: selectedKeywordsIDs.isEmpty ?
            Container()
                :
            ScrollablePositionedList.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemScrollController: scrollController,
              scrollDirection: Axis.horizontal,
              itemPositionsListener: itemPositionListener,
              itemCount: selectedKeywordsIDs.length,
              padding: _barPadding,
              itemBuilder: (BuildContext ctx, int index) {

                final String _keyword = index >= 0 ?
                selectedKeywordsIDs[index]
                    :
                null;

                // final bool _highlightedMapIsCity =
                      // highlightedKeyword == null ? false
                      //     :
                      // highlightedKeyword.flyerType == 'cities' ? true
                      //     : false;

                      // const bool _isHighlighted = false;
                      // _highlightedMapIsCity == true && _keyword.flyerType == 'cities'? true
                      //     :
                      // _highlightedMapIsCity == true && _keyword.flyerType == 'area'? true
                      //     :
                      // Keyword.KeywordsAreTheSame(highlightedKeyword, _keyword) == true ? true
                      //     :
                      // false;

                // blog('_keywords.length : ${selectedKeywordsIDs.length}');
                // blog('index : $index');

                return _keyword == null ?
                Container(
                  // width: 10,
                  height: 10,
                  color: Colorz.yellow20,
                  child: const SuperVerse(
                    verse: '.....',
                  ),
                )

                    :

                KeywordBarButton(
                  keywordID: _keyword,
                  xIsOn: true,
                  onTap: () => removeKeyword(_keyword),
                );

                },
            ),
          ),

          /// yellow line
          Container(
            width: _screenWidth,
            height: _yellowLineHeight,
            color: Colorz.yellow50,
          ),

        ],
      ),
    );
  }
}
