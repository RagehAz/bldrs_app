import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/parts/c_expanding_tile.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/parts/chain_expander/b_chain_box.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/parts/chain_expander/c_chains_sons_builder.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';


class ChainExpanderStarter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainExpanderStarter({
    @required this.chain,
    @required this.boxWidth,
    // @required this.onTap,
    @required this.icon,
    @required this.firstHeadline,
    @required this.secondHeadline,
    @required this.initiallyExpanded,
    @required this.selectedKeywordsIDs,
    this.alignment,
    this.isDisabled = false,
    this.margin,
    this.initialColor = Colorz.black50,
    this.expansionColor = Colorz.white20,
    this.onKeywordTap,
    this.parentLevel = 0,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Chain chain;
  final bool isDisabled;
  final double boxWidth;
  final Alignment alignment;
  // final ValueChanged<bool> onTap;
  final String icon;
  final String firstHeadline;
  final String secondHeadline;
  final Color initialColor;
  final Color expansionColor;
  final EdgeInsets margin;
  final ValueChanged<String> onKeywordTap;
  final bool initiallyExpanded;
  final int parentLevel;
  final List<String> selectedKeywordsIDs;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _sonWidth = ChainBox.getSonWidth(
      parentLevel: parentLevel,
      parentWidth: boxWidth,
    );

    return ChainBox(
      key: ValueKey<String>('ChainExpanderStarter_${chain.id}'),
      boxWidth: boxWidth,
      alignment: alignment,
      child: ExpandingTile(
        key: PageStorageKey<String>(chain.id),
        width: boxWidth,
        isDisabled: isDisabled,
        icon: icon,
        firstHeadline: firstHeadline,
        secondHeadline: secondHeadline,
        initialColor: initialColor,
        expansionColor: expansionColor,
        initiallyExpanded: initiallyExpanded,
        child: ChainSonsBuilder(
          boxWidth: _sonWidth,
          chain: chain,
          initiallyExpanded: initiallyExpanded,
          onKeywordTap: (String keywordID) => onKeywordTap(keywordID),
          parentLevel: parentLevel,
          selectedKeywordsIDs: selectedKeywordsIDs,
        ),
      ),
    );

  }
}
