import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/a_dashboard_home/b_dashboard_home_screen/dash_button/dash_button.dart';
import 'package:bldrs/x_dashboard/a_dashboard_home/b_dashboard_home_screen/dash_button/dash_button_model.dart';
import 'package:bldrs/x_dashboard/zzzzz_test_lab/specialized_labs/fire_base_lab/cloud_functions_test.dart';
import 'package:bldrs/x_dashboard/zzzzz_test_lab/specialized_labs/fire_base_lab/pagination_test_screen.dart';
import 'package:bldrs/x_dashboard/zzzzz_test_lab/specialized_labs/fire_base_lab/streaming_test.dart';
import 'package:bldrs/x_dashboard/zzzzz_test_lab/specialized_labs/fire_base_lab/real_http_test_screen.dart';
import 'package:bldrs/x_dashboard/zzzzz_test_lab/specialized_labs/fire_base_lab/real_test_screen.dart';
import 'package:bldrs/x_dashboard/zzzzz_test_lab/specialized_labs/fire_base_lab/dynamic_links_test_screen.dart';
import 'package:bldrs/x_dashboard/zzzzz_test_lab/specialized_labs/email_test_screen.dart';
import 'package:bldrs/x_dashboard/zzzzz_test_lab/specialized_labs/location_test_screen/locations_test_screen.dart';
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

      /// EMAIL SENDER
      DashButtonModel(
        verse:  'email Test Screen',
        icon: Iconz.comEmail,
        screen: EmailTestScreen(),
      ),

      /// DYNAMIC LINKS TEST
      DashButtonModel(
        verse:  'Dynamic Links',
        icon: Iconz.reload,
        screen: DynamicLinksTestScreen(),
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

      /// CLOUD FUNCTIONS
      DashButtonModel(
        verse:  'Cloud Functions',
        icon: Iconz.gears,
        screen: CloudFunctionsTest(),
      ),

      /// LOCATION TEST SCREEN
      DashButtonModel(
        verse:  'Locations Test screen',
        icon: Iconz.locationPin,
        screen: LocationsTestScreen(),
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
