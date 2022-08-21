import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/specs_wrapper.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/c_protocols/phrase_protocols/a_phrase_protocols_old.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class InfoPageSpecs extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageSpecs({
    @required this.pageWidth,
    @required this.specs,
    @required this.flyerType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final List<SpecModel> specs;
  final FlyerType flyerType;
  /// --------------------------------------------------------------------------
  List<SpecPicker> _getFlyerSpecsPickers({
    @required List<SpecModel> flyerSpecs,
    @required FlyerType flyerType,
  }){
    final List<SpecPicker> _pickers = <SpecPicker>[];

    final List<SpecPicker> _flyerTypePickers = SpecPicker.getPickersByFlyerType(flyerType);

    if (Mapper.checkCanLoopList(flyerSpecs)){

      for (final SpecModel _spec in flyerSpecs){

        final SpecPicker _picker = SpecPicker.getPickerFromPickersByChainIDOrUnitChainID(
          specsPickers: _flyerTypePickers,
          pickerChainID: _spec.pickerChainID,
        );

        // blog('picker chain ID is : ${_spec.pickerChainID}');
        // _picker.blogSpecPicker();

        final bool _alreadyAdded = SpecPicker.pickersContainPicker(
          pickers: _pickers,
          picker: _picker,
        );

        if (_alreadyAdded == false){
          _pickers.add(_picker);
        }

      }

    }

    return _pickers;
  }
// -----------------------------------------------------------------------------
  /*
  String _generateTranslateSpecsString({
    @required BuildContext context,
    @required List<SpecModel> flyerSpecs,
    @required SpecPicker specPicker,
  }){

    String _output = '';

    final List<SpecModel> _flyerSpecsFromThisSpecPicker = <SpecModel>[];

    /// GET FLYER SPECS MATCHING THIS SPECS PICKER
    if (Mapper.canLoopList(flyerSpecs) == true && specPicker != null){

      for (final SpecModel spec in flyerSpecs){

        if (spec.pickerChainID == specPicker?.chainID){

          final bool _alreadyAdded = SpecModel.specsContainThisSpecValue(
            specs: _flyerSpecsFromThisSpecPicker,
            value: spec.value,
          );

          if (_alreadyAdded == false){
            _flyerSpecsFromThisSpecPicker.add(spec);
          }

        }

      }

    }

    /// TRANSLATE THOSE FOUND SPECS
    if (Mapper.canLoopList(_flyerSpecsFromThisSpecPicker)){

      for (final SpecModel _spec in _flyerSpecsFromThisSpecPicker){

        final String _specName = SpecModel.translateSpec(
          context: context,
          spec: _spec,
        );

        if (_output == ''){
          _output = _specName;
        }
        else {
          _output = '$_output - $_specName';
        }

      }

    }

    return _output == null || _output == '' ? null : _output;
  }
   */
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<SpecPicker> _flyerSpecsPickers = _getFlyerSpecsPickers(
      flyerType: flyerType,
      flyerSpecs: specs,
    );

    return SizedBox(
      key: const ValueKey<String>('InfoPageSpecs'),
        width: pageWidth,
        child:

        ListView.builder(
            itemCount: _flyerSpecsPickers.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
            itemBuilder: (_, int index){

              final SpecPicker _specPicker = _flyerSpecsPickers[index];

              final String _pickerName = xPhrase(context, _specPicker?.chainID);

              // blog('_pickerName is : $_pickerName');

              // final String _specsInString = _generateTranslateSpecsString(
              //   context: context,
              //   flyerSpecs: specs,
              //   specPicker: _specPicker,
              // );

              final List<SpecModel> _specsOfThisPicker = SpecModel.getSpecsRelatedToPicker(
                  specs: specs,
                  picker: _specPicker,
              );

              return Container(
                width: pageWidth,
                decoration: BoxDecoration(
                  borderRadius: Borderers.superBorderAll(context, pageWidth * 0.04),
                  color: Colorz.white50,
                ),
                margin: const EdgeInsets.only(bottom: 2.5),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    /// SPEC PICKER NAME
                    SuperVerse(
                      verse: _pickerName,
                      weight: VerseWeight.thin,
                      color: Colorz.white200,
                      centered: false,
                      size: 1,
                      scaleFactor: 1.3,
                    ),

                    SpecsWrapper(
                      boxWidth: pageWidth,
                      specs: _specsOfThisPicker,
                      picker: _specPicker,
                      onSpecTap: null,
                      xIsOn: false,
                      padding: 5,
                    ),

                  ],
                ),
              );

            }
        )
    );
  }
}
