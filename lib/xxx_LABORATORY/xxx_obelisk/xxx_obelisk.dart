import 'dart:async';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/dashboard/s01_dashboard.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/views/screens/x1_flyers_publisher_screen.dart';
import 'package:bldrs/views/screens/x2_flyer_editor_screen_test.dart';
import 'package:bldrs/views/widgets/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/buttons/main_button.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/views/widgets/textings/the_golden_scroll.dart';
import 'package:bldrs/xxx_LABORATORY/animations/animations_screen.dart';
import 'package:bldrs/xxx_LABORATORY/firestore_test/storage_test.dart';
import 'package:bldrs/xxx_LABORATORY/forms_and_inputs/popup.dart';
import 'package:bldrs/xxx_LABORATORY/forms_and_inputs/form.dart';
import 'package:bldrs/xxx_LABORATORY/navigation_test/nav_test_home.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/aaa_state_test.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/appbar_test.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/dialog_test_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/dynamic_links_test.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/fire_search_test.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/firebase_testing.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/google_sign_in_test.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/random_test_space.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/share_and_gallery_image_test.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/slider_test.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/text_field_test.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x03_font_test_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x04_flyers_sizes_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x06_single_collection_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x06_swiper_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x08_earth_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x10_pro_flyer_page_view.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x11_pro_flyer_grid_view.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x12_checkbox_lesson.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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

class _ObeliskScreenState extends State<ObeliskScreen> with TickerProviderStateMixin{
  AnimationController _blackHoleController;
  int _spinsDuration = 1;
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
    _blackHoleController = AnimationController(
      duration: Duration(seconds: _spinsDuration),
      vsync: this
    );

    User _firebaseUser = superFirebaseUser();
    _isSignedIn = _firebaseUser == null ? false : true;

    super.initState();
  }
// ---------------------------------------------------------------------------
  // final GlobalKey<FormState> _key = GlobalKey<FormState>();
// ---------------------------------------------------------------------------
  Timer _timoor(){
    Timer _timoor = Timer(Duration(seconds: _spinsDuration),
            (){
          if(mounted){_blackHoleController.reset();}
          if(mounted){_enterTheBlackHole();}
        }
    );
    return _timoor;
  }
// ---------------------------------------------------------------------------
  void _enterTheBlackHole(){
    print('ezayak el awwal');
    if(mounted){_blackHoleController.forward();}
    if(mounted){_timoor();}
  }
// ---------------------------------------------------------------------------
  @override
  void dispose() {
    _timoor()?.cancel();
    _blackHoleController.stop();
    _blackHoleController.dispose();
    super.dispose();
  }
