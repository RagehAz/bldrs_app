import 'dart:async';

import 'package:bldrs/a_models/flyer/records/record_model.dart';
import 'package:bldrs/a_models/secondary_models/search_result.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/y_views/c_search/c_0_search_screen_view.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/c_0_search_controller.dart';
import 'package:bldrs/d_providers/search_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
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
        _searchProvider.getSetSearchRecords(context);


      }

    });

  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      if (userIsSignedIn()){

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
    super.dispose();
    TextChecker.disposeControllerIfNotEmpty(_searchController);
  }
// -----------------------------------------------------------------------------
  Future<void> _onSearchSubmit(String searchText) async {

    await controlOnSearchSubmit(
        context: context,
        searchText: _searchController.text,
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
  @override
  Widget build(BuildContext context) {

    final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: true);
    final List<RecordModel> _records = _searchProvider.searchRecords;

    final String _verse =
        _uiProvider.isLoading ? 'loading' :
            _uiProvider.isSearchingFlyersAndBzz ? 'searching' :
                'default';

    return MainLayout(
      appBarType: AppBarType.search,
      appBarRowWidgets: [
        DreamBox(
          height: 35,
          verse: _verse,
          verseScaleFactor: 0.5,
          secondLine: '${_records.length} records',
          onTap: () async {

            // final bool _isOnline = userIsSignedIn();

            final String id = superUserID();

            blog(id);

          },
        ),
      ],
      pyramidsAreOn: true,
      searchController: _searchController,
      onSearchSubmit: _onSearchSubmit,
      onSearchChanged: _onSearchChanged,
      onBack: () async {

        _searchProvider.emptySearchRecords();
        _searchProvider.setSearchResult(<SearchResult>[]);
        _uiProvider.triggerIsSearching(searchingModel: SearchingModel.flyersAndBzz, setIsSearchingTo: false);
        _uiProvider.triggerLoading(setLoadingTo: false);

        goBack(context);

      },
      layoutWidget: SearchScreenView(
        scrollController: _scrollController,
      ),

    );
  }
}
