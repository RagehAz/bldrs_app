import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/keywords/sub_group_expansion_tile.dart';
import 'package:flutter/material.dart';

class KeywordsButtonsList extends StatelessWidget {
  final double buttonWidth;
  final List<Keyword> keywords;
  final Function onKeywordTap;

  const KeywordsButtonsList({
    @required this.buttonWidth,
    @required this.keywords,
    @required this.onKeywordTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth,
      height: SubGroupTile.calculateButtonsTotalHeight(keywords: keywords),
      margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding, horizontal: 0),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: keywords.length,
        itemExtent: SubGroupTile.collapsedTileHeight + Ratioz.appBarPadding,
        shrinkWrap: true,
        itemBuilder: (ctx, keyIndex){

          Keyword _keyword = keywords[keyIndex];
          String _keywordID = _keyword.keywordID;
          String _icon = Keyword.getImagePath(_keyword);
          String _keywordName = Keyword.getKeywordNameByKeywordID(context, _keywordID);
          String _keywordNameArabic = Keyword.getKeywordArabicName(_keyword);

          return

            DreamBox(
              height: SubGroupTile.collapsedTileHeight,
              width: buttonWidth - (Ratioz.appBarMargin * 2),
              icon: _icon,
              verse: _keywordName,
              secondLine: '$_keywordNameArabic',
              verseScaleFactor: 0.7,
              verseCentered: false,
              bubble: false,
              color: Colorz.White20,
              margins: const EdgeInsets.only(bottom: SubGroupTile.buttonVerticalPadding),
              onTap: () async {await onKeywordTap(_keyword);},
            );

        },
      ),
    );
  }
}
