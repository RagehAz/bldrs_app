import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';

class DistrictLDBOps {
  // -----------------------------------------------------------------------------

  const DistrictLDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE / INSERT

  // --------------------
  /// TASK : TEST ME
  static Future<void> insertDistrict(DistrictModel districtModel) async {

    await LDBOps.insertMap(
      docName: LDBDoc.districts,
      input: districtModel?.toMap(
        toJSON: true,
        toLDB: true,
      ),
    );

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> insertDistricts(List<DistrictModel> districts) async {

    if (Mapper.checkCanLoopList(districts) == true){

      await LDBOps.insertMaps(
        docName: LDBDoc.districts,
        inputs: DistrictModel.cipherDistrictsMaps(
          districts: districts,
          toLDB: true,
          toJSON: true,
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TASK : TEST ME
  static Future<DistrictModel> readDistrict(String districtID) async {

    final Map<String, Object> _map = await LDBOps.searchFirstMap(
      docName: LDBDoc.districts,
      sortFieldName: 'id',
      searchFieldName: 'id',
      searchValue: districtID,
    );

    final DistrictModel _district = DistrictModel.decipherDistrict(
      map: _map,
      districtID: districtID,
    );

    return _district;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<List<DistrictModel>> readDistricts(List<String> districtsIDs) async {
    List<DistrictModel> _output = <DistrictModel>[];

    if (Mapper.checkCanLoopList(districtsIDs) == true){

      final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
        docName: LDBDoc.districts,
        ids: districtsIDs,
      );

      _output = DistrictModel.decipherDistrictsMaps(_maps);

    }

    return _output;
  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static Future<List<DistrictModel>> searchCitiesByName({
    @required String cityName,
    @required String langCode,
  }) async {

    final List<Map<String, dynamic>> _foundMaps = await LDBOps.searchLDBDocTrigram(
      searchValue: cityName,
      docName: LDBDoc.cities,
      lingoCode: langCode,
    );

    final List<CityModel> _foundCities = CityModel.decipherCities(
      maps: _foundMaps,

      fromJSON: true,
    );

    return _foundCities;
  }
   */
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  ///
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///
  // -----------------------------------------------------------------------------
}
