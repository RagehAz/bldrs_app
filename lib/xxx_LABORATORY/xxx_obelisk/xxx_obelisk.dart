import 'package:bldrs/controllers/notifications/test_screens/awesome_noti_test_screen.dart';
import 'package:bldrs/controllers/notifications/test_screens/fcm_tet_screen.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/dashboard/s01_dashboard.dart';
import 'package:bldrs/db/firestore/auth_ops.dart';
import 'package:bldrs/db/ldb/sembast/sembast_test_screen.dart';
import 'package:bldrs/db/ldb/sql_db/flyers_sql_screen.dart';
import 'package:bldrs/views/screens/a_starters/a_0_user_checker_widget.dart';
import 'package:bldrs/views/widgets/general/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/buttons/main_button.dart';
import 'package:bldrs/views/widgets/general/dialogs/web_view/web_view_test_screen.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/general/textings/the_golden_scroll.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/xxx_LABORATORY/animations/animations_screen.dart';
import 'package:bldrs/xxx_LABORATORY/animations/black_hole.dart';
import 'package:bldrs/xxx_LABORATORY/google_maps/x08_earth_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/cloud_functions_test.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/dialog_test_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/fire_search_test.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/forms_test.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/random_test_space.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/slider_test.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/timer_test.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/trigram_test.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x03_font_lab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// === === === === === === === === === === === === === === === === === === ===
// ---------------------------------------------------------------------------
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
class ObeliskScreen extends StatefulWidget {
  final PageController controller;

  ObeliskScreen({
    this.controller,
  });


  @override
  _ObeliskScreenState createState() => _ObeliskScreenState();
}

class _ObeliskScreenState extends State<ObeliskScreen>{
  bool _isSignedIn;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    User _firebaseUser = superFirebaseUser();
    _isSignedIn = _firebaseUser == null ? false : true;
  }
// ---------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
  }
// ---------------------------------------------------------------------------
  Widget oButton (String title, String icon, Widget screen, {Color color}){

    Color _color = color == null ? Colorz.Black125 : color;

    return
      MainButton(
        buttonVerse: title,
        buttonColor: _color,
        buttonIcon: icon,
        buttonVerseShadow: true,
        splashColor: Colorz.Yellow255,
        function: () => Nav.goToNewScreen(context, screen),
        stretched: false,
      );
  }
// ---------------------------------------------------------------------------
//   Future<void> _tapGoogleSignOut() async {
//
//     _triggerLoading();
//
//     bool _isInAfterSignOut = await AuthOps.googleSignOutOps(context);
//
//       setState(() {
//         _isSignedIn = _isInAfterSignOut;
//       });
//
//     _triggerLoading();
//
//     print('_tapGoogleSignOut _isSignedIn : ${_isSignedIn}');
//
//   }
// ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    User _firebaseUser = superFirebaseUser();

