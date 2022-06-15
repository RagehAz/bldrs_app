import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/y_views/i_flyer/flyer_maker/spec_picker_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/c_controllers/i_flyer_maker_controllers/specs_picker_controllers.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;

class SpecPickerScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecPickerScreen({
    @required this.specPicker,
    @required this.selectedSpecs,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final SpecPicker specPicker;
  final ValueNotifier<List<SpecModel>> selectedSpecs;
  /// --------------------------------------------------------------------------
  static const double instructionBoxHeight = 50;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    // final double _listZoneHeight =
    //           _screenHeight
    //         - Ratioz.stratosphere
    //         - SpecPickerScreen.instructionBoxHeight;
    // final String _instructions = _getInstructions();
    // blog('SpecPickerScreen : ${_specChain.id} : sons ${_specChain.sons} : sons type ${_specChain.sons.runtimeType}');

    return MainLayout(
      key: const ValueKey<String>('SpecPickerScreen'),
      appBarType: AppBarType.basic,
      // appBarBackButton: true,
      skyType: SkyType.black,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      pageTitle: superPhrase(context, specPicker.chainID),
      pyramidsAreOn: true,
      onBack: () => onGoBackToSpecsPickersScreen(
          context: context,
          selectedSpecs: selectedSpecs
      ),
      layoutWidget: SpecPickerScreenView(
        specPicker: specPicker,
        selectedSpecs: selectedSpecs,
        screenHeight: _screenHeight,
      ),

    );
  }
}
