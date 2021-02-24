import 'package:bldrs/models/planet/country_model.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class CountryScreen extends StatelessWidget {
  final Country country;

  CountryScreen({@required this.country});

  @override
  Widget build(BuildContext context) {

    double _screenWidth = superScreenWidth(context);
    double _screenHeight = superScreenHeight(context);


    return MainLayout(
      sky: Sky.Black,
      pyramids: Iconz.PyramidzYellow,
      layoutWidget: Container(
        width: _screenWidth,
        height: _screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Stratosphere(heightFactor: 0.1),

            InPyramidsBubble(
              centered: true,
                columnChildren: <Widget>[
                  DreamBox(
                    height: _screenWidth * 0.1,
                    width: _screenWidth * 0.8,
                    color: Colorz.WhiteGlass,
                    icon: country.flag,
                    verse: country.name,
                    verseMaxLines: 2,
                    verseScaleFactor: 0.8,
                    boxMargins: EdgeInsets.all(7.5),
                    boxFunction: () => superDialog(context, '${country.iso3}', 'Country ISO3'),
                  ),

                ],
            ),


          ],
        ),
      ),
    );
  }
}
