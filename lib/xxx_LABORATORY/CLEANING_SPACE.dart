
/// OLD PROVIDERS SHIT TO DELETE WHEN EVERYTHING WORK ISA
// // -----------------------------------------------------------------------------
// List<TinyBz> _sponsors;
// List<TinyBz> get getSponsors {
//   return <TinyBz> [..._sponsors];
// }
// /// TASK : sponsors tiny bzz should depend on which city
// Future<void> fetchAndSetSponsors(BuildContext context) async {
//
//   print('fetching sponsors');
//
//   /// 1 - get sponsors map from db/admin/sponsors
//   final Map<String, dynamic> _sponsorsIDsMap = await Fire.readDoc(
//     context: context,
//     collName: FireCollection.admin,
//     docName: FireCollection.admin_sponsors,
//   );
//
//   /// 2 - transform sponsors map into list<String>
//   final List<String> _sponsorsIDs = TextMod.getValuesFromValueAndTrueMap(_sponsorsIDsMap);
//
//   /// 3- get tinyBz for each id
//   final List<TinyBz> _sponsorsTinyBzz = <TinyBz>[];
//   for (var id in _sponsorsIDs){
//     final TinyBz _tinyBz = await BzOps.readTinyBzOps(context: context, bzID: id);
//     _sponsorsTinyBzz.add(_tinyBz);
//   }
//
//   _sponsors = _sponsorsTinyBzz;
//   print('Bldrs ${_sponsors.length} Sponsors are ${_sponsors.toString()}');
//   notifyListeners();
// }
// // -----------------------------------------------------------------------------
// List<TinyBz> _userTinyBzz;
// List<TinyBz> get getUserTinyBzz {
//   // print('getting user tiny bzz');
//   return <TinyBz> [..._userTinyBzz];
// }
// /// if a user is an Author, this READs & sets user tiny bzz form db/users/userID['myBzzIDs']
// Future<void> fetchAndSetUserTinyBzz(BuildContext context) async {
//   final String _userID = superUserID();
//
//   final Map<String, dynamic> _userMap = await Fire.readDoc(
//     context: context,
//     collName: FireCollection.users,
//     docName: _userID,
//   );
//
//   final UserModel _userModel = UserModel.decipherUserMap(_userMap);
//
//   final List<dynamic> _userBzzIDs = _userModel.myBzzIDs;
//
//   final List<TinyBz> _userTinyBzzList = <TinyBz>[];
//
//   for (var id in _userBzzIDs){
//     final dynamic _tinyBzMap = await Fire.readDoc(
//       context: context,
//       collName: FireCollection.tinyBzz,
//       docName: id,
//     );
//
//     if (_tinyBzMap != null){
//       final TinyBz _tinyBz = TinyBz.decipherTinyBzMap(_tinyBzMap);
//       _userTinyBzzList.add(_tinyBz);
//     }
//
//   }
//
//   _userTinyBzz = _userTinyBzzList;
//   notifyListeners();
// }
// // -----------------------------------------------------------------------------
// void removeTinyBzFromLocalUserTinyBzz(String bzID){
//   if (_loadedTinyBzz != null){
//     final int _index = _userTinyBzz.indexWhere((tinyBz) => tinyBz.bzID == bzID);
//     _userTinyBzz.removeAt(_index);
//     notifyListeners();
//   }
// }
// //-----------------------------------------------------------------------------
// List<TinyFlyer> _loadedSavedTinyFlyers;
// List<TinyFlyer> get getSavedTinyFlyers {
//   return <TinyFlyer>[..._loadedSavedTinyFlyers];
// }
// /// READs and sets  db/users/userID/saves/flyers document
// Future<void> fetchAndSetSavedFlyers(BuildContext context) async {
//
//   // /// read user's saves doc
//   // final List<SaveModel> _userSaveModels = await RecordOps.readUserSavesOps(context);
//
//   /// from saveModels, get a list of saved tinyFlyers
//   final List<TinyFlyer> _savedTinyFlyers = <TinyFlyer>[];
//
//   // if (_userSaveModels != null || _userSaveModels?.length != 0){
//   //   for (var saveModel in _userSaveModels){
//   //     if (saveModel.saveState == SaveState.Saved) {
//   //       final TinyFlyer _tinyFlyer = await FlyerOps().readTinyFlyerOps(context: context, flyerID: saveModel.flyerID);
//   //
//   //       if (_tinyFlyer != null){
//   //         _savedTinyFlyers.add(_tinyFlyer);
//   //       }
//   //
//   //     }
//   //   }
//   // }
//
//   /// assign the value to local variable
//   _loadedSavedTinyFlyers = _savedTinyFlyers;
//
//   notifyListeners();
//   print('_loadedSavedFlyers :::: --------------- ${_loadedSavedTinyFlyers.toString()}');
//
// }
// //-----------------------------------------------------------------------------
// List<String> _loadedFollows;
// List<String> get getFollows{
//   return <String>[..._loadedFollows];
// }
// /// READs and sets db/users/userID/saves/bzz document
// Future<void> fetchAndSetFollows(BuildContext context) async {
//
//   // /// read user's follows list
//   // final List<String> _follows = await RecordOps.readUserFollowsOps(context);
//
//   _loadedFollows =
//   // _follows ??
//   <String>[];
//
//   print('_loadedFollows = $_loadedFollows');
//   notifyListeners();
// }
// void updatedFollowsInLocalList(List<String> updatedFollows){
//   _loadedFollows = updatedFollows;
//   notifyListeners();
// }
// //-----------------------------------------------------------------------------
// Section _currentSection;
// List<Group> _sectionGroups;
// Section get getCurrentSection {
//   return _currentSection ?? Section.NewProperties;
// }
// List<Group> get getSectionFilters {
//   return <Group>[..._sectionGroups];
// }
// Future<void> changeSection(BuildContext context, Section section) async {
//   print('Changing section to $section');
//   _currentSection = section;
//
//   _setSectionFilters();
//
//   await fetchAndSetTinyFlyersBySection(context, section);
//
//   // notifyListeners();
// }
// void _setSectionFilters(){
//   final List<Group> _filtersBySection = Group.getGroupBySection(
//     section: _currentSection,
//   );
//   _sectionGroups = _filtersBySection;
// }
// //-----------------------------------------------------------------------------
