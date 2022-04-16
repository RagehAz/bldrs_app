import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/x_screens/f_bz_editor/f_x_bz_editor_screen.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/specs_selector_screen/specs_lists_pickers_screen.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/notifications/test_screens/awesome_noti_test_screen.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/new_asks.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/golden_scrolls_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/location_test_screen/locations_test_screen.dart';
import 'package:bldrs/x_dashboard/b_widgets/dash_button/dash_button.dart';
import 'package:bldrs/x_dashboard/b_widgets/dash_button/dash_button_model.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/cloud_functions_test.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/providers_test.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/slider_test.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/video_player.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/sembast_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart' as FlyerTypeClass;


class SpecializedLabs extends StatelessWidget {

  const SpecializedLabs({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);

    final List<DashButtonModel> _buttons = <DashButtonModel>[

      /// SEMBAST TESTER
      DashButtonModel(
        verse: 'Providers Test',
        icon: Iconz.check,
        screen: const ProvidersTestScreen(),
      ),

      /// SEMBAST TESTER
      DashButtonModel(
          verse: 'SEMBAST',
          icon: Iconz.terms,
          screen: const SembastReaderTestScreen(),
      ),

      /// ASKS
      DashButtonModel(
        verse: 'New ASKs',
        icon: Iconz.utPlanning,
        screen: const NewAsks(),
      ),

      /// BUSINESS EDITOR
      DashButtonModel(
        verse: 'BzEditor',
        icon: Iconz.bz,
        screen: BzEditorScreen(
          userModel: UserModel.dummyUserModel(context),
          // bzModel: null,
          firstTimer: true,
        ),
      ),

      /// VIDEO EDITOR
      DashButtonModel(
        verse: 'Video Player',
        icon: Iconz.play,
        screen: const VideoPlayerScreen(),
      ),

      /// SPECS SELECTOR
      DashButtonModel(
        verse: 'Specs Selector',
        icon: Iconz.keyword,
        screen: const SpecsListsPickersScreen(
          flyerType: FlyerTypeClass.FlyerType.design,
          selectedSpecs: <SpecModel>[],
        ),
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
        screen: null,//const FCMTestScreen(),
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

    ];

    return Container(
      width: _screenWidth,
      height: 120,
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
