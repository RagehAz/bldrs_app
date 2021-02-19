// this in app dashboard will be separated into separate app to control database and audit app content
// or now it will be developed here until launch version is complete
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/buttons/bt_back.dart';
import 'package:bldrs/views/widgets/buttons/bt_main.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/dashboard/s02_statistics.dart';
import 'package:bldrs/xxx_LABORATORY/dashboard/s05_keywords_manager.dart';
import 'package:bldrs/xxx_LABORATORY/dashboard/s06_flyers_auditor.dart';
import 'package:flutter/material.dart';

import 's03_zones_manager.dart';
import 's04_notifications_manager.dart';

class DashBoard extends StatefulWidget {

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  String currentPage = 'Main';

  void pageSwitcher (String pageName){
    setState(() {
      currentPage = pageName;
    });
  }

  @override
  Widget build(BuildContext context) {

    double _screenWidth = superScreenWidth(context);
    double _screenHeight = superScreenHeight(context);

    return MainLayout(
      sky: Sky.Black,
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Basic,
      appBarRowWidgets: [BldrsBackButton()],
      layoutWidget: Container(
        width: _screenWidth,
        height: _screenHeight,
        child: ListView(
          children: <Widget>[

            Stratosphere(),

            LogoSlogan(onlyLogo: true,),

            Stratosphere(heightFactor: 0.5,),

            // --- General Statistics
            BTMain(
              buttonVerse: 'General Statistics',
              function: () => goToNewScreen(context, GeneralStatistics()),
              splashColor: Colorz.Yellow,
              buttonColor: Colorz.Yellow,
              verseColor: Colorz.BlackBlack,
              verseWeight : VerseWeight.black,
              buttonVerseShadow: false,
              stretched: false,
              buttonIcon: Iconz.Statistics,
            ),

            // --- ZONES MANAGER
            BTMain(
              buttonVerse: 'Zones Manager',
              function: () => goToNewScreen(context, ZonesManager()),
              splashColor: Colorz.Yellow,
              buttonColor: Colorz.Yellow,
              verseColor: Colorz.BlackBlack,
              verseWeight : VerseWeight.black,
              buttonVerseShadow: false,
              stretched: false,
              buttonIcon: Iconz.Earth,
            ),

            // --- NOTIFICATIONS MANAGER
            BTMain(
              buttonVerse: 'Notifications Manager',
              function: () => goToNewScreen(context, NotificationsManager()),
              splashColor: Colorz.Yellow,
              buttonColor: Colorz.Yellow,
              verseColor: Colorz.BlackBlack,
              verseWeight : VerseWeight.black,
              buttonVerseShadow: false,
              stretched: false,
              buttonIcon: Iconz.News,
            ),

            // --- KEYWORD MANAGER
            BTMain(
              buttonVerse: 'Keywords Manager',
              function: () => goToNewScreen(context, KeywordsManager()),
              splashColor: Colorz.Yellow,
              buttonColor: Colorz.Yellow,
              verseColor: Colorz.BlackBlack,
              verseWeight : VerseWeight.black,
              buttonVerseShadow: false,
              stretched: false,
              buttonIcon: Iconz.Language,
            ),

            // --- FLYERS AUDITOR
            BTMain(
              buttonVerse: 'Flyers Auditor',
              function: () => goToNewScreen(context, FlyersAuditor()),
              splashColor: Colorz.Yellow,
              buttonColor: Colorz.Yellow,
              verseColor: Colorz.BlackBlack,
              verseWeight : VerseWeight.black,
              buttonVerseShadow: false,
              stretched: false,
              buttonIcon: Iconz.FlyerGrid,
            ),

          ],
        ),
      ),
    );
  }
}