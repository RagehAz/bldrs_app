import 'package:bldrs/a_models/d_zone/b_country/country_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
/// => TAMAM
class CountryLDBOps {
  // -----------------------------------------------------------------------------

  const CountryLDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE / INSERT / UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertCountry(CountryModel? country) async {

    await LDBOps.insertMap(
      docName: LDBDoc.countries,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.countries),
      input: country?.toMap(
        toLDB: true,
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CountryModel?> readCountry(String? countryID) async {

    final Map<String, Object?>? _map = await LDBOps.searchFirstMap(
      docName: LDBDoc.countries,
      sortFieldName: 'id',
      searchFieldName: 'id',
      searchValue: countryID,
    );

    final CountryModel? _country  = CountryModel.decipherCountryMap(
      map: _map,
    );

    return _country;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteCountry(String countryID) async {

    await LDBOps.deleteMap(
      docName: LDBDoc.countries,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.countries),
      objectID: countryID,
    );

  }
  // -----------------------------------------------------------------------------
}
