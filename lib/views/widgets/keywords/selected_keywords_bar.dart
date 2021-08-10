import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/views/widgets/keywords/keyword_button.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SelectedKeywordsBar extends StatelessWidget {
  final List<Keyword> selectedKeywords;
  final ItemScrollController scrollController;
  final ItemPositionsListener itemPositionListener;
  final Keyword highlightedKeyword;
  final Function removeKeyword;

  const SelectedKeywordsBar({
    @required this.selectedKeywords,
    @required this.scrollController,
    @required this.itemPositionListener,
    @required this.highlightedKeyword,
    @required this.removeKeyword,
});

  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    double _selectedKeywordsZoneHeight = 80;

    double _keywordsZoneHeight =  _screenHeight - Ratioz.stratosphere - _selectedKeywordsZoneHeight - Ratioz.appBarPadding;

    String _screenTitle =
    selectedKeywords.length == 0 ? 'Select keywords' :
    selectedKeywords.length == 1 ? '1 Selected keyword' :
    '${selectedKeywords.length} Selected keywords';

    EdgeInsets _barPadding = appIsLeftToRight(context) == true ?
    EdgeInsets.only(left: Ratioz.appBarPadding, right: _selectedKeywordsZoneHeight)
        :
    EdgeInsets.only(left: _selectedKeywordsZoneHeight, right: Ratioz.appBarPadding)
    ;

    return Container(
      width: _screenWidth,
      height: _selectedKeywordsZoneHeight,
      // margin: EdgeInsets.only(bottom: Ratioz.appBarPadding),
      color: Colorz.White10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// Selected keywords Title
          Container(
            width: _screenHeight,
            height: _selectedKeywordsZoneHeight * 0.3,
            padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
            child: SuperVerse(
              verse: _screenTitle,
              size: 1,
              weight: VerseWeight.bold,
              centered: false,
            ),
          ),

          /// Selected keywords
          Container(
            width: _screenWidth,
            height: _selectedKeywordsZoneHeight * 0.7,

            child:
            selectedKeywords.length == 0 ? Container() :
            ScrollablePositionedList.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemScrollController: scrollController,
              scrollDirection: Axis.horizontal,
              itemPositionsListener: itemPositionListener,
              itemCount: selectedKeywords.length,
              padding: _barPadding,
              itemBuilder: (ctx, index){

                Keyword _keyword = index >= 0 ? selectedKeywords[index] : null;

                bool _highlightedMapIsCity =
                highlightedKeyword == null ? false
                    :
                highlightedKeyword.flyerType == 'cities' ? true
                    : false;

                bool _isHighlighted =
                _highlightedMapIsCity == true && _keyword.flyerType == 'cities'? true
                    :
                _highlightedMapIsCity == true && _keyword.flyerType == 'area'? true
                    :
                Keyword.KeywordsAreTheSame(highlightedKeyword, _keyword) == true ? true
                    :
                false;

                print('_keywords.length : ${selectedKeywords.length}');
                print('index : $index');

                return

                  _keyword == null ?
                  Container(
                    // width: 10,
                    height: 10,
                    color: Colorz.Yellow20,
                    child: SuperVerse(
                      verse : '.....',
                    ),
                  )
                      :
                  KeywordBarButton(
                    keyword: _keyword,
                    xIsOn: true,
                    onTap: () => removeKeyword(index),
                    color: _isHighlighted == true ? Colorz.Red255 : Colorz.Blue80,
                  );

              },
            ),

          ),

        ],
      ),
    );
  }
}
