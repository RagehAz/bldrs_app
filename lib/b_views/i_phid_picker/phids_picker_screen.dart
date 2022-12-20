import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/b_views/i_chains/a_pickers_screen/xx_pickers_search_controller.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/structure/slides_shelf/aaa_flyer_slides_shelf.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/phids_bubble/phids_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/corner_widget_maximizer.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/obelisk_layout.dart';
import 'package:bldrs/b_views/z_components/texting/customs/no_result_found.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/hashtag_manager/hashtags_builder_page.dart';
import 'package:flutter/material.dart';

class PhidsPickerScreen extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const PhidsPickerScreen({
    @required this.chainsIDs,
    this.selectedPhids,
    this.multipleSelectionMode = false,
    this.flyerModel,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final List<String> selectedPhids;
  /// RETURNS <String>[] if is multiple selection mode, and returns String if not
  final bool multipleSelectionMode;
  /// SHOWS flyer in the corner widget maximizer showing selected keywords,
  final FlyerModel flyerModel;

  final List<String> chainsIDs;
  // -----------------------------------------------------------------------------
  @override
  _TheStatefulScreenState createState() => _TheStatefulScreenState();
  // -----------------------------------------------------------------------------
}

class _TheStatefulScreenState extends State<PhidsPickerScreen> with SingleTickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  TabController _tabBarController;
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey _globalKey = GlobalKey();
  // --------------------
  List<Chain> _chains;
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
  Future<void> _triggerLoading({@required bool setTo}) async {
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

    final List<Chain> _allChains = ChainsProvider.proGetBldrsChains(
      context: context,
      onlyUseCityChains: false,
      listen: false,
    );

    final List<Chain> _chainsByIDs = Chain.getChainsFromChainsByIDs(
      allChains: _allChains,
      phids: widget.chainsIDs,
    );

    // setState(() {

      if (
          _chainsByIDs?.length == 1
          &&
          Chain.checkIsChains(_chainsByIDs.first.sons) == true
      ){
        _chains = _chainsByIDs.first.sons;
      }
      else {
        _chains = _chainsByIDs;
      }

      _allPhids = Chain.getOnlyPhidsSonsFromChains(
          chains: _chains,
      );
    // });

    _tabBarController = TabController(
        vsync: this,
        animationDuration: const Duration(milliseconds: 300),
        length: _chains.length ?? 1,
        // initialIndex: 0,
    );

    setNotifier(
        notifier: _selectedPhidsNotifier,
        mounted: mounted,
        value: widget.selectedPhids ?? <String>[],
    );

    _generateNavModels();

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        /// FUCK

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _tabBarController.dispose();
    _searchController.dispose();
    _selectedPhidsNotifier.dispose();
    _selectedPhidsScrollController.dispose();

    _foundChains.dispose();
    _isSearching.dispose();
    _searchText.dispose();

    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// NAV MODELS

  // --------------------
  /// TESTED : WORKS PERFECT
  void _generateNavModels(){

    final List<NavModel> _output = [];

    for (final Chain _chain in _chains){

      final NavModel _navModel = NavModel(
        id: _chain.id,
        titleVerse: Verse(text: _chain.id, translate: true),
        icon: ChainsProvider.proGetPhidIcon(context: context, son: _chain.id),
        iconSizeFactor: 1,
        screen: HashtagsBuilderPage(
          chain: _chain,
          searchText: _searchText,
          selectedPhidsNotifier: _selectedPhidsNotifier,
          onPhidTap: (String path, String phid) => _onPhidTap(
            path: path,
            phid: phid,
            autoScroll: true,
          ),
        ),
      );

      _output.add(_navModel);

    }

    setState(() {
      _navModels = _output;
    });

  }
  // -----------------------------------------------------------------------------

  /// SEARCH

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSearchSubmit(String text) async {

    await onChainsSearchChanged(
      context: context,
      text: text,
      chains: _chains,
      foundChains: _foundChains,
      isSearching: _isSearching,
      phidsOfAllPickers: _allPhids,
      searchText: _searchText,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSearchCancelled() async {

    _foundChains.value = [];
    _isSearching.value = false;
    _searchText.value = '';
    _searchController.text = '';

  }
  // -----------------------------------------------------------------------------

  /// SELECTION

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onPhidTap({
    @required String path,
    @required String phid,
    @required bool autoScroll,
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
  ///
  Future<void> _singleSelectionModeTap({
  @required String phid,
}) async {

    await Nav.goBack(
      context: context,
      passedData: phid,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _multipleSelectionModeTap({
    @required String path,
    @required String phid,
    @required bool autoScroll,
  }) async {

    final List<String> _selectedPhids = Stringer.addOrRemoveStringToStrings(
      strings: _selectedPhidsNotifier.value,
      string: phid,
    );

    final int _oldLength = _selectedPhidsNotifier.value.length;
    final int _newLength = _selectedPhids.length;
    final int _selectedPhidIndex = _selectedPhidsNotifier.value.indexOf(phid);

    _selectedPhidsNotifier.value = _selectedPhids;

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
    @required int oldLength,
    @required int newLength,
    @required int selectedPhidIndex,
  }) async {

    if (_isSearching.value == false){

      final bool _shouldGoToEnd = newLength > oldLength;

      if (_shouldGoToEnd == true){
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

  /// SELECTION

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onBack() async {

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
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ObeliskLayout(
      globalKey: _globalKey,
      navModels: _navModels,
      canGoBack: true,
      initiallyExpanded: true,
      appBarType: AppBarType.search,
      searchController: _searchController,
      onSearchSubmit: _onSearchSubmit,
      onSearchCancelled: _onSearchCancelled,
      onSearchChanged: _onSearchSubmit,
      isSearching: _isSearching,
      onBack: _onBack,
      searchHintVerse: const Verse(
        text: 'phid_search',
        translate: true,
      ),
      // appBarRowWidgets: <Widget>[
      //
      //   const Expander(),
      //
      //   AppBarButton(
      //     verse: Verse.plain('blogChains'),
      //     onTap: (){
      //       Chain.blogChains(_bldrsChains);
      //     },
      //   ),
      //
      // ],
      /// SEARCH VIEW
      searchView: SizedBox(
        width: Scale.screenWidth(context),
        height: Scale.screenHeight(context),
        child: ValueListenableBuilder(
          valueListenable: _foundChains,
          builder: (BuildContext context, List<Chain> foundChains, Widget child) {

            if (Mapper.checkCanLoopList(foundChains) == true){
              return HashtagsBuilderPage(
                chain: Chain(
                  id: 'foundChains',
                  sons: foundChains,
                ),
                searchText: _searchText,
                selectedPhidsNotifier: _selectedPhidsNotifier,
                onPhidTap: (String path, String phid) => _onPhidTap(
                  path: path,
                  phid: phid,
                  autoScroll: true,
                ),              );
            }

            else {
              return const NoResultFound();
            }


          },
        ),
      ),

      /// CORNER SELECTED PHIDS
      abovePyramidsChild: widget.multipleSelectionMode == false ?
      const SizedBox()
          :
      CornerWidgetMaximizer(
        maxWidth: BldrsAppBar.width(context),
        minWidth: 170,
        childWidth: BldrsAppBar.width(context),

        /// FLYER SHELF IN SELECTED PHIDS PANEL
        topChild: widget.flyerModel == null ?
        const SizedBox()
            :
        FlyerSlidesShelf(
          flyerModel: widget.flyerModel,
          shelfWidth: BldrsAppBar.clearWidth(context),
        ),

        /// SELECTED PHIDS PANEL
        child: ValueListenableBuilder(
          valueListenable: _selectedPhidsNotifier,
          builder: (BuildContext context, List<String> selectedPhids, Widget child) {

            final String _selectedKeywords = Verse.transBake(context, 'phid_selected_keywords');

            final Verse _verse = Verse(
              text: '(${selectedPhids.length}) $_selectedKeywords',
              translate: false,
            );

            return PhidsBubble(
              bubbleColor: Colorz.white10,
              selectedWords: selectedPhids,
              passPhidOnTap: true,
              titleVerse: _verse,
              phids: selectedPhids,
              addButtonIsOn: false,
              bubbleWidth: BldrsAppBar.width(context),
              maxLines: 3,
              scrollController: _selectedPhidsScrollController,
              onPhidTap: (String phid) => _onPhidTap(
                path: null,
                phid: phid,
                autoScroll: false,
              ),
            );

          },
        ),

      ),

    );

  }
// -----------------------------------------------------------------------------
}