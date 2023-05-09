import 'package:bldrs/a_models/a_user/sub/need_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/m_search/user_search_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';

class UserFireSearchOps{
  // -----------------------------------------------------------------------------

  const UserFireSearchOps();

  // -----------------------------------------------------------------------------
  static FireQueryModel createQuery({
    String countryID,
    String cityID,
    String orderBy,
    bool descending,
    int limit = 4,
    UserSearchType searchType,
    String searchText,
    SignInMethod signInMethod,
    NeedType needType,
    Gender gender,
    String userLanguage,
    String devicePlatform,
    bool onlyUsersWithPublicContacts = false,
    bool onlyBzAuthors = false,
    bool onlyBldrsAdmins = false,
    bool onlyUsersWithVerifiedEmails = false,
  }){

    final QueryOrderBy _orderBy = orderBy == null ? null : QueryOrderBy(
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

          if (countryID != null)
            FireFinder(
              field: 'zone.countryID',
              comparison: FireComparison.equalTo,
              value: countryID,
            ),

          if (cityID != null)
            FireFinder(
              field: 'zone.cityID',
              comparison: FireComparison.equalTo,
              value: cityID,
            ),

          if (searchType == UserSearchType.byName && _canSearchText == true)
            FireFinder(
                field: 'trigram',
                comparison: FireComparison.arrayContains,
                value: TextMod.removeAllCharactersAfterNumberOfCharacters(
                  input: searchText.trim(),
                  numberOfChars: Standards.maxTrigramLength,
                )),

          if (searchType == UserSearchType.byCompanyName && _canSearchText == true)
            FireFinder(
                field: 'company',
                comparison: FireComparison.equalTo,
                value: searchText.trim(),
            ),

          if (searchType == UserSearchType.byJobTitle && _canSearchText == true)
            FireFinder(
                field: 'title',
                comparison: FireComparison.equalTo,
                value: searchText.trim(),
            ),

          if (searchType == UserSearchType.byEmail && _canSearchText == true)
            FireFinder(
                field: 'contacts.email',
                comparison: FireComparison.equalTo,
                value: searchText.trim(),
            ),

          if (searchType == UserSearchType.byPhone && _canSearchText == true)
            FireFinder(
                field: 'contacts.phone',
                comparison: FireComparison.equalTo,
                value: searchText.trim(),
            ),

          if (searchType == UserSearchType.byDeviceID && _canSearchText == true)
            FireFinder(
                field: 'device.id',
                comparison: FireComparison.equalTo,
                value: searchText.trim(),
            ),

          if (signInMethod != null)
            FireFinder(
                field: 'signInMethod',
                comparison: FireComparison.equalTo,
                value: AuthModel.cipherSignInMethod(signInMethod),
            ),

          if (needType != null)
            FireFinder(
                field: 'need.needType',
                comparison: FireComparison.equalTo,
                value: NeedModel.cipherNeedType(needType),
            ),

          if (gender != null)
            FireFinder(
                field: 'gender',
                comparison: FireComparison.equalTo,
                value: UserModel.cipherGender(gender),
            ),

          if (TextCheck.isEmpty(userLanguage) == false)
            FireFinder(
                field: 'language',
                comparison: FireComparison.equalTo,
                value: userLanguage,
            ),

          if (onlyUsersWithPublicContacts == true)
            const FireFinder(
                field: 'contactsArePublic',
                comparison: FireComparison.equalTo,
                value: true,
            ),

          if (onlyBzAuthors == true)
            const FireFinder(
              field: 'myBzzIDs',
              comparison: FireComparison.notEqualTo,
              value: <String>[],
            ),

          if (onlyBldrsAdmins == true)
            const FireFinder(
              field: 'isAdmin',
              comparison: FireComparison.equalTo,
              value: true,
            ),

          if (devicePlatform != null)
            FireFinder(
              field: 'device.platform',
              comparison: FireComparison.equalTo,
              value: devicePlatform,
            ),

          if (onlyUsersWithVerifiedEmails == true)
            const FireFinder(
              field: 'emailIsVerified',
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
    @required String name,
    @required List<String> userIDsToExclude,
    QueryDocumentSnapshot<Object> startAfter,
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
    @required String name,
    int limit = 3,
    QueryDocumentSnapshot<Object> startAfter,
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
          field: 'myBzzIDs',
          comparison: FireComparison.notEqualTo,
          value: <String>[],
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
