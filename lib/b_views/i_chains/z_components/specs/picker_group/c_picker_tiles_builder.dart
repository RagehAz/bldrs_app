import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/picker_group/cc_spec_picker_tile.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:flutter/material.dart';

class PickersTilesBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickersTilesBuilder({
    @required this.selectedSpecs,
    @required this.specPickers,
    @required this.onPickerTap,
    @required this.onDeleteSpec,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<List<SpecModel>> selectedSpecs;
  final List<PickerModel> specPickers;
  final ValueChanged<PickerModel> onPickerTap;
  final ValueChanged<List<SpecModel>> onDeleteSpec;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      key: const ValueKey<String>('PickersTilesBuilder'),
      width: Scale.superScreenWidth(context),
      child: ValueListenableBuilder(
        valueListenable: selectedSpecs,
        builder: (_, List<SpecModel> _allSelectedSpecs, Widget childC){

          return Column(
            children: <Widget>[

              ...List<Widget>.generate(specPickers.length,
                      (int index) {

                    final PickerModel _picker = specPickers[index];

                    final List<SpecModel> _pickerSelectedSpecs = SpecModel.getSpecsRelatedToPicker(
                      specs: _allSelectedSpecs,
                      picker: _picker,
                    );

                    return SpecPickerTile(
                      onTap: () => onPickerTap(_picker),
                      specPicker: _picker,
                      selectedSpecs: _pickerSelectedSpecs,
                      onDeleteSpec: onDeleteSpec,
                    );

                  }

              ),

            ],
          );

        },
      ),
    );
  }
}
