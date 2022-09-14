import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/aa_chain_path_converter.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/a_chain_button_box.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/b_expanding_tile.dart';
import 'package:bldrs/b_views/i_chains/z_components/chain_builders/a_chain_splitter.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/c_chains_editor/z_components/editing_chain_builders/a_editing_chain_splitter.dart';
import 'package:flutter/material.dart';

class EditingChainBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const EditingChainBuilder({
    @required this.chain,
    @required this.previousPath,
    @required this.boxWidth,
    @required this.icon,
    @required this.firstHeadlineVerse,
    @required this.secondHeadlineVerse,
    @required this.initiallyExpanded,
    @required this.selectedPhids,
    @required this.secondLinesType,
    @required this.onDoubleTap,
    @required this.onReorder,
    this.inverseAlignment = true,
    this.deactivated = false,
    this.initialColor = Colorz.black50,
    this.expansionColor = Colorz.white20,
    this.onPhidTap,
    this.level = 0,
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
  final Verse firstHeadlineVerse;
  final Verse secondHeadlineVerse;
  final Color initialColor;
  final Color expansionColor;
  final Function(String path, String phid) onPhidTap;
  final bool initiallyExpanded;
  final int level;
  final List<String> selectedPhids;
  final ValueNotifier<String> searchText;
  final Function(String path) onAddToPath;
  final ChainSecondLinesType secondLinesType;
  final ValueChanged<String> onDoubleTap;
  final Function({int oldIndex, int newIndex, List<dynamic> sons, String previousPath, int level}) onReorder;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _sonWidth = ChainButtonBox.getSonWidth(
      level: level,
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
        firstHeadline: firstHeadlineVerse,
        secondHeadline: secondHeadlineVerse,
        initialColor: initialColor,
        expansionColor: expansionColor,
        initiallyExpanded: initiallyExpanded,
        searchText: searchText,
        onDoubleTap: () => onDoubleTap(_cleanedPath),
        child: EditingChainSplitter(
          width: _sonWidth,
          previousPath: '$previousPath/${chain.id}',
          chainOrChainsOrSonOrSons: chain.sons,
          initiallyExpanded: initiallyExpanded,
          onSelectPhid: (String path, String phid) => onPhidTap(path, phid),
          level: level,
          selectedPhids: selectedPhids,
          searchText: searchText,
          onAddToPath: onAddToPath,
          secondLinesType: secondLinesType,
          onDoubleTap: onDoubleTap,
          onReorder: onReorder,
        ),
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
