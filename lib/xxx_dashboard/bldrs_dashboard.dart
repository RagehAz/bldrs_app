import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/notifications/notifications_manager/notifications_manager_screen.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/xxx_dashboard/a_modules/a_test_labs/specialized_labs/ask/new_questions_stuff/components/question_separator_line.dart';
import 'package:bldrs/xxx_dashboard/a_modules/a_test_labs/zzz_test_lab.dart';
import 'package:bldrs/xxx_dashboard/a_modules/bzz_manager/bzz_manager_screen.dart';
import 'package:bldrs/xxx_dashboard/a_modules/chains_manager/chains_manager_screen.dart';
import 'package:bldrs/xxx_dashboard/a_modules/flyers_manager/all_flyers_screen.dart';
import 'package:bldrs/xxx_dashboard/a_modules/flyers_manager/auditor/flyers_auditor_screen.dart';
import 'package:bldrs/xxx_dashboard/a_modules/ldb_manager/ldb_manager_screen.dart';
import 'package:bldrs/xxx_dashboard/a_modules/pricing_manager/pricing_screen.dart';
import 'package:bldrs/xxx_dashboard/a_modules/statistics/statistics_screen.dart';
import 'package:bldrs/xxx_dashboard/a_modules/ui_manager/ui_manager_screen.dart';
import 'package:bldrs/xxx_dashboard/a_modules/users_manager/users_manager_screen.dart';
import 'package:bldrs/xxx_dashboard/a_modules/zones_manager/zones_manager_screen.dart';
import 'package:bldrs/xxx_dashboard/b_widgets/dash_button/dash_button.dart';
import 'package:bldrs/xxx_dashboard/b_widgets/dash_button/dash_button_model.dart';
import 'package:bldrs/xxx_dashboard/a_modules/translations_manager/translations_manager.dart';
import 'package:flutter/material.dart';

class BldrsDashBoard extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsDashBoard({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    // -------------------------------------------------------
    const double _gridSpacing = 10;
    const int numberOfColumns = 3;
    const double _itemHeight = 50;

    final double _boxSize = (_screenWidth - ((numberOfColumns + 1) * _gridSpacing)) / 3;

    final SliverGridDelegate _gridDelegate =
    SliverGridDelegateWithFixedCrossAxisCount(
      mainAxisSpacing: _gridSpacing,
      crossAxisSpacing: _gridSpacing,
      mainAxisExtent: _boxSize,
      crossAxisCount: numberOfColumns,
    );
// -------------------------------------------------------
    final List<DashButtonModel> _buttons = <DashButtonModel>[

      /// TEST LAB
      DashButtonModel(
          verse: 'Test Lab',
          icon: Iconz.lab,
          screen: const TestLab()
      ),

      /// PHRASES EDITOR
      DashButtonModel(
          verse: 'Phrases\nEditor',
          icon: Iconz.language,
          screen: const TranslationsManager()
      ),

      /// CHAINS EDITOR
      DashButtonModel(
          verse: 'Chains\nEditor',
          icon: Iconz.keyword,
          screen: const ChainsManagerScreen()
      ),

      /// LDB VIEWER
      DashButtonModel(
          verse: 'Local db viewers',
          icon: Iconz.terms,
          screen: const LDBViewersScreen()
      ),

      /// LDB VIEWER
      DashButtonModel(
          verse: 'UI Manager',
          icon: Iconz.terms,
          screen: const UIManager()
      ),

      /// FLYERS AUDITOR
      DashButtonModel(
          verse: 'Flyers Auditor',
          icon: Iconz.verifyFlyer,
          screen: const FlyersAuditor()
      ),

      /// NOTIFICATIONS MANAGER
      DashButtonModel(
          verse: 'Notifications Manager',
          icon: Iconz.news,
          screen: const NotificationsManager()
      ),

      /// BZZ MANAGER
      DashButtonModel(
          verse: 'Bzz Manager',
          icon: Iconz.bz,
          screen: const BzzManagerScreen()
      ),

      /// ZONES MANAGER
      DashButtonModel(
          verse: 'Zones Manager',
          icon: Iconz.earth,
          screen: const ZonesManagerScreen()
      ),

      /// ZONES MANAGER
      DashButtonModel(
          verse: 'Users Manager',
          icon: Iconz.users,
          screen: const UsersManagerScreen()
      ),

      /// STATISTICS
      DashButtonModel(
          verse: 'Users Manager',
          icon: Iconz.statistics,
          screen: const GeneralStatistics()
      ),

      /// STATISTICS
      DashButtonModel(
          verse: 'All Flyers',
          icon: Iconz.flyerScale,
          screen: const AllFlyersScreen()
      ),

      /// BIG MC
      DashButtonModel(
          verse: 'All Flyers',
          icon: Iconz.bigMac,
          screen: const PricingScreen()
      ),

      /// PRICING
      DashButtonModel(
          verse: 'Pricing',
          icon: Iconz.bigMac,
          screen: null,
      ),


    ];
// -------------------------------------------------------
    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.non,
      pyramidsAreOn: true,
      layoutWidget: Column(
        children: <Widget>[

          /// BESM ALLAH
          const SizedBox(
            height: 50,
            child: SuperVerse(
              verse: 'Dear Lord\nPlease Bless this project to be in good use for humanity',
              size: 1,
              italic: true,
              weight: VerseWeight.thin,
              color: Colorz.white80,
              maxLines: 5,
              margin: 10,
            ),
          ),

          const QuestionSeparatorLine(),

          /// BUTTONS
          SizedBox(
            width: _screenWidth,
            height: _screenHeight - 50 - 20.25,
            child: GridView.builder(
                itemCount: _buttons.length,
                gridDelegate: _gridDelegate,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                itemBuilder: (BuildContext context, int index){

                  final DashButtonModel _button = _buttons[index];

                  return DashButton(
                    size: _boxSize,
                    dashButtonModel: _button,
                  );

                }
            ),
          ),

        ],
      ),
    );

  }
}
