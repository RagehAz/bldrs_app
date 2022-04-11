import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/parts/chain_expander/a_chain_expander_starter.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/parts/d_chain_son_button.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChainSonStarter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainSonStarter({
    @required this.son,
    @required this.initiallyExpanded,
    this.parentLevel = 0,
    this.sonWidth,
    this.onKeywordTap,
    this.selectedKeywordsIDs,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic son;
  final int parentLevel;
  final double sonWidth;
  final ValueChanged<String> onKeywordTap;
  final List<String> selectedKeywordsIDs;
  static const double buttonHeight = 60;
  final bool initiallyExpanded;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

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
        sonWidth: sonWidth,
        parentLevel: parentLevel,
        color: _color,
        // isDisabled: false,
        onTap: () => onKeywordTap(_keywordID),
      );

    }

    /// IF SON IS CHAIN OF KEYWORDS
    else if (son.runtimeType == Chain) {

      final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
      final Chain _chain = son;

      return ChainExpanderStarter(
        key: PageStorageKey<String>(_chain.id),
        chain: _chain,
        boxWidth: sonWidth,
        icon: _chainsProvider.getKeywordIcon(son: son, context: context),
        firstHeadline: superPhrase(context, _chain.id),
        secondHeadline: null,
        initiallyExpanded: initiallyExpanded,
        margin: const EdgeInsets.all(Ratioz.appBarPadding) ,
        onKeywordTap: onKeywordTap,
        // isDisabled: false,
        parentLevel: parentLevel,
      );

    }

    /// OTHERWISE
    else {
      return const BldrsName(size: 40);
    }

  }
}
