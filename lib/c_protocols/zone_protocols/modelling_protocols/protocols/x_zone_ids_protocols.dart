import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/b_country/country_model.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:stringer/stringer.dart';
/// => GEOLOCATOR_DOES_NOT_WORK
// import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/b_zone_search_protocols.dart';
// import 'package:bldrs/c_protocols/zone_protocols/positioning_protocols/geo_location/location_ops.dart';
// import 'package:bldrs/f_helpers/theme/standards.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:mapper/mapper.dart';
/// => TAMAM
class ZoneIDsProtocols {
  // -----------------------------------------------------------------------------

  const ZoneIDsProtocols();

  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneModel> fetchZoneModelByGeoPoint({
    @required BuildContext context,
    @required GeoPoint geoPoint
  }) async {

    ZoneModel _zoneModel;

    /// GEOLOCATOR_DOES_NOT_WORK
    // if (geoPoint != null){
    //
    //   final List<Placemark> _marks = await LocationOps.getPlaceMarksFromGeoPoint(geoPoint: geoPoint);
    //
    //   // blog('_getCountryData : got place marks : ${_marks.length}');
    //
    //   if (Mapper.checkCanLoopList(_marks) == true){
    //
    //     final Placemark _mark = _marks[0];
    //
    //     // blog('mark is : $_mark');
    //
    //     final String _countryISO2 = _mark.isoCountryCode;
    //     final String _countryID = Flag.getCountryIDByISO2(_countryISO2);
    //
    //     final List<CityModel> _countryCities = await ZoneProtocols.fetchCitiesOfCountry(
    //       countryID: _countryID,
    //     );
    //
    //     CityModel _foundCity;
    //
    //     if (Mapper.checkCanLoopList(_countryCities) == true) {
    //
    //       /// by subAdministrativeArea
    //       List<CityModel> _foundCities = ZoneSearchOps.searchCitiesByNameFromCities(
    //         context: context,
    //         sourceCities: _countryCities,
    //         inputText: TextMod.removeAllCharactersAfterNumberOfCharacters(
    //           input: TextMod.fixCountryName(_mark.subAdministrativeArea),
    //           numberOfChars: Standards.maxTrigramLength,
    //         ),
    //         langCodes: ['en'],
    //       );
    //
    //       /// by administrativeArea
    //       if (Mapper.checkCanLoopList(_foundCities) == false) {
    //         _foundCities = ZoneSearchOps.searchCitiesByNameFromCities(
    //           context: context,
    //           sourceCities: _countryCities,
    //           inputText: TextMod.removeAllCharactersAfterNumberOfCharacters(
    //             input: TextMod.fixCountryName(_mark.administrativeArea),
    //             numberOfChars: Standards.maxTrigramLength,
    //           ),
    //           langCodes: ['en'],
    //         );
    //       }
    //
    //       /// by locality
    //       if (Mapper.checkCanLoopList(_foundCities) == false) {
    //         _foundCities = ZoneSearchOps.searchCitiesByNameFromCities(
    //           context: context,
    //           sourceCities: _countryCities,
    //           inputText: TextMod.removeAllCharactersAfterNumberOfCharacters(
    //             input: TextMod.fixCountryName(_mark.locality),
    //             numberOfChars: Standards.maxTrigramLength,
    //           ),
    //           langCodes: ['en'],
    //         );
    //       }
    //
    //       if (Mapper.checkCanLoopList(_foundCities) == true){
    //         _foundCity = _foundCities.first;
    //       }
    //
    //     }
    //
    //     _zoneModel = ZoneModel(
    //       countryID: _countryID,
    //       cityID: _foundCity?.cityID,
    //     );
    //
    //   }
    //
    // }

    return _zoneModel;
  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneModel> completeZoneModel({
    @required BuildContext context,
    @required ZoneModel incompleteZoneModel,
  }) async {

    // assert(incompleteZoneModel != null, 'incompleteZoneModel is null');
    // assert(incompleteZoneModel.countryID != null, 'incompleteZoneModel.countryID is null');

    /// incomplete zone model is what only has (countryID - cityID)
    /// complete zone model is that has all IDs  Models and Names initialized

    ZoneModel _output = incompleteZoneModel;

    if (incompleteZoneModel != null && incompleteZoneModel.countryID != null){

      /// COUNTRY MODEL
      if (incompleteZoneModel.countryModel == null){

        // blog('completeZoneModel : country model is null');

        final CountryModel _bzCountry = await ZoneProtocols.fetchCountry(
          countryID: incompleteZoneModel.countryID,
        );

        // blog('completeZoneModel : got country model : $_bzCountry');

        _output = _output.copyWith(
          countryModel: _bzCountry,
        );
      }

      /// CITY MODEL
      if (incompleteZoneModel.cityModel == null){
        final CityModel _bzCity = await ZoneProtocols.fetchCity(
          cityID: incompleteZoneModel.cityID,
        );
        _output = _output.copyWith(
          cityModel: _bzCity,
        );

      }

      /// COUNTRY NAME
      if (TextCheck.isEmpty(incompleteZoneModel.countryName) == true || incompleteZoneModel.countryName == '...'){

        final String _countryName = ZoneProtocols.translateCountry(
          context: context,
          countryID: incompleteZoneModel.countryID,
          // langCode:
        )?.id;

        _output = _output.copyWith(
          countryName: _countryName,
        );

      }

      /// CITY NAME
      if (TextCheck.isEmpty(incompleteZoneModel.cityName) == true || incompleteZoneModel.cityName == '...'){

        final String _cityName = ZoneProtocols.translateCity(
          context: context,
          cityModel: _output.cityModel,
          // langCode:
        )?.id;

        _output = _output.copyWith(
          cityName: _cityName,
        );

      }

      /// FLAG
      if (TextCheck.isEmpty(incompleteZoneModel.icon) == true || incompleteZoneModel.icon == Iconz.dvBlankSVG){
        _output = _output.copyWith(
          icon: Flag.getCountryIcon(incompleteZoneModel.countryID),
        );
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
