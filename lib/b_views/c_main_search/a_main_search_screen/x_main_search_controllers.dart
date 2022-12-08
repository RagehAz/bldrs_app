import 'dart:async';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/k_statistics/record_model.dart';

import 'package:bldrs/a_models/x_secondary/search_result.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/search_provider.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/c_protocols/bz_protocols/fire/bz_search.dart' as BzFireSearch;
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_search.dart' as FlyerSearch;
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_search.dart';
import 'package:bldrs/c_protocols/user_protocols/real/user_record_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

/// INITIALIZATION

// --------------------
Future<void> initializeSearchScreen(BuildContext context) async {

  _setIsLoading(context, true);
  _setIsSearching(context, false);

  final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);
  await _searchProvider.paginateSetSearchRecords(
    context: context,
    notify: true,
  );

  _setIsLoading(context, false);
}
// -----------------------------------------------------------------------------

/// SUBMIT - CHANGE

// --------------------
Future<void> controlOnSearchSubmit({
  @required BuildContext context,
  @required String searchText,
  @required QueryDocumentSnapshot<Object> lastBzSnapshot,
  @required QueryDocumentSnapshot<Object> lastFlyerSnapshot,
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
    startAfter: lastBzSnapshot,
  );
  final List<SearchResult> _authorsResults = await _searchAuthors(
    context: context,
    searchText: searchText,
  );
  final List<SearchResult> _flyersResults = await _searchFlyersByTitle(
    context: context,
    searchText: searchText,
    startAfter: lastFlyerSnapshot,
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
// --------------------
void controlOnSearchChange({
  @required BuildContext context,
  @required String searchText,
}){

  blog('search value changed to $searchText');
  final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);

  if (searchText.isEmpty) {
    _searchProvider.clearSearchResult(
      notify: true,
    );
    _setIsSearching(context, false);
  }

  else if (searchText.length < 3){
    _setIsSearching(context, false);
  }

  else if (searchText.length >= 3){
    _setIsSearching(context, true);
  }

}
// --------------------
Future<void> onSearchRecordTap({
  @required BuildContext context,
  @required RecordModel record,
}) async {

  final String _recordText = record?.recordDetails.toString();

  if (_recordText != null){

    await controlOnSearchSubmit(
      context: context,
      searchText: _recordText,
      lastBzSnapshot: null,
      lastFlyerSnapshot: null,
    );

  }

}
// -----------------------------------------------------------------------------

/// SEARCHERS

// --------------------
/// TASK : MAKE ME
Future<List<SearchResult>> _searchKeywords({
  @required BuildContext context,
  @required String searchText,
}) async {

  final List<SearchResult> _results = <SearchResult>[];

  // final List<Map<String, dynamic>> _maps = await LDBOps.searchTrigram(
  //   searchValue: searchText,
  //   docName: LDBDoc.keywordsChain,
  //   lingoCode: Wordz.languageCode(context),
  // );
  //
  // if (Mapper.canLoopList(_maps)) {
  //
  //   final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
  //   final ChainsProvider _keywordsProvider = Provider.of<ChainsProvider>(context, listen: false);
  //
  //   final List<KW> _keywords = KW.decipherKeywordsLDBMaps(maps: _maps);
  //
  //   for (final KW kw in _keywords) {
  //     final List<FlyerModel> _flyersByKeyword =
  //     await _flyersProvider.fetchFlyersByCurrentZoneAndKeyword(
  //       context: context,
  //       kw: kw,
  //     );
  //
  //     if (_flyersByKeyword.isNotEmpty) {
  //       _results.add(SearchResult(
  //         title: Phrase.getPhraseByCurrentLangFromPhrases(context: context, phrases: kw.names)?.value,
  //         icon: _keywordsProvider.getKeywordIcon(context: context, son: kw),
  //         flyers: _flyersByKeyword,
  //       ));
  //     }
  //   }
  // }

  return _results;
}
// --------------------
/// TESTED : WORKS PERECT
Future<List<SearchResult>> _searchBzz({
  @required BuildContext context,
  @required String searchText,
  @required QueryDocumentSnapshot<Object> startAfter,
}) async {
  final List<SearchResult> _results = <SearchResult>[];

  blog('_onSearchBzz : _searchController.text : $searchText');

  final List<BzModel> _bzz = await BzFireSearch.paginateBzzBySearchingBzName(
    bzName: searchText,
    limit: 10,
    startAfter: startAfter,
  );

  if (Mapper.checkCanLoopList(_bzz)) {

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);

    for (final BzModel bz in _bzz) {
      final List<FlyerModel> _bzFlyers = await _flyersProvider
          .fetchFirstFlyersByBzModel(context: context, bz: bz);

      if (Mapper.checkCanLoopList(_bzFlyers)) {
        _results.add(SearchResult(
          title: 'Flyers by ${bz.name}',
          icon: bz.logoPath,
          flyers: _bzFlyers,
        ));
      }
    }
  }

  return _results;
}
// --------------------
Future<List<SearchResult>> _searchAuthors({
  @required BuildContext context,
  @required String searchText,
}) async {

  final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);

  final List<SearchResult> _results = <SearchResult>[];

  final List<UserModel> _users = await UserFireSearch.usersByNameAndIsAuthor(
    name: searchText,
  );

  if (Mapper.checkCanLoopList(_users)) {
    for (final UserModel user in _users) {
      /// task should get only bzz showing teams
      ///
      final List<BzModel> _userBzz = await BzProtocols.fetchBzz(
        context: context,
        bzzIDs: user.myBzzIDs,
      );

      if (Mapper.checkCanLoopList(_userBzz)) {
        for (final BzModel bz in _userBzz) {
          /// task should get only flyers showing authors
          final List<FlyerModel> _bzFlyers = await _flyersProvider
              .fetchFirstFlyersByBzModel(context: context, bz: bz);

          if (Mapper.checkCanLoopList(_bzFlyers)) {
            _results.add(SearchResult(
              title: 'Flyers from ${bz.name} published by ${user.name}',
              icon: user.picPath,
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
// --------------------
/// TASK : TEST ME
Future<List<SearchResult>> _searchFlyersByTitle({
  @required BuildContext context,
  @required String searchText,
  @required QueryDocumentSnapshot<Object> startAfter,
}) async {

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

  final List<SearchResult> _results = <SearchResult>[];

  final List<FlyerModel> _flyers = await FlyerSearch.flyersByZoneAndTitle(
    zone: _zoneProvider.currentZone,
    title: searchText,
    startAfter: startAfter,
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
// -----------------------------------------------------------------------------

/// RESULT

// --------------------
Future<void> _handleSearchResult({
  @required BuildContext context,
  @required List<SearchResult> allResults,
}) async {

  final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);

  if (allResults.isNotEmpty) {

    _searchProvider.setSearchResult(
      result: allResults,
      notify: true,
    );

  }

  else {

    _searchProvider.clearSearchResult(
      notify: true,
    );

    await TopDialog.showTopDialog(
      context: context,
      firstVerse: const Verse(
        text: 'phid_no_result_found',
        translate: true,
      ),
      secondVerse: const Verse(
        pseudo: 'Try again with different words',
        text: 'phid_try_again_with_different_words',
        translate: true,
      ),
    );

  }

}
// --------------------
Future<void> _createFireSearchRecord({
  @required BuildContext context,
  @required String searchText,
}) async {

  /// TASK : need to check if this record already exists

  if (searchText.isNotEmpty){

    final RecordModel _record = await UserRecordRealOps.createUserSearchRecord(
        searchText: searchText
    );

    if (_record != null){
      final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);
      _searchProvider.addToSearchRecords(
        record: _record,
        notify: true,
      );
    }

  }

}
// -----------------------------------------------------------------------------

/// SETTERS

// --------------------
void _setIsLoading(BuildContext context, bool isLoading){
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  _uiProvider.triggerLoading(
    setLoadingTo: isLoading,
    callerName: 'SearchController _setIsLoading',
    notify: true,
  );
}
// --------------------
void _setIsSearching(BuildContext context, bool isSearching){
  final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);

  _searchProvider.triggerIsSearching(
    searchingModel: SearchingModel.flyersAndBzz,
    setIsSearchingTo: isSearching,
    notify: true,
  );

}
// -----------------------------------------------------------------------------
