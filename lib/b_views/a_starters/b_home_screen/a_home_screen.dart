import 'dart:async';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/aa_static_logo_screen_view.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/aa_home_screen_view.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_initialization_controllers.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_notes_controllers.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/super_pyramids.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_home_screen_controllers.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class HomeScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const HomeScreen({
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _HomeScreenState createState() => _HomeScreenState();
/// --------------------------------------------------------------------------
}

class _HomeScreenState extends State<HomeScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isExpanded = ValueNotifier(null);
  final ValueNotifier<ProgressBarModel> _progressBarModel = ValueNotifier(null);
  // --------------------
  /// KEYBOARD VISIBILITY
  StreamSubscription<bool> _keyboardSubscription;
  final KeyboardVisibilityController keyboardVisibilityController = KeyboardVisibilityController();
  // --------------------
  /// NOTES STREAM SUBSCRIPTIONS
  StreamSubscription _userNotesStreamSub;
  List<StreamSubscription> _bzzNotesStreamsSubs;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({
    @required bool setTo,
  }) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _initializeKeyboard();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        if (PhraseProvider.proGetPhidsAreLoaded(context) == false){
          await Nav.pushNamedAndRemoveAllBelow(
              context: context,
              goToRoute: Routing.staticLogoScreen,
          );
        }

        await initializeHomeScreen(context);

        await initializeNotesListeners();

        await _triggerLoading(setTo: false);

        if (mounted){
          await Nav.autoNavigateFromHomeScreen(context);
        }

      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _keyboardSubscription.cancel();
    _userNotesStreamSub?.cancel();
    Streamer.disposeStreamSubscriptions(_bzzNotesStreamsSubs);
    _isExpanded.dispose();
    _progressBarModel.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// KEYBOARDS CONTROLLERS

  // --------------------
  /// TESTED : WORKS PERFECT
  void _initializeKeyboard(){

    /// Query
    // blog('Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');

    /// Subscribe
    _keyboardSubscription = Keyboard.initializeKeyboardListener(
      context: context,
      controller: keyboardVisibilityController,
    );

  }
  // -----------------------------------------------------------------------------

  /// NOTE LISTENERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> initializeNotesListeners() async{
    if (mounted){
      await initializeObeliskNumbers(context);
      _userNotesStreamSub = listenToUserUnseenNotes(context);
      _bzzNotesStreamsSubs = listenToMyBzzUnseenNotes(context);
    }
  }
  // -----------------------------------------------------------------------------

  /// PYRAMID EXPANSION

  // --------------------
  /// TESTED : WORKS PERFECT
  void onTriggerExpansion(){
    _isExpanded.value = !_isExpanded.value;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final RouteSettings _afterHomeRoute = UiProvider.proGetAfterHomeRoute(
      context: context,
      listen: true,
    );

    /// WHEN AFTER HOME ROUTE IS DEFINED => works as loading screen until didChangedDependencies methods finish
    if (_afterHomeRoute != null){
      return MainLayout(
        skyType: SkyType.non,
        onBack: () async {

          UiProvider.proClearAfterHomeRoute(
            context: context,
            notify: true,
          );

        },
        layoutWidget: const LogoScreenView(),
      );
    }

    /// WHEN AFTER HOME ROUTE IS NULL
    else {

      final List<BzModel> _bzzModels = BzzProvider.proGetMyBzz(context: context, listen: true);
      final UserModel _userModel = UsersProvider.proGetMyUserModel(context: context, listen: true);
      final ZoneModel _currentZone = ZoneProvider.proGetCurrentZone(context: context, listen: true);

      /// TASK MAIN NAV MODELS SHOULD BE PLACED IN PROVIDER TO LISTEN TO REBUILDS WHEN DELETING A BZ
      /// TASK : IT SHOULD WORK NOW AS WE PUT THE PRO GETTERS OUTSIDE THE BELOW METHOD
      final List<NavModel> _navModels = generateMainNavModels(
        context: context,
        userModel: _userModel,
        bzzModels: _bzzModels,
        currentZone: _currentZone,
      );

      return MainLayout(
        key: const ValueKey<String>('mainLayout'),
        sectionButtonIsOn: true,
        // navBarIsOn: false,
        appBarType: AppBarType.main,
        onBack: () => Nav.onLastGoBackInHomeScreen(context,),
        layoutWidget: Stack(
          children: <Widget>[

            /// PAGE CONTENTS
            ValueListenableBuilder(
              valueListenable: _loading,
              builder: (_, bool loading, Widget child){

                /// LOADING
                if (loading == true) {
                  return const FlyersGrid(
                    isLoadingGrid: true,
                    heroPath: 'Home_Screen_Flyers_Loading_Grid',
                  );
                }

                /// HOME FLYERS
                else {
                  return const HomeFlyersGrid();
                }

              },
            ),

            /// PYRAMIDS NAVIGATOR
            /// TASK : SHOULD LISTEN TO NAV MODELS IN A PROVIDER,, AND SHOULD PUT THE SELECTOR DEEPTER INSIDE SUPER PYRAMIDS
            SuperPyramids(
              isExpanded: _isExpanded,
              onExpansion: onTriggerExpansion,
              onRowTap: (int index) => onNavigate(
                context: context,
                index: index,
                models: _navModels,
                progressBarModel: _progressBarModel,
                isExpanded: _isExpanded,
              ),
              progressBarModel: _progressBarModel,
              navModels: _navModels,
              isYellow: true,
            ),

          ],
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------
}
