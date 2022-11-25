import 'package:bldrs/a_models/d_zone/a_zoning/zone_level.dart';
import 'package:bldrs/a_models/d_zone/zz_old/city_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class DistrictModel{
  /// --------------------------------------------------------------------------
  const DistrictModel({
    @required this.id,
    @required this.level,
    @required this.phrases,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final ZoneLevelType level;
  final List<Phrase> phrases;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, Object> toMap({
    @required bool toJSON,
    @required bool toLDB,
  }){

    Map<String, dynamic> _map = {
      'id': id,
      'phrases' : Phrase.cipherPhrasesToLangsMap(phrases),
      'level': ZoneLevel.cipherLevelType(level),
    };

    if (toLDB == true){
      _map = Mapper.insertMapInMap(
        baseMap: _map,
        insert: {
          'id': id,
        },
      );
    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String,dynamic> cipherDistricts({
    @required List<DistrictModel> districts,
    @required bool toJSON,
    @required bool toLDB,
  }){
    Map<String, dynamic> _districtsMap = <String, dynamic>{};

    if (Mapper.checkCanLoopList(districts) == true){
      for (final DistrictModel district in districts){
        _districtsMap = Mapper.insertPairInMap(
          map: _districtsMap,
          key: district.id,
          value: district.toMap(
            toJSON: toJSON,
            toLDB: toLDB,
          ),
        );
      }
    }

    return _districtsMap;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DistrictModel decipherDistrict(dynamic map){
    return DistrictModel(
      id : map['id'],
      level: ZoneLevel.decipherLevelType(map['level']),
      phrases: Phrase.decipherPhrasesLangsMap(
        langsMap: map['phrases'],
        phid: map['id'],
      ),

    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<DistrictModel> decipherDistricts(Map<String, dynamic> map){

    final List<DistrictModel> _districts = <DistrictModel>[];

    if (map != null){

      final List<String> districtsIDs = map.keys.toList();
      final List<dynamic> _districtsMaps = map.values.toList();

      if (Mapper.checkCanLoopList(districtsIDs)){

        for (int i = 0; i< districtsIDs.length; i++){

          final Map<String, dynamic> _districtMapWithID = Mapper.insertPairInMap(
              map: _districtsMaps[i],
              key:'id',
              value: districtsIDs[i],
          );

          final DistrictModel _district = decipherDistrict(_districtMapWithID);
          _districts.add(_district);

        }

      }

    }

    return _districts;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /*
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
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static DistrictModel getDistrictFromDistricts({
    @required List<DistrictModel> districts,
    @required String districtID
  }){
    DistrictModel _district;

    if (Mapper.checkCanLoopList(districts)){
      _district = districts.firstWhere((DistrictModel district) => district.id == districtID,
          orElse: () => null
      );
    }

    return _district;
  }
  // -----------------------------------------------------------------------------

  /// PHRASES

  // --------------------
  /// TESTED : WORKS PERFECT
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

      final Phrase _phrase = Phrase.searchFirstPhraseByCurrentLang(
        context: context,
        phrases: _district?.phrases,
      );

      if (_phrase != null){
        _districtName = _phrase.value;
      }

    }

    return _districtName;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getTranslatedDistrictNameFromDistrict({
    @required BuildContext context,
    @required DistrictModel district,
  }){

    final Phrase _districtName = Phrase.searchFirstPhraseByCurrentLang(
      context: context,
      phrases: district?.phrases,
    );

    final String _nameString = _districtName?.value;

    return _nameString;

  }
  // --------------------
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

        final Phrase _districtPhrase = Phrase.searchPhraseByIDAndLangCode(
          phid: district.id,
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
  // --------------------
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

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogDistrict(){

    blog('districtID : $id : has ${phrases.length} phrases : level : $level');
    Phrase.blogPhrases(phrases);

  }
  // --------------------
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

  // --------------------
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

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkDistrictsAreIdentical(DistrictModel district1, DistrictModel district2){
    bool _identical = false;

    if (district1 == null && district2 == null){
      _identical = true;
    }
    else {

      if (district1 != null && district2 != null){

        if (
            district1.id == district2.id &&
            district1.level == district2.level &&
            Phrase.checkPhrasesListsAreIdentical(phrases1: district1.phrases, phrases2: district2.phrases) == true
        ){
          _identical = true;
        }

      }

    }

    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkDistrictsListsAreIdentical(List<DistrictModel> districts1, List<DistrictModel> districts2){

    bool _listsAreIdentical = false;

    if (districts1 == null && districts2 == null){
      _listsAreIdentical = true;
    }
    else if (districts1?.isEmpty == true && districts2?.isEmpty == true){
      _listsAreIdentical = true;
    }

    else if (Mapper.checkCanLoopList(districts1) == true && Mapper.checkCanLoopList(districts2) == true){

      if (districts1.length != districts2.length) {
        _listsAreIdentical = false;
      }

      else {
        for (int i = 0; i < districts1.length; i++) {

          if (checkDistrictsAreIdentical(districts1[i], districts2[i]) == false) {
            _listsAreIdentical = false;
            break;
          }

          else {
            _listsAreIdentical = true;
          }

        }
      }

    }

    return _listsAreIdentical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is DistrictModel){
      _areIdentical = checkDistrictsAreIdentical(
        this,
        other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      level.hashCode^
      phrases.hashCode;
  // -----------------------------------------------------------------------------
}
