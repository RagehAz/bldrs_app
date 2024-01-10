import 'package:basics/animators/helpers/sliders.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/b_views/i_chains/a_pickers_screen/xx_pickers_search_controller.dart';
import 'package:bldrs/b_views/i_phid_picker/phids_builder_page.dart';
import 'package:bldrs/b_views/i_phid_picker/views/a_single_chain_selector_view.dart';
import 'package:bldrs/b_views/i_phid_picker/views/b_multi_chain_selector_view.dart';
import 'package:bldrs/b_views/i_phid_picker/views/c_no_chains_found_view.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/phids_bubble/phids_bubble.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:flutter/material.dart';

class PhidsPickerScreen extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const PhidsPickerScreen({
    required this.chainsIDs,
    required this.onlyUseZoneChains,
    this.selectedPhids,
    this.multipleSelectionMode = false,
    this.flyerModel,
    super.key
  });
  // -----------------------------------------------------------------------------
  final List<String>? selectedPhids;
  /// RETURNS <String>[] if is multiple selection mode, and returns String if not
  final bool multipleSelectionMode;
  /// SHOWS flyer in the corner widget maximizer showing selected keywords,
  final FlyerModel? flyerModel;

  final List<String> chainsIDs;
  final bool onlyUseZoneChains;

  // -----------------------------------------------------------------------------
  @override
  _TheStatefulScreenState createState() => _TheStatefulScreenState();
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> goPickPhid({
    required FlyerType? flyerType,
    required ViewingEvent? event,
    required bool onlyUseZoneChains,
    required bool slideScreenFromEnLeftToRight,
    List<String>? selectedPhids,
  }) async {

    final String? phid = await BldrsNav.goToNewScreen(
      // pageTransitionType: Nav.superHorizontalTransition(
      //   appIsLTR: UiProvider.checkAppIsLeftToRight(),
      //   enAnimatesLTR: !slideScreenFromEnLeftToRight,
      // ),
      screen: PhidsPickerScreen(
        chainsIDs: FlyerTyper.getChainsIDsPerViewingEvent(
          flyerType: flyerType,
          event: ViewingEvent.homeView,
        ),
        onlyUseZoneChains: onlyUseZoneChains,
        selectedPhids: selectedPhids,
        // flyerModel: ,
        // multipleSelectionMode: false,
      ),
    );

    return phid;
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> goPickPhids({
    required FlyerType? flyerType,
    required ViewingEvent event,
    required bool onlyUseZoneChains,
    required bool slideScreenFromEnLeftToRight,
    List<String>? selectedPhids,
  }) async {

    final List<String>? phids = await BldrsNav.goToNewScreen(
      // pageTransitionType: Nav.superHorizontalTransition(
      //   appIsLTR: UiProvider.checkAppIsLeftToRight(),
      //   enAnimatesLTR: slideScreenFromEnLeftToRight,
      // ),
      screen: PhidsPickerScreen(
        chainsIDs: FlyerTyper.getChainsIDsPerViewingEvent(
          flyerType: flyerType,
          event: ViewingEvent.homeView,
        ),
        onlyUseZoneChains: onlyUseZoneChains,
        selectedPhids: selectedPhids ?? [],
        // flyerModel: ,
        multipleSelectionMode: true,
      ),
    );

    return phids ?? [];
  }
  // -----------------------------------------------------------------------------
}

