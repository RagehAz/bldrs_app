import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/x_dashboard/a_modules/d_notes_creator/notes_creator.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/new_questions_stuff/components/question_separator_line.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/zzz_test_lab.dart';
import 'package:bldrs/x_dashboard/a_modules/f_bzz_manager/bzz_manager_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/chains_manager_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/i_flyers_manager/all_flyers_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/h_flyers_auditor/flyers_auditor_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/k_currency_manager/currency_manager.dart';
import 'package:bldrs/x_dashboard/a_modules/l_ldb_manager/ldb_manager_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/k_pricing_manager/pricing_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/j_statistics/statistics_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/m_ui_manager/a_ui_manager_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/g_users_manager/users_manager_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/e_zones_editor/zones_manager_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/n_app_controls/app_controls_manager.dart';
import 'package:bldrs/x_dashboard/b_widgets/dash_button/dash_button.dart';
import 'package:bldrs/x_dashboard/b_widgets/dash_button/dash_button_model.dart';
import 'package:bldrs/x_dashboard/a_modules/b_phrases_editor/translations_manager.dart';
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
    // const double _itemHeight = 50;

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
          screen: const TestLab(),
      ),

      null,

      /// TEST LAB
      DashButtonModel(
          verse: 'App Controls',
          icon: Iconz.dashBoard,
          screen: const AppControlsManager(),
      ),


      /// PHRASES EDITOR
      DashButtonModel(
          verse: 'Phrases\nEditor',
          icon: Iconz.language,
          screen: const TranslationsManager(),
      ),

      /// CHAINS EDITOR
      DashButtonModel(
          verse: 'Chains\nEditor',
          icon: Iconz.keyword,
          screen: const ChainsManagerScreen(),
      ),

      /// NOTIFICATIONS CREATOR
      DashButtonModel(
          verse: 'Notes\nCreator',
          icon: Iconz.news,
          screen: const NotesCreatorScreen(),
      ),

      /// ZONES EDITOR
      DashButtonModel(
          verse: 'Zones Editor',
          icon: Iconz.earth,
          screen: const ZonesEditorScreen(),
      ),

      /// BZZ MANAGER
      DashButtonModel(
          verse: 'Businesses Manager',
          icon: Iconz.bz,
          screen: const BzzManagerScreen(),
      ),

      /// USERS MANAGER
      DashButtonModel(
          verse: 'Users Manager',
          icon: Iconz.users,
          screen: const UsersManagerScreen(),
      ),

      /// FLYERS AUDITOR
      DashButtonModel(
          verse: 'Flyers Auditor',
          icon: Iconz.verifyFlyer,
          screen: const FlyersAuditor(),
      ),

      null,

      /// ALL FLYERS
      DashButtonModel(
          verse: 'All Flyers',
          icon: Iconz.flyerScale,
          screen: const AllFlyersScreen(),
      ),

      null,

      /// STATISTICS
      DashButtonModel(
          verse: 'Statistics',
          icon: Iconz.statistics,
          screen: const GeneralStatistics(),
      ),

      null,

      /// BIGMC
      DashButtonModel(
          verse: 'BigMc',
          icon: Iconz.bigMac,
          screen: const PricingScreen(),
      ),

      DashButtonModel(
        verse: 'Currencies',
        icon: Iconz.dollar,
        screen: const CurrencyManagerScreen(),
      ),

      /// LDB VIEWER
      DashButtonModel(
          verse: 'Local db viewers',
          icon: Iconz.terms,
          screen: const LDBViewersScreen(),
      ),

      null,

      /// UI MANAGER
      DashButtonModel(
          verse: 'UI Manager',
          icon: Iconz.dvDonaldDuck,
          screen: const UIManager(),
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
              physics: const BouncingScrollPhysics(),
                itemCount: _buttons.length,
                gridDelegate: _gridDelegate,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 100),
                itemBuilder: (BuildContext context, int index){

                  final DashButtonModel _button = _buttons[index];

                  if (_button == null){
                    return const SizedBox();
                  }

                  else {
                    return DashButton(
                      size: _boxSize,
                      dashButtonModel: _button,
                    );
                  }

                }
            ),
          ),

        ],
      ),
    );

  }
}
