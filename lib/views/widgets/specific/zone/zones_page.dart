import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/providers/zones/old_zone_provider.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class ZonesPage extends StatelessWidget {
  final String title;
  final String continentIcon;
  final List<String> countriesIDs;
  final Function buttonTap;

  const ZonesPage({
    @required this.title,
    @required this.continentIcon,
    @required this.countriesIDs,
    @required this.buttonTap,
  });

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
    final double _verseHeight = superVerseRealHeight(context, 2, 1, Colorz.White10);

    return Container(
      width: _screenWidth,
      height: _screenHeight - Ratioz.stratosphere - 24,
      // color: Colorz.BabyBlueGlass,
      child: Column(
        children: <Widget>[

          DreamBox(
            height: 50,
            corners: 25,
            icon: continentIcon,
          ),

          SuperVerse(
            verse: title,
            size: 2,
            labelColor: Colorz.White10,
          ),

          const SizedBox(height: 10,),

          Container(
            width: _screenWidth,
            height: _screenHeight - Ratioz.stratosphere - 24 - 50 - _verseHeight - 10 - 2.2,
            // color: Colorz.YellowAir,
            child:Bubble(
              // title: 'Countries',
              centered: true,
              columnChildren: <Widget>[

                Container(
                  width: Bubble.clearWidth(context),
                  height: _screenHeight - Ratioz.stratosphere - 24 - 50 - _verseHeight - 10 - 2.2 - 30,
                  // color: Colorz.BloodTest,
                  child: ListView.builder(
                    itemCount: countriesIDs.length,
                    itemBuilder: (context, index){

                      final String _id = countriesIDs[index];

                      return
                        Align(
                          alignment: Aligners.superCenterAlignment(context),
                          child: DreamBox(
                            height: 35,
                            width: Bubble.clearWidth(context) - 10,
                            icon: Flagz.getFlagByCountryID(_id),
                            iconSizeFactor: 0.8,
                            verse: OldCountryProvider().getCountryNameInCurrentLanguageByIso3(context, _id),
                            bubble: false,
                            margins: const EdgeInsets.all(5),
                            verseScaleFactor: 0.8,
                            color: Colorz.White10,
                            // textDirection: superTextDirection(context),
                            onTap: () => buttonTap(_id),
                          ),
                        );
                    },
                  )
                  ,
                ),

              ],
            ),
          )

        ],
      ),
    );
  }
}