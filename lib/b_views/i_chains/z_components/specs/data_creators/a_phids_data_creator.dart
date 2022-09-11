import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/chain_builders/a_chain_splitter.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class PhidsDataCreator extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PhidsDataCreator({
    @required this.specPicker,
    @required this.onlyUseCityChains,
    @required this.selectedSpecs,
    @required this.onPhidTap,
    @required this.allowableHeight,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PickerModel specPicker;
  final bool onlyUseCityChains;
  final List<SpecModel> selectedSpecs;
  final ValueChanged<String> onPhidTap;
  final double allowableHeight;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return PickersViewBox(
      height: allowableHeight,
      child: ChainSplitter(
        width: BldrsAppBar.width(context),
        previousPath: specPicker.chainID,
        chainOrChainsOrSonOrSons: Chain.filterSpecPickerChainRange(
          picker: specPicker,
          context: context,
          onlyUseCityChains: onlyUseCityChains,
        )?.sons,
        onSelectPhid: (String path, String phid) => onPhidTap(phid),
        selectedPhids: SpecModel.getSpecsIDs(selectedSpecs),
        initiallyExpanded: false,
        editMode: false,
        secondLinesType: ChainSecondLinesType.non,
        onLongPress: null,
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
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double height;
  final Widget child;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BorderRadius _corners = Borderers.superBorderAll(context, Ratioz.appBarCorner);
    final double _boxHeight = height - ( Ratioz.appBarMargin);
    // --------------------
    return Container(
      width: BldrsAppBar.width(context),
      height: _boxHeight,
      decoration: BoxDecoration(
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
