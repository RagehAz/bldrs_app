import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/picker_group/c_picker_tiles_builder.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/picker_group/b_pickers_group_headline.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SpecsPickersGroup extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecsPickersGroup({
    @required this.headline,
    @required this.selectedSpecs,
    @required this.groupPickers,
    @required this.onPickerTap,
    @required this.onDeleteSpec,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String headline;
  final ValueNotifier<List<SpecModel>> selectedSpecs;
  final List<SpecPicker> groupPickers;
  final ValueChanged<SpecPicker> onPickerTap;
  final ValueChanged<List<SpecModel>> onDeleteSpec;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    return Padding(
      key: const ValueKey<String>('SpecsPickersGroup'),
      padding: const EdgeInsets.only(bottom: Ratioz.appBarMargin),
      child: Column(
        children: <Widget>[

          /// GROUP HEADLINE
          PickersGroupHeadline(
            headline: headline,
          ),

          /// GROUP SPECS PICKERS
          PickersTilesBuilder(
            onPickerTap: onPickerTap,
            selectedSpecs: selectedSpecs,
            onDeleteSpec: onDeleteSpec,
            specPickers: groupPickers,
          ),

        ],
      ),
    );
  }
}
