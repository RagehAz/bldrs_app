import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
@immutable
class DistrictModel{
  /// --------------------------------------------------------------------------
  const DistrictModel({
    this.countryID,
    this.cityID,
    this.districtID,
    this.isActivated,
    this.isPublic,
    this.phrases,
  });
  /// --------------------------------------------------------------------------
  final String countryID;
  final String cityID;
  final String districtID;
  /// dashboard manual switch to deactivate entire cities.
  final bool isActivated;
  /// automatic switch when flyers reach 'city publishing-target ~ 1000 flyers'
  /// then all flyers will be visible to users not only between bzz
  final bool isPublic;
  final List<Phrase> phrases; // was not changed in firebase sub docs,, kessa ba2a
// -----------------------------------------------------------------------------

  /// CYPHERS

// -------------------------------------
  Map<String, Object> toMap({@required bool toJSON}){
    return <String, Object>{
      'countryID' : countryID,
      'cityID' : cityID,
      'districtID' : TextMod.fixCountryName(districtID),
      'isActivated' : isActivated,
      'isPublic' : isPublic,
      'phrases' : CountryModel.cipherZonePhrases(
        phrases: phrases,
        toJSON: toJSON,
      ),

    };
  }
// -----------------------------------------------------------------------------
  static Map<String,dynamic> cipherDistricts({
    @required List<DistrictModel> districts,
    @required bool toJSON,
  }){

    Map<String, dynamic> _districtsMap = <String, dynamic>{};

    for (final DistrictModel district in districts){

      _districtsMap = Mapper.insertPairInMap(
        map: _districtsMap,
        key: TextMod.fixCountryName(district.districtID),
        value: district.toMap(toJSON: toJSON),
      );

    }

    return _districtsMap;
  }
// -----------------------------------------------------------------------------
  static DistrictModel decipherDistrictMap(Map<String, dynamic> map){
    return DistrictModel(
      countryID : map['countryID'],
      cityID : map['cityID'],
      districtID : map['districtID'],
      isActivated : map['isActivated'],
      isPublic : map['isPublic'],
      phrases: CountryModel.decipherZonePhrases(
          phrasesMap: map['phrases'],
          zoneID: map['districtID'],
      ),

    );
  }
// -----------------------------------------------------------------------------
  static List<DistrictModel> decipherDistrictsMap(Map<String, dynamic> map){

    final List<DistrictModel> _districts = <DistrictModel>[];

    final List<String> _keys = map.keys.toList();
    final List<dynamic> _values = map.values.toList();

    if (Mapper.checkCanLoopList(_keys)){

      for (int i = 0; i<_keys.length; i++){

        final DistrictModel _district = decipherDistrictMap(_values[i]);

        _districts.add(_district);

      }

    }

    return _districts;
  }
// -----------------------------------------------------------------------------

  /// GETTERS

// -------------------------------------
  static List<MapModel> getDistrictsNamesMapModels({
    @required BuildContext context,
    @required List<DistrictModel> districts
  }){

    final List<MapModel> _districtsMapModels = <MapModel>[];

    if (Mapper.checkCanLoopList(districts)){

      for (final DistrictModel district in districts){
        _districtsMapModels.add(
            MapModel(
                key: district.districtID,
                value: DistrictModel.getTranslatedDistrictNameFromDistrict(
                    context: context,
                    district: district
                ),

                // Name.getNameByCurrentLingoFromNames(
                //     context: context,
                //     names: district.names
                // )

            )
        );
      }

    }

    return MapModel.sortValuesAlphabetically(_districtsMapModels);
  }
// -----------------------------------------------------------------------------
  static DistrictModel getDistrictFromDistricts({
    @required List<DistrictModel> districts,
    @required String districtID
  }){
    DistrictModel _district;
    if (Mapper.checkCanLoopList(districts)){

      _district = districts.firstWhere(
              (DistrictModel district) => district.districtID == districtID,
          orElse: () => null
      );

    }
    return _district;
  }
// -----------------------------------------------------------------------------

