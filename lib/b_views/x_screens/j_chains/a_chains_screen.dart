import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/x_screens/j_chains/aa_chains_screen_search_view.dart';
import 'package:bldrs/b_views/x_screens/j_chains/ab_chains_screen_browse_view.dart';
import 'package:bldrs/b_views/x_screens/j_chains/controllers/a_chains_screen_controllers.dart';
import 'package:bldrs/b_views/x_screens/j_chains/controllers/b_chains_search_controller.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/e_flyer_maker/c_specs_picker_controllers.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChainsScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ChainsScreen({
    @required this.flyerTypeChainFilter,
    @required this.onlyUseCityChains,
    @required this.isMultipleSelectionMode,
    @required this.pageTitle,
    this.selectedSpecs,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<SpecModel> selectedSpecs;
  /// if given flyer type : will generate flyer type chain : if null will get all chains
  final FlyerType flyerTypeChainFilter;
  final bool onlyUseCityChains;
  final bool isMultipleSelectionMode;
  final String pageTitle;
  /// --------------------------------------------------------------------------
  @override
  State<ChainsScreen> createState() => _ChainsScreenState();
  /// --------------------------------------------------------------------------
}

class _ChainsScreenState extends State<ChainsScreen> {
// -----------------------------------------------------------------------------
  /// DATA
  Chain _initialChain;
  List<SpecPicker> _allSpecPickers = <SpecPicker>[];
  ValueNotifier<List<SpecPicker>> _refinedSpecsPickers; /// tamam disposed
  ValueNotifier<List<String>> _groupsIDs; /// tamam disposed
  /// SEARCHING
  final TextEditingController _searchTextController = TextEditingController();
  final ValueNotifier<String> _searchText = ValueNotifier<String>(null);
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false); /// tamam disposed
  /// FOUND RESULTS
  final ValueNotifier<List<Chain>> _foundChains = ValueNotifier<List<Chain>>(<Chain>[]); /// tamam disposed
  /// SELECTION
  ValueNotifier<List<SpecModel>> _selectedSpecs;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    // ------------------------------
    _initialChain = ChainsProvider.proGetBigChainK(
      context: context,
      onlyUseCityChains: widget.onlyUseCityChains,
      listen: false,
    );
    // ------------------------------
    /// WHEN CHAINS ARE LOADED IN CHAINS PRO
    if (_initialChain != null){
      _initializeScreen(_initialChain);
    }

    // ------------------------------
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    /// DATA
    _refinedSpecsPickers.dispose();
    _groupsIDs.dispose();
    /// SEARCHING
    _searchTextController.dispose();
    _searchText.dispose();
    _isSearching.dispose();
    /// FOUND RESULTS
    _foundChains.dispose();
    /// SELECTION
    _selectedSpecs.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  bool _isInitialized = false;
  void _initializeScreen(Chain _initialChain){
    if (_isInitialized == false){
      // ------------------------------
      if (widget.flyerTypeChainFilter == null){

        _allSpecPickers = SpecPicker.createPickersForChainK(
          context: context,
          chainK: _initialChain,
        );
      }
      else {
        _allSpecPickers = SpecPicker.getPickersByFlyerType(widget.flyerTypeChainFilter);
      }
      // ------------------------------
      _selectedSpecs = ValueNotifier<List<SpecModel>>(widget.selectedSpecs ?? []);
      // ------------------------------
      final List<SpecPicker> _theRefinedPickers = SpecPicker.applyDeactivatorsToSpecsPickers(
        sourceSpecsPickers: _allSpecPickers,
        selectedSpecs: widget.selectedSpecs,
      );
      _refinedSpecsPickers = ValueNotifier<List<SpecPicker>>(_theRefinedPickers);
      // ------------------------------
      final List<String> _theGroupsIDs = SpecPicker.getGroupsFromSpecsPickers(
        specsPickers: _theRefinedPickers,
      );
      _groupsIDs = ValueNotifier<List<String>>(_theGroupsIDs);
      // ------------------------------
      _generatePhidsFromAllSpecPickers();
      // ------------------------------
      _isInitialized = true;
    }
  }
// -----------------------------------------------------------------------------
  List<String> _phidsOfAllPickers = <String>[];
  void _generatePhidsFromAllSpecPickers(){

    if (Mapper.checkCanLoopList(_allSpecPickers) == true){

      final List<Chain> _sons = <Chain>[];

      for (final SpecPicker _picker in _allSpecPickers){
        final Chain _chain = ChainsProvider.proFindChainByID(
          context: context,
          chainID: _picker.chainID,
          onlyUseCityChains: widget.onlyUseCityChains,
        );
        if (_chain != null){
          _sons.add(_chain);
        }
      }

      if (Mapper.checkCanLoopList(_sons) == true){

        _phidsOfAllPickers = Chain.getOnlyStringsSonsIDsFromChains(
            chains: _sons
        );

      }

    }

  }
