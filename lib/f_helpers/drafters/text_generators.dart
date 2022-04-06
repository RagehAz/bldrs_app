import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart' as FlyerTypeClass;
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/theme/standards.dart' as Standards;
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
String flyerTypeDescriptionStringer(BuildContext context, FlyerTypeClass.FlyerType flyerType){
  final String _description =
  flyerType == FlyerTypeClass.FlyerType.property ? 'By RealEstate Developers & Brokers.' : //Wordz.realEstateTagLine(context) :
  flyerType == FlyerTypeClass.FlyerType.design ? 'By Architects & Designers' : //Wordz.constructionTagLine(context) :
  flyerType == FlyerTypeClass.FlyerType.project ? 'By Contractors' : //Wordz.constructionTagLine(context) :
  flyerType == FlyerTypeClass.FlyerType.craft ? 'By Craftsmen, Technicians & Artists.' : //Wordz.constructionTagLine(context) :
  flyerType == FlyerTypeClass.FlyerType.product ? 'By Manufacturers & Suppliers.' : //Wordz.suppliesTagLine(context) :
  flyerType == FlyerTypeClass.FlyerType.equipment ? 'By Manufacturers & Suppliers.' : //Wordz.constructionTagLine(context) :

  Wordz.bldrsShortName(context);

  return _description;
}
// -----------------------------------------------------------------------------
String countryStringerByModels ({
  @required BuildContext context,
  @required CountryModel country,
  @required CityModel city,
  @required ZoneModel zone
}){
  String _verse = '...';

  if (country != null && ZoneModel.zoneHasAllIDs(zone)){

    final String _countryName = CountryModel.getTranslatedCountryName(
        context: context,
        countryID: country.id,
    );

    final String _cityName = CityModel.getTranslatedCityNameFromCity(
      context: context,
      city: city,
    );

    final String _districtName = DistrictModel.getTranslatedDistrictNameFromCity(
      context: context,
      city: city,
      districtID: zone.districtID,
    );

    _verse =
    zone.countryID == null || zone.cityID == null ? '...' :
    '${superPhrase(context, 'phid_inn')} $_districtName , $_cityName , $_countryName . ';

  }


  return _verse;
}
// -----------------------------------------------------------------------------
String countryStringerByZoneModel ({
  @required BuildContext context,
  @required ZoneModel zone
}){
  String _verse = '...';

  if (zone != null && ZoneModel.zoneHasAllIDs(zone)){

    final String _countryName = zone.countryName;

    final String _cityName = zone.cityName;

    final String _districtName = zone.districtName;

    _verse =
    zone.countryID == null || zone.cityID == null ? '...' :
    '${superPhrase(context, 'phid_inn')} $_districtName , $_cityName , $_countryName . ';

  }


  return _verse;
}
// -----------------------------------------------------------------------------
String cityCountryStringer ({
  @required BuildContext context,
  @required CountryModel country,
  @required CityModel city,
  @required ZoneModel zone,
}){

  String _verse = '...';

  if (country != null && ZoneModel.zoneHasAllIDs(zone)){

    final String _countryName = superPhrase(context, country.id);

    final String _cityName = superPhrase(context, city.cityID);

    _verse =
    zone.countryID == null || zone.cityID == null ? '...' :
    '${superPhrase(context, 'phid_inn')}, $_cityName , $_countryName . ';


  }

  return _verse;
}
// -----------------------------------------------------------------------------
String functionStringer(Function function) {
  final String _functionNameAsAString = function.toString();
  final int _s = _functionNameAsAString.indexOf("'");
  final int _e = _functionNameAsAString.lastIndexOf("'");
  // print('functionNameAsAString : ${functionNameAsAString.substring(s + 1, e)}');
  return _functionNameAsAString.substring(_s+1, _e);  // return functionNameAsAString;
}
// -----------------------------------------------------------------------------
String askHinter (BuildContext context, BzType bzType){
  final String _askHint =
  bzType == BzType.developer ? superPhrase(context, 'phid_askHint_developer') :
  bzType == BzType.broker ? superPhrase(context, 'phid_askHint_broker') :
  bzType == BzType.manufacturer ? superPhrase(context, 'phid_askHint_manufacturer') :
  bzType == BzType.supplier ? superPhrase(context, 'phid_askHint_supplier') :
  bzType == BzType.designer ? superPhrase(context, 'phid_askHint_designer') :
  bzType == BzType.contractor ? superPhrase(context, 'phid_askHint_contractor') :
  bzType == BzType.craftsman ? superPhrase(context, 'phid_askHint_craftsman') :
  superPhrase(context, 'phid_askHint');
  return _askHint;
}
// -----------------------------------------------------------------------------

