import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/m_search/search_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:fire/super_fire.dart';

/// => TAMAM
class BzSearch {
  // -----------------------------------------------------------------------------

  const BzSearch();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static FireQueryModel createQuery({
    SearchModel? searchModel,
    String? bzName,
    String? bzID,
    String? orderBy = 'createdAt',
    bool descending = true,
    int limit = 4,
  }){

    final QueryOrderBy? _orderBy = orderBy == null || bzID != null ? null : QueryOrderBy(
      fieldName: orderBy,
      descending: descending,
    );

    return FireQueryModel(
        coll: FireColl.bzz,
        orderBy: _orderBy,
        limit: limit,
        // idFieldName: 'id',
        finders: <FireFinder>[

          if (bzID != null)
            FireFinder(
              field: 'id',
              comparison: FireComparison.equalTo,
              value: bzID,
            ),

          if (SearchModel.checkCanSearchByCountry(countryID: searchModel?.zone?.countryID) == true)
            FireFinder(
              field: 'zone.countryID',
              comparison: FireComparison.equalTo,
              value: searchModel?.zone?.countryID,
            ),

          if (SearchModel.checkCanSearchByCity(cityID: searchModel?.zone?.cityID) == true)
            FireFinder(
              field: 'zone.cityID',
              comparison: FireComparison.equalTo,
              value: searchModel?.zone?.cityID,
            ),

          if (searchModel?.bzSearchModel?.bzType != null)
            FireFinder(
              field: 'bzTypes.${BzTyper.cipherBzType(searchModel?.bzSearchModel?.bzType)}',
              comparison: FireComparison.equalTo,
              value: true,
            ),

          if (searchModel?.bzSearchModel?.scopePhid != null)
            FireFinder(
              field: 'scope.${searchModel?.bzSearchModel?.scopePhid}',
              comparison: FireComparison.equalTo,
              value: true,
            ),

          if (TextCheck.isEmpty(bzName?.trim()) == false)
            FireFinder(
                field: 'trigram',
                comparison: FireComparison.arrayContains,
                value: TextMod.removeAllCharactersAfterNumberOfCharacters(
                  text: bzName!.trim(),
                  numberOfChars: Standards.maxTrigramLength,
                )),

          if (searchModel?.bzSearchModel?.bzForm != null)
            FireFinder(
              field: 'bzForm',
              comparison: FireComparison.equalTo,
              value: BzTyper.cipherBzForm(searchModel?.bzSearchModel?.bzForm),
            ),

          if (searchModel?.bzSearchModel?.bzAccountType != null)
            FireFinder(
            field: 'accountType',
            comparison: FireComparison.equalTo,
            value: BzTyper.cipherBzAccountType(searchModel?.bzSearchModel?.bzAccountType),
          ),

          if (Mapper.boolIsTrue(searchModel?.bzSearchModel?.onlyShowingTeams) == true)
            const FireFinder(
              field: 'showsTeam',
              comparison: FireComparison.equalTo,
              value: true,
            ),

          if (Mapper.boolIsTrue(searchModel?.bzSearchModel?.onlyVerified) == true)
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
  /// TESTED : WORKS PERFECT
  static Future<List<BzModel>> paginateBzzBySearchingBzName({
    required String? bzName,
    required QueryDocumentSnapshot<Object>? startAfter,
    required int limit,
  }) async {

  final List<Map<String, dynamic>>? _result = await Fire.readColl(
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
            text: bzName?.trim(),
            numberOfChars: Standards.maxTrigramLength,
          ),
        ),
      ],
    ),
  );

  List<BzModel> _bzz = <BzModel>[];

  if (Lister.checkCanLoop(_result)) {
    _bzz = BzModel.decipherBzz(
      maps: _result,
      fromJSON: false,
    );
  }

  return _bzz;
}
  // -----------------------------------------------------------------------------
}
