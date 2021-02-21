import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/view_brains/drafters/keyboarders.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/appbar/bldrs_appbar.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids_menu.dart';
import 'package:bldrs/views/widgets/space/skies/black_sky.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/buttons/bt_rageh.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';

enum AppBarType{
  Basic,
  Scrollable,
  Main,
  Localizer,
  Intro,
  InPyramids,
  Sections,
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
  final bool canRefreshFlyers;

  MainLayout({
    this.appBarRowWidgets,
    this.layoutWidget,
    this.tappingRageh,
    this.pyramids,
    this.appBarType,
    this.pageTitle,
    this.sky = Sky.Night,
    this.canRefreshFlyers = false,
});

  Future<void> _refresh(BuildContext context) async {
    await Provider.of<FlyersProvider>(context,listen: false).fetchAndSetBzz();
  }

  @override
  Widget build(BuildContext context) {

    bool _ragehIsOn = tappingRageh == null ? false : true;

    return StreamProvider<List<UserModel>>.value(
      value: UserProvider().userStream,
      child: GestureDetector(
          onTap: (){minimizeKeyboardOnTapOutSide(context);},
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomPadding: false,
            // resizeToAvoidBottomInset: false,
            body:
            canRefreshFlyers ?

            RefreshIndicator(
              onRefresh: ()=> _refresh(context),
              color: Colorz.BlackBlack,
              backgroundColor: Colorz.Yellow,
              displacement: Ratioz.ddAppBarMargin,
              strokeWidth: 4,
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[

                  sky == Sky.Black ? BlackSky() :
                  NightSky(),

                  layoutWidget == null ? Container() :
                  layoutWidget,

                  if(appBarType!=null)
                    BldrsAppBar(
                      appBarType: appBarType,
                      appBarRowWidgets: appBarRowWidgets,
                      pageTitle: pageTitle,
                    ),

                  // pyramids == null ? Container() :
                  // Pyramids(whichPyramid: appBarType == AppBarType.Localizer ? Iconz.PyramidzYellow : pyramids),

                  // --- CHAT BUTTON
                  PyramidsMenu(),

                  _ragehIsOn == false ? Container() :
                  Rageh(
                    tappingRageh: tappingRageh != null ? tappingRageh : (){print('no function here bitch');},
                    doubleTappingRageh:
                    Wordz.activeLanguage(context) == 'Arabic' ?
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
            )

                :

            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[

                // --- BACKGROUND SKY
                sky == Sky.Black ? BlackSky() :
                NightSky(),

                // --- LAYOUT WIDGET
                layoutWidget == null ? Container() :
                layoutWidget,

                // --- BLDRS APPBAR
                if(appBarType!=null)
                  BldrsAppBar(
                    appBarType: appBarType,
                    appBarRowWidgets: appBarRowWidgets,
                    pageTitle: pageTitle,
                  ),

                // --- PYRAMIDS
                // pyramids == null ? Container() :
                // Pyramids(whichPyramid: appBarType == AppBarType.Localizer ? Iconz.PyramidzYellow : pyramids),


                // --- RAGEH BUTTON
                _ragehIsOn == false ? Container() :
                Rageh(
                  tappingRageh: tappingRageh != null ? tappingRageh : (){print('no function here bitch');},
                  doubleTappingRageh:
                  Wordz.activeLanguage(context) == 'Arabic' ?
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

    return Container(
      width: superScreenWidth(context),
      height: 70 * heightFactor,
    );
  }
}


