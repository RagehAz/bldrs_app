import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/b_pickers_screen/bb_pickers_screen_view.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/i_chains/b_pickers_screen/x_pickers_screen_controllers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

class PickerScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PickerScreen({
    @required this.picker,
    @required this.showInstructions,
    @required this.isMultipleSelectionMode,
    @required this.onlyUseCityChains,
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
  final ZoneModel zone;
  /// --------------------------------------------------------------------------
  static const double instructionBoxHeight = 60;
  /// --------------------------------------------------------------------------
  @override
  State<PickerScreen> createState() => _PickerScreenState();
  /// --------------------------------------------------------------------------
}

class _PickerScreenState extends State<PickerScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<List<SpecModel>> _tempSpecs = ValueNotifier(<SpecModel>[]);
  // -----------------------------------------------------------------------------
  /*
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'TestingTemplate',);
    }
  }
   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    _tempSpecs.value = widget.selectedSpecs.value;
    super.initState();
  }
  // --------------------
  /*
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        /// FUCK

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
   */
  // --------------------
  @override
  void dispose() {
    _tempSpecs.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onGoBack() async {

    bool _canContinue = true;

    final bool _specsChanged = SpecModel.checkSpecsListsAreIdentical(
        widget.selectedSpecs.value,
        _tempSpecs.value,
    ) == false;

    if (_specsChanged == true){
      _canContinue = await Dialogs.discardChangesGoBackDialog(context);
    }

    if (_canContinue == true){
      await Nav.goBack(
        context: context,
        invoker: 'SpecPickerScreen.goBack',
      );
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    widget.picker?.blogPicker(methodName: 'PickerScreen');
    // --------------------
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    final String _chainID = widget.picker?.chainID;
    // --------------------
    return MainLayout(
      key: const ValueKey<String>('SpecPickerScreen'),
      appBarType: AppBarType.search,
      // appBarBackButton: true,
      skyType: SkyType.black,
      sectionButtonIsOn: false,
      pageTitleVerse: Verse(
        text: _chainID,
        translate: true,
      ),
      pyramidsAreOn: true,
      onBack: _onGoBack,
      confirmButtonModel: widget.isMultipleSelectionMode == false ? null : ConfirmButtonModel(
        firstLine: const Verse(
          text: 'phid_confirm_selections',
          translate: true,
        ),
        onTap: () => onGoBackFromPickerScreen(
          context: context,
          isMultipleSelectionMode: widget.isMultipleSelectionMode,
          specsToPassBack: _tempSpecs.value,
          phidToPassBack: null, /// onSelectPhidInPickerScreen() handles this
        ),
      ),
      layoutWidget: PickersScreenView(
          appBarType: AppBarType.search,
          picker: widget.picker,
          selectedSpecs: _tempSpecs,
          screenHeight: _screenHeight,
          showInstructions: widget.showInstructions,
          isMultipleSelectionMode: widget.isMultipleSelectionMode,
          onlyUseCityChains: widget.onlyUseCityChains,
          zone: widget.zone,
          onSelectPhid: (String phid) => onSelectPhidInPickerScreen(
            context: context,
            phid: phid,
            selectedSpecs: _tempSpecs,
            isMultipleSelectionMode: widget.isMultipleSelectionMode,
            picker: widget.picker,
          ),
          onAddSpecs: (List<SpecModel> specs) => onAddSpecs(
            specs: specs,
            picker: widget.picker,
            selectedSpecs: _tempSpecs,
          ),
          onKeyboardSubmitted: () => onGoBackFromPickerScreen(
            context: context,
            specsToPassBack: _tempSpecs.value,
            isMultipleSelectionMode: widget.isMultipleSelectionMode,
            phidToPassBack: null, /// onSelectPhidInPickerScreen() handles this
          )
      ),

    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
