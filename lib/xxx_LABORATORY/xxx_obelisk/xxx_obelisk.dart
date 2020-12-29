import 'package:bldrs/view_brains/controllers/flyer_controllers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/screens/ask_screen.dart';
import 'package:bldrs/views/widgets/appbar/ab_main.dart';
import 'package:bldrs/views/widgets/appbar/pages/pg_country.dart';
import 'package:bldrs/views/widgets/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/buttons/bt_main.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/planet/google_map_2.dart';
import 'package:bldrs/views/widgets/planet/google_map_3.dart';
import 'package:bldrs/views/widgets/planet/google_map_4.dart';
import 'package:bldrs/views/widgets/planet/google_map_5.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
import 'package:bldrs/views/widgets/space/stratosphere.dart';
import 'package:bldrs/views/widgets/textings/the_golden_scroll.dart';
import 'package:bldrs/xxx_LABORATORY/ask/ask_screen.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/camera_page.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/google_map.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/x12_image_picker.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/x13_camera.dart';
import 'package:bldrs/xxx_LABORATORY/forms_and_inputs/popup.dart';
import 'package:bldrs/xxx_LABORATORY/forms_and_inputs/form.dart';
import 'package:bldrs/xxx_LABORATORY/testers/database_viewer_screen.dart';
import 'package:bldrs/xxx_LABORATORY/testers/test_subjects.dart'
    as TestSubjects;
import 'package:bldrs/xxx_LABORATORY/testers/testerScreen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x11_pro_flyer_grid_view.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x16_sounds_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x17_create_new_flyer.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x18_multi_gallery_picker.dart';
import 'package:flutter/material.dart';
import '../CLEANING_SPACE.dart';
import 'x10_pro_flyer_page_view.dart';
import 'x12_checkbox_lesson.dart';

// === === === === === === === === === === === === === === === === === === ===
// ---------------------------------------------------------------------------
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
class ObeliskScreen extends StatefulWidget {
  ObeliskScreen({Key key, this.controller}) : super(key: key);

  final PageController controller;

  @override
  _ObeliskScreenState createState() => _ObeliskScreenState();
}

class _ObeliskScreenState extends State<ObeliskScreen> {
  String theChosenFlag = flagFileNameSelectedFromPGLanguageList;
  void flagSwitch() {
    setState(() {
      theChosenFlag = flagFileNameSelectedFromPGLanguageList;
    });
    print(flagFileNameSelectedFromPGLanguageList);
  }

  // final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // double buttonCorner = MediaQuery.of(context).size.height * varza.rrButtonCorner;
    // double appBarCornerValue = MediaQuery.of(context).size.height * 0.0215;
    // String theChosenFlag = flagfileNameSelectedFromPGLanguageList;
    // void switchingCountry(){
    //   setState(() {
    //     theChosenFlag = flagFileNameSelectedFromPGLanguageList;
    //   });
    // }

    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = superScreenHeight(context);

