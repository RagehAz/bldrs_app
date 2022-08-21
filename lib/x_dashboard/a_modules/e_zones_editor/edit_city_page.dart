

import 'package:bldrs/a_models/chain/city_phid_counters.dart';
import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/tile_bubble.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/e_db/real/foundation/real.dart';
import 'package:bldrs/e_db/real/foundation/real_colls.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class EditCityPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const EditCityPage({
    @required this.zoneModel,
    @required this.screenHeight,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ZoneModel zoneModel;
  final double screenHeight;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final CityModel _city = zoneModel?.cityModel;

    if (_city == null){
      return const SizedBox();
    }

    else {

      final double _clearWidth = PageBubble.clearWidth(context);

      return PageBubble(
        screenHeightWithoutSafeArea: screenHeight,
        appBarType: AppBarType.basic,
        color: Colorz.bloodTest,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[

            /// NAME
            SuperVerse(
              verse: zoneModel?.cityName,
              size: 5,
              labelColor: Colorz.white50,
              maxLines: 3,
              margin: 20,
            ),

            /// POPULATION
            DataStrip(
                dataKey: 'Population',
                dataValue: Numeric.formatNumToSeparatedKilos(number: _city?.population),
            ),

            /// DISTRICTS
            DataStrip(
              dataKey: 'Districts',
              dataValue: '${_city?.districts?.length} districts',
            ),

            /// POSITION
            DataStrip(
              dataKey: 'Position',
              dataValue: 'Lat: ${_city?.position?.latitude} , Lng: ${_city?.position?.longitude}',
            ),

            /// STATE
            DataStrip(
              dataKey: 'State',
              dataValue: _city?.state,
            ),

            /// PHRASES
            if (Mapper.checkCanLoopList(_city.phrases) == true)
              ...List.generate(_city.phrases.length, (index){

                final Phrase _phrase = _city.phrases[index];

                return DataStrip(
                  dataKey: 'Name ${_phrase?.langCode}',
                  dataValue: _phrase.value,
                );

              }),

            /// --- IS ACTIVATED
            TileBubble(
              bubbleWidth: _clearWidth,
              bubbleHeaderVM: BubbleHeaderVM(
                headline: 'City is Activated',
                hasSwitch: true,
                onSwitchTap: (bool val) {
                  blog('city is Active : $val');
                },
                switchIsOn: _city?.isActivated,

              ),
              secondLine: 'When City is Deactivated, '
                  '\nonly business authors may see it while creating business profile'
                  "\nBut Users won't see it while browsing",
            ),

            /// --- IS PUBLIC
            TileBubble(
              bubbleWidth: _clearWidth,
              bubbleHeaderVM: BubbleHeaderVM(
                leadingIconBoxColor: Colorz.grey50,
                headline: 'City is Global ?',
                hasSwitch: true,
                onSwitchTap: (bool val) {
                  blog('city is Global : $val');
                },
                switchIsOn: _city?.isPublic,
              ),
              secondLine: 'Means City content volumes reached the publishing sweet spot'
                  '\nUsers of This city can view Flyers now,, not only The Businesses'
                  '\nWhen Switched On users can only see City Businesses but not Flyers or Questions',
            ),

            const SeparatorLine(
              width: 300,
            ),

            if (_city?.cityID != null)
              FutureBuilder(
                  future: Real.readDocOnce(
                    context: context,
                    collName: RealColl.chainsUsage,
                    docName: _city.cityID,
                  ),
                  builder: (_, AsyncSnapshot<dynamic> snapshot){
                    final Map<String, dynamic> _map = snapshot.data;

                    if (Streamer.connectionIsLoading(snapshot) == true){
                      return const Loading(loading: true);
                    }

                    else {

                      final CityPhidCounters _countersModel = CityPhidCounters.decipherCityChain(
                          map: _map,
                          cityID: _city.cityID,
                      );

                      List<MapModel> keywords = _countersModel.phidsCounters;
                      keywords = MapModel.removeMapsWithThisValue(
                        mapModels: keywords,
                        value: 0,
                      );
                      keywords = MapModel.removeMapsWithThisValue(
                        mapModels: keywords,
                        value: _city.cityID,
                      );

                      return Column(
                        children: <Widget>[

                          if (Mapper.checkCanLoopList(keywords) == true)
                          ...List.generate(keywords.length, (index){

                            final MapModel _kw = keywords[index];

                            return DreamBox(
                              height: 30,
                              width: PageBubble.clearWidth(context),
                              icon: ChainsProvider.proGetPhidIcon(context: context, son: _kw.key),
                              verse: '${_kw.value} : ${_kw.key}',
                              verseScaleFactor: 0.6,
                              verseWeight: VerseWeight.thin,
                              verseCentered: false,
                            );

                          },


                          )
                        ],

                      );

                    }

                  }),

            const Horizon(),

          ],
        ),

      );
    }

  }

}