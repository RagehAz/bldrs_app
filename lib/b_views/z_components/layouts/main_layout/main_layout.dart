import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/widgets/sensors/connectivity_sensor.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/editors_buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout_stack_widgets.dart';
import 'package:bldrs/b_views/z_components/layouts/pyramids/pyramids_panel.dart';
import 'package:bldrs/b_views/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/general_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:flutter/material.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:provider/provider.dart';
import 'package:basics/helpers/classes/space/scale.dart';

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
    this.appBarRowWidgets,
    this.child,
    this.pyramidsAreOn = false,
    this.appBarType,
    this.title,
    this.skyType = SkyType.night,
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
    this.confirmButtonModel,
    this.globalKey,
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
  final bool canGoBack;
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
  final ConfirmButtonModel? confirmButtonModel;
  final GlobalKey? globalKey;
  final List<Widget>? pyramidButtons;
  final bool listenToHideLayout;
  final ValueNotifier<bool?>? filtersAreOn;
  final Widget? filters;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static void onCancelSearch({
    required TextEditingController? controller,
    required ValueNotifier<dynamic>? foundResultNotifier,
    required ValueNotifier<bool>? isSearching,
    required bool mounted,
  }){

    Keyboard.closeKeyboard();

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
  static Color _mainLayoutBackGroundColor(SkyType skyType){

    if (skyType == SkyType.non){
      return Colorz.black255;
    }

    else if (skyType == SkyType.black){
      return Colorz.blackSemi255;
    }
    else {
      return Colorz.skyDarkBlue;
    }

  }
  // --------------------
  Future<void> _onBack() async {


    if (onBack != null){
      await onBack?.call();
    }

    else {

      final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
      if (_uiProvider.keyboardIsOn == true){
        Keyboard.closeKeyboard();
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

    final Color _backgroundColor = _mainLayoutBackGroundColor(skyType);

    return WillPopScope(
      key: const ValueKey<String>('Main_layout'),
      onWillPop: () async {
        await _onBack();
        return false;
      },
      child: GestureDetector(
        onTap: (){

          UiProvider.proSetPyramidsAreExpanded(setTo: false, notify: true);
          Keyboard.closeKeyboard();

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

                if (skyType == SkyType.non)
                  Container(
                    key: const ValueKey<String>('noSkyBackground'),
                    width: Scale.screenWidth(context),
                    height: Scale.screenHeight(context),
                    color: _backgroundColor,
                  ),

                Scaffold(
                  key: scaffoldKey ?? const ValueKey<String>('mainScaffold'),

                  /// INSETS
                  resizeToAvoidBottomInset: false, /// if false : prevents keyboard from pushing pyramids up / bottom sheet
                  // resizeToAvoidBottomPadding: false,

                  /// BACK GROUND COLOR
                  backgroundColor: _backgroundColor,

                  /// BOTTOM SHEET
                  // bottomSheet: const KeyboardFloatingField(), /// removed it

                  /// BODY CONTENT
                  body: MainLayoutStackWidgets(
                    key: const ValueKey<String>('mainStack'),
                    globalKey: globalKey,
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
                    onSearchCancelled: onSearchCancelled,
                    confirmButtonModel: confirmButtonModel,
                    listenToHideLayout: listenToHideLayout,
                    filtersAreOn: filtersAreOn,
                    filters: filters,
                    layoutWidget: child,
                  ),

                ),

                if (Mapper.checkCanLoopList(pyramidButtons) == true)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: PyramidsPanel(
                    pyramidButtons: pyramidButtons,
                  ),
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
