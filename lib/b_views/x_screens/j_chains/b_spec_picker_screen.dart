import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/bb_chain_instructions.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/e_flyer_maker/c_specs_picker_controllers.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

class SpecPickerScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecPickerScreen({
    @required this.specPicker,
    @required this.showInstructions,
    @required this.isMultipleSelectionMode,
    @required this.onlyUseCityChains,
    @required this.originalSpecs,
    this.selectedSpecs,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PickerModel specPicker;
  final ValueNotifier<List<SpecModel>> selectedSpecs;
  final bool showInstructions;
  final bool isMultipleSelectionMode;
  final bool onlyUseCityChains;
  final List<SpecModel> originalSpecs;
  /// --------------------------------------------------------------------------
  static const double instructionBoxHeight = 60;
  /// --------------------------------------------------------------------------

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    final String _pageTitle = xPhrase(context, specPicker.chainID);

    return MainLayout(
      key: const ValueKey<String>('SpecPickerScreen'),
      appBarType: AppBarType.basic,
      // appBarBackButton: true,
      skyType: SkyType.black,
      sectionButtonIsOn: false,
      pageTitle: _pageTitle,
      pyramidsAreOn: true,
      onBack: () async {

        const bool _canContinue = true;

        // final bool _specsChanged = SpecModel.checkSpecsListsAreIdentical(
        //     originalSpecs,
        //     selectedSpecs.value
        // ) == false;
        //
        // if (_specsChanged == true){
        //   _canContinue = await CenterDialog.showCenterDialog(
        //     context: context,
        //     title: 'Discard Changes',
        //     body: 'This will ignore All Changes in Selected Specifications',
        //     confirmButtonText: 'Discard',
        //     boolDialog: true,
        //   );
        // }

        if (_canContinue == true){
          Nav.goBack(
              context: context,
              invoker: 'SpecPickerScreen.goBack',
          );
        }

      },
      confirmButtonModel: isMultipleSelectionMode == false ? null : ConfirmButtonModel(
        firstLine: 'Confirm $_pageTitle',
        onTap: () => onGoBackFromSpecPickerScreen(
          context: context,
          isMultipleSelectionMode: isMultipleSelectionMode,
          selectedSpecs: selectedSpecs,
          phid: null,
        ),
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
