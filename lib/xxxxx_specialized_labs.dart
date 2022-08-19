import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/images_test_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/animations_lab/animations_lab.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/animations_lab/super_rage7.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/back_end_lab/cloud_functions_test.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/back_end_lab/pagination_and_streaming/pagination_test_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/back_end_lab/pagination_and_streaming/streaming_test.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/back_end_lab/real_shit/real_http_test_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/back_end_lab/real_shit/real_test_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/back_end_lab/sembast_test_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/dynamic_links_test_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/email_test_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/go_back_widget_test.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/golden_scrolls_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/keyboard_field_widget_test.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/location_test_screen/locations_test_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/notifications_test/awesome_noti_test_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/notifications_test/fcm_tet_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/providers_test.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/slider_test.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/sounds_test_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/super_lock/lock_test_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/video_player.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/zoning_workspace.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/chains_viewer_test_screen.dart';
import 'package:bldrs/x_dashboard/b_widgets/dash_button/dash_button.dart';
import 'package:bldrs/x_dashboard/b_widgets/dash_button/dash_button_model.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SpecializedLabs extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecializedLabs({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  static const double height = 120;
// -----------------------------------------------------------------------------
  List<DashButtonModel> _generateButtonsModels(BuildContext context){

    final List<DashButtonModel> _buttons = <DashButtonModel>[

      /// EMAIL SENDER
      DashButtonModel(
        verse: 'email Test Screen',
        icon: Iconz.comEmail,
        screen: const EmailTestScreen(),
      ),

      /// IMAGES TEST SCREEN
      DashButtonModel(
        verse: 'images Test Screen',
        icon: Iconz.camera,
        screen: const ImagesTestScreen(),
      ),

      /// CHAINS TEST SCREEN
      DashButtonModel(
        verse: 'Chains View Test Screen',
        icon: Iconz.keyword,
        screen: const ChainsViewTestScreen(),
      ),

      /// DYNAMIC LINKS TEST
      DashButtonModel(
        verse: 'Dynamic Links',
        icon: Iconz.reload,
        screen: const DynamicLinksTestScreen(),
      ),

      /// THE GO BACK WIDGET
      DashButtonModel(
        verse: 'ZONING WORK SPACE',
        icon: Iconz.earth,
        screen: const ZoningWorkSpace(),
      ),

      /// THE GO BACK WIDGET
      DashButtonModel(
        verse: 'KEYBOARD FIELD TEST',
        icon: Iconz.language,
        screen: const KeyboardFieldWidgetTest(),
      ),

      /// THE GO BACK WIDGET
      DashButtonModel(
        verse: 'THE GO BACK WIDGET TEST',
        icon: Iconz.back,
        screen: const GoBackWidgetTest(),
      ),

      /// REAL TEST
      DashButtonModel(
        verse: 'REAL TEST',
        icon: Iconz.clock,
        screen: const RealTestScreen(),
      ),

      /// REAL HTTP TEST
      DashButtonModel(
        verse: 'REAL HTTP TEST',
        icon: Iconz.clock,
        screen: const RealHttpTestScreen(),
      ),

      /// PROVIDER TEST
      DashButtonModel(
        verse: 'Providers Test',
        icon: Iconz.check,
        screen: const ProvidersTestScreen(),
      ),

      /// STREAMING
      DashButtonModel(
        verse: 'STREAMING TEST',
        icon: Iconz.statistics,
        screen: const StreamingTest(),
        transitionType: PageTransitionType.leftToRightWithFade,
      ),

      /// PAGINATOR
      DashButtonModel(
        verse: 'PAGINATOR TEST',
        icon: Iconz.statistics,
        screen: const PaginatorTest(),
        transitionType: PageTransitionType.leftToRightWithFade,
      ),

      /// SOUNDS TEST
      DashButtonModel(
        verse: 'Sounds Test',
        icon: Iconz.play,
        screen: const SoundsTestScreen(),
      ),

      /// LOCK - SPINNER
      DashButtonModel(
        verse: 'Lock Test',
        icon: Iconz.password,
        screen: const LockTestScreen(),
      ),

      /// SEMBAST TESTER
      DashButtonModel(
        verse: 'SEMBAST',
        icon: Iconz.terms,
        screen: const SembastReaderTestScreen(),
      ),

      /// VIDEO EDITOR
      DashButtonModel(
        verse: 'Video Player',
        icon: Iconz.play,
        screen: const VideoPlayerScreen(),
      ),

      /// ANIMATIONS LAB
      DashButtonModel(
        verse: 'Animations lab',
        icon: Iconz.dvDonaldDuck,
        screen: const AnimationsLab(),
      ),

      /// SUPER RAGE7
      DashButtonModel(
        verse: 'Super Rage7',
        icon: Iconz.dvRageh2,
        screen: const SuperRage7Screen(),
      ),

      /// CLOUD FUNCTIONS
      DashButtonModel(
        verse: 'Cloud Functions',
        icon: Iconz.gears,
        screen: const CloudFunctionsTest(),
      ),

      /// FCM TEST SCREEN
      DashButtonModel(
        verse: 'FCM test screen',
        icon: Iconz.news,
        screen: const FCMTestScreen(),
      ),

      /// AWESOME NOTIFICATION TEST
      DashButtonModel(
        verse: 'Awesome Notification test',
        icon: Iconz.news,
        screen: const AwesomeNotiTestScreen(),
      ),

      /// LOCATION TEST SCREEN
      DashButtonModel(
        verse: 'Locations Test screen',
        icon: Iconz.dumPinPNG,
        screen: const LocationsTestScreen(),
      ),

      /// SLIDER TEST SCREEN
      DashButtonModel(
        verse: 'Slider Test Screen',
        icon: Iconz.dashBoard,
        screen: const SliderTestScreen(),
      ),

      /// GOLDEN SCROLLS
      DashButtonModel(
        verse: 'Golden Scrolls',
        icon: Iconz.cleopatra,
        screen: const GoldenScrollsScreen(),
      ),

      /// SOUND TEST
      DashButtonModel(
        verse: 'SOUND TEST',
        icon: Iconz.dvRageh,
        screen: null,
      ),

    ];

    return _buttons;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    // final double _screenHeight = Scale.superScreenHeight(context);
    final List<DashButtonModel> _buttons = _generateButtonsModels(context);

    return Container(
      width: _screenWidth,
      height: height,
      color: Colorz.bloodTest,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: _buttons.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index){

          final DashButtonModel _buttonModel = _buttons[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: DashButton(
                dashButtonModel: _buttonModel,
                size: 100,
              ),
            );

          }
      ),
    );
  }

}
