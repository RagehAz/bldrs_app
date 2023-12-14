import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:basics/helpers/models/flag_model.dart';
import 'package:basics/layouts/separators/dot_separator.dart';
import 'package:basics/super_box/src/f_super_box_tap_layer/x_tap_layer.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/g_statistics/census/census_model.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/a_tile_button.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/census_line.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/zone_button_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

class AmericaStatesTileButtons extends StatelessWidget {
  // --------------------------------------------------------------------------
  const AmericaStatesTileButtons({
    required this.onStateTap,
    required this.activeCountriesIDs,
    required this.disabledCountriesIDs,
    required this.onDisabledStateTap,
    required this.censusModels,
    required this.selectedZone,
    this.width,
    this.height,
    this.verse,
    this.verseCentered = true,
    super.key
  });
  // --------------------
  final double? width;
  final double? height;
  final List<String> activeCountriesIDs;
  final List<String> disabledCountriesIDs;
  final List<CensusModel>? censusModels;
  final Verse? verse;
  final bool verseCentered;
  final Function onStateTap;
  final Function? onDisabledStateTap;
  final ZoneModel? selectedZone;
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkUSABoxIsActive({
    required List<String> activeStatesIDs,
  }){
    return Lister.checkCanLoop(activeStatesIDs);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCanShowUSACensus({
    required CensusModel? combinedUSACensus,
  }){
    return CensusLine.canShowCensus(
      censusModel: combinedUSACensus,
      isPlanetButton: false,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkStateButtonIsActive({
    required List<String> activeStatesIDs,
    required String stateID,
  }){
    return Stringer.checkStringsContainString(
      strings: activeStatesIDs,
      string: stateID,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCanShowStateCensus({
    required CensusModel? stateCensus,
  }){
    return CensusLine.canShowCensus(
      censusModel: stateCensus,
      isPlanetButton: false,
    );
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------

    /// SCALES

    // --------------------
    final double _buttonWidth = width ?? Bubble.bubbleWidth(context: context);
    final double _stateButtonWidth = _buttonWidth - TileButton.defaultHeight;
    // --------------------

    /// STATES IDS

    // --------------------
    final List<String> _activeStatesIDs = America.getStatesIDsFromCountriesIDs(
      countriesIDs: activeCountriesIDs,
    );
    final List<String> _disabledStatedIDs = America.getStatesIDsFromCountriesIDs(
      countriesIDs: disabledCountriesIDs,
    );
    final List<String> _allStatesIDs = [..._activeStatesIDs, ..._disabledStatedIDs];
    // --------------------

    /// USA IS ACTIVE

    // --------------------
    final bool _usaBoxIsActive = checkUSABoxIsActive(
      activeStatesIDs: _activeStatesIDs,
    );
    // --------------------

    /// USA CENSUS

    // --------------------
    final CensusModel? _usaCensus = CensusModel.combineUSACensuses(
      models: censusModels,
    );
    final bool _canShowUSACensus = checkCanShowUSACensus(
      combinedUSACensus: _usaCensus,
    );
    // --------------------

    /// IS SELECTED

    // --------------------
    final bool _usaIsSelected = America.checkCountryIDIsStateID(selectedZone?.countryID);
    // --------------------
    return ZoneButtonBox(
      onTap: null,
      onDeactivatedTap: null,
      isActive: _usaBoxIsActive,
      isSelected: _usaIsSelected,
      isSelectedColor: Colorz.yellow10,
      canTap: false,
      columnChildren: <Widget>[

        Container(
          width: _buttonWidth,
          decoration: const BoxDecoration(
            color: Colorz.nothing,
            borderRadius: Borderers.constantCornersAll12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[

              /// FLAG & COUNTRY NAME
              TileButton(
                isActive: _usaBoxIsActive,
                height: height,
                width: _buttonWidth,
                /// IF COUNTRY FLAG IS NULL, IT WILL SHOW PLANET ICON
                icon: Flag.getCountryIcon('usa'),
                verse: Verse.plain(
                    CountryModel.translateCountry(
                      langCode: Localizer.getCurrentLangCode(),
                      countryID: 'usa',
                    )
                ),
                color: Colorz.black0,
                margins: EdgeInsets.zero,
                verseCentered: verseCentered,
                // onTap: null,
                // corners: BorderRadius.zero,
              ),

              /// USA CENSUS
              if (_canShowUSACensus == true)
              CensusLine(
                width: _buttonWidth,
                censusModel: _usaCensus,
                hasFlagSpace: true,
                isActive: _usaBoxIsActive,
              ),

              /// SEPARATOR
              Padding(
                padding: const EdgeInsets.only(
                  top: 5
                ),
                child: DotSeparator(
                  boxWidth: _stateButtonWidth,
                  bottomMarginIsOn: false,
                ),
              ),

              /// STATES
              SizedBox(
                width: _stateButtonWidth,
                // height: _allStatesIDs.length * ((TileButton.defaultHeight * 1.8) + 5),
                child: ListView.builder(
                  // itemExtent: (TileButton.defaultHeight * 1.8) + 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _allStatesIDs.length,
                  itemBuilder: (_, int index){

                    final String _stateID = _allStatesIDs[index];
                    final CensusModel? _censusModel = CensusModel.getCensusFromCensusesByID(
                      censuses: censusModels,
                      censusID: _stateID,
                    );
                    final bool _canShowCensus = checkCanShowStateCensus(
                      stateCensus: _censusModel,
                    );

                    final bool isActive = checkStateButtonIsActive(
                      stateID: _stateID,
                      activeStatesIDs: _activeStatesIDs,
                    );

                    final bool _isSelected = selectedZone?.countryID == _stateID;

                    final double _heightMultiplier = isActive == true && _canShowCensus == true ? 1.8 : 1;

                    return TapLayer(
                      height: TileButton.defaultHeight * _heightMultiplier,
                      onTap: () => onStateTap(_stateID),
                      onDisabledTap: () => onDisabledStateTap?.call(_stateID),
                      isDisabled: !isActive,
                      width: _stateButtonWidth,
                      corners: Borderers.constantCornersAll12,
                      boxColor: isActive == false ? null
                          :
                      ZoneButtonBox.getBoxColor(
                          isActive: isActive,
                          isSelected: _isSelected,
                          isSelectedColor: null,
                      ),
                      borderColor: _isSelected == false ? null : ZoneButtonBox.borderColor,
                      margin: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[

                          /// STATE NAME LINE
                          TileButton(
                            isActive: isActive,
                            height: height,
                            width: _stateButtonWidth,
                            /// IF COUNTRY FLAG IS NULL, IT WILL SHOW PLANET ICON
                            icon: Flag.getAmericaStateIcon(_stateID),
                            iconSizeFactor: 0.6,
                            verse: Verse.plain(
                              America.getStateName(
                                stateID: _stateID,
                                withISO2: America.useISO2,
                              ),
                            ),
                            color: Colorz.nothing,
                            margins: EdgeInsets.zero,
                            verseCentered: verseCentered,
                            // onTap: null,
                            // corners: BorderRadius.zero,
                          ),

                          /// CENSUS LINE
                          if (isActive == true && _canShowCensus == true)
                            CensusLine(
                              width: _stateButtonWidth,
                              censusModel: _censusModel,
                              hasFlagSpace: true,
                              isActive: isActive,
                            ),

                        ],
                      ),
                    );

                    },
                ),
              ),

            ],
          ),
        ),

      ],
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
