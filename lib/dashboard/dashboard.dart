import 'package:bldrs/controllers/router/navigators.dart' as Nav;
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/dashboard/bzz_manager/bzz_manager_screen.dart';
import 'package:bldrs/dashboard/flyers_manager/all_flyers_screen.dart';
import 'package:bldrs/dashboard/ldb_manager/ldb_manager_screen.dart';
import 'package:bldrs/dashboard/notifications_manager/notifications_manager_screen.dart';
import 'package:bldrs/dashboard/pricing_manager/pricing_screen.dart';
import 'package:bldrs/dashboard/statistics/statistics_screen.dart';
import 'package:bldrs/dashboard/keywords/keywords_manager_screen.dart';
import 'package:bldrs/dashboard/auditor/flyers_auditor_screen.dart';
import 'package:bldrs/dashboard/ui_manager/ui_manager_screen.dart';
import 'package:bldrs/dashboard/users_manager/users_manager_screen.dart';
import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/dashboard/zones_manager/zones_manager_screen.dart';
import 'package:bldrs/views/widgets/general/layouts/dashboard_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key key}) : super(key: key);

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

          WideButton(
            verse: 'Big Mac Price Index',
            icon: Iconz.BigMac,
            onTap: () => Nav.goToNewScreen(context, const PricingScreen()),
          ),

          WideButton(
            verse: 'Pricing',
            icon: Iconz.Dollar,
            onTap: () => Nav.goToNewScreen(context, const PricingScreen()),
          ),

          WideButton(
            verse: 'All Flyers',
            icon: Iconz.Flyer,
            onTap: () => Nav.goToNewScreen(context, const AllFlyersScreen()),
          ),

          WideButton(
              verse: 'General Statistics',
              icon: Iconz.Statistics,
              onTap: () => Nav.goToNewScreen(context, const GeneralStatistics()),
          ),

          WideButton(
              verse: 'Users Manager',
              icon: Iconz.Users,
              onTap: () => Nav.goToNewScreen(context, const UsersManagerScreen()),
          ),

          WideButton(
            verse: 'Zones Manager',
            icon: Iconz.Earth,
            onTap: () => Nav.goToNewScreen(context, const ZonesManagerScreen()),
          ),

          WideButton(
            verse: 'Bzz Manager',
            icon: Iconz.Bz,
            onTap: () => Nav.goToNewScreen(context, const BzzManagerScreen()),
          ),

          WideButton(
            verse: 'Notifications Manager',
            icon: Iconz.News,
            onTap: () => Nav.goToNewScreen(context, const NotificationsManager()),
          ),

          WideButton(
            verse: 'Keywords Manager',
            icon: Iconz.Keyword,
            onTap: () => Nav.goToNewScreen(context, const KeywordsManager()),
          ),

          WideButton(
            verse: 'Flyers Auditor',
            icon: Iconz.VerifyFlyer,
            onTap: () => Nav.goToNewScreen(context, const FlyersAuditor()),
          ),

          WideButton(
            verse: 'UI Manager',
            icon: Iconz.Star,
            onTap: () => Nav.goToNewScreen(context, const UIManager()),
          ),

          WideButton(
            verse: 'Local db viewers',
            icon: Iconz.Terms,
            onTap: () => Nav.goToNewScreen(context, const LDBViewersScreen()),
          ),

          const PyramidsHorizon(),

        ]
    );
  }
}