    return MainLayout(
      pyramids: Iconz.PyramidsCrystal,
      appBarType: AppBarType.Main,
      layoutWidget: ListView(
        children: <Widget>[
          Stratosphere(),

          LogoSlogan(),

          BTMain(
            buttonVerse: 'AskScreen',
            buttonColor: Colorz.BloodRed,
            buttonIcon: Iconz.DvGouran,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            function: () => goToNewScreen(context, AskScreen()),
            stretched: false,
          ),

          BTMain(
            buttonVerse: getTranslated(context, 'Create_Flyer'),
            buttonColor: Colorz.BlackPlastic,
            buttonIcon: Iconz.DvGouran,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            function: () => goToNewScreen(context, CreateFlyerScreen()),
            stretched: false,
          ),

          //  Ask Page
          BTMain(
            buttonVerse: "Ask Page",
            buttonColor: Colorz.BlackPlastic,
            buttonIcon: Iconz.DvGouran,
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

          // --- PRINT TEST
          BTMain(
            function: () {
              print('Testing print');
            },
            buttonIcon: '',
            splashColor: Colorz.White,
            buttonColor: Colorz.BloodRed,
            buttonVerseShadow: true,
            stretched: true,
            buttonVerse: 'print test',
          ),

          // --- DATA BASE GETTERS -------------------------------
          BTMain(
            buttonVerse: 'Database Getters Tests',
            buttonIcon: Iconz.DvGouran,
            buttonColor: Colorz.SkyDarkBlue,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function:
                // Routez.ProviderTest,
                () => goToNewScreen(
                    context, TesterScreen(testList: TestSubjects.dbGetters)),
            stretched: false,
          ),

          // --- PROVIDERS HATTERS -------------------------------
          BTMain(
            buttonVerse: 'provider Hatters Tests',
            buttonIcon: Iconz.DvGouran,
            buttonColor: Colorz.SkyDarkBlue,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function:
                // Routez.ProviderTest,
                () => goToNewScreen(context,
                    TesterScreen(testList: TestSubjects.proHatters(context))),
            stretched: false,
          ),

          // --- DATABASE VIEWER -------------------------------
          BTMain(
            buttonVerse: 'Database viewer',
            buttonIcon: Iconz.DvGouran,
            buttonColor: Colorz.SkyDarkBlue,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function:
                // Routez.ProviderTest,
                () => goToNewScreen(context, DatabaseViewerScreen()),
            stretched: false,
          ),

          // --- FLYERS SCREEN -------------------------------
          BTMain(
            buttonVerse: 'Flyer Screen',
            buttonIcon: Iconz.Gallery,
            buttonColor: Colorz.Green,
            splashColor: Colorz.Yellow,
            buttonVerseShadow: false,
            function: () => openFlyer(context, 'f034'),
            stretched: false,
          ),

          // --- FLYERS TEST SCREEN -------------------------------
          BTMain(
            buttonVerse: 'Flyer Sizes tests',
            buttonIcon: Iconz.Flyer,
            buttonColor: Colorz.Green,
            splashColor: Colorz.Yellow,
            buttonVerseShadow: false,
            function: Routez.FlyersTest,
            stretched: false,
          ),

          // --- FLYERS COLLECTION -------------------------------
          BTMain(
            buttonVerse: 'Single Collection Screen',
            buttonIcon: Iconz.Gallery,
            buttonColor: Colorz.Green,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function: Routez.SingleCollection,
            stretched: false,
          ),

          // --- FONT CORRECTION -------------------------------
          BTMain(
            buttonVerse: 'Font lab',
            buttonIcon: Iconz.Language,
            buttonColor: Colorz.Green,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function: Routez.FontTest,
            stretched: false,
          ),

          // --- ID ISSUE -------------------------------
          BTMain(
            buttonVerse: 'ID ISSUE',
            buttonIcon: Iconz.Info,
            buttonColor: Colorz.Green,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function: Routez.IDScreen,
            stretched: false,
          ),

          // --- SWIPER LAYOUT -------------------------------
          BTMain(
            buttonVerse: 'Swiper Layout',
            buttonColor: Colorz.Green,
            buttonIcon: Iconz.Gallery,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            function: Routez.MainLayout,
            stretched: false,
          ),

          // --- PRO FLYERS PAGE VIEW -------------------------------
          BTMain(
            buttonVerse: 'ProFlyersPageView',
            buttonIcon: Iconz.Statistics,
            buttonColor: Colorz.Green,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function:
                // Routez.ProviderTest,
                () => goToNewScreen(context, ProFlyersPageView()),
            stretched: false,
          ),

          // --- PRO FLYERS GRID VIEW -------------------------------
          BTMain(
            buttonVerse: 'ProFlyersGridView',
            buttonIcon: Iconz.Statistics,
            buttonColor: Colorz.Green,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function:
                // Routez.ProviderTest,
                () => goToNewScreen(context, ProFlyersGridView()),
            stretched: false,
          ),

          // --- PROBZ Test -------------------------------
          // BTMain(
          //   buttonVerse: 'ProBz',
          //   buttonIcon: Iconz.Bz,
          //   buttonColor: Colorz.BloodRedPlastic,
          //   splashColor: Colorz.White,
          //   buttonVerseShadow: true,
          //   function:
          //   // Routez.ProviderTest,
          //       () => goToNewScreen(context, ProBzScreen()),
          //   stretched: false,
          // ),

          // --- CAMERA BY MAX -------------------------------
          BTMain(
            buttonVerse: 'Camera by Max',
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

          // --- CAMERA PACKAGE -------------------------------
          BTMain(
            buttonVerse: 'Camera Package',
            buttonIcon: Iconz.Camera,
            buttonColor: Colorz.Nothing,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function:
                // Routez.ProviderTest,
                () => goToNewScreen(context, CameraPage()),
            // (){widget.controller.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.ease);},
            stretched: false,
          ),

          // --- CAMERA PACKAGE -------------------------------
          BTMain(
            buttonVerse: 'MainLayout now not flutter Better Camera Package',
            buttonIcon: Iconz.Camera,
            buttonColor: Colorz.Nothing,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function:
                // Routez.ProviderTest,
                () => goToNewScreen(context, MainLayout()),
            // (){widget.controller.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.ease);},
            stretched: false,
          ),

          // --- IMAGE PICKER -------------------------------
          BTMain(
            buttonVerse: 'Image Picker',
            buttonIcon: Iconz.PhoneGallery,
            buttonColor: Colorz.LightBlue,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function:
                // Routez.ProviderTest,
                () => goToNewScreen(context, CameraScreen()),
            stretched: false,
          ),

          // --- SOUNDZ -------------------------------
          BTMain(
            buttonVerse: 'Soundz',
            buttonIcon: Iconz.News,
            buttonColor: Colorz.Nothing,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function:
                // Routez.ProviderTest,
                () => goToNewScreen(context, SoundzScreen()),
            // (){widget.controller.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.ease);},
            stretched: false,
          ),

          // --- POP UP -------------------------------
          BTMain(
            buttonVerse: 'PopUp',
            buttonIcon: Iconz.News,
            buttonColor: Colorz.GreyZircon,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function:
                // Routez.ProviderTest,
                () => goToNewScreen(context, PopUpTestScreen()),
            stretched: false,
          ),

          // --- FORM -------------------------------
          BTMain(
            buttonVerse: 'Form',
            buttonIcon: Iconz.Terms,
            buttonColor: Colorz.GreyZircon,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function:
                // Routez.ProviderTest,
                () => goToNewScreen(context, TestFormScreen()),
            stretched: false,
          ),

          // --- HERO -------------------------------
          BTMain(
            buttonVerse: 'Hero Test',
            buttonIcon: Iconz.Gallery,
            buttonColor: Colorz.Grey,
            splashColor: Colorz.White,
            buttonVerseShadow: true,
            function: Routez.HeroTest,
            stretched: false,
          ),

          // --- CHAT SCREEN -------------------------------
          BTMain(
            buttonVerse: 'Chat Screen',
            buttonColor: Colorz.BabyBlueSmoke,
            buttonIcon: Iconz.UTPlanning,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            function: Routez.ChatScreen,
            stretched: false,
          ),

          // --- Earth -------------------------------
          BTMain(
            buttonVerse: 'City Dots',
            buttonColor: Colorz.Green,
            buttonIcon: Iconz.Earth,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            function: Routez.EarthScreen,
            stretched: false,
          ),

          // --- GOOGLE MAP NON RESIZABLE PNG PIN -------------------------------
          BTMain(
            buttonVerse: 'Google Maps - Custom non resizable fucking pin',
            buttonColor: Colorz.Green,
            buttonIcon: Iconz.ComMap,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            stretched: true,
            function: () => goToNewScreen(context, GoogleMapScreen()),
          ),

          // --- GOOGLE MAP DEFINED SIZE PIN -------------------------------
          BTMain(
            buttonVerse: 'Google Maps - Defined size Pin',
            buttonColor: Colorz.Green,
            buttonIcon: Iconz.ComMap,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            stretched: true,
            function: () => goToNewScreen(context, GoogleMapScreen2()),
          ),

          // --- GOOGLE MAP IMAGE PIN -------------------------------
          BTMain(
            buttonVerse: 'Google Maps - Image Pin',
            buttonColor: Colorz.Green,
            buttonIcon: Iconz.ComMap,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            stretched: true,
            function: () => goToNewScreen(context, GoogleMapScreen3()),
          ),

          // --- GOOGLE MAP CANVAS -------------------------------
          BTMain(
            buttonVerse: 'Google Maps - text box canvas',
            buttonColor: Colorz.Green,
            buttonIcon: Iconz.ComMap,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            stretched: true,
            function: () => goToNewScreen(context, GoogleMapScreen4()),
          ),

          // --- GOOGLE MAP -------------------------------
          BTMain(
            buttonVerse: 'Google Maps - testSpace',
            buttonColor: Colorz.WhiteAir,
            buttonIcon: Iconz.ComMap,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            stretched: true,
            function: () => goToNewScreen(context, GoogleMapScreen5()),
          ),

          // --- CREATE A NEW ACCOUNT -------------------------------
          BTMain(
            buttonVerse: getTranslated(context, 'Create_Account'),
            buttonIcon: Iconz.DvGouran,
            buttonColor: Colorz.BlackPlastic,
            splashColor: Colorz.Yellow,
            buttonVerseShadow: false,
            function: Routez.SignUp,
            stretched: true,
          ),

          // --- SIGN IN -------------------------------
          BTMain(
            buttonVerse: getTranslated(context, 'Sign_In'),
            buttonIcon: Iconz.DvGouran,
            buttonColor: Colorz.BlackPlastic,
            splashColor: Colorz.Yellow,
            buttonVerseShadow: false,
            function: Routez.SignIn,
            stretched: true,
          ),

          // --- CheckBox thing -------------------------------
          BTMain(
            buttonVerse: 'CheckBox thing',
            buttonColor: Colorz.Grey,
            buttonIcon: Iconz.Check,
            buttonVerseShadow: true,
            splashColor: Colorz.Yellow,
            stretched: true,
            function: () => goToNewScreen(context, CheckBoxLessonScreen()),
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
            children: [
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

          SizedBox(
            height: screenHeight * .1,
          ),

          // BTMain(
          //   buttonIcon: DreamBox(
          //     icon: Iconz.DvRageh,
          //     corners: screenWidth * 0.02,
          //     color: Colorz.Nothing,
          //     width: double.infinity,
          //     height: double.infinity,
          //     iconSizeFactor: 1,
          //   ),
          //   buttonVerse: 'Rageh Dash Board',
          //   stretched: true,
          //   buttonVerseShadow: true,
          //   buttonColor: Colorz.Yellow,
          //   splashColor: Colorz.White,
          //   function: Routez.RagehDashBoard,
          //   iconSizeFactor: 1,
          // ),
          // ---------------------------------------------------------------------
          // --- LAST THING TO GIVE SCROLLING SOME SPACE
          SizedBox(
            height: MediaQuery.of(context).size.height * .5,
          ),
        ],
      ),
    );
  }
}
