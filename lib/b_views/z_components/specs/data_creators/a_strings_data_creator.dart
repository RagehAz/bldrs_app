import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/expander_structure/c_chains_sons_builder.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class StringsDataCreator extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StringsDataCreator({
    @required this.specPicker,
    @required this.selectedSpecs,
    @required this.onSpecTap,
    @required this.height,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final SpecPicker specPicker;
  final List<SpecModel> selectedSpecs;
  final ValueChanged<String> onSpecTap;
  final double height;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BorderRadius _corners = Borderers.superBorderAll(context, Ratioz.appBarCorner);
    final double _boxHeight = height - ( Ratioz.appBarMargin);

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
        child: ChainSonsBuilder(
          boxWidth: BldrsAppBar.width(context),
          chain: Chain.filterSpecPickerChainRange(
            specPicker: specPicker,
            context: context,
            onlyConsiderCityPhids: false,
          ),
          onSpecTap: (String phid) => onSpecTap(phid),
          selectedPhids: SpecModel.getSpecsIDs(selectedSpecs),
          initiallyExpanded: false,
        ),
      ),

    );
  }
}
