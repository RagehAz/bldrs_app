import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/e_db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/e_db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
class UsersProvider extends ChangeNotifier {
// -------------------------------------

  /// FETCHING USER

// -------------------------------------
  Future<UserModel> fetchUserByID({
    @required BuildContext context,
    @required String userID
  }) async {
    UserModel _userModel;

    /// 1 - search in entire LDBs for this userModel
    for (final String doc in LDBDoc.userModelsDocs) {
      final Map<String, Object> _map = await LDBOps.searchFirstMap(
        docName: doc,
        fieldToSortBy: 'id',
        searchField: 'id',
        searchValue: userID,
      );

      if (_map != null && _map != <String, dynamic>{}) {
        blog('fetchUserModelByID : UserModel found in local db : $doc');
        _userModel = UserModel.decipherUserMap(map: _map, fromJSON: true);
        break;
      }
    }

    /// 2 - if not found, search firebase
    if (_userModel == null) {
      blog('fetchUserModelByID : UserModel NOT found in local db');

      /// 2.1 read firebase UserOps
      _userModel = await UserFireOps.readUser(
        context: context,
        userID: userID,
      );

      /// 2.2 if found on firebase, store in ldb sessionUsers
      if (_userModel != null) {
        blog('fetchUserModelByID : UserModel found in firestore db');

        await LDBOps.insertMap(
          input: _userModel.toMap(toJSON: true),
          docName: LDBDoc.users,
          primaryKey: 'id',
        );
      }
    }

    return _userModel;
  }
// // -------------------------------------
//   /// fetch Users By IDs
//   Future<List<UserModel>> _fetchUsersByIDs({BuildContext context, List<String> usersIDs}) async {
//     List<UserModel> _userModels = <UserModel>[];
//
//     if (usersIDs != null && usersIDs.isNotEmpty){
//
//       for (String userID in usersIDs){
//
//         final UserModel _userModel = await _fetchUserByID(context: context, userID: userID);
//
//         if (_userModel != null){
//
//           _userModels.add(_userModel);
//
//         }
//
//       }
//
//     }
//
//     return _userModels;
//   }

// -----------------------------------------------------------------------------

  /// MY USER MODEL

// -------------------------------------
  UserModel _myUserModel; //UserModel.initializeUserModelStreamFromUser(superFirebaseUser()); needs to be null if didn't find the userModel
  CountryModel _myUserCountry;
  CityModel _myUserCity;
// -------------------------------------
  UserModel get myUserModel =>_myUserModel;
  CountryModel get myUserCountry => _myUserCountry;
  CityModel get myUserCity => _myUserCity;
// -------------------------------------
  Future<void> getsetMyUserModelAndCountryAndCity(BuildContext context) async {
    UserModel _userModel;
    CountryModel _userCountry;
    CityModel _userCity;

    final String _myUserID = FireAuthOps.superUserID();

    if (_myUserID != null) {
      _userModel = await fetchUserByID(context: context, userID: _myUserID);

      final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
      _userCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: _userModel.zone.countryID);
      _userCity = await _zoneProvider.fetchCityByID(context: context, cityID: _userModel.zone.cityID);

      blog('_userCountry is ${_userCountry.id} ahoooooooooooooo');
      blog('_userCity is ${_userCity.cityID} ahoooooooooooooo');

      setMyUserModelAndCountryAndCity(
        userModel: _userModel,
        countryModel: _userCountry,
        cityModel: _userCity,
      );

    }

  }
// -------------------------------------
  void setMyUserModelAndCountryAndCity({
    @required UserModel userModel,
    @required CountryModel countryModel,
    @required CityModel cityModel,
  }){
    _myUserModel = userModel;
    _myUserCountry = countryModel;
    _myUserCity = cityModel;
    notifyListeners();
  }
// -------------------------------------
  void clearMyUserModelAndCountryAndCity(){
    setMyUserModelAndCountryAndCity(
      userModel: null,
      countryModel: null,
      cityModel: null,
    );
  }
// -----------------------------------------------------------------------------

  /// USER STREAM

// // -------------------------------------
//   Stream<UserModel> get myUserModelStream {
//     final CollectionReference<Object> _userCollection = UserFireOps.collRef();
//     final Stream<UserModel> _stream = _userCollection
//         .doc(_myUserModel?.id)
//         .snapshots()
//         .map(_userModelFromSnapshot);
//     return _stream;
//   }
// // -------------------------------------
//   static UserModel _userModelFromSnapshot(DocumentSnapshot<Object> doc) {
//     UserModel _userModel;
//
//     if (doc != null) {
//       try {
//         final Map<String, dynamic> _map = doc.data() as Map<String, dynamic>;
//
//         _userModel = UserModel.decipherUserMap(map: _map, fromJSON: false);
//       } on Exception catch (error) {
//         blog('_userModelFromSnapshot error is : $error');
//         rethrow;
//       }
//     }
//
//     return _userModel;
//   }
// // -----------------------------------------------------------------------------

}
