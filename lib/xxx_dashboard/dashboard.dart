import 'package:bldrs/f_helpers/notifications/notifications_manager/notifications_manager_screen.dart';
import 'package:bldrs/xxx_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/xxx_dashboard/a_modules/bzz_manager/bzz_manager_screen.dart';
import 'package:bldrs/xxx_dashboard/a_modules/flyers_manager/all_flyers_screen.dart';
import 'package:bldrs/xxx_dashboard/a_modules/flyers_manager/auditor/flyers_auditor_screen.dart';
import 'package:bldrs/xxx_dashboard/a_modules/keywords/keywords_manager_screen.dart';
import 'package:bldrs/xxx_dashboard/a_modules/ldb_manager/ldb_manager_screen.dart';
import 'package:bldrs/xxx_dashboard/a_modules/pricing_manager/pricing_screen.dart';
import 'package:bldrs/xxx_dashboard/a_modules/statistics/statistics_screen.dart';
import 'package:bldrs/xxx_dashboard/a_modules/ui_manager/ui_manager_screen.dart';
import 'package:bldrs/xxx_dashboard/a_modules/users_manager/users_manager_screen.dart';
import 'package:bldrs/xxx_dashboard/b_widgets/wide_button.dart';
import 'package:bldrs/xxx_dashboard/a_modules/zones_manager/zones_manager_screen.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {

  const DashBoard({
    Key key
  }) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return DashBoardLayout(pageTitle: 'DashBoard', listWidgets: <Widget>[

      WideButton(
        verse: 'Big Mac Price Index',
        icon: Iconz.bigMac,
        onTap: () => Nav.goToNewScreen(context, const PricingScreen()),
      ),

      WideButton(
        verse: 'Pricing',
        icon: Iconz.dollar,
        onTap: () => Nav.goToNewScreen(context, const PricingScreen()),
      ),

      WideButton(
        verse: 'All Flyers',
        icon: Iconz.flyer,
        onTap: () => Nav.goToNewScreen(context, const AllFlyersScreen()),
      ),

      WideButton(
        verse: 'General Statistics',
        icon: Iconz.statistics,
        onTap: () => Nav.goToNewScreen(context, const GeneralStatistics()),
      ),

      WideButton(
        verse: 'Users Manager',
        icon: Iconz.users,
        onTap: () => Nav.goToNewScreen(context, const UsersManagerScreen()),
      ),

      WideButton(
        verse: 'Zones Manager',
        icon: Iconz.earth,
        onTap: () => Nav.goToNewScreen(context, const ZonesManagerScreen()),
      ),

      WideButton(
        verse: 'Bzz Manager',
        icon: Iconz.bz,
        onTap: () => Nav.goToNewScreen(context, const BzzManagerScreen()),
      ),

      WideButton(
        verse: 'Notifications Manager',
        icon: Iconz.news,
        onTap: () => Nav.goToNewScreen(context, const NotificationsManager()),
      ),

      WideButton(
        verse: 'Keywords Manager',
        icon: Iconz.keyword,
        onTap: () => Nav.goToNewScreen(context, const KeywordsManager()),
      ),

      WideButton(
        verse: 'Flyers Auditor',
        icon: Iconz.verifyFlyer,
        onTap: () => Nav.goToNewScreen(context, const FlyersAuditor()),
      ),

      WideButton(
        verse: 'UI Manager',
        icon: Iconz.star,
        onTap: () => Nav.goToNewScreen(context, const UIManager()),
      ),

      WideButton(
        verse: 'Local db viewers',
        icon: Iconz.terms,
        onTap: () => Nav.goToNewScreen(context, const LDBViewersScreen()),
      ),

      const Horizon(),

    ]);
  }
}