// -----------------------------------------------------------------------------
  Chain _getProChain (BuildContext ctx, ChainsProvider chainsPro){
    if (widget.onlyUseCityChains == true){
      return chainsPro.cityChainK;
    }
    else {
      return chainsPro.bigChainK;
    }
}
// -----------------------------------------------------------------------------
  String _getSpecPickerChainIDOfPhid(String phid){

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    final Chain _bigChainK = _chainsProvider.bigChainK;
    final Chain _bigChainS = _chainsProvider.bigChainS;

    final String _rooChainID = Chain.getRootChainIDOfPhid(
        allChains: <Chain>[..._bigChainK.sons, ..._bigChainS.sons],
        phid: phid,
    );

    return _rooChainID;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    return MainLayout(
      hasKeyboard: false,
      skyType: SkyType.black,
      appBarType: AppBarType.search,
      sectionButtonIsOn: false,
      pageTitle: widget.pageTitle,
      zoneButtonIsOn: false,
      pyramidsAreOn: true,
      pyramidType: PyramidType.crystalYellow,
      onBack: (){
        Nav.goBack(context, passedData: _selectedSpecs.value);
      },
      onSearchChanged: (String text) => onChainsSearchChanged(
        text: text,
        isSearching: _isSearching,
        context: context,
        foundChains: _foundChains,
        searchText: _searchText,
        phidsOfAllPickers: _phidsOfAllPickers,
      ),
      onSearchSubmit: (String text) => onChainsSearchSubmitted(
        text: text,
        isSearching: _isSearching,
        foundChains: _foundChains,
        context: context,
        searchText: _searchText,
        phidsOfAllPickers: _phidsOfAllPickers,
      ),
      onSearchCancelled: (){
        _searchTextController.text = '';
        Keyboard.closeKeyboard(context);
        _isSearching.value = false;
      },
      searchController: _searchTextController,
      searchHint: 'Search keywords',
      layoutWidget: Selector<ChainsProvider, Chain>(
        selector: _getProChain,
        // child: ,
        // shouldRebuild: ,
        builder: (_, Chain chain, Widget screenView){

          /// WHILE LOADING CHAIN
          if (chain == null){
            return const Center(
              child: WidgetFader(
                fadeType: FadeType.repeatAndReverse,
                child: SuperVerse(
                  verse: 'Loading\n Please Wait',
                  weight: VerseWeight.black,
                  maxLines: 2,
                ),
              ),
            );
          }

          /// AFTER CHAIN IS LOADED
          else {

            _initializeScreen(chain);

            return screenView;

          }


        },

        child: ValueListenableBuilder<bool>(
          key: const ValueKey<String>('ChainsScreen_view'),
          valueListenable: _isSearching,
          child: Container(),
          builder: (_, bool isSearching, Widget child){

            /// WHILE SEARCHING
            if (isSearching == true){

              /// NEW METHOD - NEED CHECK
              return ChainsScreenSearchView(
                screenHeight: _screenHeight,
                foundChains: _foundChains,
                selectedSpecs: _selectedSpecs,
                searchText: _searchText,
                onSelectPhid: (String phid) => onSelectPhid(
                    context: context,
                    phid: phid,
                    isMultipleSelectionMode: widget.isMultipleSelectionMode,
                    selectedSpecs: _selectedSpecs,
                    specPicker: SpecPicker.getPickerFromPickersByChainIDOrUnitChainID(
                      specsPickers: _allSpecPickers,
                      pickerChainID: _getSpecPickerChainIDOfPhid(phid),
                    ),
                ),
              );

            }

            /// WHILE BROWSING
            else {

              return ChainsScreenBrowseView(
                refinedSpecsPickers: _refinedSpecsPickers,
                specsPickers: _allSpecPickers,
                selectedSpecs: _selectedSpecs,
                onPickerTap: (SpecPicker picker) => onSpecPickerTap(
                  context: context,
                  selectedSpecs: _selectedSpecs,
                  isMultipleSelectionMode: widget.isMultipleSelectionMode,
                  onlyUseCityChains: widget.onlyUseCityChains,
                  allSpecPickers: _allSpecPickers,
                  picker: picker,
                  refinedSpecsPickers: _refinedSpecsPickers,
                ),
                onDeleteSpec: (List<SpecModel> specs) => onRemoveSpecs(
                  specs: specs,
                  selectedSpecs: _selectedSpecs,
                ),
              );

            }

          },
        ),

      ),

    );

  }
}
