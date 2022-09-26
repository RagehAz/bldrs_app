import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/chain/dd_data_creation.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/a_pickers_screen/x_pickers_screen_controllers.dart';
import 'package:bldrs/b_views/i_chains/b_picker_screen/bb_picker_screen_browse_view.dart';
import 'package:bldrs/b_views/i_chains/b_picker_screen/x_picker_screen_controllers.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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
  final TextEditingController _searchController = TextEditingController();
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
    _searchController.dispose();
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
        invoker: 'PickerScreen.goBack',
      );
    }

  }
  // -----------------------------------------------------------------------------
  AppBarType _getAppBarType(){

    final Chain _valueChain = ChainsProvider.proFindChainByID(
      context: context,
      chainID: widget.picker?.chainID,
      onlyUseCityChains: widget.onlyUseCityChains,
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
    // --------------------
    widget.picker?.blogPicker(methodName: 'PickerScreen');
    // --------------------
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    final String _chainID = widget.picker?.chainID;
    final AppBarType _appBarType = _getAppBarType();
    // --------------------
    return MainLayout(
      key: const ValueKey<String>('PickerScreen'),
      appBarType: _appBarType,
      searchController: _searchController,
      onSearchChanged: (String text){blog('PickerScreen : onSearchChanged : $text');},
      onSearchSubmit: (String text){blog('PickerScreen : onSearchSubmit : $text');},
      onSearchCancelled: () => MainLayout.onCancelSearch(
        context: context,
        controller: _searchController,
        foundResultNotifier: null,
        isSearching: null,
      ),
      searchHintVerse: const Verse(text: 'phid_search_keywords', translate: true),
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
      layoutWidget: PickerScreenBrowseView(
          appBarType: _appBarType,
          picker: widget.picker,
          selectedSpecs: _tempSpecs,
          screenHeight: _screenHeight,
          showInstructions: widget.showInstructions,
          isMultipleSelectionMode: widget.isMultipleSelectionMode,
          onlyUseCityChains: widget.onlyUseCityChains,
          zone: widget.zone,
          onKeyboardSubmitted: (String text) => onGoBackFromPickerScreen(
            context: context,
            specsToPassBack: _tempSpecs.value,
            isMultipleSelectionMode: widget.isMultipleSelectionMode,
            phidToPassBack: null, /// onSelectPhidInPickerScreen() handles this
          ),
          onExportSpecs: (List<SpecModel> specs) => onAddSpecs(
            specs: specs,
            picker: widget.picker,
            selectedSpecs: _tempSpecs,
          ),
          onPhidTap: (String path, String phid) => onSelectPhidInPickerScreen(
            context: context,
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
