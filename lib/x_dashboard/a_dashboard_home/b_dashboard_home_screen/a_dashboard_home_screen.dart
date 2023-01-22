import 'dart:async';

import 'package:bldrs/b_views/z_components/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/general_provider.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/main.dart';
import 'package:scale/scale.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:bldrs/x_dashboard/a_dashboard_home/b_dashboard_home_screen/dash_button/dash_button.dart';
import 'package:bldrs/x_dashboard/a_dashboard_home/b_dashboard_home_screen/dash_button/dash_button_model.dart';
import 'package:bldrs/x_dashboard/backend_lab/backend_lab_home.dart';
import 'package:bldrs/x_dashboard/hashtag_manager/hashtags_manager_screen.dart';
import 'package:bldrs/x_dashboard/phrase_editor/phrase_editor_screen.dart';
import 'package:bldrs/x_dashboard/chains_editor/a_chains_manager_screen.dart';
import 'package:bldrs/x_dashboard/pickers_editor/a_pickers_manager_screen.dart';
import 'package:bldrs/x_dashboard/device_info_reader/device_info_screen.dart';
import 'package:bldrs/x_dashboard/users_manager/a_users_manager_screen.dart';
import 'package:bldrs/x_dashboard/bzz_manager/a_bzz_manager_screen.dart';
import 'package:bldrs/x_dashboard/zones_manager/a_zones_manager_screen.dart';
import 'package:bldrs/x_dashboard/currency_manager/a_currency_manager_screen.dart';
import 'package:bldrs/x_dashboard/flyers_manager/all_flyers_screen.dart';
import 'package:bldrs/x_dashboard/flyers_auditor/a_flyers_auditor_screen.dart';
import 'package:bldrs/x_dashboard/census_manager/statistics_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/a_ui_manager_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/golden_scrolls_screen.dart';
import 'package:bldrs/x_dashboard/app_controls/a_app_controls_manager.dart';
import 'package:bldrs/x_dashboard/notes_creator/notes_creator_home.dart';
import 'package:bldrs/x_dashboard/xxx_test_lab.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

/// ONLY_FOR_BLDRS_DASHBOARD_VERSION
import 'package:page_transition/page_transition.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/x_dashboard/a_dashboard_home/a_lock_screen/lock_test_screen.dart';
/// TESTED : WORKS PERFECT
Future<void> onPyramidAdminDoubleTap(BuildContext context) async {

  final UserModel _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
  );

  if (_userModel?.isAdmin == true){

    final bool _result = await Nav.goToNewScreen(
      context: context,
      pageTransitionType: PageTransitionType.fade,
      screen: const LockScreen(),
    );

    if (_result == true){

      await Nav.pushAndRemoveAllBelow(
        context: context,
        screen: const DashBoardHomeScreen(),
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
        verse: 'Test Lab',
        icon: Iconz.lab,
        screen: TestLab(),
      ),
      null,
      /// BACK END LAB
      DashButtonModel(
        verse: 'Backend Lab',
        icon: Iconz.form,
        screen: BackendLabHome(),
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
        verse:  'Phrase\nEditor',
        icon: Iconz.language,
        screen: PhraseEditorScreen(),
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
      /// HASHTAG
      DashButtonModel(
        verse:  'HashTag\nManager',
        icon: Iconz.hashtag,
        screen: HashTagManager(),
      ),
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
        verse:  'Zones\nManager',
        icon: Iconz.earth,
        screen: ZonesManagerScreen(),
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
      /// NOTES CREATOR
      DashButtonModel(
        verse:  'Notes\nCreator',
        icon: Iconz.notification,
        screen: NotesCreatorScreen(),
      ),
      /// EMPTY
      null,
      /// EMPTY
      null,
      /// APP CONTROLS
      DashButtonModel(
        verse:  'App Controls',
        icon: Iconz.dashBoard,
        screen: AppControlsManager(),
      ),
      // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      /// EMPTY
      null,
      /// EMPTY
      null,
      /// DEVICE INFO
      DashButtonModel(
        verse: 'Device Info',
        icon: Iconz.mobilePhone,
        screen: DeviceInfoScreen(),
      ),
      /// EMPTY
      null,
      // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      /// EMPTY
      null,
      /// EMPTY
      DashButtonModel(
        verse: 'Golden Scrolls',
        icon: Iconz.dvGouran,
        iconColor: Colorz.yellow200,
        screen: GoldenScrollsScreen(),
      ),
      /// EMPTY
      null,
      /// EMPTY
      null,
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
      invertButtons: true,
      confirmButtonVerse: const Verse(
        text: 'Reboot !',
        translate: false,
      ),
    );

    if (_result == true){

      pushWaitDialog(
        context: context,
        verse: Verse.plain('Rebooting system'),
      );

      await Future.wait(<Future>[

        /// WIPE OUT LDB
        LDBOps.wipeOutEntireLDB(),

        /// WIPE OUT PRO
        GeneralProvider.wipeOutAllProviders(context),

      ]);

      /// SIGN OUT
      await AuthFireOps.signOut(
          context: context,
          routeToLogoScreen: true
      );

      await WaitDialog.closeWaitDialog(context);

    }

  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
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
    final int _youHaveBeenHereFor = Timers.calculateTimeDifferenceInDays(
            from: Timers.createDate(year: 2020, month: 06, day: 1),
            to: DateTime.now(),
        );
    // --------------------
    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
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
      child: ListView(
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

          const SeparatorLine(
            width: 200,
            thickness: 0.5,
          ),

          /// YOU HAVE BEEN HERE FOR
          SizedBox(
            height: 50,
            child: SuperVerse(
              verse: Verse(
                text: "You've been Blding ($devVersion) for ( $_youHaveBeenHereFor ) days",
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

          const SeparatorLine(
            width: 200,
            thickness: 0.5,
          ),

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
