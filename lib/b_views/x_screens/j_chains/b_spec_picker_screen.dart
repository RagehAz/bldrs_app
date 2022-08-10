import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/bb_spec_picker_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/e_flyer_maker/c_specs_picker_controllers.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:flutter/material.dart';

class SpecPickerScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecPickerScreen({
    @required this.specPicker,
    @required this.showInstructions,
    @required this.isMultipleSelectionMode,
    @required this.onlyUseCityChains,
    this.selectedSpecs,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final SpecPicker specPicker;
  final ValueNotifier<List<SpecModel>> selectedSpecs;
  final bool showInstructions;
  final bool isMultipleSelectionMode;
  final bool onlyUseCityChains;
  /// --------------------------------------------------------------------------
  static const double instructionBoxHeight = 50;
  /// --------------------------------------------------------------------------

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
      onBack: () => onGoBackFromSpecPickerScreen(
        context: context,
        isMultipleSelectionMode: isMultipleSelectionMode,
        selectedSpecs: selectedSpecs,
        phid: null,
      ),
      layoutWidget: SpecPickerScreenView(
        specPicker: specPicker,
        selectedSpecs: selectedSpecs,
        screenHeight: _screenHeight,
        showInstructions: showInstructions,
        isMultipleSelectionMode: isMultipleSelectionMode,
        onlyUseCityChains: onlyUseCityChains,
        onSelectPhid: (String phid) => onSelectPhid(
          context: context,
          phid: phid,
          selectedSpecs: selectedSpecs,
          isMultipleSelectionMode: isMultipleSelectionMode,
          specPicker: specPicker,
        ),
      ),

    );
  }
}
