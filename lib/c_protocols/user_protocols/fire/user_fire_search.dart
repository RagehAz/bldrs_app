import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:bldrs/a_models/a_user/sub/need_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/m_search/search_model.dart';
import 'package:bldrs/a_models/m_search/user_search_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:fire/super_fire.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';

class UserFireSearchOps{
  // -----------------------------------------------------------------------------

  const UserFireSearchOps();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static FireQueryModel createQuery({
    String? orderBy,
    bool descending = true,
    int limit = 4,
    String? searchText,
    UserSearchModel? userSearchModel,
    ZoneModel? zoneModel,
  }){

    final QueryOrderBy? _orderBy = orderBy == null ? null : QueryOrderBy(
      fieldName: orderBy,
      descending: descending,
    );

    final bool _canSearchText = TextCheck.isEmpty(searchText) == false;

    return FireQueryModel(
        coll: FireColl.users,
        orderBy: _orderBy,
        limit: limit,
        // idFieldName: 'id',
        finders: <FireFinder>[

          if (SearchModel.checkCanSearchByCountry(countryID: zoneModel?.countryID) == true)
            FireFinder(
              field: 'zone.countryID',
              comparison: FireComparison.equalTo,
              value: zoneModel?.countryID,
            ),

          if (SearchModel.checkCanSearchByCity(cityID: zoneModel?.cityID) == true)
            FireFinder(
              field: 'zone.cityID',
              comparison: FireComparison.equalTo,
              value: zoneModel?.cityID,
            ),

          if (userSearchModel?.searchType == UserSearchType.byName && _canSearchText == true)
            FireFinder(
                field: 'trigram',
                comparison: FireComparison.arrayContains,
                value: TextMod.removeAllCharactersAfterNumberOfCharacters(
                  text: searchText?.trim(),
                  numberOfChars: Standards.maxTrigramLength,
                )),

          if (userSearchModel?.searchType == UserSearchType.byCompanyName && _canSearchText == true)
            FireFinder(
                field: 'company',
                comparison: FireComparison.equalTo,
                value: searchText?.trim(),
            ),

          if (userSearchModel?.searchType == UserSearchType.byJobTitle && _canSearchText == true)
            FireFinder(
                field: 'title',
                comparison: FireComparison.equalTo,
                value: searchText?.trim(),
            ),

          if (userSearchModel?.searchType == UserSearchType.byEmail && _canSearchText == true)
            FireFinder(
                field: 'contacts.email',
                comparison: FireComparison.equalTo,
                value: searchText?.trim(),
            ),

          if (userSearchModel?.searchType == UserSearchType.byPhone && _canSearchText == true)
            FireFinder(
                field: 'contacts.phone',
                comparison: FireComparison.equalTo,
                value: searchText?.trim(),
            ),

          if (userSearchModel?.searchType == UserSearchType.byDeviceID && _canSearchText == true)
            FireFinder(
                field: 'device.id',
                comparison: FireComparison.equalTo,
                value: searchText?.trim(),
            ),

          if (userSearchModel?.signInMethod != null)
            FireFinder(
                field: 'signInMethod',
                comparison: FireComparison.equalTo,
                value: AuthModel.cipherSignInMethod(userSearchModel?.signInMethod),
            ),

          if (userSearchModel?.needType != null)
            FireFinder(
                field: 'need.needType',
                comparison: FireComparison.equalTo,
                value: NeedModel.cipherNeedType(userSearchModel?.needType),
            ),

          if (userSearchModel?.gender != null)
            FireFinder(
                field: 'gender',
                comparison: FireComparison.equalTo,
                value: UserModel.cipherGender(userSearchModel?.gender),
            ),

          if (TextCheck.isEmpty(userSearchModel?.language) == false)
            FireFinder(
                field: 'language',
                comparison: FireComparison.equalTo,
                value: userSearchModel?.language,
            ),

          if (Mapper.boolIsTrue(userSearchModel?.onlyWithPublicContacts) == true)
            const FireFinder(
                field: 'contactsArePublic',
                comparison: FireComparison.equalTo,
                value: true,
            ),

          if (Mapper.boolIsTrue(userSearchModel?.onlyBzAuthors) == true)
            const FireFinder(
              field: 'isAuthor',
              comparison: FireComparison.equalTo,
              value: true,
            ),

          if (Mapper.boolIsTrue(userSearchModel?.onlyBldrsAdmins) == true)
            const FireFinder(
              field: 'isAdmin',
              comparison: FireComparison.equalTo,
              value: true,
            ),

          if (userSearchModel?.devicePlatform != null)
            FireFinder(
              field: 'device.platform',
              comparison: FireComparison.equalTo,
              value: userSearchModel?.devicePlatform,
            ),

          if (Mapper.boolIsTrue(userSearchModel?.onlyVerifiedEmails) == true)
            const FireFinder(
              field: 'emailIsVerified',
              comparison: FireComparison.equalTo,
              value: true,
            ),

          if (Mapper.boolIsTrue(userSearchModel?.onlyCanReceiveNotification) == true)
            const FireFinder(
              field: 'device.canBeNotified',
              comparison: FireComparison.equalTo,
              value: true,
            ),

      ],
        // orderBy: 'score',
      );

  }
  // -----------------------------------------------------------------------------

  /// USERS

  // --------------------
  /// TASK : TEST ME
  static Future<List<UserModel>> usersByUserName({
    required String? name,
    required List<String> userIDsToExclude,
    QueryDocumentSnapshot<Object>? startAfter,
    int limit = 10,
  }) async {

    final List<Map<String, dynamic>> _result = await Fire.readColl(
      addDocSnapshotToEachMap: true,
      startAfter: startAfter,
      queryModel: FireQueryModel(
        coll: FireColl.users,
        limit: limit,
        finders: <FireFinder>[
          FireFinder(
            field: 'trigram',
            comparison: FireComparison.arrayContains,
            value: name?.trim(),
          ),
        ],
      ),
    );

    List<UserModel> _usersModels = <UserModel>[];

    if (Mapper.checkCanLoopList(_result) == true) {
      _usersModels = UserModel.decipherUsers(
        maps: _result,
        fromJSON: false,
      );
    }

    if (Mapper.checkCanLoopList(userIDsToExclude) == true){
      for (final String userID in userIDsToExclude){
        _usersModels.removeWhere((user) => user.id == userID);
      }
    }

    return _usersModels;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<List<UserModel>> usersByNameAndIsAuthor({
    required String? name,
    int limit = 3,
    QueryDocumentSnapshot<Object>? startAfter,
  }) async {

    final List<Map<String, dynamic>> _result = await Fire.readColl(
      addDocSnapshotToEachMap: true,
      startAfter: startAfter,
      // orderBy: const QueryOrderBy(fieldName: 'trigram', descending: false),
      queryModel: FireQueryModel(
        coll: FireColl.users,
        limit: limit,
        finders: <FireFinder>[

        const FireFinder(
          field: 'isAuthor',
          comparison: FireComparison.equalTo,
          value: true,
        ),

      if (name != null)
        FireFinder(
          field: 'trigram',
          comparison: FireComparison.arrayContains,
          value: name.trim(),
        ),
      ],
      ),
    );

    List<UserModel> _usersModels = <UserModel>[];

    if (Mapper.checkCanLoopList(_result)) {
      _usersModels = UserModel.decipherUsers(
        maps: _result,
        fromJSON: false,
      );
    }

    return _usersModels;
  }
  // -----------------------------------------------------------------------------
}
