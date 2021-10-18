import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/models/helpers/app_updates.dart';
import 'package:bldrs/models/keywords/groups.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/providers/flyers_provider.dart';
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
  Future<void> fetchAppState(BuildContext context) async {

    final Map<String, dynamic> _map = await Fire.readDoc(
      context: context,
      collName: FireColl.admin,
      docName: FireColl.admin_appState,
    );

    final AppState _updates = AppState.fromMap(_map);

    _appState = _updates;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  /// SECTION & GROUPS
  Section _currentSection;
// -------------------------------------
  Section get currentSection {
    return _currentSection ?? Section.Designs;
  }
// -------------------------------------
  Future<void> changeSection(BuildContext context, Section section) async {
    print('Changing section to $section');

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    await _flyersProvider.getsetWallFlyersBySection(context: context, section: section);

    _currentSection = section;
    setSectionGroups();

    // notifyListeners();
  }
// -------------------------------------
  List<Group> _sectionGroups;
// -------------------------------------
  List<Group> get sectionGroups {
    return <Group>[..._sectionGroups];
  }
// -------------------------------------
  void setSectionGroups(){

    final List<Group> _groupsBySection = Group.getGroupBySection(
      section: _currentSection,
    );

    _sectionGroups = _groupsBySection;
  }
// -----------------------------------------------------------------------------
}