import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/a_pickers_screen/x_pickers_screen_controllers.dart';
import 'package:bldrs/b_views/i_chains/z_components/others/spec_picker_instruction.dart';
import 'package:bldrs/b_views/i_chains/z_components/pickers/picker_splitter.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class PickersScreenBrowseView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickersScreenBrowseView({
    @required this.selectedSpecsNotifier,
    @required this.refinedPickersNotifier,
    @required this.onlyUseCityChains,
    @required this.flyerTypes,
    @required this.isMultipleSelectionMode,
    @required this.zone,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<List<SpecModel>> selectedSpecsNotifier;
  final ValueNotifier<List<PickerModel>> refinedPickersNotifier;
  final bool onlyUseCityChains;
  final List<FlyerType> flyerTypes;
  final bool isMultipleSelectionMode;
  final ZoneModel zone;
  // --------------------------------------------------------------------------
  /// CHAIN GROUPS ( PICKERS )  INSTRUCTIONS
  Verse _getInstructions(BuildContext context){
    // ------
    final ZoneModel _zone = ZoneProvider.proGetCurrentZone(
      context: context,
      listen: true,
    );
    // ------
    final List<String> _translations = FlyerTyper.translateFlyerTypes(
      context: context,
      flyerTypes: flyerTypes,
    );
    // ------
    final String _flyerTypesString = Stringer.generateStringFromStrings(
      strings: _translations,
    );
    // ------
    // final String _flyerTypesStringWithNewLineIfNotNull = _flyerTypesString == null ?
    // '' : '\n$_flyerTypesString';
    // ------
    final String _instructions =
        onlyUseCityChains == true ?
            '${xPhrase(context, 'phid_showing_only_keywords_used_in')}\n'
            '${_zone.cityName}, ${_zone.countryName}'
            // '$_flyerTypesStringWithNewLineIfNotNull'
                :
            '${xPhrase(context, 'phid_showing_all_available_keywords')}\n'
            '$_flyerTypesString';
    // ------
    return Verse(
      text: _instructions,
      translate: false,
    );
  }
  // --------------------
  String _getInstructionsIcon(BuildContext context){
    // ---------------------
    final ZoneModel _zone = ZoneProvider.proGetCurrentZone(
      context: context,
      listen: true,
    );
    // ---------------------

    // ---------------------
    final String _icon = onlyUseCityChains == true ?
    _zone.flag
        :
    Iconz.info;
    // ---------------------

    return _icon;
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // PickerModel.blogPickers(pickers, methodName: 'ChainsScreenBrowseView');

    return ValueListenableBuilder(
      valueListenable: refinedPickersNotifier,
      builder: (_, List<PickerModel> _refinedPickers, Widget instructions){

        /// WHEN PICKERS ARE PROVIDED
        if (refinedPickersNotifier != null){
          return ValueListenableBuilder(
            valueListenable: selectedSpecsNotifier,
            builder: (_, List<SpecModel> _allSelectedSpecs, Widget childC){

              return ListView.builder(
                  itemCount: _refinedPickers.length + 1,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(
                    top: Stratosphere.bigAppBarStratosphere,
                    bottom: Ratioz.horizon,
                  ),
                  itemBuilder: (BuildContext ctx, int index) {

                    /// INSTRUCTIONS
                    if (index == 0){
                      return instructions;
                    }

                    /// PICKERS
                    else {

                      final PickerModel _picker = _refinedPickers[index - 1];

                      return PickerSplitter(
                        picker: _picker,
                        allSelectedSpecs: _allSelectedSpecs,

                        /// TAPPING ON PICKER IT SELF => GO TO PICKER SCREEN
                        onPickerTap: () => onGoToPickerScreen(
                          context: context,
                          zone: zone,
                          selectedSpecsNotifier: selectedSpecsNotifier,
                          isMultipleSelectionMode: isMultipleSelectionMode,
                          onlyUseCityChains: onlyUseCityChains,
                          allPickers: _refinedPickers,
                          picker: _picker,
                          refinedPickersNotifier: refinedPickersNotifier,
                        ),

                        /// TAPPING ON BLACK SPEC => NOTHING FOR NOW
                        onSelectedSpecTap: ({SpecModel value, SpecModel unit}){
                          blog('PickersScreenBrowseView : onSpecTap');
                          value.blogSpec();
                          unit?.blogSpec();
                        },

                        /// TAPPING ON X ON BLACK SPEC => REMOVE THAT SPEC/COMPOUND SPEC
                        onDeleteSpec: ({SpecModel value, SpecModel unit}) => onRemoveSpecs(
                          valueSpec: value,
                          unitSpec: unit,
                          pickers: _refinedPickers,
                          selectedSpecsNotifier: selectedSpecsNotifier,
                        ),

                      );

                    }

                  }
              );

            },
          );
        }

        /// WHEN NO PICKERS THERE
        else {
          return Center(
            child: Container(
              width: Scale.superScreenWidth(context),
              height: Scale.superScreenHeight(context),
              padding: Scale.superMargins(margins: 20),
              child: const SuperVerse(
                verse: Verse(
                  text: 'phid_no_flyer_in_this_city',
                  pseudo: 'No Available Flyers in This City yet',
                  translate: true,
                ),
                weight: VerseWeight.black,
                italic: true,
                size: 3,
                maxLines: 3,
                margin: Ratioz.appBarMargin,
              ),
            ),
          );
        }

      },
      child: ChainInstructions(
        instructions: _getInstructions(context),
        leadingIcon: _getInstructionsIcon(context),
        iconSizeFactor: onlyUseCityChains == true ? 1 : 0.6,
      ),

    );

  }
  // --------------------------------------------------------------------------
}
