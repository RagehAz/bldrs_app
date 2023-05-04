import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/b_views/i_chains/a_pickers_screen/aa_pickers_screen_browse_view.dart';
import 'package:bldrs/b_views/i_chains/a_pickers_screen/aa_pickers_screen_search_view.dart';
import 'package:bldrs/b_views/i_chains/a_pickers_screen/x_pickers_screen_controllers.dart';
import 'package:bldrs/b_views/i_chains/a_pickers_screen/xx_pickers_search_controller.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:widget_fader/widget_fader.dart';
import 'package:bldrs/b_views/z_components/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:night_sky/night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:mapper/mapper.dart';
import 'package:scale/scale.dart';
import 'package:filers/filers.dart';
import 'package:layouts/layouts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PickersScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PickersScreen({
    @required this.flyerTypeFilter,
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
  final FlyerType flyerTypeFilter;
  final bool onlyUseCityChains;
  final bool isMultipleSelectionMode;
  final Verse pageTitleVerse;
  final bool onlyChainKSelection;
  final ZoneModel zone;
  /// --------------------------------------------------------------------------
  @override
  State<PickersScreen> createState() => _PickersScreenState();
  /// --------------------------------------------------------------------------
}

class _PickersScreenState extends State<PickersScreen> {
  // -----------------------------------------------------------------------------
  /// DATA
  // --------------------
  List<Chain> _bldrsChains;
  List<Chain> _pickersChains;
  // --------------------
  List<PickerModel> _allPickers = <PickerModel>[];
  final ValueNotifier<List<PickerModel>> _refinedPickers = ValueNotifier([]);
  // --------------------
  /// SEARCHING
  // --------------------
  final TextEditingController _searchTextController = TextEditingController();
  final ValueNotifier<String> _searchText = ValueNotifier<String>(null);
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  /// FOUND RESULTS
  final ValueNotifier<List<Chain>> _foundChains = ValueNotifier<List<Chain>>(<Chain>[]);
  /// SELECTION
  // --------------------
  final ValueNotifier<List<SpecModel>> _selectedSpecs = ValueNotifier([]);
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
  }
  // --------------------
  @override
  void dispose() {
    /// DATA
    _refinedPickers.dispose();
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

      List<PickerModel> _pickers = _refinedPickers.value;

      /// ( IN BZ EDITOR FOR BZ SCOPE SELECTION ) WHEN USING CHAIN K ONLY
      if (widget.onlyChainKSelection == true){


        _pickers = PickerModel.createHomeWallPickers(
          context: context,
          canPickMany: true,
          onlyUseTheseFlyerTypes: [widget.flyerTypeFilter],
        );
      }

      /// WHEN USING BOTH CHAIN K AND CHAIN S
      else {

        /// ( IN WALL PHID SELECTION ) WHEN NO FLYER TYPES GIVE
        if (widget.flyerTypeFilter == null){

          blog('should pick a phid');

          _pickers = PickerModel.createHomeWallPickers(
            context: context,
            canPickMany: false,
            onlyUseTheseFlyerTypes: FlyerTyper.concludePossibleFlyerTypesByChains(_bldrsChains),
          );
        }

        /// ( IN FLYER EDITOR FOR SPECS SELECTION ) => ONE FLYER TYPE IS GIVEN FOR THE FLYER
        else if ([widget.flyerTypeFilter].length == 1){
          _pickers = ChainsProvider.proGetPickersByFlyerType(
            context: context,
            flyerType: [widget.flyerTypeFilter][0],
            listen: false,
            sort: true,
          );
        }
        else {
          _pickers = ChainsProvider.proGetSortedPickersByFlyerTypes(
            context: context,
            flyerTypes: [widget.flyerTypeFilter],
            sort: true,
            listen: false,
          );
        }

      }

      // ------------------------------
      setNotifier(
          notifier: _selectedSpecs,
          mounted: mounted,
          value: widget.selectedSpecs ?? <SpecModel>[],
      );
      // ------------------------------
      setState(() {
        _allPickers = _pickers;
      });
      // ------------------------------
      setNotifier(
        notifier: _refinedPickers,
        mounted: mounted,
        value: PickerModel.applyBlockersAndSort(
          sourcePickers: _pickers,
          selectedSpecs: widget.selectedSpecs,
          sort: true,
        ),
      );
      // ------------------------------
      _generatePhidsFromAllPickers(_refinedPickers.value);
      // ------------------------------
      _isInitialized = true;
      // ------------------------------
      _pickersChains = Chain.getChainsFromChainsByIDs(
        allChains: _bldrsChains,
        phids: PickerModel.getPickersChainsIDs(_refinedPickers.value),
      );
    }
  }
  // --------------------
  List<String> _phidsOfAllPickers = <String>[];
  void _generatePhidsFromAllPickers(List<PickerModel> refinedPickers){

    if (Mapper.checkCanLoopList(refinedPickers) == true){

      final List<Chain> _sons = <Chain>[];

      for (final PickerModel _picker in refinedPickers){
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

        final List<String> _phidsWithIndexes = Chain.getOnlyPhidsSonsFromChains(
            chains: _sons
        );
        final List<String> _chainsIDs = Chain.getOnlyChainSonsIDs(chain: Chain(
          id: '',
          sons: _sons,
        ));

        _phidsOfAllPickers = Phider.removePhidsIndexes(<String>[..._chainsIDs, ..._phidsWithIndexes]);

      }

    }

  }
  // --------------------
  List<Chain> _getBldrsChains (BuildContext ctx, ChainsProvider chainsPro){

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

    final double _screenHeight = Scale.screenHeight(context);

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.search,
      title: widget.pageTitleVerse,
      pyramidsAreOn: true,
      pyramidType: PyramidType.crystalYellow,
      appBarRowWidgets: [

        const Expander(),

        AppBarButton(
          verse: Verse.plain('blog'),
          onTap: (){

            // final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
            // final List<Phrase> _phrases = _chainsProvider.chainsPhrases;
            //
            // Phrase.blogPhrases(_phrases);

            // Stringer.blogStrings(strings: _phidsOfAllPickers);

            // Chain.blogChains(_pickersChains);

            PickerModel.blogPickers(_refinedPickers.value);

          },
        ),

      ],

      onBack: () => onGoBackFromPickersScreen(
        context: context,
        isMultipleSelectionMode: widget.isMultipleSelectionMode,
        selectedSpecs: _selectedSpecs,
        widgetSelectedSpecs: widget.selectedSpecs,
      ),
      confirmButtonModel: widget.isMultipleSelectionMode == false ? null : ConfirmButtonModel(
        firstLine: Verse(
          id: 'phid_confirm_selections',
          translate: true,
          variables: widget.pageTitleVerse,
        ),
        onTap: () async {
          await Nav.goBack(
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
        chains: _pickersChains,
        mounted: mounted,
      ),
      onSearchSubmit: (String text) => onSearchChains(
        text: text,
        isSearching: _isSearching,
        foundChains: _foundChains,
        context: context,
        searchText: _searchText,
        phidsOfAllPickers: _phidsOfAllPickers,
        chains: _pickersChains,
        mounted: mounted,
      ),
      onSearchCancelled: () => MainLayout.onCancelSearch(
        context: context,
        controller: _searchTextController,
        foundResultNotifier: _foundChains,
        isSearching: _isSearching,
        mounted: mounted,
      ),
      searchController: _searchTextController,
      searchHintVerse: const Verse(
        id: 'phid_search_keywords',
        translate: true,
      ),
      child: Selector<ChainsProvider, List<Chain>>(
        selector: _getBldrsChains,
        // child: ,
        // shouldRebuild: ,
        builder: (_, List<Chain> chains, Widget screenView){

          /// WHILE LOADING CHAIN
          if (chains == null){
            return const Center(
              child: WidgetFader(
                fadeType: FadeType.repeatAndReverse,
                child: BldrsText(
                  verse: Verse(
                    id: 'phid_loading',
                    translate: true,
                    pseudo: 'Loading\n Please Wait',
                    casing: Casing.capitalizeFirstChar,
                  ),
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

        /// SCREEN VIEW
        child: ValueListenableBuilder<bool>(
          key: const ValueKey<String>('ChainsScreen_view'),
          valueListenable: _isSearching,
          child: Container(),
          builder: (_, bool isSearching, Widget child){

            /// WHILE SEARCHING
            if (isSearching == true){

              /// NEW METHOD - NEED CHECK
              return PickersScreenSearchView(
                screenHeight: _screenHeight,
                foundChains: _foundChains,
                selectedSpecsNotifier: _selectedSpecs,
                searchText: _searchText,
                zone: widget.zone,
                onlyUseCityChains: widget.onlyUseCityChains,
                isMultipleSelectionMode: widget.isMultipleSelectionMode,
                refinedPickersNotifier: _refinedPickers,
                allPickers: _allPickers,
                mounted: mounted,
              );

            }

            /// WHILE BROWSING
            else {

              return PickersScreenBrowseView(
                onlyUseCityChains: widget.onlyUseCityChains,
                refinedPickersNotifier: _refinedPickers,
                selectedSpecsNotifier: _selectedSpecs,
                flyerTypes: [widget.flyerTypeFilter],
                zone: widget.zone,
                isMultipleSelectionMode: widget.isMultipleSelectionMode,
                mounted: mounted,
              );

            }

          },
        ),

      ),

    );

  }
  // -----------------------------------------------------------------------------
}
