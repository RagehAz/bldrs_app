import 'package:bldrs/b_views/i_chains/z_components/expander_button/b_expanding_tile.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeywordsButtonsList extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const KeywordsButtonsList({
    @required this.buttonWidth,
    @required this.keywordsIDs,
    @required this.onKeywordTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double buttonWidth;
  final List<String> keywordsIDs;
  final Function onKeywordTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final ChainsProvider _keywordsProvider = Provider.of<ChainsProvider>(context, listen: false);

    return Container(
      width: buttonWidth,
      height: ExpandingTile.calculateButtonsTotalHeight(keywordsIDs: keywordsIDs),
      margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: keywordsIDs.length,
        itemExtent: ExpandingTile.collapsedTileHeight + Ratioz.appBarPadding,
        shrinkWrap: true,
        // padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
        itemBuilder: (BuildContext ctx, int keyIndex) {

          final String _keywordID = keywordsIDs[keyIndex];
          final String _icon = _keywordsProvider.getPhidIcon(context: context, son: _keywordID);
          final String _keywordName = _keywordID;
          const String _keywordNameArabic = '##keyword name but in arabic';//Phrase.getPhraseByLangFromPhrases(phrases: _keywordID.names, langCode: 'ar')?.value;

          return DreamBox(
            height: ExpandingTile.collapsedTileHeight,
            width: buttonWidth - (Ratioz.appBarMargin * 2),
            icon: _icon,
            verse: Verse.plain(_keywordName),
            secondLine: Verse.plain(_keywordNameArabic),
            verseScaleFactor: 0.7,
            verseCentered: false,
            bubble: false,
            color: Colorz.white20,
            margins: const EdgeInsets.only(
                bottom: ExpandingTile.buttonVerticalPadding
            ),
            onTap: () async {
              await onKeywordTap(_keywordID);
            },
          );

        },
      ),
    );

  }
/// --------------------------------------------------------------------------
}
