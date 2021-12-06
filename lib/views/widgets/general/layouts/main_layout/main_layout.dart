import 'package:bldrs/controllers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/kw/section_class.dart' as SectionClass;
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/providers/general_provider.dart';
import 'package:bldrs/views/widgets/general/dialogs/side_dialog/drawer_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout_stack_widgets.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

export 'package:bldrs/controllers/drafters/tracers.dart';
export 'package:bldrs/views/widgets/general/appbar/app_bar_button.dart';
// -----------------------------------------------------------------------------
enum AppBarType{
  basic,
  scrollable,
  main,
  search,
  intro,
  non,
}
// -----------------------------------------------------------------------------
class Expander extends StatelessWidget {

  const Expander({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(),);
  }
}
// -----------------------------------------------------------------------------

class MainLayout extends StatelessWidget {
  final List<Widget> appBarRowWidgets;
  final Widget layoutWidget;
  final String pyramids;
  final AppBarType appBarType;
  final String pageTitle;
  final SkyType skyType;
  final bool canRefreshFlyers;
  final bool loading;
  final Function onBack;
  final Key scaffoldKey;
  // final List<TinyBz> myTinyBzz;
  final ScrollController appBarScrollController;
  final bool sectionButtonIsOn;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchSubmit;
  final bool historyButtonIsOn;
  final ValueChanged<String> onSearchChanged;

  const MainLayout({
    this.appBarRowWidgets,
    this.layoutWidget,
    this.pyramids,
    this.appBarType,
    this.pageTitle,
    this.skyType = SkyType.night,
    this.canRefreshFlyers = false,
    this.loading = false,
    this.onBack,
    this.scaffoldKey,
    // this.myTinyBzz,
    this.appBarScrollController,
    this.sectionButtonIsOn,
    this.searchController,
    this.onSearchSubmit,
    this.historyButtonIsOn = true,
    this.onSearchChanged,
    Key key
}) : super (key: key);

  static const Widget spacer5 = const SizedBox(width: 5, height: 5,);
  static const Widget spacer10 = const SizedBox(width: 10, height: 10,);

// -----------------------------------------------------------------------------
  Future<void> _refresh(BuildContext context) async {

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: true);
    final SectionClass.Section _currentSection = _generalProvider.currentSection;
    await _flyersProvider.getsetWallFlyersBySection(
        context: context,
        section: _currentSection
    );
  }
