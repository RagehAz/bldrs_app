import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/view_brains/controllers/devicerz.dart';
import 'package:bldrs/view_brains/drafters/keyboarders.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/appbar/bldrs_appbar.dart';
import 'package:bldrs/views/widgets/buttons/bt_back.dart';
import 'package:bldrs/views/widgets/nav_bar/nav_bar.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/skies/black_sky.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/buttons/bt_rageh.dart';
import 'package:provider/provider.dart';
import '../../../main.dart';
// === === === === === === === === === === === === === === === === === === ===
enum AppBarType{
  Basic,
  Scrollable,
  Main,
  Localizer,
  Intro,
  InPyramids,
  Sections,
}
// === === === === === === === === === === === === === === === === === === ===
enum Sky {
  Night,
  Black,
}
// === === === === === === === === === === === === === === === === === === ===
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
  final bool appBarBackButton;

  MainLayout({
    this.appBarRowWidgets,
    this.layoutWidget,
    this.tappingRageh,
    this.pyramids,
    this.appBarType,
    this.pageTitle,
    this.sky = Sky.Night,
    this.canRefreshFlyers = false,
    this.loading = false,
    this.appBarBackButton = false,
});

  Future<void> _refresh(BuildContext context) async {
    await Provider.of<FlyersProvider>(context,listen: false).fetchAndSetBzz(context);
  }

  // final static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    bool _ragehIsOn = tappingRageh == null ? false : true;

    final List<Widget> _mainLayoutStackWidgets = <Widget>[

      sky == Sky.Black ? BlackSky() :
      NightSky(),

      layoutWidget == null ? Container() :
      layoutWidget,

      if(appBarType!=null)
        BldrsAppBar(
          appBarType: appBarType,
          appBarRowWidgets: appBarRowWidgets,
          pageTitle: pageTitle,
          backButton: appBarBackButton,
          loading: loading,
        ),

      if (pyramids != null)
        Pyramids(
          pyramidsIcon: pyramids,
          loading: loading,
        ),

      // --- NAV BAR
      if (pyramids == null)
      NavBar(
        barType: BarType.min,
      ),

      _ragehIsOn == false ? Container() :
      Rageh(
        tappingRageh: tappingRageh != null ? tappingRageh : (){print('no function here bitch');},
        doubleTappingRageh:
        Wordz.activeLanguage(context) == 'Arabic' ?
            () async {
          Locale temp = await setLocale('en');
          BldrsApp.setLocale(context, temp);
        } :
            () async {
          Locale temp = await setLocale('ar');
          BldrsApp.setLocale(context, temp);
        },
      ),

      if (pyramids != null && deviceIsIOS() == true)
        Positioned(
            bottom: 0,
            left: 0,
            child: BldrsBackButton(
              color: sky == Sky.Black ? Colorz.YellowZircon : Colorz.WhiteGlass,
            ),
    ),

    ];

    return StreamProvider<List<UserModel>>.value(
      value: UserProvider().allUsersStream,
      child: GestureDetector(
          onTap: (){minimizeKeyboardOnTapOutSide(context);},
        child: SafeArea(
          child: Scaffold(
            // key: _scaffoldKey,
            resizeToAvoidBottomPadding: false,
            // resizeToAvoidBottomInset: false,
            body:
            canRefreshFlyers ?

            RefreshIndicator(
              onRefresh: ()=> _refresh(context),
              color: Colorz.BlackBlack,
              backgroundColor: Colorz.Yellow,
              displacement: Ratioz.ddAppBarMargin,
              strokeWidth: 4,
              child: Stack(
                alignment: Alignment.topCenter,
                children: _mainLayoutStackWidgets,
              ),
            )

                :

            Stack(
              alignment: Alignment.topCenter,
              children: _mainLayoutStackWidgets,
            ),

          ),
        ),
      ),
    );
  }
}
// === === === === === === === === === === === === === === === === === === ===
/// --- for testing purposes, only used in appBar
Widget zorar(Function function, String functionName){
  return DreamBox(
    height: 40,
    boxMargins: EdgeInsets.all(5),
    color: Colorz.WhiteAir,
    verse: functionName,
    verseScaleFactor: 0.7,
    boxFunction: function,
  );
}
// === === === === === === === === === === === === === === === === === === ===
/// --- THE HORIZON IS BOTTOM PADDING THAT RESPECTS PYRAMIDS HEIGHT
class PyramidsHorizon extends StatelessWidget {
  final double heightFactor;

  PyramidsHorizon({
    this.heightFactor = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Ratioz.horizon * heightFactor,
    );
  }
}
// === === === === === === === === === === === === === === === === === === ===
/// --- STRATOSPHERE IS UPPER SCREEN PADDING THAT RESPECTS APPBAR HEIGHT
class Stratosphere extends StatelessWidget {
  final double heightFactor;

  Stratosphere({
    this.heightFactor = 1,
});

  static const EdgeInsets stratosphereInsets = EdgeInsets.only(top: Ratioz.stratosphere);
  static const EdgeInsets stratosphereSandwich = EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.stratosphere);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: superScreenWidth(context),
      height: 70 * heightFactor,
    );
  }
}
// === === === === === === === === === === === === === === === === === === ===

