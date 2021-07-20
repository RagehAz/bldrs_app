import 'dart:async';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/dashboard/s01_dashboard.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/views/screens/a0_user_checker_widget.dart';
import 'package:bldrs/views/widgets/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/buttons/main_button.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/views/widgets/textings/the_golden_scroll.dart';
import 'package:bldrs/xxx_LABORATORY/animations/animations_screen.dart';
import 'package:bldrs/xxx_LABORATORY/animations/black_hole.dart';
import 'package:bldrs/xxx_LABORATORY/firestore_test/storage_test.dart';
import 'package:bldrs/xxx_LABORATORY/forms_and_inputs/popup.dart';
import 'package:bldrs/xxx_LABORATORY/forms_and_inputs/form.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/dialog_test_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/dynamic_links_test.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/fire_search_test.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/firebase_testing.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/random_test_space.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/slider_test.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x03_font_test_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x06_swiper_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x08_earth_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x10_pro_flyer_page_view.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x11_pro_flyer_grid_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// === === === === === === === === === === === === === === === === === === ===
// ---------------------------------------------------------------------------
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
class ObeliskScreen extends StatefulWidget {
  final PageController controller;

  ObeliskScreen({
    this.controller,
    Key key,
  }) : super(key: key);


  @override
  _ObeliskScreenState createState() => _ObeliskScreenState();
}

class _ObeliskScreenState extends State<ObeliskScreen>{
  bool _isSignedIn;
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    User _firebaseUser = superFirebaseUser();
    _isSignedIn = _firebaseUser == null ? false : true;

    super.initState();
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
  Future<void> _tapGoogleSignOut() async {

    _triggerLoading();

    bool _isInAfterSignOut = await AuthOps.googleSignOutOps(context);

      setState(() {
        _isSignedIn = _isInAfterSignOut;
      });

    _triggerLoading();

    print('_tapGoogleSignOut _isSignedIn : ${_isSignedIn}');

  }
// ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

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
        Expanded(child: Container(),),

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

          Stratosphere(),

          SuperVerse(
            verse: 'Dear Lord\nPlease give us the power to finish this project and succeeed',
            size: 0,
            italic: true,
            weight: VerseWeight.thin,
            color: Colorz.White80,
            maxLines: 4,
          ),

          LogoSlogan(sizeFactor: 0.8,),

          oButton('user checker', Iconz.Flyer, UserChecker()),

          oButton('Random Test Space', Iconz.Flyer, RandomTestSpace()),

          oButton('Slider Test Screen', Iconz.Flyer, SliderTestScreen()),

          oButton('Fire search test', Iconz.Search, FireSearchTest()),

          oButton('Dynamic Links test', Iconz.Share, DynamicLinkTest()),

          oButton('Dialog Test', Iconz.More, DialogTestScreen(), color: Colorz.BloodTest),

          oButton('Firebase testing', Iconz.Filter, Firebasetesting()),

          oButton('Storage testing', Iconz.ArrowDown, FireStorageTest()),

          oButton('10 - Font lab', Iconz.Language, FontTestScreen()),

          oButton('12 - Swiper Layout', Iconz.Gallery, SwiperScreen()),

          oButton('13 - FlyersPageView', Iconz.Statistics, FlyersPageView()),

          oButton('14 - FlyersGridView', Iconz.FlyerGrid, FlyersGridView()),

          // oButton('21 - Soundz', Iconz.News, SoundzScreen()),

          oButton('22 - PopUp', Iconz.News, PopUpTestScreen()),

          oButton('23 - Form', Iconz.Terms, TestFormScreen()),

          oButton('26 - City Dots', Iconz.Earth, EarthScreen()),

          // oButton('28 - Google Maps - Defined size Pin', Iconz.ComMap, GoogleMapScreen2()),

          // oButton('29 - Google Maps - Image Pin', Iconz.ComMap, GoogleMapScreen3()),

          // oButton('30 - Google Maps - text box canvas', Iconz.ComMap, GoogleMapScreen4()),

          // oButton('31 - Google Maps - testSpace', Iconz.ComMap, GoogleMapScreen5()),

          oButton('36 - Animations Screen', Iconz.DvDonaldDuck, AnimationsScreen()),

          oButton('BLACK HOLE', Iconz.DvBlackHole, BlackHoleScreen()),

          // --- BLDRS DEVELOPMENT SCROLLS --------------------------------
          Column(
            children: <Widget>[
              GoldenScroll(
                scrollTitle: 'To run on my Note3 mobile',
                scrollScript: 'flutter run --release -d 4d00c32746ba80bf',
              ),
              GoldenScroll(
                scrollTitle: 'To run on all emulators',
                scrollScript: 'flutter run -d all',
              ),
              GoldenScroll(
                scrollTitle: 'Google Maps API key',
                scrollScript: 'AIzaSyDQGuhqhKu1mSdNxAbS_BCP8NfCB1ENmaI',
              ),
              GoldenScroll(
                scrollTitle: 'Google Maps Platform API key',
                scrollScript:
                    'AIzaSyDp6MMLw2LJflspqJ0x2uZCmQuZ32vS3XU', // AIzaSyD5CBTWvMaL6gU0X7gfdcnkpFmo-aNfgx4
              ),
              GoldenScroll(
                scrollTitle: 'To change terminal Directory',
                scrollScript: 'cd H:\\bldrs\\bldrs',
              ),
              GoldenScroll(
                scrollTitle: 'Git repo URL',
                scrollScript:
                    'git remote add origin https://github.com/RagehAz/bldrs.net \n'
                    'git push -u origin master',
              ),
            ],
          ),

          PyramidsHorizon(heightFactor: 3,),

        ],
      ),
    );
  }
}
