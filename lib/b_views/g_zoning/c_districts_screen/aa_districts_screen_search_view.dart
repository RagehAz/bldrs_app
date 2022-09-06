import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_district_button.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class DistrictsScreenSearchView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DistrictsScreenSearchView({
    @required this.onDistrictTap,
    @required this.loading,
    @required this.foundDistricts,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<String> onDistrictTap;
  final ValueNotifier<bool> loading;
  final ValueNotifier<List<DistrictModel>> foundDistricts;
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

                        final DistrictModel input = foundDistricts[index];

                        return WideDistrictButton(
                          district: input,
                          onTap: onDistrictTap,
                        );

                      }
                  );
                }

                /// WHEN RESULT IS EMPTY
                else {

                  return Container(
                    margin: _topMargin,
                    child: const SuperVerse(
                      verse: '##No Result found',
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
