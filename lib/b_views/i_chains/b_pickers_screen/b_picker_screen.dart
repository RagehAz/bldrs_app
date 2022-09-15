import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/b_pickers_screen/bb_pickers_screen_view.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/i_chains/b_pickers_screen/x_pickers_screen_controllers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

class PickerScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickerScreen({
    @required this.picker,
    @required this.showInstructions,
    @required this.isMultipleSelectionMode,
    @required this.onlyUseCityChains,
    @required this.originalSpecs,
    @required this.zone,
    this.selectedSpecs,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PickerModel picker;
  final ValueNotifier<List<SpecModel>> selectedSpecs;
  final bool showInstructions;
  final bool isMultipleSelectionMode;
  final bool onlyUseCityChains;
  final List<SpecModel> originalSpecs;
  final ZoneModel zone;
  /// --------------------------------------------------------------------------
  static const double instructionBoxHeight = 60;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    picker?.blogPicker(methodName: 'PickerScreen');

    // --------------------
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    final String _chainID = picker?.chainID;
    // --------------------
    return MainLayout(
      key: const ValueKey<String>('SpecPickerScreen'),
      appBarType: AppBarType.basic,
      // appBarBackButton: true,
      skyType: SkyType.black,
      sectionButtonIsOn: false,
      pageTitleVerse: Verse(
        text: _chainID,
        translate: true,
      ),
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
        firstLine: const Verse(
          text: 'phid_confirm_selections',
          translate: true,
        ),
        onTap: () => onGoBackFromPickerScreen(
          context: context,
          isMultipleSelectionMode: isMultipleSelectionMode,
          selectedSpecs: selectedSpecs,
          passPhidBack: null,
        ),
      ),
      layoutWidget: PickersScreenView(
          appBarType: AppBarType.basic,
          picker: picker,
          selectedSpecs: selectedSpecs,
          screenHeight: _screenHeight,
          showInstructions: showInstructions,
          isMultipleSelectionMode: isMultipleSelectionMode,
          onlyUseCityChains: onlyUseCityChains,
          zone: zone,
          onSelectPhid: (String phid) => onSelectPhid(
            context: context,
            phid: phid,
            selectedSpecs: selectedSpecs,
            isMultipleSelectionMode: isMultipleSelectionMode,
            picker: picker,
          ),
          onAddSpecs: (List<SpecModel> specs) => onAddSpecs(
            specs: specs,
            picker: picker,
            selectedSpecs: selectedSpecs,
          ),
          onKeyboardSubmitted: () => onGoBackFromPickerScreen(
            context: context,
            selectedSpecs: selectedSpecs,
            isMultipleSelectionMode: isMultipleSelectionMode,
            passPhidBack: null,
          )
      ),

    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
