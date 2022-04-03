import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart' as FlyerTypeClass;
import 'package:bldrs/a_models/chain/spec_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/x_screens/f_bz_editor/f_x_bz_editor_screen.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/xxx_dashboard/a_modules/translations_manager/translations_manager.dart';
import 'package:bldrs/xxx_lab/xxx_obelisk/only_for_dev_widgets/obelisk_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/xxx_lab/xxx_obelisk/only_for_dev_widgets/the_golden_scroll.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/flyer_maker_screen.dart/specs_lists_pickers_screen.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name_button.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/f_helpers/notifications/test_screens/awesome_noti_test_screen.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_dashboard/dashboard.dart';
import 'package:bldrs/xxx_lab/ask/new_asks.dart';
import 'package:bldrs/xxx_lab/xxx_obelisk/cloud_functions_test.dart';
import 'package:bldrs/xxx_lab/xxx_obelisk/location_test_screen/locations_test_screen.dart';
import 'package:bldrs/xxx_lab/xxx_obelisk/providers_test.dart';
import 'package:bldrs/xxx_lab/xxx_obelisk/slider_test.dart';
import 'package:bldrs/xxx_lab/xxx_obelisk/video_player.dart';
import 'package:bldrs/xxx_lab/xxx_obelisk/zzz_test_lab.dart';
import 'package:bldrs/xxx_lab/xxx_old_stuff/old_ldb_tests/sembast_test_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
/// typedef ValuesChanged<T, E> = void Function(T value, E valueTwo);
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
  }
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
//     final User _firebaseUser = FireAuthOps.superFirebaseUser();
// ---------------------------------------------------------------------------
    return MainLayout(
      key: const ValueKey<String>('obelisk'),
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

        /// BLDRS NAME
        BldrsNameButton(
            onTap: () => Nav.goToNewScreen(context, const DashBoard())
        ),

      ],

      layoutWidget: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[

          const Stratosphere(),

          const SuperVerse(
            verse: 'Dear Lord\nPlease Bless this project to be in good use for humanity',
            size: 1,
            italic: true,
            weight: VerseWeight.thin,
            color: Colorz.white80,
            maxLines: 5,
            margin: 10,
          ),

          const ObeliskButton('SEMBAST', Iconz.terms, SembastReaderTestScreen()),

          const ObeliskButton('New ASKs', Iconz.utPlanning, NewAsks()),

          const ObeliskButton('Translations Lab', Iconz.language, TranslationsManager()),

          ObeliskButton('BzEditor', Iconz.bz, BzEditorScreen(
            userModel: UserModel.dummyUserModel(context),
            // bzModel: null,
            firstTimer: true,
          )
          ),

          const ObeliskButton('VideoPlayer', Iconz.play, VideoPlayerScreen()),

          const ObeliskButton('TEST LAB', Iconz.flyer, TestLab()),

          const ObeliskButton(
              'Specs Selector',
              Iconz.flyer,
              SpecsListsPickersScreen(
                flyerType: FlyerTypeClass.FlyerType.design,
                selectedSpecs: <SpecModel>[],
              )),

          const ObeliskButton('Locations Test screen', Iconz.flyer, LocationsTestScreen()),

          const ObeliskButton('Providers Test', Iconz.terms, ProvidersTestScreen()),

          const ObeliskButton('Cloud Functions', Iconz.gears, CloudFunctionsTest()),

          // const ObeliskButton('Notification test', Iconz.news, FCMTestScreen()),

          const ObeliskButton('Awesome Notification test', Iconz.news, AwesomeNotiTestScreen()),

          const ObeliskButton('Slider Test Screen', Iconz.flyer, SliderTestScreen()),

          /// --- BLDRS DEVELOPMENT SCROLLS --------------------------------
          Column(
            children: const <Widget>[
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
            ],
          ),

          const Horizon(),
        ],
      ),
    );
  }
}
