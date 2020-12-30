import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/views/widgets/appbar/ab_main.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/buttons/bt_rageh.dart';
import '../../../main.dart';

enum AppBarType{
  Basic,
  Scrollable,
  Main,
}

class MainLayout extends StatelessWidget {
  final List<Widget> appBarRowWidgets;
  final Widget layoutWidget;
  // final bool scrollableAppBar;
  // final bool ragehIsOn;
  final Function tappingRageh;
  // final bool appBarIsOn;
  final String pyramids;
  final AppBarType appBarType;

  MainLayout({
    this.appBarRowWidgets,
    this.layoutWidget,
    // this.ragehIsOn = false,
    this.tappingRageh,
    this.pyramids,
    this.appBarType,
});

  @override
  Widget build(BuildContext context) {

    bool ragehIsOn = tappingRageh == null ? false : true;

    return SafeArea(
      child: Scaffold(
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
              rowWidgets: appBarRowWidgets == null ? [Container()] : appBarRowWidgets,
            ) :

            appBarType == AppBarType.Main ?
                ABMain()
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
    );
  }
}
