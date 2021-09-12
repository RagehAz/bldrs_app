import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/dashboard/flyers_manager/all_flyers_screen.dart';
import 'package:bldrs/dashboard/pricing_manager/pricing_screen.dart';
import 'package:bldrs/dashboard/s02_statistics.dart';
import 'package:bldrs/dashboard/s05_keywords_manager.dart';
import 'package:bldrs/dashboard/users_manager/users_manager_screen.dart';
import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/views/widgets/layouts/dashboard_layout.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'bzz_manager/bzz_manager_screen.dart';
import 'notifications_manager/s04_notifications_manager.dart';
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

    return DashBoardLayout(
        pageTitle: 'DashBoard',
        loading: false,
        listWidgets: <Widget>[

          DashboardWideButton(
            title: 'Big Mac Price Index',
            icon: Iconz.BigMac,
            onTap: () => Nav.goToNewScreen(context, PricingScreen()),
          ),

          DashboardWideButton(
            title: 'Pricing',
            icon: Iconz.Dollar,
            onTap: () => Nav.goToNewScreen(context, PricingScreen()),
          ),

          DashboardWideButton(
            title: 'All Flyers',
            icon: Iconz.Flyer,
            onTap: () => Nav.goToNewScreen(context, AllFlyersScreen()),
          ),

          DashboardWideButton(
              title: 'General Statistics',
              icon: Iconz.Statistics,
              onTap: () => Nav.goToNewScreen(context, GeneralStatistics()),
          ),

          DashboardWideButton(
              title: 'Users Manager',
              icon: Iconz.NormalUser,
              onTap: () => Nav.goToNewScreen(context, UsersManagerScreen()),
          ),

          DashboardWideButton(
            title: 'Zones Manager',
            icon: Iconz.Earth,
            onTap: () => Nav.goToNewScreen(context, ZonesManagerScreen()),
          ),

          DashboardWideButton(
            title: 'Bzz Manager',
            icon: Iconz.Bz,
            onTap: () => Nav.goToNewScreen(context, BzzManagerScreen()),
          ),

          DashboardWideButton(
            title: 'Notifications Manager',
            icon: Iconz.News,
            onTap: () => Nav.goToNewScreen(context, NotificationsManager()),
          ),

          DashboardWideButton(
            title: 'Keywords Manager',
            icon: Iconz.Language,
            onTap: () => Nav.goToNewScreen(context, KeywordsManager()),
          ),

          DashboardWideButton(
            title: 'Flyers Auditor',
            icon: Iconz.FlyerGrid,
            onTap: () => Nav.goToNewScreen(context, FlyersAuditor()),
          ),

          DashboardWideButton(
            title: 'Local Bz & Flyers Uploader',
            icon: Iconz.AddFlyer,
            onTap: () => Nav.goToNewScreen(context, LocalFlyersUploader()),
          ),

          PyramidsHorizon(),

        ]
    );
  }
}