import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/protocols/staging_protocols.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
/// => TAMAM
class CountryRealOps {
  // -----------------------------------------------------------------------------

  const CountryRealOps();

  // -----------------------------------------------------------------------------

  /// READ COUNTRY MODEL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CountryModel?> readCountry({
    required String? countryID,
  }) async {
    CountryModel? _output;

    final StagingModel? _citiesIDs = await StagingProtocols.fetchCitiesStaging(
      countryID: countryID,
      invoker: 'readCountry'
    );

    if (_citiesIDs != null){
      _output = CountryModel(
        id: countryID,
        citiesIDs: _citiesIDs,
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
