import 'dart:async';

import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_fire_ops.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/a_modules/b_phrases_editor/phrase_manager.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/chains_manager.dart';
import 'package:bldrs/x_dashboard/a_modules/c_spec_pickers_editor/spec_picker_manager_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/d_notes_creator/notes_creator.dart';
import 'package:bldrs/x_dashboard/a_modules/e_zones_editor/zones_manager_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/f_bzz_manager/bzz_manager_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/g_users_manager/users_manager_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/h_flyers_auditor/flyers_auditor_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/i_flyers_manager/all_flyers_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/j_statistics/statistics_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/k_currency_manager/currency_manager.dart';
import 'package:bldrs/x_dashboard/a_modules/k_pricing_manager/pricing_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/l_ldb_manager/ldb_manager_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/m_ui_manager/a_ui_manager_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/n_app_controls/app_controls_manager.dart';
import 'package:bldrs/x_dashboard/b_widgets/dash_button/dash_button.dart';
import 'package:bldrs/x_dashboard/b_widgets/dash_button/dash_button_model.dart';
import 'package:bldrs/xxxxx_test_lab.dart';
import 'package:flutter/material.dart';

class BldrsDashBoard extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsDashBoard({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  List<DashButtonModel> _getButtons(){

    const List<DashButtonModel> _buttons = <DashButtonModel>[
      // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      /// TEST LAB
      DashButtonModel(
        verse:  'Test Lab',
        icon: Iconz.lab,
        screen: TestLab(),
      ),
      /// EMPTY
      null,
      /// LDB VIEWER
      DashButtonModel(
        verse:  'Local db viewers',
        icon: Iconz.terms,
        screen: LDBViewersScreen(),
      ),
      /// UI MANAGER
      DashButtonModel(
        verse:  'UI\nManager',
        icon: Iconz.dvDonaldDuck,
        screen: UIManager(),
      ),
      // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      /// PHRASES EDITOR
      DashButtonModel(
        verse:  'Phrase\nManager',
        icon: Iconz.language,
        screen: PhraseManager(),
      ),
      /// CHAINS EDITOR
      DashButtonModel(
        verse:  'Chains\nManager',
        icon: Iconz.keyword,
        screen: ChainsManager(),
      ),
      /// SPEC PICKER manager
      DashButtonModel(
        verse:  'Spec Picker\nManager',
        icon: Iconz.more,
        screen: SpecPickerManager(),
      ),
      /// EMPTY
      null,
      // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      /// USERS MANAGER
      DashButtonModel(
        verse:  'Users Manager',
        icon: Iconz.users,
        screen: UsersManagerScreen(),
      ),
      /// BZZ MANAGER
      DashButtonModel(
        verse:  'Businesses Manager',
        icon: Iconz.bz,
        screen: BzzManagerScreen(),
      ),
      /// ZONES EDITOR
      DashButtonModel(
        verse:  'Zones\nEditor',
        icon: Iconz.earth,
        screen: ZonesEditorScreen(),
      ),
      /// CURRENCIES
      DashButtonModel(
        verse:  'Currency\nManager',
        icon: Iconz.dollar,
        screen: CurrencyManagerScreen(),
      ),
      // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      /// FLYERS AUDITOR
      DashButtonModel(
        verse:  'Flyers Auditor',
        icon: Iconz.verifyFlyer,
        screen: FlyersAuditor(),
      ),
      /// ALL FLYERS
      DashButtonModel(
        verse:  'All Flyers',
        icon: Iconz.flyerScale,
        screen: AllFlyersScreen(),
      ),
      /// EMPTY
      null,
      /// STATISTICS
      DashButtonModel(
        verse:  'Statistics',
        icon: Iconz.statistics,
        screen: GeneralStatistics(),
      ),
      // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      /// NOTIFICATIONS CREATOR
      DashButtonModel(
        verse:  'Notes\nCreator',
        icon: Iconz.news,
        screen: NotesCreatorScreen(),
      ),
      /// EMPTY
      null,
      /// BIG MAC
      DashButtonModel(
        verse:  'BigMc',
        icon: Iconz.bigMac,
        screen: PricingScreen(),
      ),
      /// APP CONTROLS
      DashButtonModel(
        verse:  'App Controls',
        icon: Iconz.dashBoard,
        screen: AppControlsManager(),
      ),
      // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ];

    return _buttons;
  }
  // -------------------------------------------------------
  Future<void> _onRebootSystem(BuildContext context) async {

      final bool _result = await CenterDialog.showCenterDialog(
        context: context,
        title: 'Reboot System ?',
        body: 'This will clear all local data, all cache in pro and in LDB, continue ?',
        boolDialog: true,
        confirmButtonText: 'Fuck it !',
      );

      if (_result == true){

        unawaited(WaitDialog.showWaitDialog(
          context: context,
          loadingPhrase: 'Rebooting system',
        ));

        /// WIPE OUT LDB
        await LDBOps.wipeOutEntireLDB();

        /// WIPE OUT PRO
        GeneralProvider.wipeOutAllProviders(context);

        /// SIGN OUT
        await AuthFireOps.signOut(
            context: context,
            routeToLogoScreen: true
        );

        WaitDialog.closeWaitDialog(context);

      }

  }
  // -------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    // final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    // -------------------------------------------------------
    const double _gridSpacing = 10;
    const int numberOfColumns = 4;
    // const double _itemHeight = 50;

    final double _boxSize = (_screenWidth - ((numberOfColumns + 1) * _gridSpacing)) / numberOfColumns;

    final SliverGridDelegate _gridDelegate =
    SliverGridDelegateWithFixedCrossAxisCount(
      mainAxisSpacing: _gridSpacing,
      crossAxisSpacing: _gridSpacing,
      mainAxisExtent: _boxSize,
      crossAxisCount: numberOfColumns,
    );
// -------------------------------------------------------

    final List<DashButtonModel> _buttons = _getButtons();
// -------------------------------------------------------
    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      sectionButtonIsOn: false,
      pyramidsAreOn: true,
      pyramidType: PyramidType.white,
      appBarRowWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          verse:  'Reboot System',
          icon: Iconz.reload,
          onTap: () => _onRebootSystem(context),
        ),

      ],
      layoutWidget: ListView(
        physics: const BouncingScrollPhysics(),
        padding: Stratosphere.stratosphereSandwich,
        children: <Widget>[

          /// BESM ALLAH
          const SizedBox(
            height: 50,
            child: SuperVerse(
              verse:  'Dear Lord\nPlease Bless this project to be in good use for humanity',
              size: 1,
              italic: true,
              weight: VerseWeight.thin,
              color: Colorz.white80,
              maxLines: 5,
              margin: 10,
            ),
          ),

          const SeparatorLine(width: 200),

          /// BUTTONS
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
              itemCount: _buttons.length,
              gridDelegate: _gridDelegate,
              shrinkWrap: true,
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

        ],
      ),
    );

  }
}
