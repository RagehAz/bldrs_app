import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/expander_button/a_chain_button_box.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/expander_button/b_expanding_tile.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/expander_structure/b_chain_splitter.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class ChainBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainBuilder({
    @required this.chain,
    @required this.boxWidth,
    @required this.icon,
    @required this.firstHeadline,
    @required this.secondHeadline,
    @required this.initiallyExpanded,
    @required this.selectedPhids,
    this.alignment,
    this.isDisabled = false,
    this.initialColor = Colorz.black50,
    this.expansionColor = Colorz.white20,
    this.onPhidTap,
    this.parentLevel = 0,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Chain chain;
  final bool isDisabled;
  final double boxWidth;
  final Alignment alignment;
  final String icon;
  final String firstHeadline;
  final String secondHeadline;
  final Color initialColor;
  final Color expansionColor;
  final ValueChanged<String> onPhidTap;
  final bool initiallyExpanded;
  final int parentLevel;
  final List<String> selectedPhids;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _sonWidth = ChainButtonBox.getSonWidth(
      parentLevel: parentLevel,
      parentWidth: boxWidth,
    );

    return ChainButtonBox(
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
        child: ChainSplitter(
          width: _sonWidth,
          chainOrChainsOrSonOrSons: chain.sons,
          initiallyExpanded: initiallyExpanded,
          onPhidTap: (String phid) => onPhidTap(phid),
          parentLevel: parentLevel,
          selectedPhids: selectedPhids,
        ),
      ),
    );

  }
}
