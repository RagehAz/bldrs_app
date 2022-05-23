import 'package:bldrs/b_views/z_components/chains_drawer/structure/a_chains_drawer_starter.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/connectivity_sensor.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout_stack_widgets.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/c_controllers/a_starters_controllers/a_1_home_controller.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

export 'package:bldrs/b_views/z_components/app_bar/app_bar_button.dart';

// -----------------------------------------------------------------------------
enum AppBarType {
  basic,
  scrollable,
  main,
  search,
  intro,
  non,
}
// -----------------------------------------------------------------------------

class MainLayout extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MainLayout({
    this.navBarIsOn = false,
    this.appBarRowWidgets,
    this.layoutWidget,
    this.pyramidsAreOn = false,
    this.appBarType,
    this.pageTitle,
    this.skyType = SkyType.night,
    this.canRefreshFlyers = false,
    // this.loading = false,
    this.onBack,
    this.scaffoldKey,
    // this.myTinyBzz,
    this.appBarScrollController,
    this.searchController,
    this.onSearchSubmit,
    this.onSearchChanged,
    this.historyButtonIsOn = true,
    this.sectionButtonIsOn = true,
    this.zoneButtonIsOn = true,
    this.searchHint,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> appBarRowWidgets;
  final Widget layoutWidget;
  final bool pyramidsAreOn;
  final bool navBarIsOn;
  final AppBarType appBarType;
  final String pageTitle;
  final SkyType skyType;
  final bool canRefreshFlyers;
  // final bool loading;
  final Function onBack;
  final Key scaffoldKey;
  // final List<TinyBz> myTinyBzz;
  final ScrollController appBarScrollController;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchSubmit;
  final ValueChanged<String> onSearchChanged;
  final bool historyButtonIsOn;
  final bool sectionButtonIsOn;
  final bool zoneButtonIsOn;
  final String searchHint;
  /// --------------------------------------------------------------------------
  static const Widget spacer5 = SizedBox(
    width: 5,
    height: 5,
  );
// -----------------------------------------------------------------------------
  static const Widget spacer10 = SizedBox(
    width: 10,
    height: 10,
  );
// -----------------------------------------------------------------------------
  static Color _mainLayoutBackGroundColor(SkyType skyType){

    final Color _backgroundColor =
    skyType == SkyType.non ?
    Colorz.black255
        :
    skyType == SkyType.black ?
    Colorz.blackSemi255
        :
    Colorz.skyDarkBlue;

    return _backgroundColor;
  }
// -----------------------------------------------------------------------------
  void _onDrawerChanged(context, bool drawerIsOn){
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
    _uiProvider.setKeywordsDrawerIsOn(setTo: drawerIsOn);
  }
// -----------------------------------------------------------------------------
  void _onBack(BuildContext context){

    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
    final bool _drawerIsOn = _uiProvider.keywordsDrawerIsOn;

    if (_drawerIsOn == true){
      Nav.goBack(context);
      _uiProvider.setKeywordsDrawerIsOn(setTo: false);
    }

    else if (onBack != null){
      onBack();
    }

    else {
      Nav.goBack(context);
    }

  }
// -----------------------------------------------------------------------------
  /// final static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Color _backgroundColor = _mainLayoutBackGroundColor(skyType);

    final Widget _mainLayoutStackWidgets = MainLayoutStackWidgets(
      key: const ValueKey<String>('mainStack'),
      alignment: Alignment.topCenter,
      skyType: skyType,
      appBarType: appBarType,
      appBarRowWidgets: appBarRowWidgets,
      pageTitle: pageTitle,
      onBack: () => _onBack(context),
      // loading: loading,
      appBarScrollController: appBarScrollController,
      sectionButtonIsOn: sectionButtonIsOn,
      zoneButtonIsOn: zoneButtonIsOn,
      searchController: searchController,
      onSearchSubmit: onSearchSubmit,
      historyButtonIsOn: historyButtonIsOn,
      onSearchChanged: onSearchChanged,
      pyramidsAreOn: pyramidsAreOn,
      navBarIsOn: navBarIsOn,
      searchHint: searchHint,
      layoutWidget: layoutWidget,
    );

    return GestureDetector(
      key: const ValueKey<String>('Main_layout'),
      onTap: () => Keyboarders.minimizeKeyboardOnTapOutSide(context),
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
                resizeToAvoidBottomInset: false, /// this false prevents keyboard from pushing pyramids up
                // resizeToAvoidBottomPadding: false,

                /// BACK GROUND COLOR
                backgroundColor: _backgroundColor,

                /// DRAWER
                drawer: const ChainsDrawerStarter(),
                drawerEdgeDragWidth: ChainsDrawerStarter.drawerEdgeDragWidth,
                drawerScrimColor: ChainsDrawerStarter.drawerScrimColor,
                onDrawerChanged: (bool drawerIsOn) => _onDrawerChanged(context, drawerIsOn),

                /// BODY CONTENT
                body: canRefreshFlyers ?

                RefreshIndicator(
                  onRefresh: () => onRefreshHomeWall(context),
                  color: Colorz.black230,
                  backgroundColor: Colorz.yellow255,
                  displacement: 50,//Ratioz.appBarMargin,
                  strokeWidth: 4,
                  edgeOffset: 50,
                  child: _mainLayoutStackWidgets,
                )

                    :

                _mainLayoutStackWidgets,

              ),

            ],
          ),
        ),
      ),
    );
  }
}
