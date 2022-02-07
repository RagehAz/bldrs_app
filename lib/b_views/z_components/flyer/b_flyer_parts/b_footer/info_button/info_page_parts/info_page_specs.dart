import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/a_models/kw/specs/spec_list_model.dart';
import 'package:bldrs/a_models/kw/specs/spec_model.dart';
import 'package:bldrs/a_models/secondary_models/name_model.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class InfoPageSpecs extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageSpecs({
    @required this.pageWidth,
    @required this.flyerModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final FlyerModel flyerModel;
  /// --------------------------------------------------------------------------
  List<SpecList> _getFlyerSpecsLists({
    @required List<SpecModel> flyerSpecs,
    @required FlyerType flyerType,
  }){
    final List<SpecList> _specsLists = <SpecList>[];

    final List<SpecList> _flyerTypeSpecsLists = SpecList.getSpecsListsByFlyerType(flyerType);

    if (Mapper.canLoopList(flyerSpecs)){

      for (final SpecModel _spec in flyerSpecs){

        final SpecList _specList = SpecList.getSpecListFromSpecsListsByID(
          specsLists: _flyerTypeSpecsLists,
          specListID: _spec.specsListID,
        );

        final bool _alreadyAdded = SpecList.specsListsContainSpecList(
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
    @required SpecList specList,
  }){

    String _output = '';

    final List<SpecModel> _flyerSpecsFromThisSpecList = <SpecModel>[];

    /// GET FLYER SPECS MATHCHING THIS SPECLIST
    if (Mapper.canLoopList(flyerSpecs) == true){

      for (final SpecModel spec in flyerSpecs){

        if (spec.specsListID == specList.id){

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
          _output = '$_output, $_specName';
        }

      }

    }

    return _output == null || _output == '' ? null : _output;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<SpecModel> _specs =
    // flyerModel.specs
    SpecModel.dummySpecs();

    final List<SpecList> _flyerSpecsLists = _getFlyerSpecsLists(
      // flyerType: flyerModel.flyerType,
      flyerType: FlyerType.property,
      flyerSpecs: _specs,
    );

    // SpecList.blogSpecsLists(_flyerSpecsLists);

    return SizedBox(
        width: pageWidth,
        child:

        ListView.builder(
            itemCount: _flyerSpecsLists.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
            itemBuilder: (_, int index){

              final SpecList _specList = _flyerSpecsLists[index];

              final Name _specListName = Name.getNameByCurrentLingoFromNames(context: context, names: _specList.names);

              blog('_specListName is : ${_specListName.value}');

              final String _specsInString = _generateSpecsString(
                context: context,
                flyerSpecs: _specs,
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
                      verse: '${_specListName?.value} :',
                      weight: VerseWeight.thin,
                      color: Colorz.white200,
                      centered: false,
                      size: 1,
                      scaleFactor: 1.3,
                    ),

                    /// SPECS
                    SuperVerse(
                      verse: _specsInString.toUpperCase(),
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
