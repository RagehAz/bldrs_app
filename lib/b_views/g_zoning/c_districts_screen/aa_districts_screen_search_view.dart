import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/district_tile_button.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class DistrictsScreenSearchView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DistrictsScreenSearchView({
    @required this.onDistrictTap,
    @required this.loading,
    @required this.foundDistricts,
    @required this.censusModels,
    @required this.shownDistrictsIDs,
    @required this.onDeactivatedDistrictTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<String> onDistrictTap;
  final ValueNotifier<bool> loading;
  final ValueNotifier<List<DistrictModel>> foundDistricts;
  final List<CensusModel> censusModels;
  final List<String> shownDistrictsIDs;
  final ValueChanged<String> onDeactivatedDistrictTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: loading,
        builder:(_, bool loading, Widget child){

          /// WHILE LOADING
          if (loading == true){
            return const LoadingFullScreenLayer();
          }

          /// SEARCH RESULT
          else {

            return ValueListenableBuilder(
              valueListenable: foundDistricts,
              builder: (_, List<DistrictModel> foundDistricts, Widget child){

                const EdgeInsets _topMargin = EdgeInsets.only(
                  top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2,
                  bottom: Ratioz.horizon,
                );

                /// WHEN SEARCH RESULTS
                if (Mapper.checkCanLoopList(foundDistricts) == true){
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: foundDistricts.length,
                      padding: _topMargin,
                      shrinkWrap: true,
                      itemBuilder: (_, int index) {

                        final DistrictModel _districtModel = foundDistricts[index];

                        final CensusModel _census = CensusModel.getCensusFromCensusesByID(
                          censuses: censusModels,
                          censusID: _districtModel.id,
                        );

                        final bool _isActive = Stringer.checkStringsContainString(
                          strings: shownDistrictsIDs,
                          string: _districtModel.id,
                        );

                        return WideDistrictButton(
                          district: _districtModel,
                          onTap: onDistrictTap,
                          censusModel: _census,
                          isActive: _isActive,
                          onDeactivatedTap: onDeactivatedDistrictTap,
                        );

                      }
                  );
                }

                /// WHEN RESULT IS EMPTY
                else {

                  return Container(
                    margin: _topMargin,
                    child: const BldrsText(
                      verse: Verse(
                        id: 'phid_no_result_found',
                        translate: true,
                        casing: Casing.capitalizeFirstChar,
                      ),
                      labelColor: Colorz.white10,
                      size: 3,
                      weight: VerseWeight.thin,
                      italic: true,
                      color: Colorz.white200,
                    ),
                  );

                }

              },
            );

          }


        }
    );

  }
// -----------------------------------------------------------------------------
}
