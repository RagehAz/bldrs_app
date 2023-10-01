import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/ldb/stages_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/real/staging_real_ops.dart';

class StagingProtocols {
  // -----------------------------------------------------------------------------

  const StagingProtocols();

  // -----------------------------------------------------------------------------

  /// FETCH COUNTRIES STAGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<StagingModel?> fetchCountriesStaging() async {

    StagingModel? _output = await StagingLDBOps.readStaging(
        id: StagingModel.countriesStagingId,
    );


    // _output?.blogStaging();

    if (StagingModel.isEmpty(_output) == true){

      _output = await StagingRealOps.readCountriesStaging();

      if (StagingModel.isEmpty(_output) == false){
        // blog('inserting staging into ldb');
        await StagingLDBOps.insertStaging(staging: _output,);
      //   blog('non no no no');
      // _output.blogStaging();
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<StagingModel?> refetchCountiesStaging() async {

    await StagingLDBOps.deleteStaging(id: StagingModel.countriesStagingId);

    final StagingModel? _output = await fetchCountriesStaging();

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FETCH CITIES STAGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<StagingModel?> fetchCitiesStaging({
    required String? countryID,
    required String invoker,
  }) async {
    StagingModel? _output;

    blog('fetchCitiesStaging : $invoker : countryID : $countryID');

    if (countryID != null){

      _output = await StagingLDBOps.readStaging(id: countryID);

      if (StagingModel.isEmpty(_output) == true){

        _output = await StagingRealOps.readCitiesStaging(countryID: countryID);

        if (StagingModel.isEmpty(_output) == false){
          await StagingLDBOps.insertStaging(staging: _output);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<StagingModel?> refetchCitiesStaging({
    required String? countryID,
  }) async {
    StagingModel? _output;

    if (countryID != null){
      await StagingLDBOps.deleteStaging(id: countryID,);
      _output = await fetchCitiesStaging(
        countryID: countryID,
        invoker: 'refetchCitiesStaging',
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TASK : TEST ME
  static Future<void> renovateCountriesStaging({
    required StagingModel? newStaging,
  }) async {

    if (newStaging != null){

      await Future.wait(<Future>[

        /// REAL
        StagingRealOps.updateCountriesStaging(
          newStaging: newStaging,
        ),

        /// LDB
        StagingLDBOps.insertStaging(
          staging: newStaging,
        ),

      ]);

    }

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> renovateCitiesStaging({
    required StagingModel? newStaging,
  }) async {

    if (newStaging != null){

      await Future.wait(<Future>[

        /// REAL
        StagingRealOps.updateCitiesStaging(
            citiesStages: newStaging,
        ),

        /// LDB
        StagingLDBOps.insertStaging(
            staging: newStaging,
        ),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// TASK : TEST ME
  static Future<void> removeCityFromStages({
    required String? cityID,
  }) async {

    if (cityID != null){

      final StagingModel? _oldCitiesStaging = await StagingProtocols.fetchCitiesStaging(
        countryID: CityModel.getCountryIDFromCityID(cityID),
        invoker: 'removeCityFromStages',
      );

      if (_oldCitiesStaging != null){

        final StagingModel? _new = StagingModel.removeIDFromStaging(
          staging: _oldCitiesStaging,
          id: cityID,
        );

        await StagingProtocols.renovateCitiesStaging(
          newStaging: _new,
        );

      }

    }

  }
  // -----------------------------------------------------------------------------
}
