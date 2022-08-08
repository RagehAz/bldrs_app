import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/x_screens/j_chains/xxxxxxxxx_chains_builder.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/parts/chain_expander/a_chain_expander_starter.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/parts/d_phid_button.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChainSonStarter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainSonStarter({
    @required this.son,
    @required this.initiallyExpanded,
    this.parentLevel = 0,
    this.sonWidth,
    this.onPhidTap,
    this.selectedPhids,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic son;
  final int parentLevel;
  final double sonWidth;
  final ValueChanged<String> onPhidTap;
  final List<String> selectedPhids;
  static const double buttonHeight = 60;
  final bool initiallyExpanded;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// IF SON IS A PHID
    if (son is String) {

      final String _phid = son;

      final bool _isSelected = Mapper.checkStringsContainString(
          strings: selectedPhids,
          string: _phid,
      );

      final Color _color = _isSelected == true ? Colorz.blue125 : Colorz.white20;

      return PhidButton(
        phid: _phid,
        width: sonWidth,
        parentLevel: parentLevel,
        color: _color,
        // isDisabled: false,
        onTap: () => onPhidTap(_phid),
      );

    }

    /// IF SON IS CHAIN
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
        // margin: const EdgeInsets.all(Ratioz.appBarPadding) ,
        onPhidTap: onPhidTap,
        // isDisabled: false,
        parentLevel: parentLevel,
        selectedPhids: selectedPhids,
      );

    }

    else if (Chain.checkSonsAreChains(son) == true){
      return ChainsBuilder(
          chains: son,
          boxWidth: sonWidth,
          parentLevel: parentLevel,
          onPhidTap: onPhidTap,
          selectedPhids: selectedPhids,
          initiallyExpanded: initiallyExpanded
      );
    }

    /// OTHERWISE
    else {
      return const BldrsName(size: 40);
    }

  }
}
