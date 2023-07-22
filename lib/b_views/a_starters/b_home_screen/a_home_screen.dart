import 'dart:async';

import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/aa_static_logo_screen_view.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/aa_home_screen_view.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_home_screen_controllers.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_initialization_controllers.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_notes_controllers.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/pyramids/super_pyramids.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/e_back_end/f_cloud/dynamic_links.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart';
import 'package:bldrs/f_helpers/router/bldrs_nav.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:bldrs/z_grid/z_grid.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class HomeScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const HomeScreen({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  _HomeScreenState createState() => _HomeScreenState();
  /// --------------------------------------------------------------------------
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  // -----------------------------------------------------------------------------
  final ValueNotifier<ProgressBarModel?> _progressBarModel = ValueNotifier(null);
  PaginationController? _paginationController;
  // --------------------
  /// KEYBOARD VISIBILITY
  StreamSubscription<bool>? _keyboardSubscription;
  final KeyboardVisibilityController keyboardVisibilityController = KeyboardVisibilityController();
  // --------------------
  /// NOTES STREAM SUBSCRIPTIONS
  StreamSubscription? _userNotesStreamSub;
  List<StreamSubscription>? _bzzNotesStreamsSubs;
  // -----------------------------------------------------------------------------
  ZGridController? _zGridController;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({
    required bool setTo,
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
    _paginationController = PaginationController.initialize(
      addExtraMapsAtEnd: true,
    );

    _zGridController = ZGridController.initialize(
      vsync: this,
      scrollController: _paginationController?.scrollController,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {

        if (PhraseProvider.proGetPhidsAreLoaded() == false){
          await Nav.pushNamedAndRemoveAllBelow(
              context: context,
              goToRoute: Routing.staticLogoScreen,
          );
        }

        await initializeHomeScreen(context: context);

        await initializeNotesListeners();

        await _triggerLoading(setTo: false);

        if (mounted){
          await BldrsNav.autoNavigateFromHomeScreen();
        }

        /// DYNAMIC LINKS
        await DynamicLinks.initDynamicLinks();

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _keyboardSubscription?.cancel();
    _userNotesStreamSub?.cancel();
    Streamer.disposeStreamSubscriptions(_bzzNotesStreamsSubs);
    _progressBarModel.dispose();
    _paginationController?.dispose();
    _zGridController?.dispose();
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
      controller: keyboardVisibilityController,
    );

  }
  // -----------------------------------------------------------------------------

  /// NOTE LISTENERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> initializeNotesListeners() async{
    if (mounted){
      await initializeObeliskNumbers(
        context: context,
      );
      _userNotesStreamSub = listenToUserUnseenNotes();
      _bzzNotesStreamsSubs = listenToMyBzzUnseenNotes();
    }
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final RouteSettings? _afterHomeRoute = UiProvider.proGetAfterHomeRoute(
      context: context,
      listen: true,
    );

    /// WHEN AFTER HOME ROUTE IS DEFINED => works as loading screen until didChangedDependencies methods finish
    if (_afterHomeRoute != null){

      blog('building home screen for after home route');

      return MainLayout(
        skyType: SkyType.non,
        onBack: () async {

          UiProvider.proClearAfterHomeRoute(
            notify: true,
          );

        },
        child: const LogoScreenView(),
      );
    }

    /// WHEN AFTER HOME ROUTE IS NULL
    else {

      final List<BzModel> _bzzModels = BzzProvider.proGetMyBzz(
        context: context,
        listen: true,
      );
      final UserModel? _userModel = UsersProvider.proGetMyUserModel(
        context: context,
        listen: true,
      );
      final ZoneModel? _currentZone = ZoneProvider.proGetCurrentZone(
        context: context,
        listen: true,
      );

      final List<NavModel?> _navModels = generateMainNavModels(
        userModel: _userModel,
        bzzModels: _bzzModels,
        currentZone: _currentZone,
      );

      return MainLayout(
        key: const ValueKey<String>('mainLayout'),
        sectionButtonIsOn: true,
        // navBarIsOn: false,
        appBarType: AppBarType.main,
        listenToHideLayout: true,
        onBack: () => BldrsNav.onLastGoBackInHomeScreen(
          context: context,
          zGridController: _zGridController,
        ),
        // pyramidButtons: const <Widget>[
        /// PLAN : FLOATING_SECTION_BUTTON
        //       //   SectionsMenu(),
        //
        // ],
        child: Stack(
          children: <Widget>[

            /// PAGE CONTENTS
            HomeFlyersGrid(
                paginationController: _paginationController,
                zGridController: _zGridController,
                loading: _loading,
              ),

            /// PYRAMIDS NAVIGATOR
            SuperPyramids(
              onRowTap: (int index) => onNavigate(
                context: context,
                index: index,
                models: _navModels,
                progressBarModel: _progressBarModel,
                mounted: mounted,
              ),
              progressBarModel: _progressBarModel,
              navModels: _navModels,
              isYellow: true,
              mounted: mounted,
            ),

          ],
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------
}
