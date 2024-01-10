import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/helpers/widgets/sensors/connectivity_sensor.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/b_views/z_components/layouts/download_app_panel/download_app_panel.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout_stack_widgets.dart';
import 'package:bldrs/b_views/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/pyramids/pyramids_panel.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/general_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AppBarType {
  basic,
  scrollable,
  main,
  search,
  non,
}

class MainLayout extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MainLayout({
    required this.canSwipeBack,
    this.appBarRowWidgets,
    this.child,
    this.pyramidsAreOn = false,
    this.appBarType,
    this.title,
    this.skyType = SkyType.black,
    this.onBack,
    this.canGoBack = true,
    this.scaffoldKey,
    this.appBarScrollController,
    this.searchController,
    this.onSearchSubmit,
    this.onPaste,
    this.onSearchChanged,
    this.searchButtonIsOn = true,
    this.sectionButtonIsOn = false,
    this.searchHintVerse,
    this.loading,
    this.progressBarModel,
    this.pyramidType,
    this.onPyramidTap,
    this.onSearchCancelled,
    this.confirmButton,
    this.pyramidButtons,
    this.listenToHideLayout = false,
    this.filtersAreOn,
    this.filters,
    super.key
  });
  /// --------------------------------------------------------------------------
  final List<Widget>? appBarRowWidgets;
  final Widget? child;
  final bool pyramidsAreOn;
  final AppBarType? appBarType;
  final Verse? title;
  final SkyType skyType;
  final Function? onBack;
  /// canGoBack is impact-less if onBack is not null
  final bool canGoBack;
  final bool canSwipeBack;
  final Key? scaffoldKey;
  final ScrollController? appBarScrollController;
  final TextEditingController? searchController;
  final ValueChanged<String?>? onSearchSubmit;
  final ValueChanged<String?>? onPaste;
  final ValueChanged<String?>? onSearchChanged;
  final bool searchButtonIsOn;
  final bool sectionButtonIsOn;
  final Verse? searchHintVerse;
  final ValueNotifier<bool>? loading;
  final ValueNotifier<ProgressBarModel?>? progressBarModel;
  final PyramidType? pyramidType;
  final Function? onPyramidTap;
  final Function? onSearchCancelled;
  final Widget? confirmButton;
  final List<Widget>? pyramidButtons;
  final bool listenToHideLayout;
  final ValueNotifier<bool?>? filtersAreOn;
  final Widget? filters;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onCancelSearch({
    required TextEditingController? controller,
    required ValueNotifier<dynamic>? foundResultNotifier,
    required ValueNotifier<bool>? isSearching,
    required bool mounted,
  }) async {

    await Keyboard.closeKeyboard();

      controller?.text = '';

    if (foundResultNotifier != null){
      setNotifier(
          notifier: foundResultNotifier,
          mounted: mounted,
          value: null
      );
    }

    if (isSearching != null){
      setNotifier(
          notifier: isSearching,
          mounted: mounted,
          value: false
      );
    }

  }
  // --------------------------------------------------------------------------
  static const Widget spacer5 = SizedBox(
    width: 5,
    height: 5,
  );
  // --------------------
  static const Widget spacer10 = SizedBox(
    width: 10,
    height: 10,
  );
  // --------------------
  static double clearHeight(BuildContext context) {
    return  Scale.screenHeight(context)
            - Ratioz.stratosphere
            - (2 * Ratioz.appBarMargin);
  }
  // --------------------
  static double clearLayoutHeight({
    required BuildContext context,
    AppBarType appBarType = AppBarType.basic,
  }){

    return  Scale.screenHeight(context)
            -
            BldrsAppBar.collapsedHeight(context, appBarType);

  }
  // --------------------
  Future<void> _onBack() async {


    if (onBack != null){
      await onBack?.call();
    }

    else {

      final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
      if (_uiProvider.keyboardIsOn == true){
        await Keyboard.closeKeyboard();
      }

      if (canGoBack == true){
        await Nav.goBack(
          context: getMainContext(),
          invoker: 'MainLayout._onBack',
        );
      }

    }

  }
  // --------------------
  /// final static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      key: const ValueKey<String>('Main_layout'),
      onWillPop: () async {
        await _onBack();
        return false;
      },
      child: GestureDetector(
        onTap: () async  {

          await Keyboard.closeKeyboard();
          UiProvider.proSetPyramidsAreExpanded(setTo: false, notify: true);

        },
        child: SafeArea(
          // key: ,
          // bottom: ,
          // left: ,
          // maintainBottomViewPadding: ,
          // minimum: ,
          // right: ,
          // top: ,
          child: ConnectivitySensor(
            onConnectivityChanged: (bool isConnected) => GeneralProvider.onConnectivityChanged(
              isConnected: isConnected,
            ),
            child: Stack(
              children: <Widget>[

                /// BODY
                Scaffold(
                  key: scaffoldKey ?? const ValueKey<String>('mainScaffold'),

                  /// INSETS
                  resizeToAvoidBottomInset: false, /// if false : prevents keyboard from pushing pyramids up / bottom sheet
                  // resizeToAvoidBottomPadding: false,

                  /// BACK GROUND COLOR
                  // backgroundColor: null,

                  /// BOTTOM SHEET
                  // bottomSheet: const KeyboardFloatingField(), /// removed it

                  /// BODY CONTENT
                  body: MainLayoutStackWidgets(
                    key: const ValueKey<String>('mainStack'),
                    alignment: Alignment.topCenter,
                    skyType: skyType,
                    appBarType: appBarType,
                    appBarRowWidgets: appBarRowWidgets,
                    pageTitleVerse: title,
                    onBack: () => _onBack(),
                    loading: loading,
                    progressBarModel: progressBarModel,
                    appBarScrollController: appBarScrollController,
                    sectionButtonIsOn: sectionButtonIsOn,
                    searchController: searchController,
                    onSearchSubmit: onSearchSubmit,
                    onPaste: onPaste,
                    searchButtonIsOn: searchButtonIsOn,
                    onSearchChanged: onSearchChanged,
                    pyramidsAreOn: pyramidsAreOn,
                    searchHintVerse: searchHintVerse,
                    pyramidType: pyramidType,
                    onPyramidTap: onPyramidTap,
                    canGoBack: canGoBack,
                    canSwipeBack: canSwipeBack,
                    onSearchCancelled: onSearchCancelled,
                    confirmButton: confirmButton,
                    listenToHideLayout: listenToHideLayout,
                    filtersAreOn: filtersAreOn,
                    filters: filters,
                    layoutWidget: child,
                  ),

                ),

                /// PYRAMIDS PANEL
                if (Lister.checkCanLoop(pyramidButtons) == true)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: PyramidsPanel(
                    pyramidButtons: pyramidButtons,
                  ),
                ),

                /// WEB DOWNLOAD APP PANEL
                if (kIsWeb == true)
                Positioned(
                  left: 0,
                  bottom: Scale.screenHeight(context) * 0.16,
                  child: const DownloadAppPanel(),
                ),

              ],
            ),
          ),
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
