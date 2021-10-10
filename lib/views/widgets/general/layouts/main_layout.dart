import 'package:bldrs/controllers/drafters/device_checkers.dart';
import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/localization/localizer.dart';
import 'package:bldrs/controllers/localization/lingo.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/main.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/flyers_and_bzz/old_flyers_provider.dart';
import 'package:bldrs/providers/users/old_user_provider.dart';
import 'package:bldrs/views/widgets/general/appbar/bldrs_app_bar.dart';
import 'package:bldrs/views/widgets/general/artworks/pyramids.dart';
import 'package:bldrs/views/widgets/general/buttons/back_anb_search_button.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/views/widgets/general/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/general/buttons/rageh_button.dart';
import 'package:provider/provider.dart';
export 'package:bldrs/views/widgets/general/appbar/app_bar_button.dart';
export 'package:bldrs/controllers/drafters/tracers.dart';
// -----------------------------------------------------------------------------
enum AppBarType{
  Basic,
  Scrollable,
  Main,
  Search,
  Intro,
  Non,
}
// -----------------------------------------------------------------------------
enum Sky {
  Night,
  Black,
  Non,
}
// -----------------------------------------------------------------------------
class Expander extends StatelessWidget {

  const Expander();

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(),);
  }
}
// -----------------------------------------------------------------------------


class MainLayout extends StatelessWidget {
  final List<Widget> appBarRowWidgets;
  final Widget layoutWidget;
  final Function tappingRageh;
  final String pyramids;
  final AppBarType appBarType;
  final String pageTitle;
  final Sky sky;
  final bool canRefreshFlyers;
  final bool loading;
  final Function onBack;
  final Key scaffoldKey;
  // final List<TinyBz> myTinyBzz;
  final ScrollController appBarScrollController;
  final bool sectionButtonIsOn;
  final TextEditingController searchController;
  final Function onSearchSubmit;
  final bool historyButtonIsOn;
  final Function onSearchChanged;

  const MainLayout({
    this.appBarRowWidgets,
    this.layoutWidget,
    this.tappingRageh,
    this.pyramids,
    this.appBarType,
    this.pageTitle,
    this.sky = Sky.Night,
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
});

// -----------------------------------------------------------------------------
  Future<void> _refresh(BuildContext context) async {

    final OldFlyersProvider _pro = Provider.of<OldFlyersProvider>(context,listen: false);

    final Section _currentSection = _pro.getCurrentSection;

    await _pro.fetchAndSetTinyFlyersBySection(context, _currentSection);
  }
// -----------------------------------------------------------------------------
  // final static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final OldFlyersProvider _prof = Provider.of<OldFlyersProvider>(context, listen: true);
    final List<TinyBz> _userTinyBzz = appBarType == AppBarType.Main ? _prof.getUserTinyBzz : [];

    final bool _ragehIsOn = tappingRageh == null ? false : true;

// -----------------------------------------------------------------------------
    List<Widget> _mainLayoutStackWidgets() {
      return
        <Widget>[

          sky == Sky.Black ?
          const NightSky(sky: Sky.Black,)
          :
          sky == Sky.Night ?
          const NightSky(sky: Sky.Night,)
              :
          const NightSky(sky: Sky.Non,),

          if (layoutWidget != null)
            Container(
              width: Scale.superScreenWidth(context),
              height: Scale.superScreenHeight(context),
              alignment: Alignment.topCenter,
              child: layoutWidget,
            ),

          if(appBarType != AppBarType.Non)
            BldrsAppBar(
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
            ),

          if (pyramids != null && pyramids != Iconz.DvBlankSVG)
            Pyramids(
              pyramidsIcon: pyramids,
              loading: loading,
            ),

          /// NAV BAR
          if (pyramids == null)
            NavBar(
              barType: BarType.minWithText,
              myTinyBzz: _userTinyBzz,
            ),

          _ragehIsOn == false ? Container() :
          Rageh(
            tappingRageh: tappingRageh != null ? tappingRageh : (){print('no function here bitch');},
            doubleTappingRageh:
            Wordz.activeLanguage(context) == Lingo.arabicLingo.code ?
                () async {
              Locale temp = await Localizer.setLocale(Lingo.englishLingo.code);
              BldrsApp.setLocale(context, temp);
            } :
                () async {
              Locale temp = await Localizer.setLocale(Lingo.arabicLingo.code);
              BldrsApp.setLocale(context, temp);
            },
          ),

          if (pyramids != null && DeviceChecker.deviceIsIOS() == true)
            Positioned(
              bottom: 0,
              left: 0,
              child: BackAndSearchButton(
                backAndSearchAction: BackAndSearchAction.GoBack,
                color: sky == Sky.Black ? Colorz.Yellow50 : Colorz.White20,
              ),
            ),

        ];
    }
    // ------------------------------------------------------------------
    // print('superScreenHeightWithoutSafeArea(context) = ${superScreenHeightWithoutSafeArea(context)},, superScreenHeight(context) = ${superScreenHeight(context)}');

    final Color _backgroundColor = sky == Sky.Non || sky == Sky.Black? Colorz.Black230 : Colorz.SkyDarkBlue;

    return StreamProvider<List<UserModel>>.value(
      value: OldUserProvider().allUsersStream,
      initialData: [],
      child: GestureDetector(
        onTap: (){Keyboarders.minimizeKeyboardOnTapOutSide(context);},
        child: SafeArea(
          top: true,
          bottom: true,
          child: Stack(
            children: <Widget>[

              if(sky == Sky.Non)
                Container(
                  width: Scale.superScreenWidth(context),
                  height: Scale.superScreenHeight(context),
                  color: _backgroundColor,
                ),

              Scaffold(
                key: scaffoldKey == null ? key : scaffoldKey,
                resizeToAvoidBottomInset: false, // this false prevents keyboard from pushing pyramids up
                // resizeToAvoidBottomPadding: false,
                backgroundColor: _backgroundColor,
                body:
                canRefreshFlyers ?
                RefreshIndicator(
                  onRefresh: ()=> _refresh(context),
                  color: Colorz.Black230,
                  backgroundColor: Colorz.Yellow255,
                  displacement: Ratioz.appBarMargin,
                  strokeWidth: 4,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: _mainLayoutStackWidgets(),
                  ),
                )

                    :

                Stack(
                  alignment: Alignment.topCenter,
                  children: _mainLayoutStackWidgets(),
                ),

              ),

            ],
          ),
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
  });

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
});

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

