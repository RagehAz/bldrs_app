import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/aa_static_logo_screen_view.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_initialization_controllers.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/a_initializer.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/e_ui_initializer.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/e_back_end/f_cloud/dynamic_links.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:bldrs/f_helpers/tabbing/bldrs_tabs.dart';
import 'package:bldrs/z_components/layouts/download_app_panel/download_app_panel.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/layouts/main_layout/pre_layout.dart';
import 'package:bldrs/z_components/layouts/mirage/mirage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TheHomeScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const TheHomeScreen({
    super.key
  });
  // --------------------
  @override
  State<TheHomeScreen> createState() => _TheHomeScreenState();
  // --------------------------------------------------------------------------
}

class _TheHomeScreenState extends State<TheHomeScreen> with TickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    /// TAB BAR CONTROLLER
    HomeProvider.proInitializeTabBarController(
      context: context,
      vsync: this,
    );

    /// KEYBOARD
    UiProvider.proInitializeKeyboard();

    /// HOME GRID
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

      asyncInSync(() async {

        await Keyboard.closeKeyboard();

        final bool _loadApp = await Initializer.logoScreenInitialize(
          context: context,
          mounted: mounted,
        );

        if (_loadApp == true){

          await initializeHomeScreen(context: context);

          await NotesProvider.proInitializeNoteStreams(mounted: mounted);

          if (mounted){
            await BldrsNav.autoNavigateFromHomeScreen();
          }

          /// DYNAMIC LINKS
          await DynamicLinks.initDynamicLinks();

          await UiInitializer.initializeOnBoarding();

        }

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    HomeProvider.proDisposeTabBarController();
    UiProvider.disposeKeyword();
    HomeProvider.proDisposeHomeGrid();
    NotesProvider.disposeNoteStreams();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
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
      return MainLayout(
        canSwipeBack: false,
        onBack: () => UiProvider.proClearAfterHomeRoute(notify: true),
        child: const LogoScreenView(),
      );
    }
    // --------------------
    else {
      // --------------------
      return PreLayout(
        key: const ValueKey<String>('home_screen_tree'),
        connectivitySensorIsOn: true,
        canGoBack: false,
        child: Scaffold(
          /// INSETS
          resizeToAvoidBottomInset: false, /// if false : prevents keyboard from pushing pyramids up / bottom sheet
          // resizeToAvoidBottomPadding: false,
          body: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[

              /// SKY
              const Sky(
                key: ValueKey<String>('sky'),
                skyType: SkyType.black,
                // gradientIsOn: false,
              ),

              /// HOME VIEWS
              Selector<HomeProvider, TabController?>(
                  selector: (_, HomeProvider homePro) => homePro.tabBarController,
                  builder: (_, TabController? tabController, Widget? child) {
                    return TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: BldrsTabs.getAllViewsWidgets(),
                    );
                  }
              ),

              /// LAYOUT WIDGET
              const MirageNavBar(),

              /// WEB DOWNLOAD APP PANEL
              if (kIsWeb == true)
                const DownloadAppPanel(),

            ],
          ),

        ),
      );
      // --------------------
    }
    // --------------------
  }
// -----------------------------------------------------------------------------
}
