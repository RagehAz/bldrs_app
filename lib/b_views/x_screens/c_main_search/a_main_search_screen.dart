import 'dart:async';

import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/c_main_search/aa_main_search_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/c_main_search_controllers/main_search_controllers.dart';
import 'package:bldrs/d_providers/search_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final TextEditingController _searchController = TextEditingController(); /// tamam disposed
  final ScrollController _scrollController = ScrollController(); /// tamam disposed
// -----------------------------------------------------------------------------
  @override
  void initState(){
    super.initState();

    _scrollController.addListener(() {

      final double _maxScroll = _scrollController.position.maxScrollExtent;
      final double _currentScroll = _scrollController.position.pixels;
      final double _screenHeight = Scale.superScreenHeight(context); // * 0.25 why ??
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
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      if (AuthModel.userIsSignedIn()){

        final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
        _uiProvider.startController(()async{

          await initializeSearchScreen(context);

        });

      }

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  Future<void> _onSearchSubmit(String searchText) async {

    await controlOnSearchSubmit(
      context: context,
      searchText: _searchController.text,
      lastBzSnapshot: null, /// TASK : PAGINATE SEARCH RESULTS
      lastFlyerSnapshot: null,
    );

  }
// -----------------------------------------------------------------------------
  void _onSearchChanged(String searchText){

    controlOnSearchChange(
      context: context,
      searchText: searchText,
    );

  }
// -----------------------------------------------------------------------------
  String _getSearchHintText(BuildContext context){

    final ZoneModel _zone = ZoneProvider.proGetCurrentZone(
        context: context,
        listen: false,
    );

    final String _countryName = _zone.countryName;
    final String _cityName = _zone.cityName;

    final String _hintText = 'Search flyers in $_cityName, $_countryName';
    return _hintText;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: true);
    // final List<RecordModel> _records = _searchProvider.searchRecords;

    // final String _verse =
    //     _uiProvider.isLoading ? 'loading' :
    //     _searchProvider.isSearchingFlyersAndBzz ? 'searching' :
    //             'default';

    return MainLayout(
      appBarType: AppBarType.search,
      sectionButtonIsOn: false,
      pageTitle: 'Search',
      searchHint: _getSearchHintText(context),
      pyramidsAreOn: true,
      searchController: _searchController,
      onSearchSubmit: _onSearchSubmit,
      onSearchChanged: _onSearchChanged,
      onBack: () async {

        _searchProvider.clearSearchRecords(notify: false);
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

        Nav.goBack(context);

      },
      layoutWidget: SearchScreenView(
        scrollController: _scrollController,
      ),

    );
  }
}
