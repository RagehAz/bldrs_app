import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/keywords/keyword_button.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SelectedKeywordsBar extends StatelessWidget {
  final List<KW> selectedKeywords;
  final ItemScrollController scrollController;
  final ItemPositionsListener itemPositionListener;
  final KW highlightedKeyword;
  final Function removeKeyword;

  const SelectedKeywordsBar({
    @required this.selectedKeywords,
    @required this.scrollController,
    @required this.itemPositionListener,
    @required this.highlightedKeyword,
    @required this.removeKeyword,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    const double _selectedKeywordsZoneHeight = 80;

    final String _screenTitle =
    selectedKeywords.isEmpty ? 'Select keywords' :
    selectedKeywords.length == 1 ? '1 Selected keyword' :
    '${selectedKeywords.length} Selected keywords';

    final EdgeInsets _barPadding = appIsLeftToRight(context) == true ?
    const EdgeInsets.only(left: Ratioz.appBarPadding, right: _selectedKeywordsZoneHeight)
        :
    const EdgeInsets.only(left: _selectedKeywordsZoneHeight, right: Ratioz.appBarPadding)
    ;

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
            height: (_selectedKeywordsZoneHeight * 0.7),

            child:
            selectedKeywords.isEmpty ?
            Container()
                :
            ScrollablePositionedList.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemScrollController: scrollController,
              scrollDirection: Axis.horizontal,
              itemPositionsListener: itemPositionListener,
              itemCount: selectedKeywords.length,
              padding: _barPadding,
              itemBuilder: (BuildContext ctx, int index){

                final KW _keyword = index >= 0 ? selectedKeywords[index] : null;

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

                print('_keywords.length : ${selectedKeywords.length}');
                print('index : $index');

                return

                  _keyword == null ?
                  Container(
                    // width: 10,
                    height: 10,
                    color: Colorz.yellow20,
                    child: const SuperVerse(
                      verse : '.....',
                    ),
                  )
                      :
                  KeywordBarButton(
                    keyword: _keyword,
                    xIsOn: true,
                    onTap: () => removeKeyword(index),
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
