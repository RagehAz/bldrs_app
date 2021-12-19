import 'dart:async';

import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/y_views/c_search/c_0_search_screen_view.dart';
import 'package:bldrs/c_controllers/c_0_search_controller.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final TextEditingController _searchController = TextEditingController();

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
  void _onSearchClear(String searchText){

    controlOnSearchClear(
      context: context,
      searchText: searchText,
    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      appBarType: AppBarType.search,
      // appBarBackButton: true,
      pyramidsAreOn: true,
      searchController: _searchController,
      onSearchSubmit: _onSearchSubmit,
      onSearchChanged: _onSearchClear,
      layoutWidget: SearchScreenView(),
    );
  }
}
