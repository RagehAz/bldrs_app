import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
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
  List<SpecPicker> _getFlyerSpecsLists({
    @required List<SpecModel> flyerSpecs,
    @required FlyerType flyerType,
  }){
    final List<SpecPicker> _specsLists = <SpecPicker>[];

    final List<SpecPicker> _flyerTypeSpecsLists = SpecPicker.getSpecsPickersByFlyerType(flyerType);

    if (Mapper.canLoopList(flyerSpecs)){

      for (final SpecModel _spec in flyerSpecs){

        final SpecPicker _specList = SpecPicker.getSpecPickerFromSpecsPickersByChainID(
          specsPickers: _flyerTypeSpecsLists,
          pickerChainID: _spec.specsListID,
        );

        final bool _alreadyAdded = SpecPicker.specsPickersContainSpecPicker(
          specsLists: _specsLists,
          specList: _specList,
        );

        if (_alreadyAdded == false){
          _specsLists.add(_specList);
        }
      }

    }

    return _specsLists;
  }
// -----------------------------------------------------------------------------
  String _generateSpecsString({
    @required BuildContext context,
    @required List<SpecModel> flyerSpecs,
    @required SpecPicker specList,
  }){

    String _output = '';

    final List<SpecModel> _flyerSpecsFromThisSpecList = <SpecModel>[];

    /// GET FLYER SPECS MATHCHING THIS SPECLIST
    if (Mapper.canLoopList(flyerSpecs) == true && specList != null){

      for (final SpecModel spec in flyerSpecs){

        if (spec.specsListID == specList?.chainID){

          final bool _alreadyAdded = SpecModel.specsContainThisSpecValue(
            specs: _flyerSpecsFromThisSpecList,
            value: spec.value,
          );

          if (_alreadyAdded == false){
            _flyerSpecsFromThisSpecList.add(spec);
          }

        }

      }

    }

    /// TRANSLATE THOSE FOUND SPECS
    if (Mapper.canLoopList(_flyerSpecsFromThisSpecList)){

      for (final SpecModel _spec in _flyerSpecsFromThisSpecList){

        final String _specName = SpecModel.getSpecNameFromSpecsLists(
          context: context,
          spec: _spec,
          specsLists: [specList],
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
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<SpecPicker> _flyerSpecsLists = _getFlyerSpecsLists(
      flyerType: flyerType,
      flyerSpecs: specs,
    );

    // SpecList.blogSpecsLists(_flyerSpecsLists);

    return SizedBox(
      key: const ValueKey<String>('InfoPageSpecs'),
        width: pageWidth,
        child:

        ListView.builder(
            itemCount: _flyerSpecsLists.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
            itemBuilder: (_, int index){

              final SpecPicker _specList = _flyerSpecsLists[index];

              final String _specListName = superPhrase(context, _specList?.chainID);

              // blog('_specListName is : $_specListName');

              final String _specsInString = _generateSpecsString(
                context: context,
                flyerSpecs: specs,
                specList: _specList,
              );

              return Container(
                width: pageWidth,
                decoration: BoxDecoration(
                  borderRadius: superBorderAll(context, pageWidth * 0.04),
                  color: Colorz.white50,
                ),
                margin: const EdgeInsets.only(bottom: 2.5),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    /// SPEC LIST NAME
                    SuperVerse(
                      verse: _specListName,
                      weight: VerseWeight.thin,
                      color: Colorz.white200,
                      centered: false,
                      size: 1,
                      scaleFactor: 1.3,
                    ),

                    /// SPECS
                    SuperVerse(
                      verse: _specsInString?.toUpperCase(),
                      // size: 2,
                      maxLines: 10,
                      centered: false,
                      italic: true,
                    ),

                  ],
                ),
              );

            }
        )
    );
  }
}
