import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/a_chains_screen/aa_chains_screen_search_view.dart';
import 'package:bldrs/b_views/i_chains/a_chains_screen/aa_chains_screen_browse_view.dart';
import 'package:bldrs/b_views/i_chains/a_chains_screen/x_chains_screen_controllers.dart';
import 'package:bldrs/b_views/i_chains/a_chains_screen/xx_chains_search_controller.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/i_chains/b_pickers_screen/x_pickers_screen_controllers.dart';
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
    @required this.flyerTypesChainFilters,
    @required this.onlyUseCityChains,
    @required this.isMultipleSelectionMode,
    @required this.pageTitleVerse,
    @required this.zone,
    this.selectedSpecs,
    this.onlyChainKSelection = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<SpecModel> selectedSpecs;
  /// if given flyer type : will generate flyer type chain : if null will get all chains
  final List<FlyerType> flyerTypesChainFilters;
  final bool onlyUseCityChains;
  final bool isMultipleSelectionMode;
  final String pageTitleVerse;
  final bool onlyChainKSelection;
  final ZoneModel zone;
  /// --------------------------------------------------------------------------
  @override
  State<ChainsScreen> createState() => _ChainsScreenState();
  /// --------------------------------------------------------------------------
}

class _ChainsScreenState extends State<ChainsScreen> {
  // -----------------------------------------------------------------------------
  /// DATA
  // --------------------
  List<Chain> _bldrsChains;
  // --------------------
  List<PickerModel> _allSpecPickers = <PickerModel>[];
  ValueNotifier<List<PickerModel>> _refinedSpecsPickers;
  ValueNotifier<List<String>> _groupsIDs;
  // --------------------
  /// SEARCHING
  // --------------------
  final TextEditingController _searchTextController = TextEditingController();
  final ValueNotifier<String> _searchText = ValueNotifier<String>(null);
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false); /// tamam disposed
  /// FOUND RESULTS
  final ValueNotifier<List<Chain>> _foundChains = ValueNotifier<List<Chain>>(<Chain>[]); /// tamam disposed
  /// SELECTION
  // --------------------
  ValueNotifier<List<SpecModel>> _selectedSpecs;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    // ------------------------------
    _bldrsChains = ChainsProvider.proGetBldrsChains(
      context: context,
      onlyUseCityChains: widget.onlyUseCityChains,
      listen: false,
    );
    // ------------------------------
    /// WHEN CHAINS ARE LOADED IN CHAINS PRO
    if (_bldrsChains != null){
      _initializeScreen(_bldrsChains);
    }

    // ------------------------------
  }
  // --------------------
  /// TAMAM
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
  void _initializeScreen(List<Chain> _bldrsChains){
    if (_isInitialized == false){
      // ------------------------------

      /// ( IN BZ EDITOR FOR BZ SCOPE SELECTION ) WHEN USING CHAIN K ONLY
      if (widget.onlyChainKSelection == true){
        _allSpecPickers = PickerModel.createPickersFromAllChainKs(
          context: context,
          onlyUseTheseFlyerTypes: widget.flyerTypesChainFilters,
          canPickManyOfAPicker: true,
        );
      }

      /// WHEN USING BOTH CHAIN K AND CHAIN S
      else {

        /// ( IN WALL PHID SELECTION ) WHEN NO FLYER TYPES GIVE
        if (Mapper.checkCanLoopList(widget.flyerTypesChainFilters) == false){

          _allSpecPickers = PickerModel.createHomeWallPickers(
            context: context,
            canPickMany: false,
          );
        }

        /// ( IN FLYER EDITOR FOR SPECS SELECTION ) => ONE FLYER TYPE IS GIVEN FOR THE FLYER
        else if (widget.flyerTypesChainFilters.length == 1){
          _allSpecPickers = ChainsProvider.proGetPickersByFlyerType(
            context: context,
            flyerType: widget.flyerTypesChainFilters[0],
            listen: false,
          );
        }
        else {
          _allSpecPickers = ChainsProvider.proGetPickersByFlyerTypes(
            context: context,
            flyerTypes: widget.flyerTypesChainFilters,
            listen: false,
          );
        }

      }

      // ------------------------------
      _selectedSpecs = ValueNotifier<List<SpecModel>>(widget.selectedSpecs ?? []);
      // ------------------------------
      final List<PickerModel> _theRefinedPickers = PickerModel.applyBlockersAndSort(
        sourcePickers: _allSpecPickers,
        selectedSpecs: widget.selectedSpecs,
      );
      _refinedSpecsPickers = ValueNotifier<List<PickerModel>>(_theRefinedPickers);
      // ------------------------------
      final List<String> _theGroupsIDs = PickerModel.getGroupsIDs(
        pickers: _theRefinedPickers,
      );
      _groupsIDs = ValueNotifier<List<String>>(_theGroupsIDs);
      // ------------------------------
      _generatePhidsFromAllSpecPickers();
      // ------------------------------
      _isInitialized = true;
    }
  }
  // --------------------
  List<String> _phidsOfAllPickers = <String>[];
  void _generatePhidsFromAllSpecPickers(){

    if (Mapper.checkCanLoopList(_allSpecPickers) == true){

      final List<Chain> _sons = <Chain>[];

      for (final PickerModel _picker in _allSpecPickers){
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

        _phidsOfAllPickers = Chain.getOnlyPhidsSonsFromChains(
            chains: _sons
        );

      }

    }

  }
  // --------------------
  List<Chain> _getProChains (BuildContext ctx, ChainsProvider chainsPro){
    if (widget.onlyUseCityChains == true){
      return chainsPro.cityChains;
    }
    else {
      return chainsPro.bldrsChains;
    }
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.search,
      sectionButtonIsOn: false,
      pageTitleVerse: widget.pageTitleVerse,
      pyramidsAreOn: true,
      pyramidType: PyramidType.crystalYellow,
      onBack: () async {

        bool _canContinue = true;

        if (widget.isMultipleSelectionMode == true){
          final bool _specsChanged = SpecModel.checkSpecsListsAreIdentical(
              widget.selectedSpecs ?? [],
              _selectedSpecs.value
          ) == false;

          if (_specsChanged == true){
            _canContinue = await CenterDialog.showCenterDialog(
              context: context,
              titleVerse: '##Discard Changes',
              bodyVerse: '##This will ignore All selection changes',
              confirmButtonVerse: '##Discard',
              boolDialog: true,
            );
          }
        }

        if (_canContinue == true){
          Nav.goBack(
            context: context,
            invoker: 'SpecPickerScreen.goBack',
          );
        }

      },
      confirmButtonModel: widget.isMultipleSelectionMode == false ? null : ConfirmButtonModel(
        firstLine: '##Confirm ${widget.pageTitleVerse}',
        onTap: (){
          Nav.goBack(
            context: context,
            invoker: 'ChainsScreen',
            passedData: _selectedSpecs.value,
          );
        },
      ),
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
      searchHintVerse: '##Search keywords',
      layoutWidget: Selector<ChainsProvider, List<Chain>>(
        selector: _getProChains,
        // child: ,
        // shouldRebuild: ,
        builder: (_, List<Chain> chains, Widget screenView){

          /// WHILE LOADING CHAIN
          if (chains == null){
            return const Center(
              child: WidgetFader(
                fadeType: FadeType.repeatAndReverse,
                child: SuperVerse(
                  verse: '##Loading\n Please Wait',
                  weight: VerseWeight.black,
                  maxLines: 2,
                ),
              ),
            );
          }

          /// AFTER CHAIN IS LOADED
          else {

            _initializeScreen(chains);

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
                onSelectPhid: (String path, String phid) => onSelectPhid(
                  context: context,
                  phid: phid,
                  isMultipleSelectionMode: widget.isMultipleSelectionMode,
                  selectedSpecs: _selectedSpecs,
                  picker: PickerModel.getPickerByChainIDOrUnitChainID(
                    pickers: _allSpecPickers,
                    chainIDOrUnitChainID: PickerModel.getPickerChainIDOfPhid(
                      context: context,
                      phid: phid,
                    ),
                  ),
                ),
              );

            }

            /// WHILE BROWSING
            else {



              return ChainsScreenBrowseView(
                onlyUseCityChains: widget.onlyUseCityChains,
                refinedPickers: _refinedSpecsPickers,
                pickers: _allSpecPickers,
                selectedSpecs: _selectedSpecs,
                flyerTypes: widget.flyerTypesChainFilters,
                onPickerTap: (PickerModel picker) => onPickerTap(
                  context: context,
                  zone: widget.zone,
                  selectedSpecs: _selectedSpecs,
                  isMultipleSelectionMode: widget.isMultipleSelectionMode,
                  onlyUseCityChains: widget.onlyUseCityChains,
                  allSpecPickers: _allSpecPickers,
                  picker: picker,
                  refinedSpecsPickers: _refinedSpecsPickers,
                  originalSpecs: widget.selectedSpecs ?? [],
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
  // -----------------------------------------------------------------------------
}
