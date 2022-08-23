import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/others/spec_picker_instruction.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/picker_group/a_pickers_group.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
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
    @required this.refinedSpecsPickers,
    @required this.onlyUseCityChains,
    @required this.flyerTypes,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<SpecPicker> specsPickers;
  final ValueChanged<SpecPicker> onPickerTap;
  final ValueChanged<List<SpecModel>> onDeleteSpec;
  final ValueNotifier<List<SpecModel>> selectedSpecs;
  final ValueNotifier<List<SpecPicker>> refinedSpecsPickers;
  final bool onlyUseCityChains;
  final List<FlyerType> flyerTypes;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// WHEN PICKERS ARE PROVIDED
    if (Mapper.checkCanLoopList(specsPickers) == true){

      return ValueListenableBuilder(
          valueListenable: refinedSpecsPickers,
          builder: (_, List<SpecPicker> refinedPickers, Widget childB){

            final List<String> _theGroupsIDs = SpecPicker.getGroupsIDs(
              specsPickers: refinedPickers,
            );

            return ListView.builder(
                itemCount: _theGroupsIDs.length + 1,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  top: Stratosphere.bigAppBarStratosphere,
                  bottom: Ratioz.horizon,
                ),
                itemBuilder: (BuildContext ctx, int index) {

                  if (index == 0){
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
                    final String _instruction =
                    onlyUseCityChains == true ?
                        'Showing only keywords used in'
                        '\n${_zone.cityName}, ${_zone.countryName}.'
                        '$_flyerTypesStringWithNewLineIfNotNull'
                            :
                        'Showing All keywords in Bldrs.net'
                        '\n$_flyerTypesString';
                    // ---------------------
                    final String _icon = onlyUseCityChains == true ?
                    _zone.flag
                        :
                    Iconz.info;
                    // ---------------------
                    return ChainInstructions(
                      verseOverride: _instruction,
                      leadingIcon: _icon,
                      iconSizeFactor: onlyUseCityChains == true ? 1 : 0.6,
                    );

                  }

                  else {

                    final String _groupID = _theGroupsIDs[index - 1];

                    final List<SpecPicker> _pickersOfThisGroup = SpecPicker.getPickersByGroupID(
                      pickers: refinedPickers,
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
            verse: 'No Available Flyers in This City yet',
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
