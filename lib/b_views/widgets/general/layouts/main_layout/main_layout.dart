import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/kw/section_class.dart' as SectionClass;
import 'package:bldrs/b_views/widgets/general/dialogs/side_dialog/drawer_dialog.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout_stack_widgets.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

export 'package:bldrs/b_views/widgets/general/appbar/app_bar_button.dart';

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
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> appBarRowWidgets;
  final Widget layoutWidget;
  final bool pyramidsAreOn;
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
    final Color _backgroundColor = skyType == SkyType.non || skyType == SkyType.black ? Colorz.blackSemi255 : Colorz.skyDarkBlue;
    return _backgroundColor;
  }
// -----------------------------------------------------------------------------
  Future<void> _refresh(BuildContext context) async {
    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: true);
    final SectionClass.Section _currentSection = _generalProvider.currentSection;
    final KW _currentKeyword = _generalProvider.currentKeyword;

    await _flyersProvider.getsetWallFlyersBySectionAndKeyword(
      context: context,
      section: _currentSection,
      kw: _currentKeyword,
    );

  }
// -----------------------------------------------------------------------------
  // final static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      onBack: onBack,
      // loading: loading,
      appBarScrollController: appBarScrollController,
      sectionButtonIsOn: sectionButtonIsOn,
      zoneButtonIsOn: zoneButtonIsOn,
      searchController: searchController,
      onSearchSubmit: onSearchSubmit,
      historyButtonIsOn: historyButtonIsOn,
      onSearchChanged: onSearchChanged,
      pyramidsAreOn: pyramidsAreOn,
      layoutWidget: layoutWidget,
    );

    return GestureDetector(
      key: key,
      onTap: () => Keyboarders.minimizeKeyboardOnTapOutSide(context),
      child: SafeArea(
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
              drawer: const DrawerDialog(),
              drawerEdgeDragWidth: DrawerDialog.drawerEdgeDragWidth,
              drawerScrimColor: DrawerDialog.drawerScrimColor,
              onDrawerChanged: (bool thing) {
                blog('drawer changed and thing is :$thing');
              },

              /// BODY CONTENT
              body: canRefreshFlyers ?

              RefreshIndicator(
                onRefresh: () => _refresh(context),
                color: Colorz.black230,
                backgroundColor: Colorz.yellow255,
                displacement: Ratioz.appBarMargin,
                strokeWidth: 4,
                child: _mainLayoutStackWidgets,
              )

                  :

              _mainLayoutStackWidgets,

            ),
          ],
        ),
      ),
    );
  }
}
