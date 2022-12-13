import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/structure/slides_shelf/aaa_flyer_slides_shelf.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/phids_bubble/keywords_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/corner_widget_maximizer.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/obelisk_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/hashtag_manager/hashtags_builder_page.dart';
import 'package:flutter/material.dart';

class HashtagPickerScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const HashtagPickerScreen({
    @required this.flyerModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  /// --------------------------------------------------------------------------
  @override
  _TheStatefulScreenState createState() => _TheStatefulScreenState();
/// --------------------------------------------------------------------------
}

class _TheStatefulScreenState extends State<HashtagPickerScreen> with SingleTickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  TabController _tabBarController;
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey _globalKey = GlobalKey();
  // --------------------
  List<Chain> _bldrsChains;
  // --------------------
  List<Chain> _chains;
  List<NavModel> _navModels = [];
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

    // ------------------------------
    final List<Chain> _allChains = ChainsProvider.proGetBldrsChains(
      context: context,
      onlyUseCityChains: false,
      listen: false,
    );
    // ------------------------------

    // Chain.blogChains(_chain.sons);

    // Stringer.blogStrings(strings: _hashGroups, invoker: 'fu');


    final List<Chain> _chainsByFlyerType = Chain.getChainsFromChainsByIDs(
      allChains: _allChains,
      phids: FlyerTyper.getHashGroupsIDsByFlyerType(FlyerType.property),
    );

    setState(() {
      _bldrsChains = _allChains;
      _chains = _chainsByFlyerType;
    });

    _tabBarController = TabController(
        vsync: this,
        animationDuration: const Duration(milliseconds: 300),
        length: _chains.length,
        // initialIndex: 0,
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
          searchText: _searchController,
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
  Future<void> _onSearchSubmit(String text) async {

  }
  // --------------------
  Future<void> _onSearchChanged(String text) async {

  }
  // --------------------
  Future<void> _onSearchCancelled() async {

  }
  // -----------------------------------------------------------------------------

  /// SELECTION

  // --------------------

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
      onSearchChanged: _onSearchChanged,
      searchHintVerse: const Verse(
        text: 'phid_search',
        translate: true,
      ),
      appBarRowWidgets: [

        const Expander(),

        AppBarButton(
          verse: Verse.plain('blogChains'),
          onTap: (){
            Chain.blogChains(_bldrsChains);
          },
        ),

      ],
      abovePyramidsChild: CornerWidgetMaximizer(
        maxWidth: BldrsAppBar.width(context),
        minWidth: 170,
        childWidth: BldrsAppBar.width(context),
        topChild: FlyerSlidesShelf(
          flyerModel: widget.flyerModel,
          shelfWidth: BldrsAppBar.clearWidth(context),
        ),
        child: KeywordsBubble(
          bubbleColor: Colorz.black255,
          selectedWords: [],
          onKeywordTap: (String keyword){
            blog('keyword : $keyword');
          },
          titleVerse: const Verse(
            text: 'phid_selected_keywords',
            translate: true,
          ),
          phids: [],
          addButtonIsOn: false,
          onTap: (){
            blog('tap KeywordsBubble');
          },
          bubbleWidth: BldrsAppBar.width(context),
        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}
