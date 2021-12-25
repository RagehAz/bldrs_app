import 'dart:async';

import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/y_views/c_search/c_0_search_screen_view.dart';
import 'package:bldrs/c_controllers/c_0_search_controller.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final TextEditingController _searchController = TextEditingController();

// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
      _uiProvider.startController(()async{

        await initializeSearchScreen(context);

      });

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

    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: true);
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

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
        ),
      ],
      pyramidsAreOn: true,
      searchController: _searchController,
      onSearchSubmit: _onSearchSubmit,
      onSearchChanged: _onSearchChanged,
      layoutWidget: const SearchScreenView(),

    );
  }
}
