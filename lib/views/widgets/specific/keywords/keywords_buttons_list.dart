import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/providers/keywords_provider.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/expansion_tiles/expanding_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeywordsButtonsList extends StatelessWidget {
  final double buttonWidth;
  final List<KW> keywords;
  final Function onKeywordTap;

  const KeywordsButtonsList({
    @required this.buttonWidth,
    @required this.keywords,
    @required this.onKeywordTap,
  });

  @override
  Widget build(BuildContext context) {

    final KeywordsProvider _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);

    return Container(
      width: buttonWidth,
      height: ExpandingTile.calculateButtonsTotalHeight(keywords: keywords),
      margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding, horizontal: 0),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: keywords.length,
        itemExtent: ExpandingTile.collapsedTileHeight + Ratioz.appBarPadding,
        shrinkWrap: true,
        itemBuilder: (ctx, keyIndex){

          final KW _keyword = keywords[keyIndex];
          final String _icon = _keywordsProvider.getImagePath(_keyword);
          final String _keywordName = KW.translateKeyword(context, _keyword);
          final String _keywordNameArabic = Name.getNameByLingoFromNames(names: _keyword.names, lingoCode: 'ar');

          return

            DreamBox(
              height: ExpandingTile.collapsedTileHeight,
              width: buttonWidth - (Ratioz.appBarMargin * 2),
              icon: _icon,
              verse: _keywordName,
              secondLine: '$_keywordNameArabic',
              verseScaleFactor: 0.7,
              verseCentered: false,
              bubble: false,
              color: Colorz.white20,
              margins: const EdgeInsets.only(bottom: ExpandingTile.buttonVerticalPadding),
              onTap: () async {await onKeywordTap(_keyword);},
            );

        },
      ),
    );
  }
}
