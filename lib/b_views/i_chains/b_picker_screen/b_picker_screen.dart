import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/c_chain/dd_data_creation.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/b_views/i_chains/a_pickers_screen/x_pickers_screen_controllers.dart';
import 'package:bldrs/b_views/i_chains/b_picker_screen/bb_picker_screen_browse_view.dart';
import 'package:bldrs/b_views/i_chains/b_picker_screen/x_picker_screen_controllers.dart';
import 'package:bldrs/b_views/z_components/buttons/editors_buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:flutter/material.dart';

class PickerScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PickerScreen({
    required this.picker,
    required this.showInstructions,
    required this.isMultipleSelectionMode,
    required this.onlyUseZoneChains,
    required this.zone,
    this.selectedSpecs,
    super.key
  });
  /// --------------------------------------------------------------------------
  final PickerModel? picker;
  final ValueNotifier<List<SpecModel>>? selectedSpecs;
  final bool showInstructions;
  final bool isMultipleSelectionMode;
  final bool onlyUseZoneChains;
  final ZoneModel? zone;
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
  final TextEditingController _searchController = TextEditingController();
  // -----------------------------------------------------------------------------
  /*
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {

    setNotifier(
        notifier: _tempSpecs,
        mounted: mounted,
        value: widget.selectedSpecs?.value,
    );

    super.initState();
  }
  // --------------------
  /*
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      _triggerLoading().then((_) async {

        /// FUCK

        await _triggerLoading();
      });

    }
    super.didChangeDependencies();
  }
   */
  // --------------------
  @override
  void dispose() {
    // _loading.dispose();
    _tempSpecs.dispose();
    _searchController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onGoBack() async {

    bool _canContinue = true;

    final bool _specsChanged = SpecModel.checkSpecsListsAreIdentical(
        widget.selectedSpecs?.value,
        _tempSpecs.value,
    ) == false;

    if (_specsChanged == true){
      _canContinue = await Dialogs.discardChangesGoBackDialog();
    }

    if (_canContinue == true){
      await Nav.goBack(
        context: context,
        invoker: 'PickerScreen.goBack',
      );
    }

  }
  // -----------------------------------------------------------------------------
  AppBarType _getAppBarType(){

    final Chain? _valueChain = ChainsProvider.proFindChainByID(
      chainID: widget.picker?.chainID,
      onlyUseZoneChains: widget.onlyUseZoneChains,
      // includeChainSInSearch: true,
    );

    final bool _isDataCreator = DataCreation.checkIsDataCreator(_valueChain?.sons);

    if (_isDataCreator == true){
      return AppBarType.basic;
    }
    else {
      return AppBarType.search;
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // widget.picker?.blogPicker(invoker: 'PickerScreen');
    final double _screenHeight = Scale.screenHeight(context);
    final String? _chainID = widget.picker?.chainID;
    final AppBarType _appBarType = _getAppBarType();
    // --------------------
    return MainLayout(
      canSwipeBack: true,
      key: const ValueKey<String>('PickerScreen'),
      appBarType: _appBarType,
      searchController: _searchController,
      onSearchChanged: (String? text){blog('PickerScreen : onSearchChanged : $text');},
      onSearchSubmit: (String? text){blog('PickerScreen : onSearchSubmit : $text');},
      onSearchCancelled: () => MainLayout.onCancelSearch(
        controller: _searchController,
        foundResultNotifier: null,
        isSearching: null,
        mounted: mounted,
      ),
      searchHintVerse: const Verse(id: 'phid_search_keywords', translate: true),
      // appBarBackButton: true,
      skyType: SkyType.grey,
      title: Verse(
        id: _chainID,
        translate: true,
      ),
      pyramidsAreOn: true,
      onBack: _onGoBack,
      confirmButton: widget.isMultipleSelectionMode == false ?
      null
          :
      ConfirmButton.button(
        // onSkipTap: ,
        // enAlignment: ,
        // isDisabled: ,
        firstLine: const Verse(
          id: 'phid_confirm_selections',
          translate: true,
        ),
        onTap: () => onGoBackFromPickerScreen(
          context: context,
          isMultipleSelectionMode: widget.isMultipleSelectionMode,
          specsToPassBack: _tempSpecs.value,
          phidToPassBack: null, /// onSelectPhidInPickerScreen() handles this
        ),
      ),
      child: PickerScreenBrowseView(
          appBarType: _appBarType,
          picker: widget.picker,
          selectedSpecs: _tempSpecs,
          screenHeight: _screenHeight,
          showInstructions: widget.showInstructions,
          isMultipleSelectionMode: widget.isMultipleSelectionMode,
          onlyUseZoneChains: widget.onlyUseZoneChains,
          zone: widget.zone,
          onKeyboardSubmitted: (String? text) => onGoBackFromPickerScreen(
            context: context,
            specsToPassBack: _tempSpecs.value,
            isMultipleSelectionMode: widget.isMultipleSelectionMode,
            phidToPassBack: null, /// onSelectPhidInPickerScreen() handles this
          ),
          onExportSpecs: (List<SpecModel> specs) => onAddSpecs(
            specs: specs,
            picker: widget.picker,
            selectedSpecs: _tempSpecs,
            mounted: mounted,
          ),
          onPhidTap: (String? path, String? phid) => onSelectPhidInPickerScreen(
            context: context,
            mounted: mounted,
            phid: phid,
            selectedSpecsNotifier: _tempSpecs,
            isMultipleSelectionMode: widget.isMultipleSelectionMode,
            picker: widget.picker,
          ),
        searchText: _searchController,

      ),

    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
