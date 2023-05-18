import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/world_zoning/world_zoning.dart';
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
        id: Flag.translateCountry(
          countryID: countryID,
          langCode: langCode ?? Localizer.getCurrentLangCode(),
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
        id: CityModel.translateCity(
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
}
