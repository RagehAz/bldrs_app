import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/strings/pathing.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/b_views/i_chains/z_components/chain_builders/a_chain_splitter.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/a_chain_button_box.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/b_expanding_tile.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class ChainBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainBuilder({
    required this.chain,
    required this.previousPath,
    required this.boxWidth,
    required this.icon,
    required this.firstHeadline,
    required this.secondHeadline,
    required this.initiallyExpanded,
    required this.selectedPhids,
    required this.secondLinesType,

    required this.onPhidTap,
    required this.onPhidDoubleTap,
    required this.onPhidLongTap,

    required this.onTileTap,
    required this.onTileDoubleTap,
    required this.onTileLongTap,

    required this.searchText,
    required this.onExportSpecs,

    required this.zone,
    required this.onlyUseZoneChains,
    required this.isMultipleSelectionMode,
    required this.onDataCreatorKeyboardSubmitted,

    this.inverseAlignment = true,
    this.deactivated = false,
    this.initialColor = Colorz.black50,
    this.expansionColor = Colorz.white20,
    this.level = 0,
    this.isCollapsable = true,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Chain chain;
  final String? previousPath;
  final bool deactivated;
  final double boxWidth;
  final bool inverseAlignment;
  final String? icon;
  final Verse firstHeadline;
  final Verse? secondHeadline;
  final Color initialColor;
  final Color expansionColor;
  final bool initiallyExpanded;
  final int? level;
  final List<String> selectedPhids;
  final ValueNotifier<dynamic> searchText;
  final ChainSecondLinesType secondLinesType;

  final Function(String? path, String? phid)? onPhidTap;
  final Function(String? path, String? phid)? onPhidDoubleTap;
  final Function(String? path, String? phid)? onPhidLongTap;

  final Function(String? path, String? phid)? onTileLongTap;
  final Function(String? path, String? phid)? onTileTap;
  final Function(String? path, String? phid)? onTileDoubleTap;

  final ValueChanged<List<SpecModel>>? onExportSpecs;

  final ZoneModel? zone;
  final ValueChanged<String?>? onDataCreatorKeyboardSubmitted;
  final bool isMultipleSelectionMode;
  final bool onlyUseZoneChains;
  final bool isCollapsable;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _sonWidth = ChainButtonBox.getSonWidth(
      level: level,
      parentWidth: boxWidth,
    );
    // --------------------
    final String? _cleanedPath = Pathing.fixPathFormatting('$previousPath/${chain.id}');
    // --------------------
    return ChainButtonBox(
      key: ValueKey<String>('ChainExpanderStarter_${chain.id}'),
      width: boxWidth,
      inverseAlignment: inverseAlignment,
      child: BldrsExpandingButton(
        key: PageStorageKey<String>('${chain.id}'),
        width: boxWidth,
        isDisabled: deactivated,
        icon: icon,
        firstHeadline: firstHeadline,
        secondHeadline: secondHeadline,
        initialColor: initialColor,
        expansionColor: expansionColor,
        initiallyExpanded: initiallyExpanded,
        searchText: searchText,
        onTileLongTap: onTileLongTap == null ? null : () => onTileLongTap?.call(_cleanedPath, chain.id),
        onTileTap: onTileTap == null ? null : (bool isExpanded) => onTileTap?.call(_cleanedPath, chain.id),
        onTileDoubleTap: onTileDoubleTap == null ? null : () => onTileDoubleTap?.call(_cleanedPath, chain.id),
        isCollapsable: isCollapsable,
        child: ChainSplitter(
          width: _sonWidth,
          previousPath: '$previousPath/${chain.id}',
          chainOrChainsOrSonOrSons: chain.sons,
          initiallyExpanded: initiallyExpanded,
          level: level,
          selectedPhids: selectedPhids,
          searchText: searchText,
          secondLinesType: secondLinesType,
          onPhidDoubleTap: onPhidDoubleTap,
          onPhidLongTap: onPhidLongTap,
          onPhidTap: onPhidTap,
          onExportSpecs: onExportSpecs,
          isMultipleSelectionMode: isMultipleSelectionMode,
          onlyUseZoneChains: onlyUseZoneChains,
          zone: zone,
          onDataCreatorKeyboardSubmitted: onDataCreatorKeyboardSubmitted,
          isCollapsable: isCollapsable,
        ),
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
