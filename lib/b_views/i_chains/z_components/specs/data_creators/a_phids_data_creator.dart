import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/b_views/i_chains/z_components/chain_builders/a_chain_splitter.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:flutter/material.dart';

class PhidsDataCreator extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PhidsDataCreator({
    required this.specPicker,
    required this.selectedSpecs,
    required this.allowableHeight,
    required this.searchText,
    required this.onPhidTap,
    required this.zone,
    required this.onlyUseZoneChains,
    required this.isMultipleSelectionMode,
    required this.onDataCreatorKeyboardSubmitted,
    required this.isCollapsable,
    this.width,
    super.key
  });
  /// --------------------------------------------------------------------------
  final PickerModel? specPicker;
  final List<SpecModel>? selectedSpecs;
  final double allowableHeight;
  final ValueNotifier<dynamic> searchText;
  final Function(String? path, String? phid)? onPhidTap;
  final double? width;
  final ZoneModel? zone;
  final ValueChanged<String?>? onDataCreatorKeyboardSubmitted;
  final bool isMultipleSelectionMode;
  final bool onlyUseZoneChains;
  final bool isCollapsable;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _width = width ?? Bubble.bubbleWidth(context: context);
    
    
    return PickersViewBox(
      height: allowableHeight,
      width: _width,
      child: ChainSplitter(
        width: _width,
        previousPath: specPicker?.chainID,
        chainOrChainsOrSonOrSons: Chain.filterSpecPickerChainRange(
          picker: specPicker,
          onlyUseZoneChains: onlyUseZoneChains,
        )?.sons,
        selectedPhids: SpecModel.getSpecsIDs(selectedSpecs),
        initiallyExpanded: false,
        secondLinesType: ChainSecondLinesType.non,
        onPhidTap: onPhidTap,
        onPhidDoubleTap: (String? path, String? phid){blog('PhidsDataCreator : onPhidDoubleTap : $path : $phid');},
        onPhidLongTap:(String? path, String? phid){blog('PhidsDataCreator : onPhidLongTap : $path : $phid');},
        searchText: searchText,
        onExportSpecs: (List<SpecModel> specs) => blog('PhidsDataCreator : ${specs.length} specs'),
        isMultipleSelectionMode: isMultipleSelectionMode,
        onlyUseZoneChains: onlyUseZoneChains,
        zone: zone,
        onDataCreatorKeyboardSubmitted: onDataCreatorKeyboardSubmitted,
        isCollapsable: isCollapsable,
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

class PickersViewBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickersViewBox({
    required this.height,
    required this.child,
    this.width,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double height;
  final double? width;
  final Widget child;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const BorderRadius _corners = BldrsAppBar.corners;
    final double _boxHeight = height - ( Ratioz.appBarMargin);
    // --------------------
    return Container(
      width: width ?? Bubble.bubbleWidth(context: context),
      height: _boxHeight,
      decoration: const BoxDecoration(
        color: Colorz.white10,
        borderRadius: _corners,
      ),
      alignment: Alignment.topCenter,
      child: ClipRRect(
        borderRadius: _corners,
        child: child,
      ),

    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
