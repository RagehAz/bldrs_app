import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/a_dashboard_home/b_dashboard_home_screen/dash_button/dash_button.dart';
import 'package:bldrs/x_dashboard/a_dashboard_home/b_dashboard_home_screen/dash_button/dash_button_model.dart';
import 'package:bldrs/x_dashboard/backend_lab/location_test/locations_test_screen.dart';
import 'package:flutter/material.dart';

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
