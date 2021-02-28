import 'dart:async';
import 'package:bldrs/dashboard/s01_dashboard.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/buttons/bt_main.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/layouts/swiper_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/views/widgets/textings/the_golden_scroll.dart';
import 'package:bldrs/xxx_LABORATORY/animations/animations_screen.dart';
import 'package:bldrs/xxx_LABORATORY/ask/ask_screen.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/camera_page.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/google_map.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/x12_image_picker.dart';
import 'package:bldrs/xxx_LABORATORY/forms_and_inputs/popup.dart';
import 'package:bldrs/xxx_LABORATORY/forms_and_inputs/form.dart';
import 'package:bldrs/xxx_LABORATORY/ideas/circle_list.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/text_field_test.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x03_font_test_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x08_earth_screen.dart';
import 'package:flutter/material.dart';
import 'o_01_translations.dart';
import 'x04_flyers_sizes_screen.dart';
import 'x05_city_picker.dart';
import 'x06_single_collection_screen.dart';
import 'share_and_gallery_image_test.dart';
import 'x10_pro_flyer_page_view.dart';
import 'x11_pro_flyer_grid_view.dart';
import 'x12_checkbox_lesson.dart';
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
// ---------------------------------------------------------------------------
  @override
  void initState() {
    _blackHoleController = AnimationController(
      duration: Duration(seconds: _spinsDuration),
      vsync: this
    );
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
  @override
  Widget build(BuildContext context) {

// ---------------------------------------------------------------------------
    return MainLayout(
      pyramids: Iconz.PyramidsCrystal,
      appBarType: AppBarType.Main,
      layoutWidget: ListView(
        children: <Widget>[

          Stratosphere(),

          SuperVerse(
            verse: 'Dear Lord\nPlease give us the power to finish this and reach the ends of planet earth',
            size: 0,
            italic: true,
            weight: VerseWeight.thin,
            color: Colorz.WhiteSmoke,
            maxLines: 4,
          ),

          LogoSlogan(),

          // --- 0 - DASHBOARD
          BTMain(
            buttonVerse: 'Text field test',
            buttonColor: Colorz.BlackPlastic,
            buttonIcon: Iconz.Language,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            function: () => goToNewScreen(context, TextFieldTest()),
            stretched: false,
          ),

          // --- 0 - DASHBOARD
          BTMain(
            buttonVerse: 'DASH BOARD',
            buttonColor: Colorz.BlackPlastic,
            buttonIcon: Iconz.DashBoard,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            function: () => goToNewScreen(context, DashBoard()),
            stretched: false,
          ),

          // --- 1 - ADD FLYER
          BTMain(
            buttonVerse: '1 - Add new flyer',
            buttonColor: Colorz.BlackPlastic,
            buttonIcon: Iconz.AddFlyer,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            function: () => goToRoute(context, Routez.FlyerMaker),
            stretched: false,
          ),

          // --- 2 - BISO ASK SCREEN
          BTMain(
            buttonVerse: "2 - Biso Ask Screen",
            buttonColor: Colorz.BlackPlastic,
            buttonIcon: Iconz.UTPlanning,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            function: () => goToNewScreen(context, AskScreen()),
            stretched: false,
          ),

          // BTMain(
          //   buttonVerse: 'MultiGalleryPicker',
          //   buttonColor: Colorz.BlackPlastic,
          //   buttonIcon: Iconz.DvGouran,
          //   buttonVerseShadow: true,
          //   splashColor: Colorz.Yellow,
          //   function: () => goToNewScreen(context, MultiGalleryPicker()),
          //   stretched: false,
          // ),

          // --- 3 - PRINT TEST
          BTMain(
            function: () {
              print('3 - Testing print');
            },
            buttonIcon: '',
            splashColor: Colorz.White,
            buttonColor: Colorz.BloodRed,
            buttonVerseShadow: true,
            stretched: true,
            buttonVerse: 'print test',
          ),

          // --- 4 - DATA BASE GETTERS -------------------------------
          BTMain(
            buttonVerse: '4 - Database Getters Tests',
            buttonIcon: Iconz.DvGouran,
            buttonColor: Colorz.SkyDarkBlue,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function:
            (){},
                // () => goToNewScreen(
                //     context, TesterScreen(testList: TestSubjects.dbGetters)),
            stretched: false,
          ),

          // --- 5 - PROVIDERS HATTERS -------------------------------
          BTMain(
            buttonVerse: '5 - provider Hatters Tests',
            buttonIcon: Iconz.DvGouran,
            buttonColor: Colorz.SkyDarkBlue,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function:
                (){},
                // () => goToNewScreen(context,
                //     TesterScreen(testList: TestSubjects.proHatters(context))),
            stretched: false,
          ),

          // --- 6 - DATABASE VIEWER -------------------------------
          BTMain(
            buttonVerse: '6 - Database viewer',
            buttonIcon: Iconz.DvGouran,
            buttonColor: Colorz.SkyDarkBlue,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function:
            (){},
                // () => goToNewScreen(context, DatabaseViewerScreen()),
            stretched: false,
          ),

          // --- 6 - CipherTest -------------------------------
          BTMain(
            buttonVerse: '6 - CipherTest',
            buttonIcon: Iconz.DvGouran,
            buttonColor: Colorz.SkyDarkBlue,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function:
            (){},
                // () => goToNewScreen(context, CipherTest()),
            stretched: false,
          ),

          // --- 7 - FLYERS SCREEN -------------------------------
          BTMain(
            buttonVerse: '7 - Flyer Screen',
            buttonIcon: Iconz.Flyer,
            buttonColor: Colorz.Green,
            splashColor: Colorz.Yellow,
            buttonVerseShadow: false,
            function: () => openFlyer(context, 'f034'),
            stretched: false,
          ),

          // --- 8 - FLYERS SIZES TEST -------------------------------
          BTMain(
            buttonVerse: '8 - Flyer Sizes tests',
            buttonIcon: Iconz.FlyerScale,
            buttonColor: Colorz.Green,
            splashColor: Colorz.Yellow,
            buttonVerseShadow: false,
            function: () => goToNewScreen(context, FlyersSizesScreen()),
            stretched: false,
          ),

          // --- 9 - FLYERS COLLECTION -------------------------------
          BTMain(
            buttonVerse: '9 - Single Collection Screen',
            buttonIcon: Iconz.FlyerCollection,
            buttonColor: Colorz.Green,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function: () => goToNewScreen(context, SingleCollectionScreen()),
            stretched: false,
          ),

          // --- 10 - FONT CORRECTION -------------------------------
          BTMain(
            buttonVerse: '10 - Font lab',
            buttonIcon: Iconz.Language,
            buttonColor: Colorz.Green,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function: () => goToNewScreen(context, FontTestScreen()),
            stretched: false,
          ),

          // --- 12 - SWIPER LAYOUT -------------------------------
          BTMain(
            buttonVerse: '12 - Swiper Layout',
            buttonColor: Colorz.Green,
            buttonIcon: Iconz.Gallery,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            function: () => goToNewScreen(context, SwiperLayout()),
            stretched: false,
          ),

          // --- 13 - PRO FLYERS PAGE VIEW -------------------------------
          BTMain(
            buttonVerse: '13 - FlyersPageView',
            buttonIcon: Iconz.Statistics,
            buttonColor: Colorz.Green,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function: () => goToNewScreen(context, FlyersPageView()),
            stretched: false,
          ),

          // --- 14 - PRO FLYERS GRID VIEW -------------------------------
          BTMain(
            buttonVerse: '14 - FlyersGridView',
            buttonIcon: Iconz.FlyerGrid,
            buttonColor: Colorz.Green,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function: () => goToNewScreen(context, FlyersGridView()),
            stretched: false,
          ),

          // --- 15 - TRANSLATIONS -------------------------------
          BTMain(
            buttonVerse: '15 - Translations',
            buttonIcon: Iconz.Language,
            buttonColor: Colorz.BloodRed,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            stretched: false,
            function:
                () => goToNewScreen(context, Translations()),
          ),

          // --- 16 - PROBZ Test -------------------------------
          // BTMain(
          //   buttonVerse: '16 - ProBz',
          //   buttonIcon: Iconz.Bz,
          //   buttonColor: Colorz.BloodRedPlastic,
          //   splashColor: Colorz.White,
          //   buttonVerseShadow: true,
          //   function:
          //   // Routez.ProviderTest,
          //       () => goToNewScreen(context, ProBzScreen()),
          //   stretched: false,
          // ),

          // --- 17 - CAMERA BY MAX -------------------------------
          BTMain(
            buttonVerse: '17 - Camera by Max',
            buttonIcon: Iconz.Camera,
            buttonColor: Colorz.Nothing,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function:
                // Routez.ProviderTest,
                () => goToNewScreen(context, MaxCameraScreen()),
            // (){widget.controller.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.ease);},
            stretched: false,
          ),

          // --- 18 - CAMERA PACKAGE -------------------------------
          BTMain(
            buttonVerse: '18 - Camera Package',
            buttonIcon: Iconz.Camera,
            buttonColor: Colorz.Nothing,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function: () => goToNewScreen(context, CameraPage()),
            // (){widget.controller.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.ease);},
            stretched: false,
          ),

          // --- 19 - CAMERA PACKAGE -------------------------------
          BTMain(
            buttonVerse: '19 - MainLayout now not flutter Better Camera Package',
            buttonIcon: Iconz.Camera,
            buttonColor: Colorz.Nothing,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function: () => goToNewScreen(context, MainLayout()),
            // (){widget.controller.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.ease);},
            stretched: false,
          ),

          // --- 21 - SOUNDZ -------------------------------
          BTMain(
            buttonVerse: '21 - Soundz',
            buttonIcon: Iconz.News,
            buttonColor: Colorz.Nothing,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function:
            (){},
                // Routez.ProviderTest,
                // () => goToNewScreen(context, SoundzScreen()),
            // (){widget.controller.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.ease);},
            stretched: false,
          ),

          // --- 22 - POP UP -------------------------------
          BTMain(
            buttonVerse: '22 - PopUp',
            buttonIcon: Iconz.News,
            buttonColor: Colorz.GreyZircon,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function:
                // Routez.ProviderTest,
                () => goToNewScreen(context, PopUpTestScreen()),
            stretched: false,
          ),

          // --- 23 - FORM -------------------------------
          BTMain(
            buttonVerse: '23 - Form',
            buttonIcon: Iconz.Terms,
            buttonColor: Colorz.GreyZircon,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function:
                // Routez.ProviderTest,
                () => goToNewScreen(context, TestFormScreen()),
            stretched: false,
          ),

          // --- 25 - CHAT SCREEN -------------------------------
          BTMain(
            buttonVerse: '25 - ShareAndAddImageTest',
            buttonColor: Colorz.BabyBlueSmoke,
            buttonIcon: Iconz.Share,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            function: () => goToNewScreen(context, ShareAndAddImageTest()),
            stretched: false,
          ),

          // --- 26 - City Dots -------------------------------
          BTMain(
            buttonVerse: '26 - City Dots',
            buttonColor: Colorz.BloodTest,
            buttonIcon: Iconz.Earth,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            function: () => goToNewScreen(context, EarthScreen()),
            stretched: false,
          ),

          // --- 27 - GOOGLE MAP NON RESIZABLE PNG PIN -------------------------------
          BTMain(
            buttonVerse: '27 - Google Maps - Custom non resizable fucking pin',
            buttonColor: Colorz.BloodTest,
            buttonIcon: Iconz.ComMap,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            stretched: true,
            function: () => goToNewScreen(context, GoogleMapScreen()),
          ),

          // // --- 28 - GOOGLE MAP DEFINED SIZE PIN -------------------------------
          // BTMain(
          //   buttonVerse: '28 - Google Maps - Defined size Pin',
          //   buttonColor: Colorz.BloodTest,
          //   buttonIcon: Iconz.ComMap,
          //   buttonVerseShadow: true,
          //   splashColor: Colorz.Yellow,
          //   stretched: true,
          //   function: () => goToNewScreen(context, GoogleMapScreen2()),
          // ),

          // // --- 29 - GOOGLE MAP IMAGE PIN -------------------------------
          // BTMain(
          //   buttonVerse: '29 - Google Maps - Image Pin',
          //   buttonColor: Colorz.BloodTest,
          //   buttonIcon: Iconz.ComMap,
          //   buttonVerseShadow: true,
          //   splashColor: Colorz.Yellow,
          //   stretched: true,
          //   function: () => goToNewScreen(context, GoogleMapScreen3()),
          // ),

          // // --- 30 - GOOGLE MAP CANVAS -------------------------------
          // BTMain(
          //   buttonVerse: '30 - Google Maps - text box canvas',
          //   buttonColor: Colorz.BloodTest,
          //   buttonIcon: Iconz.ComMap,
          //   buttonVerseShadow: true,
          //   splashColor: Colorz.Yellow,
          //   stretched: true,
          //   function: () => goToNewScreen(context, GoogleMapScreen4()),
          // ),

          // --- 31 - GOOGLE MAP -------------------------------
          // BTMain(
          //   buttonVerse: '31 - Google Maps - testSpace',
          //   buttonColor: Colorz.BloodTest,
          //   buttonIcon: Iconz.ComMap,
          //   buttonVerseShadow: true,
          //   splashColor: Colorz.Yellow,
          //   stretched: true,
          //   function: () => goToNewScreen(context, GoogleMapScreen5()),
          // ),

          // --- 34 -  OLD CHECKBOX THING -------------------------------
          BTMain(
            buttonVerse: '34 - Old CheckBox thing',
            buttonColor: Colorz.BlackBlack,
            buttonIcon: Iconz.Check,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            stretched: true,
            function: () => goToNewScreen(context, CheckBoxLessonScreen()),
          ),

          // --- 36 -  AnimationsScreen -------------------------------
          BTMain(
            buttonVerse: '36 - Animations Screen',
            buttonColor: Colorz.Nothing,
            buttonIcon: Iconz.DvDonaldDuck,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            stretched: true,
            function: () => goToNewScreen(context, AnimationsScreen()),
          ),

          // --- 36 -  AnimationsScreen -------------------------------
          BTMain(
            buttonVerse: '36 - Circle list widget',
            buttonColor: Colorz.Nothing,
            buttonIcon: Iconz.Clock,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            stretched: true,
            function: () => goToNewScreen(context, CircleListWidget()),
          ),



          // --- 36 -  AnimationsScreen -------------------------------
          BTMain(
            buttonVerse: '36 - SyncFusionMap',
            buttonColor: Colorz.Nothing,
            buttonIcon: Iconz.Earth,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            stretched: true,
            function: () => goToNewScreen(context, CityPicker()),
          ),



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

          BTMain(
            buttonIcon: Iconz.DvGouran,
            buttonVerse: 'inApp Dash Board',
            stretched: true,
            buttonVerseShadow: true,
            buttonColor: Colorz.BlackBlack,
            splashColor: Colorz.White,
            function: Routez.RagehDashBoard,
            iconSizeFactor: 1,
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
              boxMargins: EdgeInsets.symmetric(vertical: 25),
              corners: 150,
              color: Colorz.WhiteAir,
              verseScaleFactor: 0.8,
              boxFunction: _enterTheBlackHole,
            ),
          ),

          PyramidsHorizon(heightFactor: 3,),

        ],
      ),
    );
  }
}
