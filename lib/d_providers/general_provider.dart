import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/kw/section_class.dart' as SectionClass;
import 'package:bldrs/a_models/secondary_models/app_updates.dart';
import 'package:bldrs/a_models/secondary_models/search_result.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
class GeneralProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------
  /// APP STATE
  AppState _appState = AppState.initialState();
// -------------------------------------
  AppState get appState {
    return _appState;
  }
// -------------------------------------
  Future<void> getsetAppState(BuildContext context) async {
    final Map<String, dynamic> _map = await Fire.readDoc(
      context: context,
      collName: FireColl.admin,
      docName: FireDoc.admin_appState,
    );

    final AppState _updates = AppState.fromMap(_map);

    _appState = _updates;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  /// SELECTED SECTION
  SectionClass.Section _currentSection;
// -------------------------------------
  SectionClass.Section get currentSection {
    return _currentSection ?? SectionClass.Section.designs;
  }
// -------------------------------------
  /// SELECTED KEYWORD
  KW _currentKeyword;
// -------------------------------------
  KW get currentKeyword {
    return _currentKeyword;
  }
// -------------------------------------
  Future<void> changeSection({
    @required BuildContext context,
    @required SectionClass.Section section,
    @required KW kw,
  }) async {
    blog('Changing section to $section');

    final FlyersProvider _flyersProvider =
        Provider.of<FlyersProvider>(context, listen: false);
    await _flyersProvider.getsetWallFlyersBySectionAndKeyword(
      context: context,
      section: section,
      kw: kw,
    );

    _currentSection = section;
    _currentKeyword = kw;
    // setSectionGroups();

    notifyListeners();
  }
// -----------------------------------------------------------------------------
  /// SEARCH RESULT
  List<SearchResult> _searchResult = <SearchResult>[];
// -------------------------------------
  List<SearchResult> get searchResult {
    return [..._searchResult];
  }
// -------------------------------------
  void setSearchResult (List<SearchResult> result){

    _searchResult = result;
    notifyListeners();

  }
// -----------------------------------------------------------------------------

}
