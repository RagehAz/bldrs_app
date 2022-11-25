import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/b_views/z_components/buttons/tile_buttons/city_tile_button.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class CitiesScreenSearchView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CitiesScreenSearchView({
    @required this.onCityTap,
    @required this.loading,
    @required this.foundCities,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<String> onCityTap;
  final ValueNotifier<bool> loading;
  final ValueNotifier<List<CityModel>> foundCities;
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
              valueListenable: foundCities,
              builder: (_, List<CityModel> foundCities, Widget child){

                const EdgeInsets _topMargin = EdgeInsets.only(
                  top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2,
                  bottom: Ratioz.horizon,
                );

                /// WHEN SEARCH RESULTS
                if (Mapper.checkCanLoopList(foundCities) == true){


                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: foundCities.length,
                      padding: _topMargin,
                      shrinkWrap: true,
                      itemBuilder: (_, int index) {

                        final CityModel input = foundCities[index];

                        return WideCityButton(
                          city: input,
                          onTap: onCityTap,
                        );

                      }
                  );

                }

                /// WHEN RESULT IS EMPTY
                else {

                  return Container(
                    margin: _topMargin,
                    child: const SuperVerse(
                      verse: Verse(
                        text: 'phid_no_result_found',
                        translate: true,
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
