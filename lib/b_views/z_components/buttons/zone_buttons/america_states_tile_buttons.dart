import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:basics/helpers/models/flag_model.dart';
import 'package:basics/super_box/src/f_super_box_tap_layer/x_tap_layer.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
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
    this.width,
    this.height,
    this.censusModels,
    this.verse,
    this.verseCentered = true,
    super.key
  });
  // --------------------
  final double? width;
  final double? height;
  final List<CensusModel>? censusModels;
  final Verse? verse;
  final bool verseCentered;
  final Function onStateTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _buttonWidth = width ?? Bubble.bubbleWidth(context: context);
    final List<String> _allStatesIDs = America.getStatesIDs();
    final double _stateButtonWidth = _buttonWidth - TileButton.defaultHeight;
    // --------------------
    return ZoneButtonBox(
      onTap: null,
      onDeactivatedTap: null,
      isActive: false,
      isSelected: false,
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
                isActive: true,
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
                onTap: null,
                // corners: BorderRadius.zero,
              ),

              /// STATES
              SizedBox(
                width: _stateButtonWidth,
                height: _allStatesIDs.length * ((TileButton.defaultHeight * 1.8) + 5),
                child: ListView.builder(
                  itemExtent: (TileButton.defaultHeight * 1.8) + 5,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _allStatesIDs.length,
                  itemBuilder: (_, int index){

                    final String _stateID = _allStatesIDs[index];
                    const bool isActive = true;
                    final CensusModel censusModel = CensusModel.createEmptyModel().copyWith(
                      totalBzz: Numeric.createRandomIndex(listLength: 9999999),
                      totalUsers: Numeric.createRandomIndex(listLength: 9999999),
                      totalFlyers: Numeric.createRandomIndex(listLength: 9999999),
                    );

                    return TapLayer(
                      height: TileButton.defaultHeight * 1.8,
                      onTap: () => onStateTap(_stateID),
                      width: _stateButtonWidth,
                      boxColor: Colorz.white10,
                      corners: Borderers.constantCornersAll12,
                      margin: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[

                          /// STATE NAME LINE
                          TileButton(
                            isActive: true,
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
                            onTap: null,
                            // corners: BorderRadius.zero,
                          ),

                          /// CENSUS LINE
                          if (isActive == true)
                            CensusLine(
                              width: _stateButtonWidth,
                              censusModel: censusModel,
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
  /// --------------------------------------------------------------------------
}
