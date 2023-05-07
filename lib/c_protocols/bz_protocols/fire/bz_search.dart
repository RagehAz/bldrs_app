import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';

class BzSearch {
  // -----------------------------------------------------------------------------

  const BzSearch();

  // -----------------------------------------------------------------------------
  static FireQueryModel createQuery({
    String countryID,
    String cityID,
    BzType bzType,
    BzForm bzForm,
    String bzScopePhid,
    String bzName,
    String orderBy,
    bool descending,
    int limit = 4,
    BzAccountType bzAccountType,
    bool onlyBzzShowingTeams,
    bool onlyVerifiedBzz,
}){

    final QueryOrderBy _orderBy = orderBy == null ? null : QueryOrderBy(
      fieldName: orderBy,
      descending: descending,
    );

    return FireQueryModel(
        coll: FireColl.bzz,
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

          if (bzType != null)
            FireFinder(
              field: 'bzTypes',
              comparison: FireComparison.arrayContains,
              value: BzTyper.cipherBzType(bzType),
            ),

          if (bzScopePhid != null)
            FireFinder(
              field: 'scope',
              comparison: FireComparison.arrayContains,
              value: bzScopePhid,
            ),

          if (TextCheck.isEmpty(bzName?.trim()) == false)
            FireFinder(
                field: 'trigram',
                comparison: FireComparison.arrayContains,
                value: TextMod.removeAllCharactersAfterNumberOfCharacters(
                  input: bzName.trim(),
                  numberOfChars: Standards.maxTrigramLength,
                )),

          if (bzForm != null)
            FireFinder(
              field: 'bzForm',
              comparison: FireComparison.equalTo,
              value: BzTyper.cipherBzForm(bzForm),
            ),

          if (bzAccountType != null)
            FireFinder(
            field: 'accountType',
            comparison: FireComparison.equalTo,
            value: BzTyper.cipherBzAccountType(bzAccountType),
          ),

          if (onlyBzzShowingTeams == true)
            const FireFinder(
              field: 'showsTeam',
              comparison: FireComparison.equalTo,
              value: true,
            ),

          if (onlyVerifiedBzz == true)
            const FireFinder(
              field: 'isVerified',
              comparison: FireComparison.equalTo,
              value: true,
            ),

      ],
        // orderBy: 'score',
      );

  }
  // -----------------------------------------------------------------------------

  /// BZZ

  // --------------------
  static Future<List<BzModel>> paginateBzzBySearchingBzName({
    @required String bzName,
    @required QueryDocumentSnapshot<Object> startAfter,
    @required int limit,
  }) async {

  final List<Map<String, dynamic>> _result = await Fire.readColl(
    addDocSnapshotToEachMap: true,
    startAfter: startAfter,
    queryModel: FireQueryModel(
      coll: FireColl.bzz,
      limit: limit,
      finders: <FireFinder>[
        FireFinder(
          field: 'trigram',
          comparison: FireComparison.arrayContains,
          value: TextMod.removeAllCharactersAfterNumberOfCharacters(
            input: bzName.trim(),
            numberOfChars: Standards.maxTrigramLength,
          ),
        ),
      ],
    ),
  );

  List<BzModel> _bzz = <BzModel>[];

  if (Mapper.checkCanLoopList(_result)) {
    _bzz = BzModel.decipherBzz(
      maps: _result,
      fromJSON: false,
    );
  }

  return _bzz;
}
  // -----------------------------------------------------------------------------
}
