import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/spec_label.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SpecsWrapper extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecsWrapper({
    @required this.boxWidth,
    @required this.specs,
    @required this.onSpecTap,
    @required this.xIsOn,
    @required this.picker,
    this.padding = Ratioz.appBarMargin,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double boxWidth;
  final List<SpecModel> specs;
  final ValueChanged<List<SpecModel>> onSpecTap;
  final bool xIsOn;
  final PickerModel picker;
  final dynamic padding;
  /// --------------------------------------------------------------------------
  static bool combineTheTwoSpecs({
    @required List<SpecModel> specs,
    @required PickerModel picker,
}){
    bool _combine = false;

    if (specs.length == 2){

      final SpecModel _first = specs[0];
      final SpecModel _second = specs[1];

      if (
      picker.chainID == _first.pickerChainID
      &&
      picker.unitChainID == _second.pickerChainID
      ){
        _combine = true;
      }

      else if (
      picker.unitChainID == _first.pickerChainID
          &&
      picker.chainID == _second.pickerChainID
      ){
        _combine = true;
      }

    }

    return _combine;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _combineTwoSpecs = combineTheTwoSpecs(
        specs: specs,
        picker: picker,
    );

    return Container(
      width: boxWidth,
      padding: Scale.superMargins(margins: padding),
      child: Wrap(
        spacing: Ratioz.appBarPadding,
        children: <Widget>[

          if (_combineTwoSpecs == false)
          ...List<Widget>.generate(specs.length,
                  (int index) {

                final SpecModel _spec = specs[index];

                return SpecLabel(
                    xIsOn: xIsOn,
                    value: SpecModel.translateSpec(context: context, spec: _spec,),
                    onTap: () => onSpecTap(<SpecModel>[_spec]),
                );

              }),

          if (_combineTwoSpecs == true)
          SpecLabel(
            xIsOn: xIsOn,
            value: '${SpecModel.translateSpec(context: context, spec: specs[0],)} ${SpecModel.translateSpec(context: context, spec: specs[1],)}',
            onTap: () => onSpecTap(<SpecModel>[specs[0], specs[1]]),
          ),

        ],
      ),
    );

  }
}