List<String> createTrigram({@required String input}){
  List<String> _trigram = <String>[];

  if (input != null){

    const int maxTrigramLength = Standards.maxTrigramLength;

    /// 0 - to lower cases
    final String _lowerCased = input.toLowerCase();

    /// 1 - first add each word separately
    final List<String> _splitWords = _lowerCased.trim().split(' ');
    _trigram.addAll(_splitWords);

    /// 2 - start trigramming after clearing spaces
    final String _withoutSpaces = TextMod.removeSpacesFromAString(_lowerCased);

    /// 3 - split characters into a list
    final List<String> _characters = _withoutSpaces.split('');
    final int _charactersLength = _characters.length;
    final int _maxTrigramLength = maxTrigramLength ?? _charactersLength;

    /// 4 - loop through trigram length 3 -> 4 -> 5 -> ... -> _charactersLength
    for (int trigramLength = 3; trigramLength <= _maxTrigramLength; trigramLength++){

      final int _difference = trigramLength - 1;

      /// 5 - loop in characters
      for (int i = 0; i < _charactersLength - _difference; i++){

        String _combined = '';

        /// 6 - combine
        for (int c = 0; c < trigramLength;c++){
          final String _char = _characters[i + c];
          _combined = '$_combined$_char';
        }

        /// 7 - add combination
        _trigram = TextMod.addStringToListIfDoesNotContainIt(strings : _trigram, stringToAdd : _combined,);
      }

    }

    // /// 3 - generate the triplets
    // for (int i = 0; i < _charactersLength - 2; i++){
    //   String _first = _characters[i];
    //   String _second = _characters[i+1];
    //   String _third = _characters[i+2];
    //   String _combined = '$_first$_second$_third';
    //   _trigram = TextMod.addStringToListIfDoesNotContainIt(strings : _trigram, stringToAdd : _combined,);
    // }

    // _trigramLength = 4;
    // /// 4 - generate quadruplets
    // for (int i = 0; i < _characters.length - 3; i++){
    //   String _first = _characters[i];
    //   String _second = _characters[i+1];
    //   String _third = _characters[i+2];
    //   String _fourth = _characters[i+3];
    //   String _combined = '$_first$_second$_third$_fourth';
    //   _trigram = TextMod.addStringToListIfDoesNotContainIt(strings : _trigram, stringToAdd : _combined,);
    // }

    // _trigramLength = 5;
    // /// 5 - generate Quintuplets
    // for (int i = 0; i < _characters.length - 4; i++){
    //   String _first = _characters[i];
    //   String _second = _characters[i+1];
    //   String _third = _characters[i+2];
    //   String _fourth = _characters[i+3];
    //   String _fifth = _characters[i+4];
    //   String _combined = '$_first$_second$_third$_fourth$_fifth';
    //   _trigram = TextMod.addStringToListIfDoesNotContainIt(strings : _trigram, stringToAdd : _combined,);
    // }

    // _trigramLength = 6;
    // /// 6 - generate Sextuplets
    // for (int i = 0; i < _characters.length - 5; i++){
    //   String _first = _characters[i];
    //   String _second = _characters[i+1];
    //   String _third = _characters[i+2];
    //   String _fourth = _characters[i+3];
    //   String _fifth = _characters[i+4];
    //   String _sixth = _characters[i+5];
    //   String _combined = '$_first$_second$_third$_fourth$_fifth$_sixth';
    //   _trigram = TextMod.addStringToListIfDoesNotContainIt(strings : _trigram, stringToAdd : _combined,);
    // }

  }

  return _trigram;
}
// -----------------------------------------------------------------------------
/// CREATES ONE STRING OF ALL STRINGS IN LIST AND SEPARATES THEM WITH ', '
String generateStringFromStrings(List<String> strings){

  String _output = '';

  if (Mapper.canLoopList(strings) == true){

    for (final String _string in strings){


      if (_output == ''){
        _output = _string;
      }

      else {
        _output = '$_output, $_string';
      }

    }

  }

  if (_output == ''){
    _output = null;
  }

  return _output;
}
// -----------------------------------------------------------------------------
/*

String sectionStringer (BuildContext context, SectionClass.Section section){
  return
    section == SectionClass.Section.properties ? 'properties' : //Wordz.realEstate(context) :

    section == SectionClass.Section.designs ? 'Designs' : //Wordz.construction(context) :
    section == SectionClass.Section.projects ? 'Projects' : //Wordz.construction(context) :
    section == SectionClass.Section.crafts ? 'Crafts & Trades' : //Wordz.construction(context) :

    section == SectionClass.Section.products ? 'Products & Materials' : //Wordz.supplies(context) :
    section == SectionClass.Section.equipment ? 'Tools & Equipment' : //Wordz.supplies(context) :

    section == SectionClass.Section.all ? 'All flyers' : //Wordz.supplies(context) :

    Wordz.bldrsShortName(context);
}


 */
