

import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/tile_bubble.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class EditCityPage extends StatelessWidget {

  const EditCityPage({
    @required this.zoneModel,
    @required this.screenHeight,
    Key key
  }) : super(key: key);

  final ZoneModel zoneModel;
  final double screenHeight;

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
                dataValue: _city?.population,
            ),

            /// DISTRICTS
            DataStrip(
              dataKey: 'Districts',
              dataValue: '${_city?.districts?.length} districts',
            ),

            /// POSITION
            DataStrip(
              dataKey: 'Position',
              dataValue: _city?.position,
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

          ],
        ),

      );
    }

  }

}
