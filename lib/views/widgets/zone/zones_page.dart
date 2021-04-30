import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class ZonesPage extends StatelessWidget {
  final String title;
  final String continentIcon;
  final List<String> countriesIDs;
  final Function buttonTap;

  ZonesPage({
    @required this.title,
    @required this.continentIcon,
    @required this.countriesIDs,
    @required this.buttonTap,
  });

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
    double _verseHeight = superVerseRealHeight(context, 2, 1, Colorz.WhiteAir);

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
            labelColor: Colorz.WhiteAir,
          ),

          SizedBox(height: 10,),

          Container(
            width: _screenWidth,
            height: _screenHeight - Ratioz.stratosphere - 24 - 50 - _verseHeight - 10 - 2.2,
            // color: Colorz.YellowAir,
            child:InPyramidsBubble(
              // title: 'Countries',
              centered: true,
              columnChildren: <Widget>[

                Container(
                  width: Scale.superBubbleClearWidth(context),
                  height: _screenHeight - Ratioz.stratosphere - 24 - 50 - _verseHeight - 10 - 2.2 - 30,
                  // color: Colorz.BloodTest,
                  child: ListView.builder(
                    itemCount: countriesIDs.length,
                    itemBuilder: (context, index){

                      String _id = countriesIDs[index];

                      return
                        Align(
                          alignment: Aligners.superCenterAlignment(context),
                          child: DreamBox(
                            height: 35,
                            width: Scale.superBubbleClearWidth(context) - 10,
                            icon: getFlagByIso3(_id),
                            iconSizeFactor: 0.8,
                            verse: CountryProvider().getCountryNameInCurrentLanguageByIso3(context, _id),
                            bubble: false,
                            boxMargins: EdgeInsets.all(5),
                            verseScaleFactor: 0.8,
                            color: Colorz.WhiteAir,
                            // textDirection: superTextDirection(context),
                            boxFunction: () => buttonTap(_id),
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