import 'dart:async';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/a_starters/aa_static_logo_screen_view.dart';
import 'package:bldrs/b_views/x_screens/a_starters/cc_home_screen_view.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/super_pyramids.dart';
import 'package:bldrs/c_controllers/a_starters_controllers/c_home_controllers.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
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
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'HomeScreen',);
    }
  }
// -----------------------------------------------------------------------------
  /// KEYBOARDS CONTROLLERS
  StreamSubscription<bool> _keyboardSubscription;
  KeyboardVisibilityController keyboardVisibilityController;
  void _initializeKeyboard(){

    keyboardVisibilityController = KeyboardVisibilityController();

    /// Query
    blog('Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');

    /// Subscribe
    _keyboardSubscription = Keyboard.initializeKeyboardListener(
      context: context,
      controller: keyboardVisibilityController,
    );

  }
// -----------------------------------------------------------------------------
  /// NOTES STREAM SUBSCRIPTIONS
  StreamSubscription _userNotesStreamSub;
  List<StreamSubscription> _bzzNotesStreamsSubs;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _initializeKeyboard();
    _userNotesStreamSub = initializeUserNotes(context);
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        await initializeHomeScreen(context);

        if (mounted){
          initializeObeliskNumbers(context);
          // initializeUserNotes(context);
          _bzzNotesStreamsSubs = initializeMyBzzNotes(context);
        }

        if (mounted){
          await _triggerLoading();
        }

        if (mounted){
          await Nav.autoNavigateFromHomeScreen(context);
        }

      });

    _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {

    _loading.dispose();
    _keyboardSubscription.cancel();

    _userNotesStreamSub?.cancel();
    Streamer.disposeStreamSubscriptions(_bzzNotesStreamsSubs);

    super.dispose();
  }
// -----------------------------------------------------------------------------

  /// PYRAMID EXPANSION

// -------------------------------------
  final ValueNotifier<bool> _isExpanded = ValueNotifier(null);
  final ValueNotifier<ProgressBarModel> _progressBarModel = ValueNotifier(null);
// -------------------------------------
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
      return const Scaffold(
        body: LogoScreenView(),
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
                  );
                }

                /// UNKNOWN CONDITION
                else {

                  return const UserHomeScreen();
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

}
