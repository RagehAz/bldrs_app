import 'package:bldrs/ambassadors/services/database.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/view_brains/drafters/keyboarders.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/appbar/ab_main.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/skies/black_sky.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/buttons/bt_rageh.dart';
import 'package:provider/provider.dart';
import '../../../main.dart';

enum AppBarType{
  Basic,
  Scrollable,
  Main,
  Localizer,
}

enum Sky {
  Night,
  Black,
}

class MainLayout extends StatelessWidget {
  final List<Widget> appBarRowWidgets;
  final Widget layoutWidget;
  final Function tappingRageh;
  final String pyramids;
  final AppBarType appBarType;
  final String pageTitle;
  final Sky sky;

  MainLayout({
    this.appBarRowWidgets,
    this.layoutWidget,
    this.tappingRageh,
    this.pyramids,
    this.appBarType,
    this.pageTitle,
    this.sky = Sky.Night,
});

  @override
  Widget build(BuildContext context) {

    bool ragehIsOn = tappingRageh == null ? false : true;

    return StreamProvider<List<UserModel>>.value(
      value: DatabaseService().userStream,
      child: GestureDetector(
          onTap: (){minimizeKeyboardOnTapOutSide(context);},
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomPadding: false,
            // resizeToAvoidBottomInset: false,
            body: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[

                sky == Sky.Black ? BlackSky() :
                NightSky(),

                layoutWidget == null ? Container() :
                layoutWidget,


                pyramids == null ? Container() :
                Pyramids(whichPyramid: pyramids),

                appBarType == AppBarType.Basic || appBarType == AppBarType.Scrollable?
                ABStrip(
                  scrollable: appBarType == AppBarType.Scrollable ? true : false,
                  rowWidgets: (appBarRowWidgets == null && pageTitle == null) ? [Container()] :
                  <Widget>[

                    pageTitle == null ? Container() :
                    Center(
                      child: SuperVerse(
                        verse: pageTitle,
                        size: 3,
                        margin: 10,
                        shadow: true,
                      ),
                    ),

                    ... appBarRowWidgets == null ? [Container()] : appBarRowWidgets,

                  ],
                ) :

                appBarType == AppBarType.Main || appBarType == AppBarType.Localizer ?
                    ABMain(
                      countryButtonOn: true,
                      searchButtonOn: appBarType == AppBarType.Localizer ? false : true,
                      sectionsAreOn: appBarType == AppBarType.Localizer ? false : true,
                    )
                : appBarType == null ? Container() : Container(),

                ragehIsOn == false ? Container() :
                Rageh(
                  tappingRageh: tappingRageh != null ? tappingRageh : (){print('no function here bitch');},
                  doubleTappingRageh:
                  getTranslated(context, 'Active_Language') == 'Arabic' ?
                      () async {
                    Locale temp = await setLocale('en');
                    BldrsApp.setLocale(context, temp);
                  } :
                      () async {
                    Locale temp = await setLocale('ar');
                    BldrsApp.setLocale(context, temp);
                    },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- for testing purposes, only used in appBar
Widget zorar(Function function, String functionName){
  return DreamBox(
    height: 40,
    boxMargins: EdgeInsets.all(5),
    color: Colorz.WhiteAir,
    verse: functionName,
    verseScaleFactor: 0.7,
    boxFunction: function,
  );
}

// --- THE HORIZON IS JUST A BOTTOM PADDING AT THE BOTTOM OF ANY SCROLLABLE SCREEN
class PyramidsHorizon extends StatelessWidget {
  final double heightFactor;

  PyramidsHorizon({
    this.heightFactor = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Ratioz.horizon * heightFactor,
    );
  }
}

class Stratosphere extends StatelessWidget {
  final double heightFactor;

  Stratosphere({
    this.heightFactor = 1,
});

  static const EdgeInsets stratosphereInsets = EdgeInsets.only(top: Ratioz.stratosphere);
  static const EdgeInsets stratosphereSandwich = EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.stratosphere);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: 70 * heightFactor,
    );
  }
}