  /// PHRASES

// -------------------------------------
  static String getTranslatedDistrictNameFromCity({
    @required BuildContext context,
    @required CityModel city,
    @required String districtID
  }){
    String _districtName;

    if (city != null && districtID != null){

      final DistrictModel _district = DistrictModel.getDistrictFromDistricts(
          districts: city.districts,
          districtID: districtID,
      );

      final Phrase _phrase = Phrase.getPhraseByCurrentLangFromMixedLangPhrases(
          context: context,
          phrases: _district?.phrases,
      );

      if (_phrase != null){
        _districtName = _phrase.value;
      }

    }

    return _districtName;
  }
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static String getTranslatedDistrictNameFromDistrict({
    @required BuildContext context,
    @required DistrictModel district,
}){

    final Phrase _districtName = Phrase.getPhraseByCurrentLangFromMixedLangPhrases(
        context: context,
        phrases: district?.phrases,
    );

    final String _nameString = _districtName?.value;

    return _nameString;

  }
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<DistrictModel> searchDistrictsByCurrentLingoName({
    @required BuildContext context,
    @required List<DistrictModel> sourceDistricts,
    @required String inputText,
    List<String> langCodes = const <String>['en', 'ar'],
  }){

    /// CREATE NAMES LIST
    final List<Phrase> _districtsPhrases = <Phrase>[];

    for (final String langCode in langCodes){
      for (final DistrictModel district in sourceDistricts){

        final Phrase _districtPhrase = Phrase.getPhraseByIDAndLangCodeFromPhrases(
          phid: district.districtID,
          langCode: langCode,
          phrases: district.phrases,
        );
        _districtsPhrases.add(_districtPhrase);

      }

    }

    /// SEARCH PHRASES
    final List<Phrase> _foundPhrases = Phrase.searchPhrasesTrigrams(
      sourcePhrases: _districtsPhrases,
      inputText: inputText,
    );

    /// GET CITIES BY IDS FROM NAMES
    final List<DistrictModel> _foundDistricts = _getDistrictsFromNames(
        names: _foundPhrases,
        sourceDistricts: sourceDistricts
    );

    DistrictModel.blogDistricts(_foundDistricts);

    return _foundDistricts;
  }
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<DistrictModel> _getDistrictsFromNames({
    @required List<Phrase> names,
    @required List<DistrictModel> sourceDistricts,
  }){
    final List<DistrictModel> _foundDistricts = <DistrictModel>[];

    if (Mapper.checkCanLoopList(sourceDistricts) && Mapper.checkCanLoopList(names)){

      for (final Phrase name in names){

        for (final DistrictModel district in sourceDistricts){

          if (district.phrases.contains(name)){

            if (!_foundDistricts.contains(district)){
              _foundDistricts.add(district);

            }

          }

        }

      }

    }

    return _foundDistricts;
  }
// -----------------------------------------------------------------------------

/// BLOGGERS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  void blogDistrict(){

    blog('districtID : $districtID : '
        'cityID : $cityID : '
        'countryID : $countryID : '
        'isActivated : $isActivated : '
        'isPublic : $isPublic : '
        'has ${phrases.length} phrases'
    );
    blog('district phrases are : -');
    Phrase.blogPhrases(phrases);

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static void blogDistricts(List<DistrictModel> districts){

    if (Mapper.checkCanLoopList(districts) == true){

      blog('BLOGGING ${districts.length} DISTRICTS -------------------------------- STAR');

      for (final DistrictModel district in districts){

        district.blogDistrict();

      }

      blog('BLOGGING ----- DISTRICTS -------------------------------- END');

    }
    else {
      blog('No districts found to blog');
    }

  }
// -----------------------------------------------------------------------------

  /// SORTING

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<DistrictModel> sortDistrictsAlphabetically({
    @required BuildContext context,
    @required List<DistrictModel> districts,
  }){
    List<DistrictModel> _output = <DistrictModel>[];

    if (Mapper.checkCanLoopList(districts) == true){

      _output = districts;

      _output.sort((DistrictModel a, DistrictModel b){

        final String _nameA = DistrictModel.getTranslatedDistrictNameFromDistrict(
          context: context,
          district: a,
        );

        final String _nameB = DistrictModel.getTranslatedDistrictNameFromDistrict(
          context: context,
          district: b,
        );

        return _nameA.compareTo(_nameB);
      });

    }

    return _output;
  }
// -----------------------------------------------------------------------------
}
