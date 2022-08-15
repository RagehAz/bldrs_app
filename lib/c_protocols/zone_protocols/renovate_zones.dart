import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class RenovateZoneProtocols {
// -----------------------------------------------------------------------------

  const RenovateZoneProtocols();

// ----------------------------------
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
          context: context,
          countryID: incompleteZoneModel.countryID,
        );
        _output = _output.copyWith(
          countryModel: _bzCountry,
        );
      }

      /// BZ CITY
      if (incompleteZoneModel.cityModel == null){
        final CityModel _bzCity = await ZoneProtocols.fetchCity(
          context: context,
          cityID: incompleteZoneModel.cityID,
        );
        _output = _output.copyWith(
          cityModel: _bzCity,
        );

      }

      /// COUNTRY NAME
      if (incompleteZoneModel.countryName == null || incompleteZoneModel.countryName == '...'){

        // superPhrase(context, _zone.countryID);
        final String _countryName = CountryModel.getTranslatedCountryName(
          context: context,
          countryID: incompleteZoneModel.countryID,
        );
        _output = _output.copyWith(
          countryName: _countryName,
        );
      }

      /// CITY NAME
      if (incompleteZoneModel.cityName == null || incompleteZoneModel.cityName == '...'){

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
      if (incompleteZoneModel.districtName == null || incompleteZoneModel.districtName == '...'){
        final String _districtName = DistrictModel.getTranslatedDistrictNameFromCity(
          context: context,
          city: _output.cityModel,
          districtID: incompleteZoneModel.districtID,
        );
        _output = _output.copyWith(
          districtName: _districtName,
        );
      }

      if (incompleteZoneModel.flag == null || incompleteZoneModel.flag == Iconz.dvBlankSVG){
        _output = _output.copyWith(
          flag: Flag.getFlagIcon(incompleteZoneModel.countryID),
        );
      }

    }

    return _output;
  }
// -----------------------------------------------------------------------------
}
