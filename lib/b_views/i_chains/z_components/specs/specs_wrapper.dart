import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/spec_label.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class SpecsWrapper extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecsWrapper({
    required this.width,
    required this.specs,
    required this.onSpecTap,
    required this.onDeleteSpec,
    required this.xIsOn,
    required this.picker,
    this.padding = Ratioz.appBarMargin,
    this.searchText,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double width;
  final List<SpecModel> specs;
  final bool xIsOn;
  final PickerModel? picker;
  final dynamic padding;
  final Function({required SpecModel? value, required SpecModel? unit})? onDeleteSpec;
  final Function({required SpecModel? value, required SpecModel? unit})? onSpecTap;
  final ValueNotifier<String?>? searchText;
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool combineTheTwoSpecs({
    required List<SpecModel> specs,
    required PickerModel? picker,
  }){
    bool _combine = false;

    if (specs.length == 2){

      final SpecModel _first = specs[0];
      final SpecModel _second = specs[1];

      _first.blogSpec();
      _second.blogSpec();
      picker?.blogPicker();

      final bool _firstSpecIsChainID = picker?.chainID == _first.pickerChainID;
      final bool _secondSpecIsChainID = picker?.chainID == _second.pickerChainID;

      final bool _firstChainIsUnitChainID = picker?.unitChainID == _first.pickerChainID;
      final bool _secondSpecIsUnitChainID = picker?.unitChainID == _second.pickerChainID;

      /// FIRST IS CHAIN ID + SECOND IS UNIT CHAIN ID
      if ( _firstSpecIsChainID == true && _secondSpecIsUnitChainID == true){
        _combine = true;
      }

      /// FIRST IS UNIT CHAIN ID + SECOND IS CHAIN ID
      else if (_secondSpecIsChainID == true && _firstChainIsUnitChainID == true){
        _combine = true;
      }

    }

    return _combine;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static SpecModel? getValueSpec(PickerModel? picker, List<SpecModel>? specs){

    return specs?.firstWhereOrNull((element) => element.pickerChainID == picker?.chainID);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static SpecModel? getUnitSpec(PickerModel? picker, List<SpecModel>? specs){
    return specs?.firstWhereOrNull((element) => element.pickerChainID == picker?.unitChainID);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Verse? _getCombinedSpecsVerse({
    required BuildContext context,
    required List<SpecModel> specs,
    required PickerModel? picker,
  }){

    Verse? _verse;

    if (Lister.checkCanLoopList(specs) == true && specs.length == 2){

      final SpecModel? _value = getValueSpec(picker, specs);
      final SpecModel? _unit = getUnitSpec(picker, specs);

      _verse = Verse(
        id: '${_value?.value} ${getWord(_unit?.value)}',
        translate: false,
      );

    }

    return _verse;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final bool _combineTwoSpecs = combineTheTwoSpecs(
      specs: specs,
      picker: picker,
    );
    // --------------------
    return SizedBox(
      width: width,
      child: Wrap(
        spacing: Ratioz.appBarPadding,
        children: <Widget>[

          if (_combineTwoSpecs == false)
            ...List<Widget>.generate(specs.length,
                    (int index) {

                  final SpecModel _spec = specs[index];

                  return SpecLabel(
                    maxBoxWidth: width,
                    searchText: searchText,
                    xIsOn: xIsOn,
                    verse: Verse(
                      id: Phider.removeIndexFromPhid(phid: _spec.value.toString()),
                      translate: true,
                    ),
                    onTap: () => onSpecTap?.call(value: _spec, unit: null),
                    onXTap: () => onDeleteSpec?.call(value: _spec, unit: null),
                  );

                }),

          if (_combineTwoSpecs == true)
            SpecLabel(
              maxBoxWidth: width,
              xIsOn: xIsOn,
              searchText: searchText,
              verse: _getCombinedSpecsVerse(
                context: context,
                picker: picker,
                specs: specs,
              ),
              onTap: () => onSpecTap?.call(
                  value: getValueSpec(picker, specs),
                  unit: getUnitSpec(picker, specs)
              ),
              onXTap: () => onDeleteSpec?.call(
                  value: getValueSpec(picker, specs),
                  unit: getUnitSpec(picker, specs)
              ),
            ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
