import 'dart:async';
import 'package:bldrs/dashboard/s01_dashboard.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/screens/s50_flyer_editor_screen.dart';
import 'package:bldrs/views/widgets/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/buttons/bt_main.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/layouts/swiper_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/views/widgets/textings/the_golden_scroll.dart';
import 'package:bldrs/xxx_LABORATORY/animations/animations_screen.dart';
import 'package:bldrs/xxx_LABORATORY/ask/ask_screen.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/cam_play_ground.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/camera_awesome.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/camera_example.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/camera_page.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/google_map.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/x12_image_picker.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/x_camera_screen.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/x_preview_screen.dart';
import 'package:bldrs/xxx_LABORATORY/forms_and_inputs/popup.dart';
import 'package:bldrs/xxx_LABORATORY/forms_and_inputs/form.dart';
import 'package:bldrs/xxx_LABORATORY/ideas/circle_list.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/flyer_outer_mask_layer.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/text_field_test.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x03_font_test_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x08_earth_screen.dart';
import 'package:flutter/material.dart';
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
  Widget oButton (String title, String icon, Widget screen){
    return
      BTMain(
        buttonVerse: title,
        buttonColor: Colorz.BlackPlastic,
        buttonIcon: icon,
        buttonVerseShadow: true,
        splashColor: Colorz.Yellow,
        function: () => goToNewScreen(context, screen),
        stretched: false,
      );
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

          oButton('FlyerOuterMaskLayer', Iconz.Camera, FlyerOuterMaskLayer(flyerSizeFactor: 0.6,color: Colorz.WhiteGlass,)),

          oButton('Camera Awesome', Iconz.Camera, AwesomeCameraScreen()),

          oButton('CameraApp', Iconz.Camera, CameraApp()),

          oButton('CamPlayGround', Iconz.Camera, CamPlayGround()),

          oButton('17 - Camera by Max', Iconz.Camera, MaxCameraScreen()),  // (){widget.controller.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.ease);},

          oButton('18 - Camera Package', Iconz.Camera, CameraPage()),

          oButton('x Camera Screen', Iconz.Camera, CameraScreen()),

          oButton('x Camera Screen', Iconz.Camera, PreviewScreen()),

          oButton('Dash Board', Iconz.DashBoard, DashBoard()),

          oButton('Text field test', Iconz.Language, TextFieldTest()),

          oButton('1 - Add new flyer', Iconz.AddFlyer, FlyerEditorScreen()),

          oButton('2 - Biso Ask Screen', Iconz.UTPlanning, AskScreen()),

          // oButton('MultiGalleryPicker', Iconz.DvGouran, MultiGalleryPicker()),

          oButton('2 - Biso Ask Screen', Iconz.UTPlanning, AskScreen()),

          // oButton('7 - Flyer Screen', Iconz.Flyer, FlyerScreen()), // () => openFlyer(context, 'f034')

          oButton('8 - Flyer Sizes tests', Iconz.FlyerScale, FlyersSizesScreen()),

          oButton('9 - Single Collection Screen', Iconz.FlyerScale, SingleCollectionScreen()),

          oButton('10 - Font lab', Iconz.Language, FontTestScreen()),

          oButton('12 - Swiper Layout', Iconz.Gallery, SwiperLayout()),

          oButton('13 - FlyersPageView', Iconz.Statistics, FlyersPageView()),

          oButton('14 - FlyersGridView', Iconz.FlyerGrid, FlyersGridView()),

          // oButton('21 - Soundz', Iconz.News, SoundzScreen()),

          oButton('22 - PopUp', Iconz.News, PopUpTestScreen()),

          oButton('23 - Form', Iconz.Terms, TestFormScreen()),

          oButton('25 - ShareAndAddImageTest', Iconz.Share, ShareAndAddImageTest()),

          oButton('26 - City Dots', Iconz.Earth, EarthScreen()),

          oButton('27 - Google Maps - Custom non resizable fucking pin', Iconz.ComMap, GoogleMapScreen()),

          // oButton('28 - Google Maps - Defined size Pin', Iconz.ComMap, GoogleMapScreen2()),

          // oButton('29 - Google Maps - Image Pin', Iconz.ComMap, GoogleMapScreen3()),

          // oButton('30 - Google Maps - text box canvas', Iconz.ComMap, GoogleMapScreen4()),

          // oButton('31 - Google Maps - testSpace', Iconz.ComMap, GoogleMapScreen5()),

          oButton('34 - Old CheckBox thing', Iconz.Check, CheckBoxLessonScreen()),

          oButton('36 - Animations Screen', Iconz.DvDonaldDuck, AnimationsScreen()),

          oButton('36 - Circle list widget', Iconz.Clock, CircleListWidget()),

          oButton('36 - SyncFusionMap', Iconz.Earth, CityPicker()),

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
