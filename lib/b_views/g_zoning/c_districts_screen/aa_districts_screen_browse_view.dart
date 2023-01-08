import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/city_tile_button.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/district_tile_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class DistrictsScreenBrowseView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DistrictsScreenBrowseView({
    @required this.districts,
    @required this.shownDistrictsIDs,
    @required this.onDistrictChanged,
    @required this.censusModels,
    @required this.onDeactivatedDistrictTap,
    @required this.cityCensus,
    @required this.onTapAllDistricts,
    @required this.showAllDistrictsButton,
    @required this.cityModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<DistrictModel> districts;
  final List<String> shownDistrictsIDs;
  final ValueChanged<String> onDistrictChanged;
  final ValueChanged<String> onDeactivatedDistrictTap;
  final List<CensusModel> censusModels;
  final CensusModel cityCensus;
  final Function onTapAllDistricts;
  final bool showAllDistrictsButton;
  final CityModel cityModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Mapper.checkCanLoopList(districts) == false){
      return const SizedBox();
    }

    else {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: districts.length + 1 ,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2, bottom: Ratioz.horizon),
        itemBuilder: (BuildContext context, int index) {

          if (index == 0){

            if (showAllDistrictsButton == false){
              return const SizedBox();
            }
            else {

              return WideCityButton(
                verse: const Verse(
                  text: 'phid_view_all_districts',
                  translate: true,
                ),
                city: cityModel,
                isActive: true,
                censusModel: cityCensus,
                onSingleTap: onTapAllDistricts,
                onDeactivatedTap: (){
                  blog('cityButton in districts screen i tapped while is deactivated');
                },
              );

            }

          }

          else {

            final DistrictModel _district = districts[index - 1];

            final CensusModel _census = CensusModel.getCensusFromCensusesByID(
              censuses: censusModels,
              censusID: _district.id,
            );

            final bool _isActive = Stringer.checkStringsContainString(
              strings: shownDistrictsIDs,
              string: _district.id,
            );

            return WideDistrictButton(
              district: _district,
              onTap: onDistrictChanged,
              censusModel: _census,
              isActive: _isActive,
              onDeactivatedTap: onDeactivatedDistrictTap,
            );

          }


        },
      );
    }

  }
  // -----------------------------------------------------------------------------
}
