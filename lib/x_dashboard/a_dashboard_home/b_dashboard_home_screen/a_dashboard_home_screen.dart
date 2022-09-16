import 'dart:async';

import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_fire_ops.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/a_dashboard_home/a_lock_screen/lock_test_screen.dart';
import 'package:bldrs/x_dashboard/a_dashboard_home/b_dashboard_home_screen/dash_button/dash_button.dart';
import 'package:bldrs/x_dashboard/a_dashboard_home/b_dashboard_home_screen/dash_button/dash_button_model.dart';
import 'package:bldrs/x_dashboard/x_modules/l_provider_viewer/provider_viewer_screen.dart';
import 'package:bldrs/x_dashboard/b_phrases_editor/a_phrase_manager_screen.dart';
import 'package:bldrs/x_dashboard/c_chains_editor/a_chains_manager_screen.dart';
import 'package:bldrs/x_dashboard/d_pickers_editors/a_pickers_manager_screen.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/a_notes_creator_screen.dart';
import 'package:bldrs/x_dashboard/g_zones_editor/a_zones_manager_screen.dart';
import 'package:bldrs/x_dashboard/f_bzz_manager/a_bzz_manager_screen.dart';
import 'package:bldrs/x_dashboard/e_users_manager/a_users_manager_screen.dart';
import 'package:bldrs/x_dashboard/j_flyers_auditor/a_flyers_auditor_screen.dart';
import 'package:bldrs/x_dashboard/i_flyers_manager/all_flyers_screen.dart';
import 'package:bldrs/x_dashboard/k_statistics/statistics_screen.dart';
import 'package:bldrs/x_dashboard/h_currency_manager/a_currency_manager_screen.dart';
import 'package:bldrs/x_dashboard/x_modules/k_pricing_manager/pricing_screen.dart';
import 'package:bldrs/x_dashboard/x_modules/l_ldb_manager/ldb_manager_screen.dart';
import 'package:bldrs/x_dashboard/x_modules/m_ui_manager/a_ui_manager_screen.dart';
import 'package:bldrs/x_dashboard/x_modules/n_app_controls/a_app_controls_manager.dart';
import 'package:bldrs/x_dashboard/xxx_test_lab.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Future<void> onPyramidAdminDoubleTap(BuildContext context) async {

  final UserModel _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
  );

  if (_userModel.isAdmin == true){

    final bool _result = await Nav.goToNewScreen(
      context: context,
      transitionType: PageTransitionType.fade,
      screen: const LockScreen(),
    );

    if (_result == true){

      await Nav.pushNamedAndRemoveAllBelow(
        context: context,
        goToRoute: Routing.ragehDashBoard,
      );

    }

  }

}

class DashBoardHomeScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DashBoardHomeScreen({
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
      DashButtonModel(
        verse:  'Provider viewer',
        icon: Iconz.check,
        screen: ProvidersViewerScreen(),
      ),
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
  // --------------------
  Future<void> _onRebootSystem(BuildContext context) async {

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        text: 'Reboot System ?',
        translate: false,
      ),
      bodyVerse: const Verse(
        text: 'This will clear all local data, all cache in pro and in LDB, continue ?',
        translate: false,
      ),
      boolDialog: true,
      confirmButtonVerse: const Verse(
        text: 'Fuck it !',
        translate: false,
      ),
    );

    if (_result == true){

      unawaited(WaitDialog.showWaitDialog(
        context: context,
        loadingVerse: Verse.plain('Rebooting system'),
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
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    // final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    // -------------------------------------------------------
    const double _gridSpacing = 10;
    const int numberOfColumns = 4;
    // const double _itemHeight = 50;
    final double _boxSize = (_screenWidth - ((numberOfColumns + 1) * _gridSpacing)) / numberOfColumns;
    // --------------------
    final SliverGridDelegate _gridDelegate =
    SliverGridDelegateWithFixedCrossAxisCount(
      mainAxisSpacing: _gridSpacing,
      crossAxisSpacing: _gridSpacing,
      mainAxisExtent: _boxSize,
      crossAxisCount: numberOfColumns,
    );
    // --------------------
    final List<DashButtonModel> _buttons = _getButtons();
    // --------------------
    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      sectionButtonIsOn: false,
      pyramidsAreOn: true,
      pyramidType: PyramidType.white,
      onBack: () async {

        final bool _result = await Dialogs.goBackDialog(
          context: context,
          titleVerse: const Verse(text: 'Exit Dashboard ?', translate: false),
          confirmButtonVerse: const Verse(text: 'Exit', translate: false),
        );

        if (_result == true){

          await Nav.pushNamedAndRemoveAllBelow(
            context: context,
            goToRoute: Routing.staticLogoScreen,
          );


        }

      },
      appBarRowWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          verse: const Verse(
            text: 'Reboot System',
            translate: false,
          ),
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
              verse: Verse(
                text: 'Dear Lord\nPlease Bless this project to be in good use for humanity',
                translate: false,
              ),
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
    // --------------------
  }
  /// --------------------------------------------------------------------------
}