import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/chain_builders/a_chain_splitter.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';

import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class PhidsDataCreator extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PhidsDataCreator({
    @required this.specPicker,
    @required this.selectedSpecs,
    @required this.allowableHeight,
    @required this.searchText,
    @required this.onPhidTap,
    @required this.zone,
    @required this.onlyUseCityChains,
    @required this.isMultipleSelectionMode,
    @required this.onDataCreatorKeyboardSubmitted,
    @required this.isCollapsable,
    this.width,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PickerModel specPicker;
  final List<SpecModel> selectedSpecs;
  final double allowableHeight;
  final ValueNotifier<dynamic> searchText;
  final Function(String path, String phid) onPhidTap;
  final double width;
  final ZoneModel zone;
  final ValueChanged<String> onDataCreatorKeyboardSubmitted;
  final bool isMultipleSelectionMode;
  final bool onlyUseCityChains;
  final bool isCollapsable;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return PickersViewBox(
      height: allowableHeight,
      width: width,
      child: ChainSplitter(
        width: width ?? BldrsAppBar.width(context),
        previousPath: specPicker.chainID,
        chainOrChainsOrSonOrSons: Chain.filterSpecPickerChainRange(
          picker: specPicker,
          context: context,
          onlyUseCityChains: onlyUseCityChains,
        )?.sons,
        selectedPhids: SpecModel.getSpecsIDs(selectedSpecs),
        initiallyExpanded: false,
        secondLinesType: ChainSecondLinesType.non,
        onPhidTap: onPhidTap,
        onPhidDoubleTap: (String path, String phid){blog('PhidsDataCreator : onPhidDoubleTap : $path : $phid');},
        onPhidLongTap:(String path, String phid){blog('PhidsDataCreator : onPhidLongTap : $path : $phid');},
        searchText: searchText,
        onExportSpecs: (List<SpecModel> specs) => blog('PhidsDataCreator : ${specs.length} specs'),
        isMultipleSelectionMode: isMultipleSelectionMode,
        onlyUseCityChains: onlyUseCityChains,
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
    @required this.height,
    @required this.child,
    this.width,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double height;
  final double width;
  final Widget child;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const BorderRadius _corners = BldrsAppBar.corners;
    final double _boxHeight = height - ( Ratioz.appBarMargin);
    // --------------------
    return Container(
      width: width ?? BldrsAppBar.width(context),
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
