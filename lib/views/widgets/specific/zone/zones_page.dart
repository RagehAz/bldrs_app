import 'package:bldrs/controllers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class ZonesPage extends StatelessWidget {
  final String title;
  final String continentIcon;
  final List<String> countriesIDs;
  final ValueChanged<String> buttonTap;
  final double pageHeight;

  const ZonesPage({
    @required this.title,
    @required this.continentIcon,
    @required this.countriesIDs,
    @required this.buttonTap,
    @required this.pageHeight,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
// -----------------------------------------------------------------------------
    const double _continentIconHeight = 50;
    const double _verseHeight = 25;//superVerseRealHeight(context, 2, 1, Colorz.White10);

    final double _pageHeight = pageHeight; //_screenHeight - Ratioz.stratosphere;
    final double _bubbleZoneHeight = _pageHeight - _continentIconHeight - _verseHeight;

    return SafeArea(
      child: Container(
        width: _screenWidth,
        height: _pageHeight,
        // color: Colorz.BloodTest,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            DreamBox(
              height: _continentIconHeight,
              corners: 25,
              icon: continentIcon,
            ),

            Container(
              height: _verseHeight,
              child: SuperVerse(
                verse: title,
                size: 2,
                labelColor: Colorz.white10,
              ),
            ),

            Container(
              width: _screenWidth,
              height: _bubbleZoneHeight,
              // color: Colorz.Black255,
              child:Bubble(
                // title: 'Countries',
                centered: true,
                columnChildren: <Widget>[

                  Container(
                    width: Bubble.clearWidth(context),
                    height: _screenHeight - Ratioz.stratosphere - _continentIconHeight - _verseHeight - (2 * Ratioz.appBarMargin) - 50,
                    // color: Colorz.BloodTest,
                    child: MaxBounceNavigator(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: countriesIDs.length,
                        itemBuilder: (BuildContext context, int index){

                          final String _id = countriesIDs[index];

                          return
                            Align(
                              alignment: Aligners.superCenterAlignment(context),
                              child: DreamBox(
                                height: 35,
                                width: Bubble.clearWidth(context) - 10,
                                icon: Flag.getFlagIconByCountryID(_id),
                                iconSizeFactor: 0.8,
                                verse: CountryModel.getTranslatedCountryNameByID(context: context, countryID: _id),
                                bubble: false,
                                margins: const EdgeInsets.all(5),
                                verseScaleFactor: 0.8,
                                color: Colorz.white10,
                                // textDirection: superTextDirection(context),
                                onTap: () => buttonTap(_id),
                              ),
                            );
                        },
                      ),
                    )
                    ,
                  ),

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}