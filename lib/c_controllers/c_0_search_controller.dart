import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/records/record_model.dart';
import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/secondary_models/name_model.dart';
import 'package:bldrs/a_models/secondary_models/search_result.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/nav_dialog/nav_dialog.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/keywords_provider.dart';
import 'package:bldrs/d_providers/search_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/fire/ops/record_ops.dart' as RecordOps;
import 'package:bldrs/e_db/fire/search/bz_search.dart' as BzSearch;
import 'package:bldrs/e_db/fire/search/flyer_search.dart' as FlyerSearch;
import 'package:bldrs/e_db/fire/search/user_search.dart' as UserSearchOps;
import 'package:bldrs/e_db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -------------------------------------------------------
Future<void> initializeSearchScreen(BuildContext context) async {

  _setIsLoading(context, true);
  _setIsSearching(context, false);

  final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);
  await _searchProvider.getSetSearchRecords(context);

  _setIsLoading(context, false);
}
// -------------------------------------------------------
Future<void> controlOnSearchSubmit({
  @required BuildContext context,
  @required String searchText,
}) async {

  _setIsLoading(context, true);
  _setIsSearching(context, true);

  // _uiProvider.triggerIsSearchingAfterMaxTextLength(
  //     text: searchText,
  //     searchModel: SearchingModel.flyersAndBzz,
  //     isSearching: _uiProvider.isSearchingFlyersAndBzz,
  //     setIsSearchingTo: true,
  // );

  /// add record to firebase
  await _createFireSearchRecord(
    context: context,
    searchText: searchText,
  );
  // /// add record to LDB
  // await
  // /// add record to provider

  final List<SearchResult> _keywordsResults = await _searchKeywords(
    context: context,
    searchText: searchText,
  );
  final List<SearchResult> _bzzResults = await _searchBzz(
    context: context,
    searchText: searchText,
  );
  final List<SearchResult> _authorsResults = await _searchAuthors(
    context: context,
    searchText: searchText,
  );
  final List<SearchResult> _flyersResults = await _searchFlyersByTitle(
    context: context,
    searchText: searchText,
  );

  final List<SearchResult> _all = <SearchResult>[
    ..._keywordsResults,
    ..._bzzResults,
    ..._authorsResults,
    ..._flyersResults
  ];

  await _handleSearchResult(
    context: context,
    allResults: _all,
  );

  _setIsLoading(context, false);
  _setIsSearching(context, true);

}
// -------------------------------------------------------
void controlOnSearchChange({
  @required BuildContext context,
  @required String searchText,
}){

  blog('search value changed to $searchText');
  final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);

  if (searchText.isEmpty) {
    _searchProvider.clearSearchResult();
    _setIsSearching(context, false);
  }

  else if (searchText.length < 3){
    _setIsSearching(context, false);
  }

  else if (searchText.length >= 3){
    _setIsSearching(context, true);
  }

}
// -------------------------------------------------------
Future<void> onSearchRecordTap({
  @required BuildContext context,
  @required RecordModel record,
}) async {

  final String _recordText = record?.recordDetails.toString();

  if (_recordText != null){

    await controlOnSearchSubmit(context: context, searchText: _recordText);

  }

}
// -------------------------------------------------------
/// TAMAM
Future<List<SearchResult>> _searchKeywords({
  @required BuildContext context,
  @required String searchText,
}) async {

  final List<SearchResult> _results = <SearchResult>[];

  final List<Map<String, dynamic>> _maps = await LDBOps.searchTrigram(
    searchValue: searchText,
    docName: LDBDoc.keywords,
    lingoCode: Wordz.languageCode(context),
  );

  if (Mapper.canLoopList(_maps)) {

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    final KeywordsProvider _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);

    final List<KW> _keywords = KW.decipherKeywordsLDBMaps(maps: _maps);

    for (final KW kw in _keywords) {
      final List<FlyerModel> _flyersByKeyword =
      await _flyersProvider.fetchFlyersByCurrentZoneAndKeyword(
        context: context,
        kw: kw,
      );

      if (_flyersByKeyword.isNotEmpty) {
        _results.add(SearchResult(
          title: Name.getNameByCurrentLingoFromNames(context: context, names: kw.names)?.value,
          icon: _keywordsProvider.getKeywordIcon(context: context, son: kw),
          flyers: _flyersByKeyword,
        ));
      }
    }
  }

  return _results;
}
// -------------------------------------------------------
/// TAMAM
Future<List<SearchResult>> _searchBzz({
  @required BuildContext context,
  @required String searchText,
}) async {
  final List<SearchResult> _results = <SearchResult>[];

  blog('_onSearchBzz : _searchController.text : $searchText');

  final List<BzModel> _bzz = await BzSearch.bzzByBzName(
    context: context,
    bzName: searchText,
  );

  if (Mapper.canLoopList(_bzz)) {

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);

    for (final BzModel bz in _bzz) {
      final List<FlyerModel> _bzFlyers = await _flyersProvider
          .fetchFirstFlyersByBzModel(context: context, bz: bz);

      if (Mapper.canLoopList(_bzFlyers)) {
        _results.add(SearchResult(
          title: 'Flyers by ${bz.name}',
          icon: bz.logo,
          flyers: _bzFlyers,
        ));
      }
    }
  }

  return _results;
}
// -------------------------------------------------------
Future<List<SearchResult>> _searchAuthors({
  @required BuildContext context,
  @required String searchText,
}) async {

  final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);

  final List<SearchResult> _results = <SearchResult>[];

  final List<UserModel> _users = await UserSearchOps.usersByNameAndIsAuthor(
    context: context,
    name: searchText,
  );

  if (Mapper.canLoopList(_users)) {
    for (final UserModel user in _users) {
      /// task should get only bzz showing teams
      final List<BzModel> _userBzz = await _bzzProvider.fetchUserBzz(context: context, userModel: user);

      if (Mapper.canLoopList(_userBzz)) {
        for (final BzModel bz in _userBzz) {
          /// task should get only flyers showing authors
          final List<FlyerModel> _bzFlyers = await _flyersProvider
              .fetchFirstFlyersByBzModel(context: context, bz: bz);

          if (Mapper.canLoopList(_bzFlyers)) {
            _results.add(SearchResult(
              title: 'Flyers from ${bz.name} published by ${user.name}',
              icon: user.pic,
              flyers: _bzFlyers,
            ));
          }
        }
      }
    }

    // _results.add(
    //     SearchResult(
    //       title: 'Flyers by ${bz.name}',
    //       icon: bz.logo,
    //       flyers: _bzFlyers,
    //     )
    // );
  }

  return _results;
}
// -------------------------------------------------------
/// TAMAM
Future<List<SearchResult>> _searchFlyersByTitle({
  @required BuildContext context,
  @required String searchText,
}) async {

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

  final List<SearchResult> _results = <SearchResult>[];

  final List<FlyerModel> _flyers = await FlyerSearch.flyersByZoneAndTitle(
    context: context,
    zone: _zoneProvider.currentZone,
    title: searchText,
  );

  if (_flyers.isNotEmpty) {
    _results.add(SearchResult(
      title: 'Matching titles',
      icon: null,
      flyers: _flyers,
    ));
  }

  return _results;
}
// -------------------------------------------------------
Future<void> _handleSearchResult({
  @required BuildContext context,
  @required List<SearchResult> allResults,
}) async {

  final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);

  if (allResults.isNotEmpty) {

    _searchProvider.setSearchResult(allResults);

  }

  else {

    _searchProvider.clearSearchResult();

    await NavDialog.showNavDialog(
      context: context,
      firstLine: 'No result found',
      secondLine: 'Try again with different words',
    );

  }

}
// -----------------------------------------------------------------------------
Future<void> _createFireSearchRecord({
  @required BuildContext context,
  @required String searchText,
}) async {

  /// TASK : need to check if this record already exists

  if (searchText.isNotEmpty){

    final RecordModel _record = RecordModel(
      recordID: null, /// will be defined as docID and injected into retrieved map
      userID: superUserID(),
      timeStamp: DateTime.now(),
      activityType: ActivityType.search,
      modelType: null, /// only used to trace model id
      modelID: null, /// like flyerID, bzID, questionID, answerID
      recordDetailsType: RecordDetailsType.searchText,
      recordDetails: searchText,
    );

    if (userIsSignedIn() == true){
      await RecordOps.createRecord(
        context: context,
        record: _record,
      );
    }

    final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);
    _searchProvider.addToSearchRecords(_record);

  }

}
// -----------------------------------------------------------------------------
void _setIsLoading(BuildContext context, bool isLoading){
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  _uiProvider.triggerLoading(setLoadingTo: isLoading);
}
// -----------------------------------------------------------------------------
void _setIsSearching(BuildContext context, bool isSearching){
  final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);

  _searchProvider.triggerIsSearching(
      searchingModel: SearchingModel.flyersAndBzz,
      setIsSearchingTo: isSearching,
  );

}
// -----------------------------------------------------------------------------
