import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/b_country/country_model.dart';
import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/location/location_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/b_zone_search_protocols.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ZoneIDsProtocols {
  // -----------------------------------------------------------------------------

  const ZoneIDsProtocols();

  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TASK : TEST ME
  static Future<ZoneModel> fetchZoneModelByGeoPoint({
    @required BuildContext context,
    @required GeoPoint geoPoint
  }) async {

    ZoneModel _zoneModel;

    if (geoPoint != null){

      final List<Placemark> _marks = await LocationOps.getPlaceMarksFromGeoPoint(geoPoint: geoPoint);

      // blog('_getCountryData : got place marks : ${_marks.length}');

      if (Mapper.checkCanLoopList(_marks) == true){

        final Placemark _mark = _marks[0];

        // blog('mark is : $_mark');

        final String _countryISO2 = _mark.isoCountryCode;
        final String _countryID = Flag.getCountryIDByISO2(_countryISO2);

        final List<CityModel> _countryCities = await ZoneProtocols.fetchCitiesOfCountryByStage(
          countryID: _countryID,
        );

        CityModel _foundCity;

        if (Mapper.checkCanLoopList(_countryCities) == true) {

          /// by subAdministrativeArea
          List<CityModel> _foundCities = ZoneSearchOps.searchCitiesByName(
            context: context,
            sourceCities: _countryCities,
            inputText: TextMod.removeAllCharactersAfterNumberOfCharacters(
              input: TextMod.fixCountryName(_mark.subAdministrativeArea),
              numberOfChars: Standards.maxTrigramLength,
            ),
            langCodes: ['en'],
          );

          /// by administrativeArea
          if (Mapper.checkCanLoopList(_foundCities) == false) {
            _foundCities = ZoneSearchOps.searchCitiesByName(
              context: context,
              sourceCities: _countryCities,
              inputText: TextMod.removeAllCharactersAfterNumberOfCharacters(
                input: TextMod.fixCountryName(_mark.administrativeArea),
                numberOfChars: Standards.maxTrigramLength,
              ),
              langCodes: ['en'],
            );
          }

          /// by locality
          if (Mapper.checkCanLoopList(_foundCities) == false) {
            _foundCities = ZoneSearchOps.searchCitiesByName(
              context: context,
              sourceCities: _countryCities,
              inputText: TextMod.removeAllCharactersAfterNumberOfCharacters(
                input: TextMod.fixCountryName(_mark.locality),
                numberOfChars: Standards.maxTrigramLength,
              ),
              langCodes: ['en'],
            );
          }

          _foundCity = _foundCities?.first;

        }

        _zoneModel = ZoneModel(
          countryID: _countryID,
          cityID: _foundCity?.cityID,
        );

      }

    }

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

    /// incomplete zone model is what only has (countryID - cityID - districtID)
    /// complete zone model is that has all IDs  Models and Names initialized

    ZoneModel _output = incompleteZoneModel;

    if (incompleteZoneModel != null){

      /// BZ COUNTRY
      if (incompleteZoneModel.countryModel == null){
        final CountryModel _bzCountry = await ZoneProtocols.fetchCountry(
          countryID: incompleteZoneModel.countryID,
        );
        _output = _output.copyWith(
          countryModel: _bzCountry,
        );
      }

      /// BZ CITY
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

        // superPhrase(context, _zone.countryID);
        final String _countryName = Flag.getCountryNameByCurrentLang(
          context: context,
          countryID: incompleteZoneModel.countryID,
        );
        _output = _output.copyWith(
          countryName: _countryName,
        );
      }

      /// CITY NAME
      if (TextCheck.isEmpty(incompleteZoneModel.cityName) == true || incompleteZoneModel.cityName == '...'){

        // superPhrase(context, _zone.cityID);
        final String _cityName = CityModel.getTranslatedCityNameFromCity(
          context: context,
          city: _output.cityModel,
        );
        _output = _output.copyWith(
          cityName: _cityName,
        );
      }

      /// DISTRICT NAME
      if (TextCheck.isEmpty(incompleteZoneModel.districtName) == true || incompleteZoneModel.districtName == '...'){
        final String _districtName = DistrictModel.getTranslatedDistrictNameFromCity(
          context: context,
          city: _output.cityModel,
          districtID: incompleteZoneModel.districtID,
        );
        _output = _output.copyWith(
          districtName: _districtName,
        );
      }

      /// FLAG
      if (TextCheck.isEmpty(incompleteZoneModel.flag) == true || incompleteZoneModel.flag == Iconz.dvBlankSVG){
        _output = _output.copyWith(
          flag: Flag.getCountryIcon(incompleteZoneModel.countryID),
        );
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
