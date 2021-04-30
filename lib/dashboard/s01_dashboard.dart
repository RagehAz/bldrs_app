// this in app dashboard will be separated into separate app to control database and audit app content
// or now it will be developed here until launch version is complete
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/dashboard/s02_statistics.dart';
import 'package:bldrs/dashboard/s05_keywords_manager.dart';
import 'package:bldrs/dashboard/users_manager/users_manager_screen.dart';
import 'package:bldrs/views/widgets/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/buttons/main_button.dart';
import 'package:bldrs/views/widgets/layouts/dashboard_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'bzz_manager_screen.dart';
import 's04_notifications_manager.dart';
import 's06_flyers_auditor.dart';
import 's07_local_flyers_uploader.dart';
import 'zones_manager/zones_manager_screen.dart';

class DashBoard extends StatefulWidget {

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {


  @override
  Widget build(BuildContext context) {

    // double _screenWidth = superScreenWidth(context);
    // double _screenHeight = superScreenHeight(context);

    Widget _button ({String title, String icon, Function onTap,}){
      return MainButton(
        buttonVerse: title,
        function: onTap,
        splashColor: Colorz.Yellow,
        buttonColor: Colorz.Yellow,
        verseColor: Colorz.BlackBlack,
        verseWeight : VerseWeight.black,
        buttonVerseShadow: false,
        stretched: false,
        buttonIcon: icon,
      );
    }

    return DashBoardLayout(
        pageTitle: 'DashBoard',
        loading: false,
        listWidgets: <Widget>[

          LogoSlogan(),

          _button(
              title: 'General Statistics',
              icon: Iconz.Statistics,
              onTap: () => Nav.goToNewScreen(context, GeneralStatistics()),
          ),

          _button(
              title: 'Users Manager',
              icon: Iconz.NormalUser,
              onTap: () => Nav.goToNewScreen(context, UsersManagerScreen()),
          ),

          _button(
            title: 'Zones Manager',
            icon: Iconz.Earth,
            onTap: () => Nav.goToNewScreen(context, ZonesManagerScreen()),
          ),

          _button(
            title: 'Bzz Manager',
            icon: Iconz.Bz,
            onTap: () => Nav.goToNewScreen(context, BzzManagerScreen()),
          ),

          _button(
            title: 'Notifications Manager',
            icon: Iconz.News,
            onTap: () => Nav.goToNewScreen(context, NotificationsManager()),
          ),

          _button(
            title: 'Keywords Manager',
            icon: Iconz.Language,
            onTap: () => Nav.goToNewScreen(context, KeywordsManager()),
          ),

          _button(
            title: 'Flyers Auditor',
            icon: Iconz.FlyerGrid,
            onTap: () => Nav.goToNewScreen(context, FlyersAuditor()),
          ),

          _button(
            title: 'Local Bz & Flyers Uploader',
            icon: Iconz.AddFlyer,
            onTap: () => Nav.goToNewScreen(context, LocalFlyersUploader()),
          ),

        ]
    );
  }
}