// ---------------------------------------------------------------------------
  Widget oButton (String title, String icon, Widget screen){
    return
      MainButton(
        buttonVerse: title,
        buttonColor: Colorz.Black125,
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

    final GoogleSignIn googleSignIn = GoogleSignIn();
    print('googleSignIn.currentUser was : ${googleSignIn.currentUser}');

    try {

      if (!kIsWeb) {await googleSignIn.signOut();}

      await FirebaseAuth.instance.signOut();

      setState(() {
        _isSignedIn = false;
      });


    } catch (error) {

      await superDialog(
        context: context,
        title: 'Can\'t sign out',
        body: 'Something is wrong : $error',
      );

    }

    _triggerLoading();
    print('googleSignIn.currentUser is : ${googleSignIn.currentUser}');

  }
// ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

// ---------------------------------------------------------------------------
    return MainLayout(
      pyramids: Iconz.PyramidsCrystal,
      appBarType: AppBarType.Basic,
      appBarRowWidgets: <Widget>[
        DreamBox(
          height: 40,
          verse: _isSignedIn ? ' Signed in ' : ' Signed out ',
          color: _isSignedIn ? Colorz.Green225 : Colorz.Grey80,
          verseScaleFactor: 0.6,
          verseColor: _isSignedIn ? Colorz.White225 : Colorz.DarkGrey225,
          onTap: () => AuthOps().signOut(context: context, routeToUserChecker: true),
        ),
      ],

      layoutWidget: ListView(
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

          oButton('Random Test Space', Iconz.Flyer, RandomTestSpace()),

          oButton('Slider Test Screen', Iconz.Flyer, SliderTestScreen()),

          oButton('Fire search test', Iconz.Search, FireSearchTest()),

          oButton('App Bar Test', Iconz.Share, AppBarTest()),

          oButton('Dynamic Links test', Iconz.Share, DynamicLinkTest()),

          oButton('Google auth test', Iconz.ComGooglePlus, GoogleSignInTest()),

          oButton('Navigation test', Iconz.ArrowUp, NavTestHome()),

          oButton('Dialog Test', Iconz.More, DialogTestScreen()),

          oButton('StateTest', Iconz.XSmall, StateTest(
            bolbol: Bolbol(
                tots: [Totta(name: 'tot 1', times: 5)],
                name: 'shosho',
                length: 3
            ),
          )),

          oButton('Firebase testing', Iconz.Filter, Firebasetesting()),

          oButton('Storage testing', Iconz.ArrowDown, FireStorageTest()),

          oButton('Dash Board', Iconz.DashBoard, DashBoard()),

          oButton('Text field test', Iconz.Language, TextFieldTest()),

          // oButton('MultiGalleryPicker', Iconz.DvGouran, MultiGalleryPicker()),

          // oButton('7 - Flyer Screen', Iconz.Flyer, FlyerScreen()), // () => openFlyer(context, 'f034')

          oButton('8 - Flyer Sizes tests', Iconz.FlyerScale, FlyersSizesScreen()),

          oButton('9 - Single Collection Screen', Iconz.FlyerScale, SingleCollectionScreen()),

          oButton('10 - Font lab', Iconz.Language, FontTestScreen()),

          oButton('12 - Swiper Layout', Iconz.Gallery, SwiperScreen()),

          oButton('13 - FlyersPageView', Iconz.Statistics, FlyersPageView()),

          oButton('14 - FlyersGridView', Iconz.FlyerGrid, FlyersGridView()),

          // oButton('21 - Soundz', Iconz.News, SoundzScreen()),

          oButton('22 - PopUp', Iconz.News, PopUpTestScreen()),

          oButton('23 - Form', Iconz.Terms, TestFormScreen()),

          oButton('25 - ShareAndAddImageTest', Iconz.Share, ShareAndAddImageTest()),

          oButton('26 - City Dots', Iconz.Earth, EarthScreen()),

          // oButton('28 - Google Maps - Defined size Pin', Iconz.ComMap, GoogleMapScreen2()),

          // oButton('29 - Google Maps - Image Pin', Iconz.ComMap, GoogleMapScreen3()),

          // oButton('30 - Google Maps - text box canvas', Iconz.ComMap, GoogleMapScreen4()),

          // oButton('31 - Google Maps - testSpace', Iconz.ComMap, GoogleMapScreen5()),

          oButton('34 - Old CheckBox thing', Iconz.Check, CheckBoxLessonScreen()),

          oButton('36 - Animations Screen', Iconz.DvDonaldDuck, AnimationsScreen()),

          // --- DATE PICKER -------------------------------
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Select Date fucker',
            ),
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year),
                lastDate: DateTime(DateTime.now().year + 50),
              );
            },
          ),

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

          // -- enter The black hole
          SuperVerse(
            verse: 'Enter\nThe Black-Hole',
            size: 4,
            maxLines: 2,
            margin: 50,
            labelTap: (){_blackHoleController.reset();},
          ),

          // -- BlackHole
          RotationTransition(
            turns: Tween(begin: 0.0, end: 100.0).animate(_blackHoleController),
            child: DreamBox(
              height: 300,
              width: 300,
              icon: Iconz.DvBlackHole,
              iconSizeFactor: 0.95,
              margins: const EdgeInsets.symmetric(vertical: 25),
              corners: 150,
              color: Colorz.White10,
              verseScaleFactor: 0.8,
              onTap: _enterTheBlackHole,
            ),
          ),

          PyramidsHorizon(heightFactor: 3,),

        ],
      ),
    );
  }
}
