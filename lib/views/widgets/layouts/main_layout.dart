import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/appbar/ab_main.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
import 'package:bldrs/views/widgets/space/stratosphere.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/buttons/bt_rageh.dart';
import '../../../main.dart';

class MainLayout extends StatelessWidget {
  final List<Widget> appBarRowWidgets;
  final Widget layoutWidget;
  final bool scrollableAppBar;
  // final bool ragehIsOn;
  final Function tappingRageh;
  final bool appBarIsOn;
  final bool pyramidsAreOn;
  final bool stratosphereIsOn;

  MainLayout({
    this.appBarRowWidgets,
    this.layoutWidget,
    this.scrollableAppBar = false,
    // this.ragehIsOn = false,
    this.tappingRageh,
    this.appBarIsOn = true,
    this.pyramidsAreOn = true,
    this.stratosphereIsOn = true,
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
            Padding(
              padding: stratosphereIsOn ? Stratosphere.stratosphereInsets : EdgeInsets.all(0),
              child: layoutWidget,
            ),

            !pyramidsAreOn? Container() :
            Pyramids(whichPyramid: Iconz.PyramidsYellow),

            !appBarIsOn? Container() :
            ABStrip(
              scrollable: scrollableAppBar,
              rowWidgets: appBarRowWidgets == null ? [Container()] : appBarRowWidgets,
            ),

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
