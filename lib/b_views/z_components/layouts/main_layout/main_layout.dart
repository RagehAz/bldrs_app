import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/structure/a_chains_drawer_starter.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/connectivity_sensor.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout_stack_widgets.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/keyboard_field/a_keyboard_floating_field.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
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
    this.appBarRowWidgets,
    this.layoutWidget,
    this.pyramidsAreOn = false,
    this.appBarType,
    this.pageTitle,
    this.skyType = SkyType.night,
    // this.loading = false,
    this.onBack,
    this.canGoBack = true,
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
    this.loading,
    this.swipeDirection,
    this.index,
    this.numberOfStrips,
    this.pyramidType,
    this.onPyramidTap,
    this.hasKeyboard = true,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> appBarRowWidgets;
  final Widget layoutWidget;
  final bool pyramidsAreOn;
  final AppBarType appBarType;
  final dynamic pageTitle;
  final SkyType skyType;
  // final bool loading;
  final Function onBack;
  final bool canGoBack;
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
  final ValueNotifier<bool> loading;
  final ValueNotifier<SwipeDirection> swipeDirection;
  final int numberOfStrips;
  final ValueNotifier<int> index;
  final PyramidType pyramidType;
  final Function onPyramidTap;
  final bool hasKeyboard;
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
  static double clearHeight(BuildContext context) {
    return Scale.superScreenHeight(context) - Ratioz.stratosphere - (2 * Ratioz.appBarMargin);
  }
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
    _uiProvider.setKeywordsDrawerIsOn(
      setTo: drawerIsOn,
      notify: true,
    );
  }
// -----------------------------------------------------------------------------
  void _onBack(BuildContext context){

    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
    final bool _drawerIsOn = _uiProvider.keywordsDrawerIsOn;
    final bool _keyboardIsOn = _uiProvider.keyboardIsOn;

    blog('wtf : _keyboardIsOn : $_keyboardIsOn');

    if (_keyboardIsOn == true){
      Keyboarders.closeKeyboard(context);
    }

    else if (_drawerIsOn == true){
      Keyboarders.closeKeyboard(context);
      Nav.goBack(context);

      _uiProvider.setKeywordsDrawerIsOn(
        setTo: false,
        notify: true,
      );
    }

    else if (onBack != null){
      onBack();
    }

    else if (canGoBack == true){
      Nav.goBack(context);
    }

  }
// -----------------------------------------------------------------------------
  /// final static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Color _backgroundColor = _mainLayoutBackGroundColor(skyType);

    return WillPopScope(
      key: const ValueKey<String>('Main_layout'),
      onWillPop: () async {
        _onBack(context);
        return false;
      },
      child: GestureDetector(
        onTap: (){

          Keyboarders.closeKeyboard(context);

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

                  /// DRAWER
                  drawer: const ChainsDrawerStarter(),
                  drawerEdgeDragWidth: ChainsDrawerStarter.drawerEdgeDragWidth,
                  drawerScrimColor: ChainsDrawerStarter.drawerScrimColor,
                  onDrawerChanged: (bool drawerIsOn) => _onDrawerChanged(context, drawerIsOn),

                  /// KEYBOARD
                  bottomSheet: hasKeyboard == true ? const KeyboardFloatingField() : null,

                  /// BODY CONTENT
                  body: MainLayoutStackWidgets(
                    key: const ValueKey<String>('mainStack'),
                    alignment: Alignment.topCenter,
                    skyType: skyType,
                    appBarType: appBarType,
                    appBarRowWidgets: appBarRowWidgets,
                    pageTitle: pageTitle,
                    onBack: () => _onBack(context),
                    loading: loading,
                    index: index,
                    swipeDirection: swipeDirection,
                    numberOfStrips: numberOfStrips,
                    appBarScrollController: appBarScrollController,
                    sectionButtonIsOn: sectionButtonIsOn,
                    zoneButtonIsOn: zoneButtonIsOn,
                    searchController: searchController,
                    onSearchSubmit: onSearchSubmit,
                    historyButtonIsOn: historyButtonIsOn,
                    onSearchChanged: onSearchChanged,
                    pyramidsAreOn: pyramidsAreOn,
                    searchHint: searchHint,
                    layoutWidget: layoutWidget,
                    pyramidType: pyramidType,
                    onPyramidTap: onPyramidTap,
                    canGoBack: canGoBack,
                  ),

                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
