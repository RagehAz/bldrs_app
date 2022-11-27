import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/b_country/country_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class RenovateZoneProtocols {
  // -----------------------------------------------------------------------------

  const RenovateZoneProtocols();

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