class _TheStatefulScreenState extends State<PhidsPickerScreen> with SingleTickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  TabController? _tabBarController;
  final TextEditingController _searchController = TextEditingController();
  // --------------------
  List<Chain> _chains = [];
  List<NavModel> _navModels = [];
  final ValueNotifier<List<String>> _selectedPhidsNotifier = ValueNotifier<List<String>>([]);
  final ScrollController _selectedPhidsScrollController = ScrollController();
  // --------------------
  final ValueNotifier<List<Chain>> _foundChains = ValueNotifier([]);
  final ValueNotifier<bool> _isSearching = ValueNotifier(false);
  final ValueNotifier<String> _searchText = ValueNotifier('');
  List<String> _allPhids = [];
  // -----------------------------------------------------------------------------
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
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {

        await _initializeChains();

        if (Lister.superLength(_chains) > 1){
          await Future.delayed(const Duration(milliseconds: 500));
          UiProvider.proSetPyramidsAreExpanded(setTo: true, notify: true);
        }

        setState(() {});

        await _triggerLoading(setTo: false);
      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _tabBarController?.dispose();
    _searchController.dispose();
    _selectedPhidsNotifier.dispose();
    _selectedPhidsScrollController.dispose();
    _foundChains.dispose();
    _isSearching.dispose();
    _searchText.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _initializeChains() async {

    /// ERADICATE_CHAINS
    final List<Chain>? _allChains = ChainsProvider.proGetBldrsChains(
      context: context,
      onlyUseZoneChains: widget.onlyUseZoneChains,
      listen: false,
    );

    // final List<Chain> _allChains = await KeywordsProtocols.fetchChainedKeywords();

    final List<Chain> _chainsByIDs = Chain.getChainsFromChainsByIDs(
      allChains: _allChains,
      phids: widget.chainsIDs,
    );

    if (Lister.checkCanLoop(_chainsByIDs) == true){

      if (
          _chainsByIDs.length == 1
          &&
          Chain.checkIsChains(_chainsByIDs.first.sons) == true
      ){
        _chains = _chainsByIDs.first.sons;
      }

      else {
        _chains = _chainsByIDs;
      }

    }
    else {
      _chains = [];
    }

    _allPhids = Chain.getOnlyPhidsSonsFromChains(
      chains: _chains,
    );

    _tabBarController = TabController(
      vsync: this,
      animationDuration: const Duration(milliseconds: 300),
      length: _chains.isEmpty ? 1 : _chains.length,
      // initialIndex: 0,
    );

    setNotifier(
      notifier: _selectedPhidsNotifier,
      mounted: mounted,
      value: widget.selectedPhids ?? <String>[],
    );

    _generateNavModels();

  }
  // -----------------------------------------------------------------------------

  /// NAV MODELS

  // --------------------
  /// TESTED : WORKS PERFECT
  void _generateNavModels(){

    final List<NavModel> _output = [];

    if (Lister.checkCanLoop(_chains) == true){

      for (final Chain _chain in _chains){

      final NavModel _navModel = NavModel(
        id: _chain.id,
        titleVerse: Verse(id: _chain.id, translate: true),
        icon: ChainsProvider.proGetPhidIcon(son: _chain.id),
        iconSizeFactor: 1,
        screen: PhidsBuilderPage(
          chain: _chain,
          searchText: _searchText,
          selectedPhidsNotifier: _selectedPhidsNotifier,
          onPhidTap: (String? path, String? phid) => _onPhidTap(
            path: path,
            phid: phid,
            autoScroll: true,
          ),
        ),
      );

      _output.add(_navModel);

    }

    }



    setState(() {
      _navModels = _output;
    });

  }
  // -----------------------------------------------------------------------------

  /// SEARCH

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSearchSubmit(String? text) async {

    await onChainsSearchChanged(
      context: context,
      text: text,
      chains: _chains,
      foundChains: _foundChains,
      isSearching: _isSearching,
      phidsOfAllPickers: _allPhids,
      searchText: _searchText,
      mounted: mounted,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSearchCancelled() async {
    setNotifier(notifier: _foundChains, mounted: mounted, value: <Chain>[]);
    setNotifier(notifier: _isSearching, mounted: mounted, value: false);
    setNotifier(notifier: _searchText, mounted: mounted, value: '');
    _searchController.text = '';
  }
  // -----------------------------------------------------------------------------

  /// SELECTION

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onPhidTap({
    required String? path,
    required String? phid,
    required bool autoScroll,
  }) async {

    /// MULTIPLE SELECTION MODE
    if (widget.multipleSelectionMode == true){
      await _multipleSelectionModeTap(
        phid: phid,
        path: path,
        autoScroll: autoScroll,
      );
    }

    /// SINGLE SELECTION MODE
    else {
      await _singleSelectionModeTap(
        phid: phid,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _singleSelectionModeTap({
    required String? phid,
  }) async {

    await Nav.goBack(
      context: context,
      passedData: phid,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _multipleSelectionModeTap({
    required String? path,
    required String? phid,
    required bool autoScroll,
  }) async {

    final List<String> _selectedPhids = Stringer.addOrRemoveStringToStrings(
      strings: _selectedPhidsNotifier.value,
      string: phid,
    );

    final int _oldLength = _selectedPhidsNotifier.value.length;
    final int _newLength = _selectedPhids.length;
    final int _selectedPhidIndex = phid == null ? -1 : _selectedPhidsNotifier.value.indexOf(phid);

    setNotifier(
        notifier: _selectedPhidsNotifier,
        mounted: mounted,
        value: _selectedPhids
    );

    if (autoScroll == true){
      await _onScrollSelectedPhids(
        newLength: _newLength,
        oldLength: _oldLength,
        selectedPhidIndex: _selectedPhidIndex,
      );
    }

  }
  // --------------------
  /// TESTED : FAIR ENOUGH
  Future<void> _onScrollSelectedPhids({
    required int oldLength,
    required int newLength,
    required int selectedPhidIndex,
  }) async {

    if (_isSearching.value  == false){

      final bool _shouldGoToEnd = newLength > oldLength;

      if (_shouldGoToEnd == true && _selectedPhidsScrollController.hasClients == true){
        await Sliders.slideToOffset(
          scrollController: _selectedPhidsScrollController,
          offset: _selectedPhidsScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
        );
      }

      else {

        final double _lineHeight = PhidsBubble.getLineHeightWithItsPadding();
        /// a line usually takes 2 words
        final int _expectedLine = (selectedPhidIndex / 2).ceil() - 1;
        final double _expectedOffset = _lineHeight * _expectedLine;

        await Sliders.slideToOffset(
          scrollController: _selectedPhidsScrollController,
          offset: _expectedOffset,
          duration: const Duration(milliseconds: 200),
        );

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// Navigation

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onConfirmSelections() async {

    /// MULTIPLE SELECTION MODE
    if (widget.multipleSelectionMode == true){
      await Nav.goBack(
        context: context,
        passedData: _selectedPhidsNotifier.value,
      );
    }

    /// SINGLE SELECTION MODE
    else {
      await Nav.goBack(
        context: context,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onCancelSelections() async {
    bool _canGoBack = true;

    if (widget.multipleSelectionMode == true){
      final bool _selectionsHaveChanged = !Lister.checkListsAreIdentical(
          list1: widget.selectedPhids,
          list2: _selectedPhidsNotifier.value,
      );

      if (_selectionsHaveChanged == true){
        _canGoBack = await Dialogs.discardChangesGoBackDialog();
      }
    }

    if (_canGoBack == true){
      await Nav.goBack(context: context);
    }
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Lister.checkCanLoop(_chains) == false){
      return const NoChainsFoundView();
    }

    /// MULTIPLE CHAINS
    else if (Lister.superLength(_chains) > 1){
      return MultiChainSelectorView(
        navModels: _navModels,
        searchController: _searchController,
        onSearchSubmit: _onSearchSubmit,
        onSearchCancelled: _onSearchCancelled,
        onSearchChanged: _onSearchSubmit,
        isSearching: _isSearching,
        foundChains: _foundChains,
        onBack: _onConfirmSelections,
        searchText: _searchText,
        selectedPhidsNotifier: _selectedPhidsNotifier,
        onPagePhidTap: (String? path, String? phid) => _onPhidTap(
          path: path,
          phid: phid,
          autoScroll: true,
        ),
        onPanelPhidTap: (String? path, String? phid) => _onPhidTap(
          path: path,
          phid: phid,
          autoScroll: false,
        ),
        selectedPhidsScrollController: _selectedPhidsScrollController,
        multipleSelectionMode: widget.multipleSelectionMode,
        flyerModel: widget.flyerModel,
      );
    }

    /// SINGLE CHAIN
    else {
      return SingleChainSelectorView(
        chain: Lister.checkCanLoop(_chains) == true ? _chains.first : null,
        searchController: _searchController,
        onSearchSubmit: _onSearchSubmit,
        onSearchCancelled: _onSearchCancelled,
        onSearchChanged: _onSearchSubmit,
        isSearching: _isSearching,
        foundChains: _foundChains,
        searchText: _searchText,
        selectedPhidsNotifier: _selectedPhidsNotifier,
        onPagePhidTap: (String? path, String? phid) => _onPhidTap(
          path: path,
          phid: phid,
          autoScroll: true,
        ),
        onConfirmSelections: _onConfirmSelections,
        onCancelSelections: _onCancelSelections,
        selectedPhids: widget.selectedPhids,
        multipleSelectionMode: widget.multipleSelectionMode,
      );
    }

  }
  // -----------------------------------------------------------------------------
}
