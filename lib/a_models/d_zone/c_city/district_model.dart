import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class DistrictModel{
  /// --------------------------------------------------------------------------
  const DistrictModel({
    @required this.id,
    @required this.phrases,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final List<Phrase> phrases;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  DistrictModel copyWith({
    String id,
    List<Phrase> phrases,
  }){

    return DistrictModel(
      id: id ?? this.id,
      phrases: phrases ?? this.phrases,
    );

  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, Object> toMap({
    @required bool toJSON,
    @required bool toLDB,
  }){

    Map<String, dynamic> _map = {
      'phrases' : Phrase.cipherPhrasesToLangsMap(phrases),
    };

    if (toLDB == true){
      _map = Mapper.insertPairInMap(
        map: _map,
        key: 'id',
        value: id,
      );
    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DistrictModel decipherDistrict({
    @required Map<String, dynamic> map,
    @required String districtID,
  }){
    DistrictModel _output;

    if (map != null){
      _output = DistrictModel(
        id : districtID,
        phrases: Phrase.decipherPhrasesLangsMap(
          langsMap: map['phrases'],
          phid: districtID,
        ),
      );
    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static List<Map<String, dynamic>> cipherDistrictsMaps({
    @required List<DistrictModel> districts,
    @required bool toJSON,
    @required bool toLDB,
  }){
    final List<Map<String, dynamic>> _output = [];

    if (Mapper.checkCanLoopList(districts) == true){

      for (final DistrictModel _district in districts){
        _output.add(_district.toMap(
          toJSON: toJSON,
          toLDB: toLDB,
        ));
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<DistrictModel> decipherDistrictsMaps(List<Map<String, dynamic>> maps){
    final List<DistrictModel> _output = <DistrictModel>[];

    if (Mapper.checkCanLoopList(maps) == true){
      for (final Map<String, dynamic> map in maps){
        _output.add(decipherDistrict(
          map: map,
          districtID: map['id'],
        ));
      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DEPRECATED CYPHERS

  // --------------------
  /// DEPRECATED
  /*
  static Map<String,dynamic> oldCipherDistrictsOneMap({
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
   */
  // --------------------
  /// DEPRECATED
  static List<DistrictModel> oldDecipherDistrictsOneMap(Map<String, dynamic> map){

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

          final DistrictModel _district = decipherDistrict(
            map: _districtMapWithID,
            districtID: _districtMapWithID['id'],
          );
          _districts.add(_district);

        }

      }

    }

    return _districts;
  }
  // -----------------------------------------------------------------------------

  /// PHRASES CYPHERS

  // --------------------
  /// TASK : TEST ME
  List<Map<String, dynamic>> toFirePhrasesMaps(){

    final List<Map<String, dynamic>> _output = [];

    final String _countryID = getCountryIDFromDistrictID(id);
    final String _cityID = getCityIDFromDistrictID(id);
    final List<String> _langCodes = Phrase.getLangCodes(phrases);

    if (Mapper.checkCanLoopList(_langCodes) == true){

      for (final String langCode in _langCodes){

        final String _phraseValue = Phrase.searchFirstPhraseByLang(phrases: phrases, langCode: langCode)?.value;

        if (_phraseValue != null){

          final Map<String, dynamic> _map = {
            'docName': getDistrictPhraseDocName(
              districtID: id,
              langCode: langCode,
            ),
            'countryID': _countryID,
            'cityID': _cityID,
            'id': id,
            'value': _phraseValue,
            'langCode': langCode,
            'trigram': Stringer.createTrigram(input: _phraseValue),
          };

          _output.add(_map);

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getDistrictsIDs(List<DistrictModel> districts){
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(districts) == true){

      for (final DistrictModel district in districts){
        _output.add(district.id);
      }

    }

    return _output;
  }
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getCountryIDFromDistrictID(String districtID){
    return TextMod.removeTextAfterFirstSpecialCharacter(districtID, '+');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getCityIDFromDistrictID(String districtID){
    /// DISTRICT ID LOOKS LIKE THIS ('countryID+cityID+districtID')
    /// CITY ID LOOKS LIKE THIS ('countryID+cityID')
    return TextMod.removeTextAfterLastSpecialCharacter(districtID, '+');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getDistrictPhraseDocName({
    @required String districtID,
    @required String langCode,
  }){
    assert(districtID != null && langCode != null, 'districtID and langCode must not be null');
    return '$districtID+$langCode';
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<DistrictModel> getDistrictsFromDistrictsByIDs({
  @required List<DistrictModel> districtsModels,
    @required List<String> districtsIDs,
  }){
    final List<DistrictModel> _output = [];

    if (Mapper.checkCanLoopList(districtsModels) == true && Mapper.checkCanLoopList(districtsIDs) == true){

      for (final DistrictModel district in districtsModels){

        final bool _isInList = Stringer.checkStringsContainString(
          strings: districtsIDs,
          string: district.id,
        );

        if (_isInList == true){
          _output.add(district);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// PHRASES

  // --------------------
  /// TESTED : WORKS PERFECT
  static String translateDistrict({
    @required BuildContext context,
    @required DistrictModel district,
    String langCode,
  }){

    Phrase _districtName = Phrase.searchFirstPhraseByLang(
      langCode: langCode ?? Localizer.getCurrentLangCode(context),
      phrases: district?.phrases,
    );

    _districtName ??= Phrase.searchFirstPhraseByLang(
      langCode: 'en',
      phrases: district?.phrases,
    );

    return _districtName?.value;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<DistrictModel> searchDistrictsByCurrentLangName({
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

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static DistrictModel replacePhraseInDistrictPhrases({
    @required DistrictModel district,
    @required Phrase phrase,
  }){
    DistrictModel _output = district;

    if (phrase != null && _output?.phrases != null) {

      final List<Phrase> _newPhrases = Phrase.replacePhraseByLangCode(
        phrases: _output.phrases,
        phrase: phrase,
      );

      _output = district.copyWith(phrases: _newPhrases);
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DistrictModel removePhraseFromDistrictPhrases({
    @required DistrictModel district,
    @required String langCode,
  }){
    DistrictModel _output = district;

    if (langCode != null && _output?.phrases != null) {

      final List<Phrase> _newPhrases = Phrase.removePhraseByLangCode(
        phrases: _output.phrases,
        langCode: langCode,
      );

      _output = district.copyWith(
          phrases: _newPhrases,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGERS

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogDistrict(){

    blog('districtID : $id : has ${phrases.length} phrases');
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

        final String _nameA = DistrictModel.translateDistrict(
          context: context,
          district: a,
        );

        final String _nameB = DistrictModel.translateDistrict(
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
  /// TASK : TEST ME
  static bool checkDistrictsIncludeDistrictID(List<DistrictModel> districts, String districtID){
    bool _output = false;

    if (Mapper.checkCanLoopList(districts) == true){
      for (final DistrictModel district in districts){
        if (district.id == districtID){
          _output = true;
          break;
        }
      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

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
      phrases.hashCode;
  // -----------------------------------------------------------------------------
}
