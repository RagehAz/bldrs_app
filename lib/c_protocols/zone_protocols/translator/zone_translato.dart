import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class ZoneTranslator {
  // -----------------------------------------------------------------------------

  const ZoneTranslator();

  // -----------------------------------------------------------------------------

  /// COUNTRY NAME

  // --------------------
  /// TESTED : WORKS PERFECT
  static Verse translateCountry({
    @required BuildContext context,
    @required String countryID,
    String langCode,
  }) {
    Verse _output;

    if (countryID != null){

      _output = Verse(
        text: Flag.translateCountry(
          countryID: countryID,
          langCode: langCode ?? Localizer.getCurrentLangCode(context),
        ),
        translate: false,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CITY NAME

  // --------------------
  /// TESTED : WORKS PERFECT
  static Verse translateCity({
    @required BuildContext context,
    @required CityModel cityModel,
    String langCode,
  }) {
    Verse _output;

    if (cityModel != null){
      _output = Verse(
        text: CityModel.translateCity(
          context: context,
          city: cityModel,
          langCode: langCode,
        ),
        translate: false,
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DISTRICT NAME

  // --------------------
  /// TESTED : WORKS PERFECT
  static Verse translateDistrict({
    @required BuildContext context,
    @required DistrictModel districtModel,
    String langCode,
  }) {
    Verse _output;

    if (districtModel != null){
      _output = Verse(
        text: DistrictModel.translateDistirct(
          context: context,
          district: districtModel,
          langCode: langCode,
        ),
        translate: false,
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
