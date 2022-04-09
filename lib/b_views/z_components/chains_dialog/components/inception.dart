import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name.dart';
import 'package:bldrs/b_views/z_components/chains_dialog/components/chain_son_button.dart';
import 'package:bldrs/b_views/z_components/chains_dialog/chain_expander_structure/b_expanding_tile.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
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
    @required this.initiallyExpanded,
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
  final bool initiallyExpanded;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _offset = (2 * Ratioz.appBarMargin) * level;
    final double _screenWidth = Scale.superScreenWidth(context);
    const double _buttonHeight = buttonHeight;
    final double _boxWidth = boxWidth ?? _screenWidth - (2 * Ratioz.appBarMargin);
    final double _buttonWidth = _boxWidth - _offset - ((level + 1) * 30);

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

    /// IF SON IS A KEYWORD
    if (son is String) {

      final String _keywordID = son;

      final bool _isSelected = Mapper.stringsContainString(
          strings: selectedKeywordsIDs,
          string: _keywordID,
      );

      final Color _color = _isSelected == true ? Colorz.green255 : Colorz.white20;

      return ChainSonButton(
        phid: _keywordID,
        boxWidth: _boxWidth,
        level: level,
        onTap: () => onKeywordTap(_keywordID),
      );

      // return Container(
      //   width: _boxWidth,
      //   alignment: superInverseCenterAlignment(context),
      //   padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
      //   child: DreamBox(
      //     width: _buttonWidth,
      //     height: _buttonHeight,
      //     icon: _chainsProvider.getKeywordIcon(
      //         son: _keywordID,
      //         context: context,
      //     ),
      //     verse: superPhrase(context, _keywordID),
      //     verseScaleFactor: 0.7,
      //     verseCentered: false,
      //     color: _color,
      //     margins: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
      //     verseMaxLines: 2,
      //     onTap: () => onKeywordTap(_keywordID),
      //   ),
      // );

    }

    /// IF SON IS CHAIN OF KEYWORDS
    else if (son.runtimeType == Chain) {

      final Chain _chain = son;
      final List<dynamic> _sons = _chain.sons;

      return Container(
        width: _boxWidth,
        alignment: superInverseCenterAlignment(context),
        padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
        child: ExpandingTile(
          key: PageStorageKey<String>(_chain.id),
          icon: _chainsProvider.getKeywordIcon(son: son, context: context),
          width: _buttonWidth,
          collapsedHeight: _buttonHeight,
          firstHeadline: superPhrase(context, _chain.id),
          secondHeadline: null,
          margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
          initiallyExpanded: initiallyExpanded,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
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
                      initiallyExpanded: initiallyExpanded,
                    );
                  }),

            ],
          ),
        ),
      );
    }

    /// OTHERWISE
    else {
      return const BldrsName(size: 40);
    }

  }
}
