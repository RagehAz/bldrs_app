import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/others/spec_picker_instruction.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/picker_group/a_pickers_group.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ChainsScreenBrowseView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainsScreenBrowseView({
    @required this.specsPickers,
    @required this.onPickerTap,
    @required this.onDeleteSpec,
    @required this.selectedSpecs,
    @required this.refinedPickers,
    @required this.onlyUseCityChains,
    @required this.flyerTypes,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<PickerModel> specsPickers;
  final ValueChanged<PickerModel> onPickerTap;
  final ValueChanged<List<SpecModel>> onDeleteSpec;
  final ValueNotifier<List<SpecModel>> selectedSpecs;
  final ValueNotifier<List<PickerModel>> refinedPickers;
  final bool onlyUseCityChains;
  final List<FlyerType> flyerTypes;
  // --------------------------------------------------------------------------
  /// CHAIN GROUPS ( PICKERS )  INSTRUCTIONS
  String _getInstructions(BuildContext context){
    // ---------------------
    final ZoneModel _zone = ZoneProvider.proGetCurrentZone(
      context: context,
      listen: true,
    );
    // ---------------------
    final List<String> _strings = FlyerTyper.translateFlyerTypes(
      context: context,
      flyerTypes: flyerTypes,
    );
    // ---------------------
    final String _flyerTypesString = Stringer.generateStringFromStrings(
      strings: _strings,
    );
    // ---------------------
    final String _flyerTypesStringWithNewLineIfNotNull = _flyerTypesString == null ?
    '' : '\n$_flyerTypesString';
    // ---------------------
    final String _instructions =
    onlyUseCityChains == true ?
    xPhrase( context, '##Showing only keywords used in'
        '\n${_zone.cityName}, ${_zone.countryName}.'
        '$_flyerTypesStringWithNewLineIfNotNull')
        :
    xPhrase( context, '##Showing All keywords in Bldrs.net'
        '\n$_flyerTypesString');
    // ---------------------

    return _instructions;
  }
// ------------------------------------------------
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
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// WHEN PICKERS ARE PROVIDED
    if (Mapper.checkCanLoopList(specsPickers) == true){

      return ValueListenableBuilder(
          valueListenable: refinedPickers,
          child: ChainInstructions(
            instructions: _getInstructions(context),
            leadingIcon: _getInstructionsIcon(context),
            iconSizeFactor: onlyUseCityChains == true ? 1 : 0.6,
          ),
          builder: (_, List<PickerModel> _refinedPickers, Widget instructions){

            final List<String> _theGroupsIDs = PickerModel.getGroupsIDs(
              specsPickers: _refinedPickers,
            );

            return ListView.builder(
                itemCount: _theGroupsIDs.length + 1,
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

                    final String _groupID = _theGroupsIDs[index - 1];

                    final List<PickerModel> _pickersOfThisGroup = PickerModel.getPickersByGroupID(
                      pickers: _refinedPickers,
                      groupID: _groupID,
                    );

                    return SpecsPickersGroup(
                      headline: _groupID.toUpperCase(),
                      selectedSpecs: selectedSpecs,
                      groupPickers: _pickersOfThisGroup,
                      onPickerTap: onPickerTap,
                      onDeleteSpec: onDeleteSpec,
                    );

                  }

                }
            );

          }
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
            verse: '##No Available Flyers in This City yet',
            weight: VerseWeight.black,
            italic: true,
            size: 3,
            maxLines: 3,
            margin: Ratioz.appBarMargin,
          ),
        ),
      );

  }

  }
}
