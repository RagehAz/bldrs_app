import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/connectivity_sensor.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout_stack_widgets.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/z_widgets/pyramids_admin_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

export 'package:bldrs/b_views/z_components/app_bar/app_bar_button.dart';
export 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';

enum AppBarType {
  basic,
  scrollable,
  main,
  search,
  intro,
  non,
}

class MainLayout extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MainLayout({
    this.appBarRowWidgets,
    this.layoutWidget,
    this.pyramidsAreOn = false,
    this.appBarType,
    this.pageTitleVerse,
    this.skyType = SkyType.night,
    this.onBack,
    this.canGoBack = true,
    this.scaffoldKey,
    this.appBarScrollController,
    this.searchController,
    this.onSearchSubmit,
    this.onSearchChanged,
    this.historyButtonIsOn = true,
    this.sectionButtonIsOn = false,
    this.searchHintVerse,
    this.loading,
    this.progressBarModel,
    this.pyramidType,
    this.onPyramidTap,
    this.onSearchCancelled,
    this.confirmButtonModel,
    this.globalKey,
    this.isInPhrasesScreen,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> appBarRowWidgets;
  final Widget layoutWidget;
  final bool pyramidsAreOn;
  final AppBarType appBarType;
  final Verse pageTitleVerse;
  final SkyType skyType;
  final Function onBack;
  final bool canGoBack;
  final Key scaffoldKey;
  final ScrollController appBarScrollController;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchSubmit;
  final ValueChanged<String> onSearchChanged;
  final bool historyButtonIsOn;
  final bool sectionButtonIsOn;
  final Verse searchHintVerse;
  final ValueNotifier<bool> loading;
  final ValueNotifier<ProgressBarModel> progressBarModel;
  final PyramidType pyramidType;
  final Function onPyramidTap;
  final Function onSearchCancelled;
  final ConfirmButtonModel confirmButtonModel;
  final GlobalKey globalKey;
  final bool isInPhrasesScreen;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static void onCancelSearch({
    @required BuildContext context,
    @required TextEditingController controller,
    @required ValueNotifier<dynamic> foundResultNotifier,
    @required ValueNotifier<bool> isSearching,
  }){

    Keyboard.closeKeyboard(context);

      controller?.text = '';

    if (foundResultNotifier != null){
      foundResultNotifier.value = null;
    }

    if (isSearching != null){
      isSearching.value = false;
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
    return  Scale.superScreenHeight(context)
            - Ratioz.stratosphere
            - (2 * Ratioz.appBarMargin);
  }
  // --------------------
  static double clearLayoutHeight({
    @required BuildContext context,
    AppBarType appBarType = AppBarType.basic,
  }){

    return  Scale.superScreenHeightWithoutSafeArea(context)
            -
            BldrsAppBar.height(context, appBarType);

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
  Future<void> _onBack(BuildContext context) async {


    if (onBack != null){
      await onBack();
    }

    else {

      final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
      if (_uiProvider.keyboardIsOn == true){
        Keyboard.closeKeyboard(context);
      }

      if (canGoBack == true){
        await Nav.goBack(
          context: context,
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
        await _onBack(context);
        return false;
      },
      child: GestureDetector(
        onTap: (){


          Keyboard.closeKeyboard(context);

        },
        child: SafeArea(
          child: ConnectivitySensor(
            child: Stack(
              children: <Widget>[

                if (skyType == SkyType.non)
                  Container(
                    key: const ValueKey<String>('noSkyBackground'),
                    width: Scale.superScreenWidth(context),
                    height: Scale.superScreenHeight(context),
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
                    pageTitleVerse: pageTitleVerse,
                    onBack: () => _onBack(context),
                    loading: loading,
                    progressBarModel: progressBarModel,
                    appBarScrollController: appBarScrollController,
                    sectionButtonIsOn: sectionButtonIsOn,
                    searchController: searchController,
                    onSearchSubmit: onSearchSubmit,
                    historyButtonIsOn: historyButtonIsOn,
                    onSearchChanged: onSearchChanged,
                    pyramidsAreOn: pyramidsAreOn,
                    searchHintVerse: searchHintVerse,
                    pyramidType: pyramidType,
                    onPyramidTap: onPyramidTap,
                    canGoBack: canGoBack,
                    onSearchCancelled: onSearchCancelled,
                    confirmButtonModel: confirmButtonModel,
                    layoutWidget: layoutWidget,
                  ),

                ),

                if (UsersProvider.proGetMyUserModel(context: context, listen: true,)?.isAdmin == true)
                PyramidsAdminPanel(
                  isInTransScreen: isInPhrasesScreen,
                  pyramidsAreOn: pyramidsAreOn,
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
