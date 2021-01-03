import 'package:bldrs/view_brains/drafters/keyboarders.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/appbar/ab_main.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/buttons/bt_rageh.dart';
import '../../../main.dart';

enum AppBarType{
  Basic,
  Scrollable,
  Main,
  Localizer,
}

class MainLayout extends StatelessWidget {
  final List<Widget> appBarRowWidgets;
  final Widget layoutWidget;
  final Function tappingRageh;
  final String pyramids;
  final AppBarType appBarType;
  final String pageTitle;

  MainLayout({
    this.appBarRowWidgets,
    this.layoutWidget,
    this.tappingRageh,
    this.pyramids,
    this.appBarType,
    this.pageTitle,
});

  @override
  Widget build(BuildContext context) {

    bool ragehIsOn = tappingRageh == null ? false : true;

    return GestureDetector(
        onTap: (){minimizeKeyboardOnTapOutSide(context);},
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,

          body: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[

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

