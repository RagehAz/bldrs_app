import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/aa_chain_path_converter.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/a_chain_button_box.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/b_expanding_tile.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_structure/b_chain_splitter.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class ChainBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainBuilder({
    @required this.chain,
    @required this.previousPath,
    @required this.boxWidth,
    @required this.icon,
    @required this.firstHeadline,
    @required this.secondHeadline,
    @required this.initiallyExpanded,
    @required this.selectedPhids,
    @required this.editMode,
    @required this.secondLinesType,
    @required this.onLongPress,
    this.inverseAlignment = true,
    this.deactivated = false,
    this.initialColor = Colorz.black50,
    this.expansionColor = Colorz.white20,
    this.onPhidTap,
    this.parentLevel = 0,
    this.searchText,
    this.onAddToPath,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Chain chain;
  final String previousPath;
  final bool deactivated;
  final double boxWidth;
  final bool inverseAlignment;
  final String icon;
  final String firstHeadline;
  final String secondHeadline;
  final Color initialColor;
  final Color expansionColor;
  final Function(String path, String phid) onPhidTap;
  final bool initiallyExpanded;
  final int parentLevel;
  final List<String> selectedPhids;
  final ValueNotifier<String> searchText;
  final Function(String path) onAddToPath;
  final bool editMode;
  final ChainSecondLinesType secondLinesType;
  final ValueChanged<String> onLongPress;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _sonWidth = ChainButtonBox.getSonWidth(
      parentLevel: parentLevel,
      parentWidth: boxWidth,
    );
    // --------------------
    final String _cleanedPath = ChainPathConverter.fixPathFormatting('$previousPath/${chain.id}');
    // --------------------
    return ChainButtonBox(
      key: ValueKey<String>('ChainExpanderStarter_${chain.id}'),
      boxWidth: boxWidth,
      inverseAlignment: inverseAlignment,
      child: ExpandingTile(
        key: PageStorageKey<String>(chain.id),
        width: boxWidth,
        isDisabled: deactivated,
        icon: icon,
        firstHeadline: firstHeadline,
        secondHeadline: secondHeadline,
        initialColor: initialColor,
        expansionColor: expansionColor,
        initiallyExpanded: initiallyExpanded,
        searchText: searchText,
        onLongPress: () => onLongPress(_cleanedPath),
        child: ChainSplitter(
          width: _sonWidth,
          previousPath: '$previousPath/${chain.id}',
          chainOrChainsOrSonOrSons: chain.sons,
          initiallyExpanded: initiallyExpanded,
          onSelectPhid: (String path, String phid) => onPhidTap(path, phid),
          parentLevel: parentLevel,
          selectedPhids: selectedPhids,
          searchText: searchText,
          onAddToPath: onAddToPath,
          editMode: editMode,
          secondLinesType: secondLinesType,
          onLongPress: onLongPress,
        ),
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
