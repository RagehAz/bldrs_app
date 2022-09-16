import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/specs_wrapper.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
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
    @required this.onSpecTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final List<SpecModel> specs;
  final FlyerType flyerType;
  final ValueChanged<List<SpecModel>> onSpecTap;
  /// --------------------------------------------------------------------------
  List<PickerModel> _getFlyerPickers({
    @required BuildContext context,
    @required List<SpecModel> flyerSpecs,
    @required FlyerType flyerType,
  }){
    final List<PickerModel> _pickers = <PickerModel>[];

    final List<PickerModel> _flyerTypePickers = ChainsProvider.proGetPickersByFlyerType(
      context: context,
      flyerType: flyerType,
      listen: true,
    );

    if (Mapper.checkCanLoopList(flyerSpecs)){

      for (final SpecModel _spec in flyerSpecs){

        final PickerModel _picker = PickerModel.getPickerByChainIDOrUnitChainID(
          pickers: _flyerTypePickers,
          chainIDOrUnitChainID: _spec.pickerChainID,
        );

        // blog('picker chain ID is : ${_spec.pickerChainID}');
        // _picker.blogSpecPicker();

        final bool _alreadyAdded = PickerModel.checkPickersContainPicker(
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
  @override
  Widget build(BuildContext context) {

    final List<PickerModel> _flyerPickers = _getFlyerPickers(
      context: context,
      flyerType: flyerType,
      flyerSpecs: specs,
    );

    return SizedBox(
      key: const ValueKey<String>('InfoPageSpecs'),
        width: pageWidth,
        child:

        ListView.builder(
            itemCount: _flyerPickers.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
            itemBuilder: (_, int index){

              final PickerModel _picker = _flyerPickers[index];

              final List<SpecModel> _specsOfThisPicker = SpecModel.getSpecsBelongingToThisPicker(
                  specs: specs,
                  picker: _picker,
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
                      verse: Verse(
                        text: _picker?.chainID,
                        translate: true,
                      ),
                      weight: VerseWeight.thin,
                      color: Colorz.white200,
                      centered: false,
                      size: 1,
                      scaleFactor: 1.3,
                    ),

                    SpecsWrapper(
                      boxWidth: pageWidth,
                      specs: _specsOfThisPicker,
                      picker: _picker,
                      onSpecTap: onSpecTap,
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
// -----------------------------------------------------------------------------
}
