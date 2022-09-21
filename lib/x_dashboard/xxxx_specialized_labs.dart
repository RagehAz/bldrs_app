import 'package:bldrs/b_views/i_chains/c_currencies_screen/c_currencies_screen.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/a_dashboard_home/b_dashboard_home_screen/dash_button/dash_button.dart';
import 'package:bldrs/x_dashboard/a_dashboard_home/b_dashboard_home_screen/dash_button/dash_button_model.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/images_test_screen.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/animations_lab/animations_lab.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/animations_lab/super_rage7.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/back_end_lab/cloud_functions_test.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/back_end_lab/pagination_and_streaming/pagination_test_screen.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/back_end_lab/pagination_and_streaming/streaming_test.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/back_end_lab/real_shit/real_http_test_screen.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/back_end_lab/real_shit/real_test_screen.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/back_end_lab/sembast_test_screen.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/dynamic_links_test_screen.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/email_test_screen.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/go_back_widget_test.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/golden_scrolls_screen.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/keyboard_field_widget_test.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/location_test_screen/locations_test_screen.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/notifications_test/awesome_noti_test_screen.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/notifications_test/fcm_tet_screen.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/redorder_list_test.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/slider_test.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/sounds_test_screen.dart';
import 'package:bldrs/x_dashboard/a_dashboard_home/a_lock_screen/lock_test_screen.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/tiny_flyer_test_screen.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/video_player.dart';
import 'package:bldrs/x_dashboard/x_modules/a_test_labs/specialized_labs/zoning_workspace.dart';
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

    const List<DashButtonModel> _buttons = <DashButtonModel>[

      /// RE-ORDER LIST
      DashButtonModel(
        verse:  'TinyFlyer test',
        icon: Iconz.flyerScale,
        screen: TinyFlyerTest(),
      ),

      /// RE-ORDER LIST
      DashButtonModel(
        verse:  'Re-order-list',
        icon: Iconz.statistics,
        screen: ReOrderListTest(),
      ),

      /// EMAIL SENDER
      DashButtonModel(
        verse:  'New Currency screen',
        icon: Iconz.dollar,
        screen: CurrenciesScreen(),
      ),

      /// EMAIL SENDER
      DashButtonModel(
        verse:  'email Test Screen',
        icon: Iconz.comEmail,
        screen: EmailTestScreen(),
      ),

      /// IMAGES TEST SCREEN
      DashButtonModel(
        verse:  'images Test Screen',
        icon: Iconz.camera,
        screen: ImagesTestScreen(),
      ),

      /// DYNAMIC LINKS TEST
      DashButtonModel(
        verse:  'Dynamic Links',
        icon: Iconz.reload,
        screen: DynamicLinksTestScreen(),
      ),

      /// THE GO BACK WIDGET
      DashButtonModel(
        verse:  'ZONING WORK SPACE',
        icon: Iconz.earth,
        screen: ZoningWorkSpace(),
      ),

      /// THE GO BACK WIDGET
      DashButtonModel(
        verse:  'KEYBOARD FIELD TEST',
        icon: Iconz.language,
        screen: KeyboardFieldWidgetTest(),
      ),

      /// THE GO BACK WIDGET
      DashButtonModel(
        verse:  'THE GO BACK WIDGET TEST',
        icon: Iconz.back,
        screen: GoBackWidgetTest(),
      ),

      /// REAL TEST
      DashButtonModel(
        verse:  'REAL TEST',
        icon: Iconz.clock,
        screen: RealTestScreen(),
      ),

      /// REAL HTTP TEST
      DashButtonModel(
        verse:  'REAL HTTP TEST',
        icon: Iconz.clock,
        screen: RealHttpTestScreen(),
      ),

      /// STREAMING
      DashButtonModel(
        verse:  'STREAMING TEST',
        icon: Iconz.statistics,
        screen: StreamingTest(),
        transitionType: PageTransitionType.leftToRightWithFade,
      ),

      /// PAGINATOR
      DashButtonModel(
        verse:  'PAGINATOR TEST',
        icon: Iconz.statistics,
        screen: PaginatorTest(),
        transitionType: PageTransitionType.leftToRightWithFade,
      ),

      /// SOUNDS TEST
      DashButtonModel(
        verse:  'Sounds Test',
        icon: Iconz.play,
        screen: SoundsTestScreen(),
      ),

      /// LOCK - SPINNER
      DashButtonModel(
        verse:  'Lock Test',
        icon: Iconz.password,
        screen: LockScreen(),
      ),

      /// SEMBAST TESTER
      DashButtonModel(
        verse:  'SEMBAST',
        icon: Iconz.terms,
        screen: SembastReaderTestScreen(),
      ),

      /// VIDEO EDITOR
      DashButtonModel(
        verse:  'Video Player',
        icon: Iconz.play,
        screen: VideoPlayerScreen(),
      ),

      /// ANIMATIONS LAB
      DashButtonModel(
        verse:  'Animations lab',
        icon: Iconz.dvDonaldDuck,
        screen: AnimationsLab(),
      ),

      /// SUPER RAGE7
      DashButtonModel(
        verse:  'Super Rage7',
        icon: Iconz.dvRageh2,
        screen: SuperRage7Screen(),
      ),

      /// CLOUD FUNCTIONS
      DashButtonModel(
        verse:  'Cloud Functions',
        icon: Iconz.gears,
        screen: CloudFunctionsTest(),
      ),

      /// FCM TEST SCREEN
      DashButtonModel(
        verse:  'FCM test screen',
        icon: Iconz.news,
        screen: FCMTestScreen(),
      ),

      /// AWESOME NOTIFICATION TEST
      DashButtonModel(
        verse:  'Awesome Notification test',
        icon: Iconz.news,
        screen: AwesomeNotiTestScreen(),
      ),

      /// LOCATION TEST SCREEN
      DashButtonModel(
        verse:  'Locations Test screen',
        icon: Iconz.dumPinPNG,
        screen: LocationsTestScreen(),
      ),

      /// SLIDER TEST SCREEN
      DashButtonModel(
        verse:  'Slider Test Screen',
        icon: Iconz.dashBoard,
        screen: SliderTestScreen(),
      ),

      /// GOLDEN SCROLLS
      DashButtonModel(
        verse:  'Golden Scrolls',
        icon: Iconz.cleopatra,
        screen: GoldenScrollsScreen(),
      ),

      /// SOUND TEST
      DashButtonModel(
        verse:  'SOUND TEST',
        icon: Iconz.dvRageh,
        screen: null,
      ),

    ];

    return _buttons;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    // final double _screenHeight = Scale.superScreenHeight(context);
    final List<DashButtonModel> _buttons = _generateButtonsModels(context);
    // --------------------
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
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