// ---------------------------------------------------------------------------
    return MainLayout(
      pyramids: Iconz.PyramidsCrystal,
      appBarType: AppBarType.Basic,
      appBarRowWidgets: <Widget>[

        /// IS SIGNED IN ?
        DreamBox(
          height: Ratioz.appBarButtonSize,
          verse: _isSignedIn ? ' Signed in ' : ' Signed out ',
          color: _isSignedIn ? Colorz.Green255 : Colorz.Grey80,
          verseScaleFactor: 0.6,
          verseColor: _isSignedIn ? Colorz.White255 : Colorz.DarkGrey225,
          onTap: () => AuthOps().signOut(context: context, routeToUserChecker: true),
        ),

        /// SPACER
        const Expander(),

        /// DASHBOARD
        DreamBox(
          height: Ratioz.appBarButtonSize,
          width: Ratioz.appBarButtonSize,
          color: Colorz.Yellow255,
          icon: Iconz.DashBoard,
          iconColor: Colorz.Black255,
          iconSizeFactor: 0.75,
          margins: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          bubble: true,
          onTap: () => Nav.goToNewScreen(context, DashBoard()),
        ),

      ],

      layoutWidget: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[

          const Stratosphere(),

          SuperVerse(
            verse: 'Dear Lord\nPlease give me the power to finish this project and succeed',
            size: 0,
            italic: true,
            weight: VerseWeight.thin,
            color: Colorz.White80,
            maxLines: 4,
          ),

          LogoSlogan(sizeFactor: 0.8,),

          oButton('TEST LAB', Iconz.Flyer, RandomTestSpace(
            flyerBoxWidth: FlyerBox.width(context, 0.5),
          )),

          oButton('TimersTest', Iconz.Clock, TimerTest()),

          oButton('Trigram Test', Iconz.More, TrigramTest()),

          oButton('Cloud Functions', Iconz.Gears, CloudFunctionsTest()),

          oButton('Web view test', Iconz.Terms, WebViewTestScreen()),

          oButton('Sembast Screen', Iconz.DvGouran, SembastTestScreen()),
          oButton('FlyersSQL Screen', Iconz.FlyerScale, FlyersSQLScreen()),

          oButton('Notification test', Iconz.News, FCMTestScreen()),

          oButton('Awesome Notification test', Iconz.News, AwesomeNotiTestScreen()),


          // oButton('HERO TEST', Iconz.DvDonaldDuck, HeroMinScreen()),

          oButton('go to user checker', Iconz.Flyer, UserChecker()),

          oButton('Slider Test Screen', Iconz.Flyer, SliderTestScreen()),

          oButton('Fire search test', Iconz.Search, FireSearchTest()),

          oButton('Dialog Test', Iconz.More, DialogTestScreen(), color: Colorz.BloodTest),

          oButton('10 - Font lab', Iconz.Language, FontLab()),

          // oButton('12 - Swiper Layout', Iconz.Gallery, SwiperScreen()),

          // oButton('21 - Soundz', Iconz.News, SoundzScreen()),

          oButton('23 - Form', Iconz.Terms, TestFormScreen()),

          oButton('26 - City Dots', Iconz.Earth, EarthScreen()),

          // oButton('28 - Google Maps - Defined size Pin', Iconz.ComMap, GoogleMapScreen2()),

          // oButton('29 - Google Maps - Image Pin', Iconz.ComMap, GoogleMapScreen3()),

          // oButton('30 - Google Maps - text box canvas', Iconz.ComMap, GoogleMapScreen4()),

          oButton('36 - Animations Screen', Iconz.DvDonaldDuck, AnimationsScreen()),

          oButton('BLACK HOLE', Iconz.DvBlackHole, BlackHoleScreen()),

          // --- BLDRS DEVELOPMENT SCROLLS --------------------------------
          Column(
            children: <Widget>[
              const GoldenScroll(
                scrollTitle: 'To run on my Note3 mobile',
                scrollScript: 'flutter run --release -d 4d00c32746ba80bf',
              ),
              const GoldenScroll(
                scrollTitle: 'To run on all emulators',
                scrollScript: 'flutter run -d all',
              ),
              const GoldenScroll(
                scrollTitle: 'Google Maps API key',
                scrollScript: 'AIzaSyDQGuhqhKu1mSdNxAbS_BCP8NfCB1ENmaI',
              ),
              const GoldenScroll(
                scrollTitle: 'Google Maps Platform API key',
                scrollScript:
                    'AIzaSyDp6MMLw2LJflspqJ0x2uZCmQuZ32vS3XU', // AIzaSyD5CBTWvMaL6gU0X7gfdcnkpFmo-aNfgx4
              ),
              const GoldenScroll(
                scrollTitle: 'To change terminal Directory',
                scrollScript: 'cd H:\\bldrs\\bldrs',
              ),
              const GoldenScroll(
                scrollTitle: 'Git repo URL',
                scrollScript:
                    'git remote add origin https://github.com/RagehAz/bldrs.net \n'
                    'git push -u origin master',
              ),

              GoldenScroll(
                  scrollTitle: 'my ID',
                  scrollScript: '${_firebaseUser?.displayName} : ${_firebaseUser?.uid}',
              ),

            ],
          ),

          const PyramidsHorizon(),

        ],
      ),
    );
  }
}
