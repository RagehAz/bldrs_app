import 'dart:async';
import 'package:authing/authing.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/b_views/c_main_search/a_main_search_screen/aa_main_search_screen_view.dart';
import 'package:bldrs/b_views/c_main_search/a_main_search_screen/x_main_search_controllers.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/search_provider.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:provider/provider.dart';
import 'package:scale/scale.dart';

class MainSearchScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const MainSearchScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _MainSearchScreenState createState() => _MainSearchScreenState();
  /// --------------------------------------------------------------------------
}

class _MainSearchScreenState extends State<MainSearchScreen> {
  // -----------------------------------------------------------------------------
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  // -----------------------------------------------------------------------------
  @override
  void initState(){
    super.initState();


    /// TASK : REFACTOR THIS SCROLLER LISTENER : OR MAYBE CREATE FUTURE PAGINATOR WIDGET
    // Scrollers.createPaginationListener(
    //     controller: controller,
    //     isPaginating: isPaginating,
    //     canKeepReading: canKeepReading,
    //     onPaginate: onPaginate
    // );

    _scrollController.addListener(() {

      final double _maxScroll = _scrollController.position.maxScrollExtent;
      final double _currentScroll = _scrollController.position.pixels;
      final double _screenHeight = Scale.screenHeight(context); // * 0.25 why ??
      final double _delta = _screenHeight * 0.1;

      if (_maxScroll - _currentScroll <= 0){

        blog('_maxScroll : $_maxScroll : _currentScroll : $_currentScroll : diff : ${_maxScroll - _currentScroll} : _delta : $_delta');

        final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);
        _searchProvider.paginateSetSearchRecords(
          context: context,
          notify: true,
        );


      }

    });

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      if (Authing.userIsSignedIn() == true){

        final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
        _uiProvider.startController(()async{

          await initializeSearchScreen(context);

        });

      }

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSearchSubmit(String searchText) async {

    await controlOnSearchSubmit(
      context: context,
      searchText: _searchController.text,
      lastBzSnapshot: null, /// TASK : PAGINATE SEARCH RESULTS
      lastFlyerSnapshot: null,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _onSearchChanged(String searchText){

    controlOnSearchChange(
      context: context,
      searchText: searchText,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Verse _getSearchHintVerse(BuildContext context){

    final ZoneModel _zone = ZoneProvider.proGetCurrentZone(
        context: context,
        listen: false,
    );

    final String _countryName = _zone?.countryName ?? '';
    final String _cityName = _zone?.cityName ?? '...';

    final String _hintText =  '${Verse.transBake(context, 'phid_search_flyers_in')} '
                              '$_cityName, $_countryName';

    return Verse(
      id: _hintText,
      translate: false,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: true);
    // --------------------
    /*
    // final List<RecordModel> _records = _searchProvider.searchRecords;

    // final String _verse =
    //     _uiProvider.isLoading ? 'loading' :
    //     _searchProvider.isSearchingFlyersAndBzz ? 'searching' :
    //             'default';
     */
    // --------------------
    return MainLayout(
      appBarType: AppBarType.search,
      title: const Verse(
        id: 'phid_search',
        translate: true,
        casing: Casing.capitalizeFirstChar,
      ),
      searchHintVerse: _getSearchHintVerse(context),
      pyramidsAreOn: true,
      searchController: _searchController,
      onSearchSubmit: _onSearchSubmit,
      onSearchChanged: _onSearchChanged,
      onBack: () async {

        // _searchProvider.clearSearchRecords(notify: false);
        _searchProvider.clearSearchResult(notify: false);
        _searchProvider.triggerIsSearching(
          searchingModel: SearchingModel.flyersAndBzz,
          setIsSearchingTo: false,
          notify: true,
        );
        _uiProvider.triggerLoading(
          setLoadingTo: false,
          callerName: 'SearchScreen',
          notify: true,
        );

        await Nav.goBack(
          context: context,
          invoker: 'MainSearchScreen',
        );

      },
      onSearchCancelled: (){
        _searchController.text = '';
        _searchProvider.clearSearchResult(notify: false);
        _searchProvider.closeAllSearches(notify: true);
      },
      child: SearchScreenView(
        scrollController: _scrollController,
        searchController: _searchController,
      ),

    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
