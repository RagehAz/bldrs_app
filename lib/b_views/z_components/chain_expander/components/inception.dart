import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/chain_expander/components/unfinished_expanding_tile.dart';
import 'package:bldrs/d_providers/keywords_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Inception extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Inception({
    @required this.son,
    this.level = 0,
    this.boxWidth,
    this.onKeywordTap,
    this.selectedKeywordsIDs,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic son;
  final int level;
  final double boxWidth;
  final ValueChanged<String> onKeywordTap;
  final List<String> selectedKeywordsIDs;
  static const double buttonHeight = 60;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _offset = (2 * Ratioz.appBarMargin) * level;
    final double _screenWidth = Scale.superScreenWidth(context);
    const double _buttonHeight = buttonHeight;
    final double _boxWidth = boxWidth ?? _screenWidth - (2 * Ratioz.appBarMargin);
    final double _buttonWidth = _boxWidth - _offset;

    final KeywordsProvider _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);

    /// IF SON IS A KEYWORD
    if (son is String) {

      final String _keywordID = son;

      final bool _isSelected = Mapper.stringsContainString(
          strings: selectedKeywordsIDs,
          string: _keywordID,
      );

      final Color _color = _isSelected == true ? Colorz.green255 : Colorz.white20;

      return DreamBox(
        width: _buttonWidth,
        height: _buttonHeight,
        icon: _keywordsProvider.getKeywordIcon(son: _keywordID, context: context),
        verse: superPhrase(context, _keywordID),
        verseScaleFactor: 0.7,
        verseCentered: false,
        color: _color,
        margins: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
        onTap: () => onKeywordTap(_keywordID),
      );

    }

    /// IF SON IS CHAIN OF KEYWORDS
    else if (son.runtimeType == Chain) {

      final Chain _chain = son;
      final List<dynamic> _sons = _chain.sons;

      return ExpandingTile(
        key: PageStorageKey<String>(_chain.id),
        icon: _keywordsProvider.getKeywordIcon(son: son, context: context),
        width: _buttonWidth,
        collapsedHeight: _buttonHeight,
        firstHeadline: superPhrase(context, _chain.id),
        secondHeadline: null,
        margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
        child: Column(
          children: <Widget>[

            ListView.builder(
                itemCount: _sons.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  final dynamic _son = _sons[index];

                  return Inception(
                    son: _son,
                    level: level + 1,
                    boxWidth: _boxWidth,
                    selectedKeywordsIDs: selectedKeywordsIDs,
                    onKeywordTap: onKeywordTap,
                  );
                }),

            // ...List<Widget>.generate(_sons.length,
            //         (int index) {
            //       final dynamic _son = _sons[index];
            //
            //       return Inception(
            //         son: _son,
            //         level: level + 1,
            //         boxWidth: _boxWidth,
            //         selectedKeywordsIDs: selectedKeywordsIDs,
            //         onKeywordTap: onKeywordTap,
            //       );
            //     }
            // ),

          ],
        ),
      );
    }

    /// OTHERWISE
    else {
      return const BldrsName(size: 40);
    }

  }
}
