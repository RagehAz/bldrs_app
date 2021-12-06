import 'package:bldrs/db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/db/fire/methods/paths.dart';
import 'package:bldrs/models/kw/section_class.dart' as SectionClass;
import 'package:bldrs/models/secondary_models/app_updates.dart';
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
  /// SECTION & GROUPS
  SectionClass.Section _currentSection;
// -------------------------------------
  SectionClass.Section get currentSection {
    return _currentSection ?? SectionClass.Section.designs;
  }
// -------------------------------------
  Future<void> changeSection(BuildContext context, SectionClass.Section section) async {
    print('Changing section to $section');

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    await _flyersProvider.getsetWallFlyersBySection(context: context, section: section);

    _currentSection = section;
    // setSectionGroups();

    notifyListeners();
  }
// -------------------------------------
//   List<GroupModel> _sectionGroups;
// // -------------------------------------
//   List<GroupModel> get sectionGroups {
//     return <GroupModel>[..._sectionGroups];
//   }
// // -------------------------------------
//   void setSectionGroups(){
//
//     final List<GroupModel> _groupsBySection = GroupModel.getGroupBySection(
//       section: _currentSection,
//     );
//
//     _sectionGroups = _groupsBySection;
//   }
// -----------------------------------------------------------------------------
}
