import 'dart:async';

import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/streamers/streamer.dart';
import 'package:basics/z_grid/z_grid.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/aa_static_logo_screen_view.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/aa_home_screen_view.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_home_screen_controllers.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_initialization_controllers.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_notes_controllers.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/e_ui_initializer.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/e_back_end/f_cloud/dynamic_links.dart';
import 'package:bldrs/f_helpers/router/c_dynamic_router.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/layouts/pyramids/super_pyramids.dart';
import 'package:bldrs/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

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
  // --------------------
  /// NOTES STREAM SUBSCRIPTIONS
  StreamSubscription? _userNotesStreamSub;
  final ValueNotifier<List<Map<String, dynamic>>> _userOldNotesNotifier = ValueNotifier<List<Map<String, dynamic>>>([]);
  List<StreamSubscription>? _bzzNotesStreamsSubs;
  late List<ValueNotifier<List<Map<String, dynamic>>>> _myBzzOldNotesNotifiers;
  // -----------------------------------------------------------------------------
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

    UiProvider.proInitializeKeyboard();

    HomeProvider.proInitializeHomeGrid(
      vsync: this,
      mounted: mounted,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {

        // if (PhraseProvider.proGetPhidsAreLoaded() == false){
        //   await Nav.pushNamedAndRemoveAllBelow(
        //       context: context,
        //       goToRoute: Routing.staticLogoScreen,
        //   );
        // }

        await initializeHomeScreen(context: context);

        _myBzzOldNotesNotifiers = createMyBzOldUnseenNotesMaps();

        await initializeNotesListeners();

        await _triggerLoading(setTo: false);

        if (mounted){
          await BldrsNav.autoNavigateFromHomeScreen();
        }

        /// DYNAMIC LINKS
        await DynamicLinks.initDynamicLinks();

        await UiInitializer.initializeOnBoarding();

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    disposeMyBzOldUnseenNotesMaps(
      notifiers: _myBzzOldNotesNotifiers,
    );
    _userOldNotesNotifier.dispose();
    _loading.dispose();

    UiProvider.disposeKeyword();

    _userNotesStreamSub?.cancel();
    Streamer.disposeStreamSubscriptions(_bzzNotesStreamsSubs);
    _progressBarModel.dispose();

    HomeProvider.proDisposeHomeGrid();

    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// NOTE LISTENERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> initializeNotesListeners() async{
    if (mounted){
      await initializeObeliskNumbers();
      _userNotesStreamSub = listenToUserUnseenNotes(
        mounted: mounted,
        oldMaps: _userOldNotesNotifier,
      );
      _bzzNotesStreamsSubs = listenToMyBzzUnseenNotes(
        mounted: mounted,
        bzzOldMaps: _myBzzOldNotesNotifiers,
      );
    }
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    DynamicRouter.blogGo('HomeScreen');
    // --------------------
    final RouteSettings? _afterHomeRoute = UiProvider.proGetAfterHomeRoute(
      context: context,
      /// this needed true for BldrsNav.restartAndRoute()
      /// it does result in rebuilding entire tree when triggering pyramid
      /// but turning this false is not the solution for that
      /// you just can't turn this false
      listen: true,
    );
    // --------------------
    /// WHEN AFTER HOME ROUTE IS DEFINED => works as loading screen until didChangedDependencies methods finish
    if (_afterHomeRoute != null){

      blog('building home screen for after home route');

      return MainLayout(
        canSwipeBack: false,
        onBack: () async {

          UiProvider.proClearAfterHomeRoute(
            notify: true,
          );

        },
        child: const LogoScreenView(),
      );
    }
    // --------------------
    /// WHEN AFTER HOME ROUTE IS NULL
    else {

      final List<BzModel> _bzzModels = BzzProvider.proGetMyBzz(
        context: context,
        listen: true,
      );
      final UserModel? _userModel = UsersProvider.proGetMyUserModel(
        context: context,
        /// if true, rebuilds the grid for each flyer save
        listen: false,
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
        canSwipeBack: false,
        sectionButtonIsOn: true,
        // navBarIsOn: false,
        appBarType: AppBarType.main,
        // skyType: SkyType.black,
        /// IGNORED AS ARE OVERRIDDEN IN THE BELOW STACK WITH THE PYRAMIDS PANEL
        // pyramidsAreOn: false,
        // pyramidType: PyramidType.white,
        listenToHideLayout: true,
        onBack: () => BldrsNav.backFromHomeScreen(
          context: context,
        ),
        child: Stack(
          children: <Widget>[

            /// PAGE CONTENTS
            const HomeFlyersGrid(),

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
              // isYellow: false,
              mounted: mounted,
            ),

          ],
        ),
      );

    }
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
