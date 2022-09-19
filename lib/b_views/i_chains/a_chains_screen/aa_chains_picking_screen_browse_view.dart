import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/others/spec_picker_instruction.dart';
import 'package:bldrs/b_views/i_chains/z_components/pickers/picker_splitter.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ChainsScreenBrowseView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainsScreenBrowseView({
    @required this.selectedSpecs,
    @required this.refinedPickers,
    @required this.onlyUseCityChains,
    @required this.flyerTypes,
    @required this.onSpecTap,
    @required this.onDeleteSpec,
    @required this.onPickerTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<List<SpecModel>> selectedSpecs;
  final ValueNotifier<List<PickerModel>> refinedPickers;
  final bool onlyUseCityChains;
  final List<FlyerType> flyerTypes;
  final Function({@required SpecModel value, @required SpecModel unit}) onSpecTap;
  final Function({@required SpecModel value, @required SpecModel unit}) onDeleteSpec;
  final ValueChanged<PickerModel> onPickerTap;
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
    final String _flyerTypesStringWithNewLineIfNotNull = _flyerTypesString == null ?
    '' : '\n$_flyerTypesString';
    // ------
    final String _instructions =
        onlyUseCityChains == true ?
            '${xPhrase(context, 'phid_showing_only_keywords_used_in')}\n'
            '${_zone.cityName}, ${_zone.countryName}'
            '$_flyerTypesStringWithNewLineIfNotNull'
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
      valueListenable: refinedPickers,
      builder: (_, List<PickerModel> _refinedPickers, Widget instructions){

        /// WHEN PICKERS ARE PROVIDED
        if (refinedPickers != null){
          return ValueListenableBuilder(
            valueListenable: selectedSpecs,
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

                    /// GROUPS BUILDER
                    else {

                      final PickerModel _picker = _refinedPickers[index - 1];

                      return PickerSplitter(
                        picker: _picker,
                        onTap: () => onPickerTap(_picker),
                        onDeleteSpec: onDeleteSpec,
                        onSpecTap: onSpecTap,
                        allSelectedSpecs: _allSelectedSpecs,
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
