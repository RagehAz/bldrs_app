part of chains;

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
      onSearchCancelled: () => Searching.onCancelSearch(
        controller: _searchController,
        foundResultNotifier: null,
        isSearching: null,
        mounted: mounted,
        closKeyboardFunction: Keyboard.closeKeyboard,
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
