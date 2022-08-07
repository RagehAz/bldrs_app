import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/x_screens/g_bz/e_flyer_maker/dd_spec_picker_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/e_flyer_maker/c_specs_picker_controllers.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';

class SpecPickerScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecPickerScreen({
    @required this.specPicker,
    @required this.showInstructions,
    @required this.inSelectionMode,
    this.selectedSpecs,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final SpecPicker specPicker;
  final ValueNotifier<List<SpecModel>> selectedSpecs;
  final bool showInstructions;
  final bool inSelectionMode;
  /// --------------------------------------------------------------------------
  static const double instructionBoxHeight = 50;
  /// --------------------------------------------------------------------------
  void onGoBack({
    @required BuildContext context,
    String phid,
}) {

    if (inSelectionMode == true){
     onGoBackToSpecsPickersScreen(
          context: context,
          selectedSpecs: selectedSpecs
      );
    }

    else {
      Nav.goBack(context, passedData: phid);
    }

  }
// -----------------------------------------------------------------------------
  Future<void> _onSelectSpec({
    @required BuildContext context,
    @required String phid,
  }) async {

    if (inSelectionMode == true){
      await onSelectSpec(
        context: context,
        phid: phid,
        picker: specPicker,
        selectedSpecs: selectedSpecs,
      );
    }

    else {
      onGoBack(
        context: context,
        phid: phid,
      );
    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    return MainLayout(
      key: const ValueKey<String>('SpecPickerScreen'),
      appBarType: AppBarType.basic,
      // appBarBackButton: true,
      skyType: SkyType.black,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      pageTitle: superPhrase(context, specPicker.chainID),
      pyramidsAreOn: true,
      onBack: () => onGoBack(context: context),
      layoutWidget: SpecPickerScreenView(
        specPicker: specPicker,
        selectedSpecs: selectedSpecs,
        screenHeight: _screenHeight,
        showInstructions: showInstructions,
        inSelectionMode: inSelectionMode,
        onSelectSpec: (String phid) => _onSelectSpec(
          context: context,
          phid: phid,
        ),
      ),

    );
  }
}
