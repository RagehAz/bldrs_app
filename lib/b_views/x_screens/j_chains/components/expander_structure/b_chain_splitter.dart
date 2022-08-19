import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/expander_button/c_phid_button.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/expander_structure/a_chain_builder.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/expander_structure/c_chain_sons_builder.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name.dart';
import 'package:bldrs/c_protocols/phrase_protocols/a_phrase_protocols.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// SPLITS CHAIN OR CHAINS OR SON OR SONS INTO DESIGNATED WIDGET
class ChainSplitter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainSplitter({
    @required this.chainOrChainsOrSonOrSons,
    @required this.initiallyExpanded,
    this.parentLevel = 0,
    this.width,
    this.onSelectPhid,
    this.selectedPhids,
    this.searchText,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic chainOrChainsOrSonOrSons;
  final int parentLevel;
  final double width;
  final ValueChanged<String> onSelectPhid;
  final List<String> selectedPhids;
  final bool initiallyExpanded;
  final ValueNotifier<String> searchText;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _width = width ?? BldrsAppBar.width(context);

    /// IF SON IS A PHID
    if (chainOrChainsOrSonOrSons is String) {

      final String _phid = chainOrChainsOrSonOrSons;

      final bool _isSelected = Stringer.checkStringsContainString(
          strings: selectedPhids,
          string: _phid,
      );

      final Color _color = _isSelected == true ? Colorz.blue125 : Colorz.white20;

      return PhidButton(
        phid: _phid,
        width: _width,
        parentLevel: parentLevel,
        searchText: searchText,
        color: _color,
        // isDisabled: false,
        onTap: () => onSelectPhid(_phid),
      );

    }

    /// IF SONS IS List<String>
    else if (chainOrChainsOrSonOrSons is List<String>){
      return ChainSonsBuilder(
        sons: chainOrChainsOrSonOrSons,
        width: _width,
        parentLevel: parentLevel,
        onPhidTap: onSelectPhid,
        selectedPhids: selectedPhids,
        initiallyExpanded: initiallyExpanded,
        searchText: searchText,
      );
    }

    /// IF SON IS CHAIN
    else if (chainOrChainsOrSonOrSons.runtimeType == Chain) {

      final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
      final Chain _chain = chainOrChainsOrSonOrSons;

      return ChainBuilder(
        key: PageStorageKey<String>(_chain.id),
        chain: _chain,
        boxWidth: _width,
        icon: _chainsProvider.getPhidIcon(son: chainOrChainsOrSonOrSons, context: context),
        firstHeadline: xPhrase(context, _chain.id),
        secondHeadline: null,
        initiallyExpanded: initiallyExpanded,
        onPhidTap: onSelectPhid,
        // isDisabled: false,
        parentLevel: parentLevel,
        selectedPhids: selectedPhids,
        searchText: searchText,
      );

    }

    /// IF SONS IS List<Chain>
    else if (Chain.checkSonsAreChains(chainOrChainsOrSonOrSons) == true){
      return ChainSonsBuilder(
        sons: chainOrChainsOrSonOrSons,
        width: _width,
        parentLevel: parentLevel,
        onPhidTap: onSelectPhid,
        selectedPhids: selectedPhids,
        initiallyExpanded: initiallyExpanded,
        searchText: searchText,
      );
    }

    /// OTHERWISE
    else {
      return const BldrsName(size: 40);
    }

  }
}
