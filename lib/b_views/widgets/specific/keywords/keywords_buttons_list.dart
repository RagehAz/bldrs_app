import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/secondary_models/name_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/chain_expander/components/unfinished_expanding_tile.dart';
import 'package:bldrs/d_providers/keywords_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeywordsButtonsList extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const KeywordsButtonsList({
    @required this.buttonWidth,
    @required this.keywords,
    @required this.onKeywordTap,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final double buttonWidth;
  final List<KW> keywords;
  final Function onKeywordTap;

  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final KeywordsProvider _keywordsProvider =
        Provider.of<KeywordsProvider>(context, listen: false);

    return Container(
      width: buttonWidth,
      height: ExpandingTile.calculateButtonsTotalHeight(keywords: keywords),
      margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: keywords.length,
        itemExtent: ExpandingTile.collapsedTileHeight + Ratioz.appBarPadding,
        shrinkWrap: true,
        itemBuilder: (BuildContext ctx, int keyIndex) {
          final KW _keyword = keywords[keyIndex];
          final String _icon =
              _keywordsProvider.getKeywordIcon(context: context, son: _keyword);
          final String _keywordName = KW.translateKeyword(context, _keyword);
          final String _keywordNameArabic = Name.getNameByLingoFromNames(names: _keyword.names, lingoCode: 'ar')?.value;

          return DreamBox(
            height: ExpandingTile.collapsedTileHeight,
            width: buttonWidth - (Ratioz.appBarMargin * 2),
            icon: _icon,
            verse: _keywordName,
            secondLine: _keywordNameArabic,
            verseScaleFactor: 0.7,
            verseCentered: false,
            bubble: false,
            color: Colorz.white20,
            margins: const EdgeInsets.only(
                bottom: ExpandingTile.buttonVerticalPadding),
            onTap: () async {
              await onKeywordTap(_keyword);
            },
          );
        },
      ),
    );
  }
}
