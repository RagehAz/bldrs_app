import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/appbar/bldrs_app_bar.dart';
import 'package:bldrs/views/widgets/buttons/dream_wrapper.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/layouts/night_sky.dart';
import 'package:flutter/material.dart';

class AppBarTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: _screenWidth,
          height: _screenHeight,
          child: Stack(
            children: <Widget>[

              NightSky(sky: Sky.Night,),

              BldrsAppBar(
                loading: false,
                // backButtonIsOn: false,
                pageTitle: 'title',
              ),

              Center(
                child: DreamWrapper(
                  verses: <String>['wtf', 'eh dah', 'opaa'],
                  onTap: (value){print(value);},
                  buttonHeight: 30,
                  margins: const EdgeInsets.all(5),
                  spacing: 5,
                  boxHeight: 200,
                  boxWidth: 200,
                  icons: [Iconz.DvRageh, Iconz.Search, Iconz.ContNorthAmerica],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
