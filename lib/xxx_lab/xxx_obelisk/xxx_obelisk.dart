import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart' as FlyerTypeClass;
import 'package:bldrs/a_models/kw/specs/spec_model.dart';
import 'package:bldrs/b_views/widgets/general/artworks/bldrs_name.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/buttons/obelisk_button.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/widgets/general/textings/the_golden_scroll.dart';
import 'package:bldrs/b_views/x_screens/g_user/g_0_user_profile_screen.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/flyer_maker_screen.dart/specs_lists_pickers_screen.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/e_db/ldb/sembast/sembast_test_screen.dart';
import 'package:bldrs/f_helpers/notifications/test_screens/awesome_noti_test_screen.dart';
import 'package:bldrs/f_helpers/notifications/test_screens/fcm_tet_screen.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_dashboard/dashboard.dart';
import 'package:bldrs/xxx_dashboard/ldb_manager/providers_test.dart';
import 'package:bldrs/xxx_lab/animations/animations_screen.dart';
import 'package:bldrs/xxx_lab/animations/black_hole.dart';
import 'package:bldrs/xxx_lab/new_layout.dart';
import 'package:bldrs/xxx_lab/xxx_obelisk/cloud_functions_test.dart';
import 'package:bldrs/xxx_lab/xxx_obelisk/dialog_test_screen.dart';
import 'package:bldrs/xxx_lab/xxx_obelisk/expansion_tiles_test.dart';
import 'package:bldrs/xxx_lab/xxx_obelisk/forms_test.dart';
import 'package:bldrs/xxx_lab/xxx_obelisk/google_test_screen.dart';
import 'package:bldrs/xxx_lab/xxx_obelisk/haversine.dart';
import 'package:bldrs/xxx_lab/xxx_obelisk/slider_test.dart';
import 'package:bldrs/xxx_lab/xxx_obelisk/timer_test.dart';
import 'package:bldrs/xxx_lab/xxx_obelisk/trigram_test.dart';
import 'package:bldrs/xxx_lab/xxx_obelisk/video_player.dart';
import 'package:bldrs/xxx_lab/xxx_obelisk/x03_font_lab.dart';
import 'package:bldrs/xxx_lab/xxx_obelisk/zzz_test_lab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
class ObeliskScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ObeliskScreen({
    this.controller,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final PageController controller;

  /// --------------------------------------------------------------------------
  @override
  _ObeliskScreenState createState() => _ObeliskScreenState();

  /// --------------------------------------------------------------------------
}

class _ObeliskScreenState extends State<ObeliskScreen> {
  bool _isSignedIn;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _isSignedIn = _isSignedInCheck();
  }

// ---------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
  }

// ---------------------------------------------------------------------------
  bool _isSignedInCheck() {
    bool _isSignedIn;

    final User _firebaseUser = FireAuthOps.superFirebaseUser();

    if (_firebaseUser == null) {
      _isSignedIn = false;
    } else {
      _isSignedIn = true;
    }

    return _isSignedIn;
  }

// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final User _firebaseUser = FireAuthOps.superFirebaseUser();

// ---------------------------------------------------------------------------
    return MainLayout(
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      appBarRowWidgets: <Widget>[
        /// IS SIGNED IN ?
        DreamBox(
          height: Ratioz.appBarButtonSize,
          verse: _isSignedIn ? ' Signed in ' : ' Signed out ',
          color: _isSignedIn ? Colorz.green255 : Colorz.grey80,
          verseScaleFactor: 0.6,
          verseColor: _isSignedIn ? Colorz.white255 : Colorz.darkGrey255,
          onTap: () =>
              FireAuthOps.signOut(context: context, routeToUserChecker: true),
        ),

        /// SPACER
        const Expander(),

        BldrsButton(onTap: () => Nav.goToNewScreen(context, const DashBoard())),
      ],
      layoutWidget: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[

          const Stratosphere(),

          const SuperVerse(
            verse:
                'Dear Lord\nPlease Bless this project to be in good use for humanity',
            size: 1,
            italic: true,
            weight: VerseWeight.thin,
            color: Colorz.white80,
            maxLines: 5,
            margin: 10,
          ),



          const ObeliskButton('New User Screen', Iconz.normalUser, UserProfileScreen()),

          const ObeliskButton('VideoPlayer', Iconz.play, VideoPlayerScreen()),

          const ObeliskButton('Haversine', Iconz.pyramidSingleWhite, Haversine()),

          const ObeliskButton('NEW LAYOUT', Iconz.star, NewLayout()),

          const ObeliskButton('TEST LAB', Iconz.flyer, TestLab()),

          const ObeliskButton(
              'Specs Selector',
              Iconz.flyer,
              SpecsListsPickersScreen(
                flyerType: FlyerTypeClass.FlyerType.design,
                selectedSpecs: <Spec>[],
              )),

          const ObeliskButton(
              'Google map Test screen', Iconz.flyer, LocationsTestScreen()),

          const ObeliskButton(
              'Expansion Tiles Test', Iconz.flyer, ExpansionTilesTest()),

          const ObeliskButton('Providers Test', Iconz.terms, ProvidersTestScreen()),

          const ObeliskButton('TimersTest', Iconz.clock, TimerTest()),

          const ObeliskButton('Trigram Test', Iconz.more, TrigramTest()),

          const ObeliskButton(
              'Cloud Functions', Iconz.gears, CloudFunctionsTest()),

          const ObeliskButton(
              'Sembast Screen', Iconz.dvGouran, SembastTestScreen()),

          // const ObeliskButton('Notification test', Iconz.news, FCMTestScreen()),

          const ObeliskButton(
              'Awesome Notification test', Iconz.news, AwesomeNotiTestScreen()),

          // ObeliskButton('HERO TEST', Iconz.DvDonaldDuck, HeroMinScreen()),

          const ObeliskButton(
              'Slider Test Screen', Iconz.flyer, SliderTestScreen()),

          const ObeliskButton('Dialog Test', Iconz.more, DialogTestScreen(),
              color: Colorz.bloodTest),

          const ObeliskButton('10 - Font lab', Iconz.language, FontLab()),

          // ObeliskButton('12 - Swiper Layout', Iconz.Gallery, SwiperScreen()),

          // ObeliskButton('21 - Soundz', Iconz.News, SoundzScreen()),

          const ObeliskButton('23 - Form', Iconz.terms, TestFormScreen()),

          // ObeliskButton('28 - Google Maps - Defined size Pin', Iconz.ComMap, GoogleMapScreen2()),

          // ObeliskButton('29 - Google Maps - Image Pin', Iconz.ComMap, GoogleMapScreen3()),

          // ObeliskButton('30 - Google Maps - text box canvas', Iconz.ComMap, GoogleMapScreen4()),

          const ObeliskButton('36 - Animations Screen', Iconz.dvDonaldDuck, AnimationsScreen()),

          const ObeliskButton('BLACK HOLE', Iconz.dvBlackHole, BlackHoleScreen()),

          /// --- BLDRS DEVELOPMENT SCROLLS --------------------------------
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
                scrollScript: r'cd H:\bldrs\bldrs',
              ),
              const GoldenScroll(
                scrollTitle: 'Git repo URL',
                scrollScript:
                    'git remote add origin https://github.com/RagehAz/bldrs.net \n'
                    'git push -u origin master',
              ),
              GoldenScroll(
                scrollTitle: 'my ID',
                scrollScript:
                    '${_firebaseUser?.displayName} : ${_firebaseUser?.uid}',
              ),
            ],
          ),

          const Horizon(),
        ],
      ),
    );
  }
}