// -----------------------------------------------------------------------------
  // final static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final Color _backgroundColor = skyType == SkyType.non || skyType == SkyType.black? Colorz.blackSemi255 : Colorz.skyDarkBlue;

    final Widget _mainLayoutStackWidgets = MainLayoutStackWidgets(
      key: const ValueKey<String>('mainStack'),
      alignment: Alignment.topCenter,
      skyType: skyType,
      appBarType: appBarType,
      appBarRowWidgets: appBarRowWidgets,
      pageTitle: pageTitle,
      onBack: onBack,
      loading: loading,
      appBarScrollController: appBarScrollController,
      sectionButtonIsOn: sectionButtonIsOn,
      searchController: searchController,
      onSearchSubmit: onSearchSubmit,
      historyButtonIsOn: historyButtonIsOn,
      onSearchChanged: onSearchChanged,
      pyramids: pyramids,
      layoutWidget: layoutWidget,
    );

    return GestureDetector(
      key: key,
      onTap: (){Keyboarders.minimizeKeyboardOnTapOutSide(context);},
      child: SafeArea(
        child: Stack(
          children: <Widget>[

            if(skyType == SkyType.non)
              Container(
                key: const ValueKey<String>('noSkyBackground'),
                width: Scale.superScreenWidth(context),
                height: Scale.superScreenHeight(context),
                color: _backgroundColor,
              ),

            Scaffold(
              key: scaffoldKey == null ? const ValueKey<String>('mainScaffold') : scaffoldKey,
              resizeToAvoidBottomInset: false, // this false prevents keyboard from pushing pyramids up
              // resizeToAvoidBottomPadding: false,
              backgroundColor: _backgroundColor,

              drawer: const DrawerDialog(),
              drawerEdgeDragWidth: DrawerDialog.drawerEdgeDragWidth,
              drawerScrimColor: DrawerDialog.drawerScrimColor,
              onDrawerChanged: (bool thing){

                print('drawer changed and thing is :${thing}');

              },


              body:
              canRefreshFlyers ?
              RefreshIndicator(
                onRefresh: ()=> _refresh(context),
                color: Colorz.black230,
                backgroundColor: Colorz.yellow255,
                displacement: Ratioz.appBarMargin,
                strokeWidth: 4,
                child: _mainLayoutStackWidgets,
              )

                  :

              _mainLayoutStackWidgets,

              // Stack(
              //   alignment: Alignment.topCenter,
              //   children: <Widget>[
              //
              //     Sky(skyType: sky,),
              //
              //     if (layoutWidget != null)
              //       Container(
              //         width: Scale.superScreenWidth(context),
              //         height: Scale.superScreenHeight(context),
              //         alignment: Alignment.topCenter,
              //         child: layoutWidget,
              //       ),
              //
              //     if(appBarType != AppBarType.Non)
              //       BldrsAppBar(
              //         appBarType: appBarType,
              //         appBarRowWidgets: appBarRowWidgets,
              //         pageTitle: pageTitle,
              //         onBack: onBack,
              //         loading: loading,
              //         appBarScrollController: appBarScrollController,
              //         sectionButtonIsOn: sectionButtonIsOn,
              //         searchController: searchController,
              //         onSearchSubmit: onSearchSubmit,
              //         historyButtonIsOn: historyButtonIsOn,
              //         onSearchChanged: onSearchChanged,
              //       ),
              //
              //     if (pyramids != null && pyramids != Iconz.DvBlankSVG)
              //       Pyramids(
              //         pyramidsIcon: pyramids,
              //         loading: loading,
              //       ),
              //
              //     /// NAV BAR
              //     if (pyramids == null)
              //       NavBar(
              //         barType: BarType.minWithText,
              //         myBzz: _userBzz,
              //       ),
              //
              //     if (pyramids != null && DeviceChecker.deviceIsIOS() == true)
              //       Positioned(
              //         bottom: 0,
              //         left: 0,
              //         child: BackAndSearchButton(
              //           backAndSearchAction: BackAndSearchAction.GoBack,
              //           color: sky == SkyType.Black ? Colorz.yellow50 : Colorz.white20,
              //         ),
              //       ),
              //
              //
              //   ],
              // ),

            ),

          ],
        ),
      ),
    );
  }
}
// -----------------------------------------------------------------------------
/// --- for testing purposes, only used in appBar
// Widget zorar({Function function, String functionName}){
//   return DreamBox(
//     height: 40,
//     margins: const EdgeInsets.all(5),
//     color: Colorz.White10,
//     verse: functionName,
//     verseScaleFactor: 2,
//     onTap: function,
//     bubble: false,
//     icon: Iconz.XLarge,
//     iconSizeFactor: 0.3,
//     secondLine: 'blaaah',
//     secondLineColor: Colorz.White200,
//   );
// }
// -----------------------------------------------------------------------------
/// --- THE HORIZON IS BOTTOM PADDING THAT RESPECTS PYRAMIDS HEIGHT
class PyramidsHorizon extends StatelessWidget {
  final double heightFactor;

  const PyramidsHorizon({
    this.heightFactor = 1,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: Scale.superScreenWidth(context),
      height: Ratioz.horizon * heightFactor,
    );
  }
}
// -----------------------------------------------------------------------------
/// --- STRATOSPHERE IS UPPER SCREEN PADDING THAT RESPECTS APPBAR HEIGHT
class Stratosphere extends StatelessWidget {
  final double heightFactor;
  final bool bigAppBar;

  const Stratosphere({
    this.heightFactor = 1,
    this.bigAppBar = false,
    Key key,
  }) : super(key: key);

  static const EdgeInsets stratosphereInsets = EdgeInsets.only(top: Ratioz.stratosphere);
  static const EdgeInsets stratosphereSandwich = EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.stratosphere);

  static const double _margins = Ratioz.appBarMargin * 2;
  static const double bigAppBarStratosphere = Ratioz.appBarBigHeight + _margins;
  static const double smallAppBarStratosphere = Ratioz.appBarSmallHeight + _margins;


  @override
  Widget build(BuildContext context) {

    final double _height = bigAppBar == true ? bigAppBarStratosphere : smallAppBarStratosphere;

    return Container(
      width: Scale.superScreenWidth(context),
      height: _height * heightFactor,
    );
  }
}
// -----------------------------------------------------------------------------
